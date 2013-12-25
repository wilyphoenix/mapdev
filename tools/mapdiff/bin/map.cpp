/*
    This file is part of MAPDIFF.

    MAPDIFF is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    MAPDIFF is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with MAPDIFF.  If not, see <http://www.gnu.org/licenses/>.
*/

#define _CRT_SECURE_NO_WARNINGS 1

#include <fstream>
#include <iostream>
#include <sstream>
#include <cstdio>

#include "map.h"

enum {
	MODE_MAP,
	MODE_ENT,
	MODE_BRUSH,
	MODE_PATCH,
	MODE_KEY
};

/* MAP Constructor */
MAP::MAP()
{
	verbose = 1;
}

/* Add Entity To Map */
void MAP::addEntity(ENTITY &e)
{
	ents.push_back(e);
}

/* Replace Current Worldspawn With New */
void MAP::addWorldspawn(ENTITY &e)
{
	std::list<BRUSH>::iterator brush_iter;
	std::list<PATCH>::iterator patch_iter;
	std::list<KEY>::iterator key_iter;

	brush_iter = e.brushes.begin();
	patch_iter = e.patches.begin();
	key_iter   = e.keys.begin();

	// Do we want to clear the world spawn here? or just add ents to it
	worldspawn.brushes.clear();
	worldspawn.patches.clear();
	worldspawn.keys.clear();

	while (brush_iter != e.brushes.end())
	{
		worldspawn.addBrush(*brush_iter);;
		brush_iter++;
	}

	while (patch_iter != e.patches.end())
	{
		worldspawn.addPatch(*patch_iter);
		patch_iter++;
	}

	while (key_iter != e.keys.end())
	{
		worldspawn.addKey(*key_iter);
		key_iter++;
	}

	
}

/* Grab Next Line From Data Array */
char* MAP::readLine(char *i,char *o)
{
	while (*i && (*i!=13) && (*i!=10))
	{
		*o++ = *i++;
	}
	*o = 0; // null-terminate
	i++;
	if (*i==10) return ++i; // return char after newline or terminator
	return i;
}

/* Return First Non-White Space Charactor in String */
char MAP::fnwsc(char*i)
{
	while (*i)
	{
		if ((*i == ' ') || (*i == '\t')) i++;
		else return *i;
	}
	return *i;
}

/* Seperates line into key/value pairs and returns points to both */
void MAP::readKeys(char* str,char* key1, char* key2)
{
	while (*str && (*str != '"')) str++;

	if (*str) str++;
	*key1++ = '"';
	while (*str && (*str != '"')) *key1++ = *str++;

	*key1++ = '"';
	*key1 = 0;

	if (*str) str++;
	while (*str && (*str != '"')) str++;
	if (*str) str++;
	*key2++ = '"';
	while (*str && (*str != '"')) *key2++ = *str++;

	*key2++ = '"';
	*key2 = 0;

}
/* Remove White Space Prefix */
char *MAP::remwsp(char *s)
{
	while (*s)
	{
		if ((*s == ' ') || ( *s == '\t' )) s++;
		else return s;
	}
	return s;
}

/* Extract Patch Point Infomation and return next patch point */
char *MAP::extractPatchPoint(char* in,char* out)
{
	while (*in)
	{
		if (*in == ')') 
		{
			*out = 0;
			return ++in; // return 1 past ')'
		}
		else if (*in == '(') in++;
		else
		{
			*out++ = *in++;
		}
	}
	*out = 0;
	return in; // return null-term
}

/* Load a .map, returns true on sucess, false on failure*/
bool MAP::loadMap(char* filename)
{
	if (verbose) std::cout << "Loading: " <<  filename<<'\n';
	std::ifstream inFile(filename,std::ios::in | std::ios::ate | std::ios::binary);
	if (inFile.is_open())
	{
		//get file size
		int fileSize = inFile.tellg();
		inFile.seekg(0,std::ios::beg);

		char *data;
		data = new char[fileSize+1];

		inFile.read(data,fileSize); // all file's contents into data
		data[fileSize] = 0; // null terminate string

		inFile.close();

		parser(data,fileSize);

		delete [] data;
		return true;
	}
	else if (verbose) std::cout << "ERROR: Couldnt open: "<<filename<<'\n';
	return false;
}

void MAP::parser(char *data,unsigned int fileSize)
{
		int mode = MODE_MAP;
		char *s = data;
		//bool eof = false;
		char line[1024];
		ENTITY ent;
		BRUSH brush;
		PATCH patch;
		std::stringstream oss;

		PLANE plane;
		char texture[1024];
		char tempB[32];
		KEY key;
		std::string search="\"classname\"";
		std::string valueK;
		char name[100],value[100];
		float temp;
		char next_line[1024];
		char point[200];
		char *p;

		short int percent = -1;

		while ( ( s >= data ) && ( s< &data[fileSize] ) )
		{
			s = readLine(s,line);
			//std::cout << line << "\n";

			temp =(float)( s-data );// / (float)( (int)data[fileSize] - (int)data) ;
			temp /= (float)( &data[fileSize] - data);

			if ( ((10*(temp))  > (percent+1)) && verbose )
			{
				std::cout << ++percent <<  "...";
			}
			

			if (mode == MODE_MAP)
			{
				//looking for { only then go to ent mode
				if ( fnwsc(line) == '{' ) mode = MODE_ENT;
			}
			else if (mode == MODE_ENT)
			{
				// Entity Finished
				if ( fnwsc(line) == '}' ) 
				{
					// CREATE NEW ENTITY IN MAP OBJECT
					ent.findKey(search,valueK);

					// If worldspawn copy to worldspawn, else add to entity list
					if (valueK == "\"worldspawn\"")
					{
						//std::cout << "THIS IS WORLDSPAWN\n";
						addWorldspawn(ent);
					}
					else
					{
						addEntity(ent);
					}

					//std::cout << "ENT FINISHED, BRUSHES: " << ent.brushes.size() << " KEYS: " << ent.keys.size() << " PATCHES: " << ent.patches.size() <<'\n';
					mode = MODE_MAP;
					//clear all data from ent
					ent.keys.clear();
					ent.brushes.clear();
					ent.patches.clear();
				}
				// Process key
				if ( fnwsc(line) == '"' )
				{
					readKeys(line,name,value);
					key.key = name;
					key.value = value;
					ent.addKey(key);
				}
				// EITHER PATCH OR BRUSH
				if (fnwsc(line) == '{')
				{
					
					readLine(s,next_line);
					if (fnwsc(next_line) == 'p') // patch mode
					{
						mode = MODE_PATCH;
						patch.insides.clear();
						patch.points.clear();
					}
					else if (fnwsc(next_line) == '(') // brush mode
					{
						mode = MODE_BRUSH;
						brush.faces.clear();
						brush.numFaces = 0;
					}
				}
			}
			else if (mode == MODE_BRUSH)
			{
				if (fnwsc(line) == '(')
				{
					oss.clear();
					oss << line;

					oss >> tempB 
						>> plane.v1.x >> plane.v1.y >> plane.v1.z >> tempB >> tempB
						>> plane.v2.x >> plane.v2.y >> plane.v2.z >> tempB >> tempB
						>> plane.v3.x >> plane.v3.y >> plane.v3.z >> tempB 
						>> texture >> plane.xOffset >> plane.yOffset >> plane.rotate >> plane.xScale >> plane.yScale
						>> plane.flags >> plane.unknown1 >> plane.unknown2;
	
					/*sscanf(line,
						"%*s %f %f %f %*s %*s %f %f %f %*s %*s %f %f %f %*s %s %f %f %f %f %f %d %f %f",
						&plane2.v1.x,&plane2.v1.y,&plane2.v1.z,&plane2.v2.x,&plane2.v2.y,&plane2.v2.z,&plane2.v3.x,&plane2.v3.y,&plane2.v3.z,
						texture,&plane2.xOffset,&plane2.yOffset,&plane2.rotate,&plane2.xScale,&plane2.yScale,&plane2.flags,&plane2.unknown1,&plane2.unknown2);
					*/
					/*std::cout << "( " << plane.v1.x << ' ' << plane.v1.y << ' ' << plane.v1.z << ' '
						      << ") ( " <<plane.v2.x << ' ' << plane.v2.y << ' ' << plane.v2.z << ' '
							  << ") ( "<< plane.v3.x << ' ' << plane.v3.y << ' ' << plane.v3.z << ' '
							  << ") "<< texture << ' ' << plane.xOffset << ' ' << plane.yOffset << ' '
							  << plane.rotate << ' ' << plane.xScale << ' ' << plane.yScale << ' '
							  << plane.flags << ' ' << plane.unknown1 << ' ' << plane.unknown2 << '\n';
					*/
					plane.texture = texture;
					brush.addFace(plane);
				}
				else if (fnwsc(line) == '}')
				{
					ent.addBrush(brush);
					mode = MODE_ENT;					
				}
			}
			else if (mode == MODE_PATCH)
			{
				// fill insides with all data up to second '}'
				/*while (patchTermCount<2)
				{
					patch.insides += line;
					patch.insides += "\n";
					if (fnwsc(line) == '}') patchTermCount++;
					if (patchTermCount <2) s = readLine(s,line);
				}
				mode = MODE_ENT;
				patchTermCount = 0;
				std::cout << patch.insides << '\n';
				ent.addPatch(patch);
				patch.insides.clear();*/


				s=readLine(s,line); // now holds second {
				s=readLine(s,line); // now holds texture
				p= remwsp(line);
				patch.texture = p;
				s=readLine(s,line);
				p=remwsp(line);
				sscanf(p,"%*s %d %d %d %d %d",&patch.rows,&patch.cols,&patch.u1,&patch.u2,&patch.u3);
				s=readLine(s,line); // now holds ( before point data
				PATCHPOINT pPoint;
				//PATCHPOINT pPoint2;
				
				for (int i=0;i<patch.rows;i++)
				{
					s=readLine(s,line);
					p=line;
					for (int j=0;j<patch.cols;j++)
					{
						p = extractPatchPoint(p,point);
						//std::stringstream oss;
						oss.clear();
						oss << point;
						oss >> pPoint.x >> pPoint.y >> pPoint.z >> pPoint.s >> pPoint.t;
						//sscanf(point," %f %f %f %f %f",&pPoint2.x,&pPoint2.y,&pPoint2.z,&pPoint2.s,&pPoint2.t);
						patch.addPoint(pPoint);
					}
				}
				s=readLine(s,line);
				s=readLine(s,line);
				s=readLine(s,line);
				ent.addPatch(patch);
				mode = MODE_ENT;
			} // END if
		} // END while
		if (verbose) std::cout << '\n';
} // END parser()

bool MAP::writeMap(char *filename)
{
	// validation ?
	if (verbose) std::cout << "Writing: " << filename << '\n';

	std::ofstream oFile(filename);
	if (oFile.is_open())
	{

		int entityCount = 1;
		//write worldspawn
		//oFile << "// entity " << entityCount++ << '\n';
		writeEntity(&worldspawn,oFile);

		//write entitys - loop through

		std::list<ENTITY>::iterator it=ents.begin();

		for (;it!=ents.end();it++)
		{
			oFile << "// entity " << entityCount++ << '\n';
			writeEntity(&*it,oFile);
		}

		oFile.close();
		return true;
	}
	if (verbose) std::cout << "ERROR: Writing File: "<<filename<<'\n';
	return false;
}

void MAP::writeEntity(ENTITY *e,std::ofstream &oFile)
{
	if (oFile.is_open())
	{
		
		oFile.precision(6);
		
		std::list<KEY>::iterator key_iter = e->keys.begin();
		std::list<BRUSH>::iterator brush_iter = e->brushes.begin();
		std::list<PATCH>::iterator patch_iter = e->patches.begin();

		int brushCount = 0; // for brush number comments in .map file

		oFile << "{\n";

		for (;key_iter != e->keys.end();key_iter++)
		{
			oFile << key_iter->key << ' ' << key_iter->value << '\n';
		}

		for (;brush_iter!=e->brushes.end();brush_iter++)
		{
			oFile << "// brush " << brushCount++;
			oFile << "\n{\n"; 
			
			//faces
			std::list<PLANE>::iterator plane_iter = brush_iter->faces.begin();

			for (;plane_iter != brush_iter->faces.end();plane_iter++)
			{
				oFile << "( " << plane_iter->v1.x << ' ' << plane_iter->v1.y << ' ' << plane_iter->v1.z << " ) ( " 
					          << plane_iter->v2.x << ' ' << plane_iter->v2.y << ' ' << plane_iter->v2.z << " ) ( "
							  << plane_iter->v3.x << ' ' << plane_iter->v3.y << ' ' << plane_iter->v3.z << " ) "
							  << plane_iter->texture << ' ' << plane_iter->xOffset << ' ' << plane_iter->yOffset
							  << ' ' << plane_iter->rotate << ' ' << plane_iter->xScale << ' ' << plane_iter->yScale
							  << ' ' << plane_iter->flags << ' ' << plane_iter->unknown1 << ' ' << plane_iter->unknown2 << '\n';
			}

			oFile << "}\n";
		}

		for (;patch_iter!=e->patches.end();patch_iter++)
		{
			oFile << "// brush " << brushCount++;

			oFile.flags(oFile.fixed);
			oFile << "\n{\npatchDef2\n{\n";
			oFile << patch_iter->texture << '\n';
			oFile << "( " << patch_iter->rows << ' ' << patch_iter->cols << ' ' 
				  << patch_iter->u1 << ' ' << patch_iter->u2 << ' ' << patch_iter->u3 << " )\n";
			oFile << "(\n";
			int vertexCount = 0;
			std::list<PATCHPOINT>::iterator point_iter = patch_iter->points.begin();
			for (;point_iter != patch_iter->points.end();point_iter++)
			{
				if ((vertexCount % patch_iter->cols) == 0) oFile << "( ";
				oFile << "( " << point_iter->x << ' ' << point_iter->y << ' ' << point_iter->z << ' ' << point_iter->s << ' ' << point_iter->t << " ) ";
				vertexCount++;
				if ((vertexCount % patch_iter->cols) == 0) oFile << ")\n";
			}
			oFile << ")\n}\n}\n";			
		}
		oFile << "}\n";
		oFile.unsetf(  oFile.fixed );
	}
}

// Adding two MAP objects together
void MAP::operator+= (MAP &m)
{
	// ADD TO WORLDSPAWN
	std::list<KEY>::iterator k_it =   m.worldspawn.keys.begin();
	std::list<BRUSH>::iterator b_it = m.worldspawn.brushes.begin();
	std::list<PATCH>::iterator p_it = m.worldspawn.patches.begin();

	while (k_it != m.worldspawn.keys.end() ) worldspawn.addKey(*k_it++);
	while (b_it != m.worldspawn.brushes.end() ) worldspawn.addBrush(*b_it++);
	while (p_it != m.worldspawn.patches.end() ) worldspawn.addPatch(*p_it++);

	// ADD OTHER ENTITYS

	std::list<ENTITY>::iterator e_it = m.ents.begin();

	while (e_it != m.ents.end()) addEntity(*e_it++);
}

void MAP::operator-= (MAP &m)
{
	// in ws find b/p/k & remove it
	// Cause a fuss if object is not found
	// Add not found brushes to error map
	// then find ent & remove it

	// Do you want this function to return an errror map? yes

	//MAP err;

	std::list<KEY>::iterator k_it =   m.worldspawn.keys.begin();
	std::list<BRUSH>::iterator b_it = m.worldspawn.brushes.begin();
	std::list<PATCH>::iterator p_it = m.worldspawn.patches.begin();
	std::list<ENTITY>::iterator e_it = m.ents.begin();

	std::list<KEY>::iterator lk_it;
	std::list<BRUSH>::iterator lb_it;
	std::list<PATCH>::iterator lp_it;
	std::list<ENTITY>::iterator le_it;

	bool found;

	while ( k_it != m.worldspawn.keys.end())
	{
		found = false;
		lk_it = worldspawn.keys.begin();
		while (!found && ( lk_it != worldspawn.keys.end() ))
		{
			if (*k_it == *lk_it) 
			{
				found = true;
				worldspawn.keys.erase(lk_it);
			}
			else lk_it++;
		}
		//if (!found) std::cout << "ARGH KEY: " << k_it->key << " NOT FOUND\n";
		k_it++;
	}

	while ( b_it != m.worldspawn.brushes.end())
	{
		found = false;
		lb_it = worldspawn.brushes.begin();
		while (!found && ( lb_it != worldspawn.brushes.end() ))
		{
			if ( *b_it == *lb_it )
			{
				found = true;
				worldspawn.brushes.erase(lb_it);
			}
			else lb_it++;
		}
		//if (!found) std::cout << "ARGH BRUSH NOT FOUND\n";
		b_it++;
	}

	while ( p_it != m.worldspawn.patches.end())
	{
		found = false;
		lp_it = worldspawn.patches.begin();
		while (!found && ( lp_it != worldspawn.patches.end() ))
		{
			if ( *p_it == *lp_it)
			{
				found = true;
				worldspawn.patches.erase(lp_it);
			}
			else lp_it++;
		}
		//if (!found) std::cout << "ARGH PATCH NOT FOUND\n"; //p_it->texture
		p_it++;
	}

	// ALL OTHER ENTS

	while (e_it != m.ents.end() )
	{
		found = false;
		le_it = ents.begin();
		while (!found && ( le_it != ents.end() ))
		{
			if (*e_it == *le_it)
			{
				found = true;
				ents.erase(le_it);
			}
			else le_it++;
		}
		//if (!found) std::cout << "ARGH ENTITY NOT FOUND\n";
		e_it++;
	}
	//return err;
}

void MAP::minusWithError(MAP &m,MAP &err)
{
	std::list<KEY>::iterator k_it =   m.worldspawn.keys.begin();
	std::list<BRUSH>::iterator b_it = m.worldspawn.brushes.begin();
	std::list<PATCH>::iterator p_it = m.worldspawn.patches.begin();
	std::list<ENTITY>::iterator e_it = m.ents.begin();

	std::list<KEY>::iterator lk_it;
	std::list<BRUSH>::iterator lb_it;
	std::list<PATCH>::iterator lp_it;
	std::list<ENTITY>::iterator le_it;

	bool found;

	while ( k_it != m.worldspawn.keys.end())
	{
		found = false;
		lk_it = worldspawn.keys.begin();
		while (!found && ( lk_it != worldspawn.keys.end() ))
		{
			if (*k_it == *lk_it) 
			{
				found = true;
				worldspawn.keys.erase(lk_it);
			}
			else lk_it++;
		}
		//if (!found) std::cout << "ARGH KEY: " << k_it->key << " NOT FOUND\n";
		if (!found) err.worldspawn.keys.push_back(*k_it);
		k_it++;
	}

	while ( b_it != m.worldspawn.brushes.end())
	{
		found = false;
		lb_it = worldspawn.brushes.begin();
		while (!found && ( lb_it != worldspawn.brushes.end() ))
		{
			if ( *b_it == *lb_it )
			{
				found = true;
				worldspawn.brushes.erase(lb_it);
			}
			else lb_it++;
		}
		//if (!found) std::cout << "ARGH BRUSH NOT FOUND\n";
		if (!found) err.worldspawn.brushes.push_back(*b_it);
		b_it++;
	}

	while ( p_it != m.worldspawn.patches.end())
	{
		found = false;
		lp_it = worldspawn.patches.begin();
		while (!found && ( lp_it != worldspawn.patches.end() ))
		{
			if ( *p_it == *lp_it)
			{
				found = true;
				worldspawn.patches.erase(lp_it);
			}
			else lp_it++;
		}
		//if (!found) std::cout << "ARGH PATCH NOT FOUND\n"; //p_it->texture
		if (!found) err.worldspawn.patches.push_back(*p_it);
		p_it++;
	}

	// ALL OTHER ENTS

	while (e_it != m.ents.end() )
	{
		found = false;
		le_it = ents.begin();
		while (!found && ( le_it != ents.end() ))
		{
			if (*e_it == *le_it)
			{
				found = true;
				ents.erase(le_it);
			}
			else le_it++;
		}
		//if (!found) std::cout << "ARGH ENTITY NOT FOUND\n";
		if (!found) err.addEntity(*e_it);
		e_it++;
	}
}

void MAP::findErrors(char *filename)
{
	// 1: loop through all brushes looking for varing plane flag value

	// worldspawn / other entitys
	std::list<BRUSH>::iterator b_it = worldspawn.brushes.begin();
	int brushNum = 0;

	while (b_it != worldspawn.brushes.end())
	{
		if (!checkBrushForErrors(*b_it))
		{
			std::ofstream oFile(filename);
			//output brush
			oFile << "// brush " << brushNum;
			oFile << "\n{\n"; 
			
			//faces
			std::list<PLANE>::iterator plane_iter = b_it->faces.begin();

			for (;plane_iter != b_it->faces.end();plane_iter++)
			{
				oFile << "( " << plane_iter->v1.x << ' ' << plane_iter->v1.y << ' ' << plane_iter->v1.z << " ) ( " 
					          << plane_iter->v2.x << ' ' << plane_iter->v2.y << ' ' << plane_iter->v2.z << " ) ( "
							  << plane_iter->v3.x << ' ' << plane_iter->v3.y << ' ' << plane_iter->v3.z << " ) "
							  << plane_iter->texture << ' ' << plane_iter->xOffset << ' ' << plane_iter->yOffset
							  << ' ' << plane_iter->rotate << ' ' << plane_iter->xScale << ' ' << plane_iter->yScale
							  << ' ' << plane_iter->flags << ' ' << plane_iter->unknown1 << ' ' << plane_iter->unknown2 << '\n';
			}

			oFile << "}\n";
			oFile.close();

		}
		brushNum++;
		b_it++;
	}

	int eNum=0;

	std::list<ENTITY>::iterator e_it = ents.begin();
	while (e_it != ents.end())
	{
		b_it = e_it->brushes.begin();
		int brushNum = 0;

		while (b_it != e_it->brushes.end())
		{
			if (!checkBrushForErrors(*b_it))
			{
				std::ofstream oFile(filename);
				//output brush
				oFile << "// entity " << eNum << '\n';
				oFile << "// brush " << brushNum;
				oFile << "\n{\n"; 
				
				//faces
				std::list<PLANE>::iterator plane_iter = b_it->faces.begin();

				for (;plane_iter != b_it->faces.end();plane_iter++)
				{
					oFile << "( " << plane_iter->v1.x << ' ' << plane_iter->v1.y << ' ' << plane_iter->v1.z << " ) ( " 
								  << plane_iter->v2.x << ' ' << plane_iter->v2.y << ' ' << plane_iter->v2.z << " ) ( "
								  << plane_iter->v3.x << ' ' << plane_iter->v3.y << ' ' << plane_iter->v3.z << " ) "
								  << plane_iter->texture << ' ' << plane_iter->xOffset << ' ' << plane_iter->yOffset
								  << ' ' << plane_iter->rotate << ' ' << plane_iter->xScale << ' ' << plane_iter->yScale
								  << ' ' << plane_iter->flags << ' ' << plane_iter->unknown1 << ' ' << plane_iter->unknown2 << '\n';
				}

				oFile << "}\n";
				oFile.close();

			}
			brushNum++;
			b_it++;
		}
		e_it++;
		eNum++;
	}
}

bool MAP::checkBrushForErrors(BRUSH &b)
{
	if (b.numFaces == 0) return true;
	long flags;
	bool ok = true;
	std::list<PLANE>::iterator p_it = b.faces.begin();
	flags = p_it->flags;
	p_it++;
	while (ok && p_it != b.faces.end())
	{
		if (p_it->flags != flags) ok = false;
		p_it++;
	} 
	return ok;
}

bool MAP::generateDiff(MAP &base, char *filename)
{
	if (verbose) std::cout << "Comparing Maps";
	MAP add,rem,err; // Addative map, Removal map, and location of any errors (if needed)

	add = *this;
	if (verbose) std::cout << '.';
	rem = base;
	if (verbose) std::cout << '.';

	add -= base;
	if (verbose) std::cout << '.';
	rem -= *this;
	if (verbose) std::cout << ".\n";

	if (verbose && ( !add && !rem ) ) std::cout << "\nWARNING: Maps are equal, diff will have zero length\n\n";

	//if (add || rem)
	//{
		

		std::list<BRUSH>::iterator b_it = rem.worldspawn.brushes.begin();
		std::list<KEY>::iterator k_it = rem.worldspawn.keys.begin();
		std::list<PATCH>::iterator p_it = rem.worldspawn.patches.begin();
		std::list<ENTITY>::iterator e_it = rem.ents.begin();

		int numAB=0,numAP=0,numAK=0,numAE=0,numRB=0,numRP=0,numRK=0,numRE=0;

		
		if (verbose) std::cout << "Writing Difference: "<< filename <<"\n";

		std::ofstream oFile(filename);
		if (oFile.is_open())
		{
			//write removal entrys first:
			oFile.precision(6);

			while (k_it != rem.worldspawn.keys.end())
			{
				if ( (k_it->key != "\"MC_REPO\"") && (k_it->key != "\"MC_REV\"") ) 
				{
					oFile << "REMOVE WORLDSPAWN KEY\n";
					k_it->write(oFile);
					oFile << '\n';
				}
				k_it++;
				numRK++;
			}

			while (b_it != rem.worldspawn.brushes.end())
			{
				oFile << "REMOVE WORLDSPAWN BRUSH\n";
				b_it->write(oFile);
				oFile << '\n';
				b_it++;
				numRB++;
			}

			while (p_it != rem.worldspawn.patches.end())
			{
				oFile << "REMOVE WORLDSPAWN PATCH\n";
				p_it->write(oFile);
				oFile << '\n';
				p_it++;
				numRP++;
			}

			while (e_it != rem.ents.end())
			{
				oFile << "REMOVE ENT\n";
				writeEntity(&*e_it,oFile);
				oFile << '\n';
				e_it++;
				numRE++;
			}


			//reset iters

			b_it = add.worldspawn.brushes.begin();
			p_it = add.worldspawn.patches.begin();
			k_it = add.worldspawn.keys.begin();
			e_it = add.ents.begin();

			// write additions

			while (k_it != add.worldspawn.keys.end())
			{
				if ( (k_it->key != "\"MC_REPO\"") && (k_it->key != "\"MC_REV\"") )
				{
					oFile << "ADD WORLDSPAWN KEY\n";
					k_it->write(oFile);
					oFile << '\n';
				}
				k_it++;
				numAK++;
			}

			while (b_it != add.worldspawn.brushes.end())
			{
				oFile << "ADD WORLDSPAWN BRUSH\n";
				b_it->write(oFile);
				oFile << '\n';
				b_it++;
				numAB++;
			}

			while (p_it != add.worldspawn.patches.end())
			{
				oFile << "ADD WORLDSPAWN PATCH\n";
				p_it->write(oFile);
				oFile << '\n';
				p_it++;
				numAP++;
			}

			while (e_it != add.ents.end())
			{
				oFile << "ADD ENT\n";
				writeEntity(&*e_it,oFile);
				oFile << '\n';
				e_it++;
				numAE++;
			}

			oFile.close();
			if (verbose==2) 
			{

				if (verbose) std::cout << "Diff Removes:\n  " << numRB << " Worldspawn Brushes\n  " << numRP << " Worldspawn Patches\n  " << numRK
				<< " Worldspawn Keys\n  " << numRE << " Entitys\n\nDiff Adds:\n  " << numAB << " Worldspawn Brushes\n  " << numAP 
				<< " Worldspawn Patches\n  " << numAK << " Worldspawn Keys\n  " << numAE << " Entitys\n\n";

				add.enforceWorldspawn();
				rem.enforceWorldspawn();
				//generate file names
				char addFilename[2000];
				char remFilename[2000];
				strcpy(addFilename,filename);
				strcpy(remFilename,filename);
				char* pdotadd = strrchr(addFilename,'.');
				char* pdotrem = strrchr(remFilename,'.');
				//char* pdotfile =strrchr(filename,'.');

				if (pdotadd)
				{
					strcpy(pdotadd,"_add.map");
					strcpy(pdotrem,"_rem.map");
				}
				else
				{
					strcat(addFilename,"_add.map");
					strcat(remFilename,"_rem.map");
				}

				add.writeMap(addFilename);
				rem.writeMap(remFilename);
				//verbose=(bool)add;
			}
			return true;
		}
		if (verbose) std::cout << "ERROR: Writing File: " << filename << '\n';
		return false;
	//}
	if (verbose) std::cout << "\n     WARNING: Maps are equal, skipping diff generation.\n";
	return false;
}

MAP& MAP::operator= (MAP &m)
{
	if (&m != this) // avoid self asignment
	{
		worldspawn = m.worldspawn;

		//ents todo
		ents.clear();
		std::list<ENTITY>::iterator e_it = m.ents.begin();
		ENTITY temp;
		while (e_it != m.ents.end())
		{
			temp =*e_it++;
			ents.push_back(temp);
		}

	}
	return *this;
}

void MAP::setVerbose(int v)
{
	verbose = v;
}

void MAP::enforceWorldspawn()
{
	// try and find "classname" "worldspawn" key
	// if not exist put it in worldspawn
	bool found=false;
	std::list<KEY>::iterator k_it=worldspawn.keys.begin();
	while (!found && k_it != worldspawn.keys.end())
	{
		if (k_it->key == "\"classname\"" && k_it->value == "\"worldspawn\"") found = true;
		k_it++;
	}

	if (!found)
	{
		KEY k;
		k.key = "\"classname\"";
		k.value = "\"worldspawn\"";
		worldspawn.addKey(k);
	}
}

MAP::operator bool()
{
	if (ents.size() != 0 || worldspawn.brushes.size() != 0 || worldspawn.patches.size() != 0 || worldspawn.keys.size() != 0) return true;
	return false;
}

int MAP::cleanBouncedLight()
{
	int count = 0;
	int loc = 0;
	std::list<ENTITY>::iterator eit = ents.begin();
	while (eit!=ents.end())
	{
		std::string key,value;
		key = "\"classname\"";
		value = "";
		eit->findKey(key,value);
		if (value == "\"light\"")
		{
			key = "\"_color\"";	
			eit->findKey(key,value);
			if (( value[3] == '0' ) && (value[4] == '0') && (value[1] == '0') )
			{
				std::list<ENTITY>::iterator rement = eit;
				eit++;
				ents.erase( rement );
				count++;
			}
			else eit++;
		}
		else eit++;
		loc++;
	}
	return count;
}

/*
 {
  patchDef2
  {
   urban_terror/barrelq32
   ( 3 3 0 0 0 ) 
(
( ( -128.000168 48.000050 56 -4.000005 -1.500002 ) ( -128.000168 64.000099 56 -4.000005 -2.000003 ) ( -112.000084 64.000099 56 -3.500003 -2.000003 ) )
( ( -128.000168 32 56 -4.000005 -1 ) ( -112.000168 48 56 -3.500005 -1.500000 ) ( -96 64.000099 56 -3 -2.000003 ) )
( ( -112.000084 32 56 -3.500003 -1 ) ( -96 32 56 -3 -1 ) ( -96 48.000050 56 -3 -1.500002 ) )
)
  }
 }

 */

/*
// brush 0
{
( 200 128 -8 ) ( -184 128 -8 ) ( -184 -128 -8 ) common/caulk 0 0 0 0.500000 0.500000 0 0 0
( -184 -128 136 ) ( -184 128 136 ) ( 200 128 136 ) common/caulk 0 0 0 0.500000 0.500000 0 0 0
( -192 -136 8 ) ( 192 -136 8 ) ( 192 -136 0 ) common/caulk 0 0 0 0.500000 0.500000 0 0 0
( 192 136 8 ) ( -192 136 8 ) ( -192 136 0 ) common/caulk 0 0 0 0.500000 0.500000 0 0 0
( -200 128 16 ) ( -200 -128 16 ) ( -200 -128 8 ) common/caulk 0 0 0 0.500000 0.500000 0 0 0
( -192 -128 16 ) ( -192 128 16 ) ( -192 -128 8 ) null_twist/brick-med-tan 0 0 0 0.500000 0.500000 0 0 0
}
*/
