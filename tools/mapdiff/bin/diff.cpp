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

#include <iostream>
#include <fstream>
#include <sstream>
#include <cstring>

#include "diff.h"

DIFF::DIFF()
{
	verbose = 1;
}

void DIFF::setVerbose(int v)
{
	verbose = v;
}

/* Grab Next Line From Data Array */
char* DIFF::readLine(char *i,char *o)
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

bool DIFF::loadDiff(char* filename)
{
	if (verbose) std::cout << "Loading Diff: " <<  filename<<'\n';
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

		//diff strom while loop here
		/*char *p = strtok(data,"DIFF END");
		char *np=0;
		while (*p)
		{
			np=strtok(NULL,"DIFF END");
			//parser(p,( (np ? np : fileSize) - p ) -p);
			//parser(p,np-p);                        

			std::cout << data << ' ' << p << ' ' << np << ' ' << fileSize << '\n';
			p=np;
		}*/
		parser(data,fileSize);

		delete [] data;
		return true;
	}
	else if (verbose) std::cout << "ERROR: Coundnt load: "<<filename<<'\n';
	return false;
}

unsigned int DIFF::getChunkSize(char* data)
{
	short int level = 1;
	char *s = data;
	while (*s != '{') s++;
	s++;
	while (level)
	{
		if (*s == '{') level++;
		else if (*s == '}') level--;
		s++;
	}
	return s-data;
}

void DIFF::readKeys(char* str,char* key1, char* key2)
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
char *DIFF::remwsp(char *s)
{
	while (*s)
	{
		if ((*s == ' ') || ( *s == '\t' )) s++;
		else return s;
	}
	return s;
}

/* Return First Non-White Space Charactor in String */
char DIFF::fnwsc(char*i)
{
	while (*i)
	{
		if ((*i == ' ') || (*i == '\t')) i++;
		else return *i;
	}
	return *i;
}

char *DIFF::extractPatchPoint(char* in,char* out)
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

char* DIFF::parseBrush(char *data,unsigned int size,BRUSH& b)
{
	char* s=data;
	bool done = false;
	char line[1024];
	std::stringstream oss;
	while (!done)
	{
		s = readLine(s,line);
		if (fnwsc(line) == '(')
		{
			PLANE plane;
			char texture[1024];
			char temp[32];

			oss.clear();
			oss << line;

			oss >> temp 
			>> plane.v1.x >> plane.v1.y >> plane.v1.z >> temp >> temp
			>> plane.v2.x >> plane.v2.y >> plane.v2.z >> temp >> temp
			>> plane.v3.x >> plane.v3.y >> plane.v3.z >> temp 
			>> texture >> plane.xOffset >> plane.yOffset >> plane.rotate >> plane.xScale >> plane.yScale
			>> plane.flags >> plane.unknown1 >> plane.unknown2;

			plane.texture = texture;
			b.addFace(plane);
			//b.numFaces++;
		}
		else if (fnwsc(line) == '}') done = true;
		if ((s-data) > (int)size) done = true;
	}
	return s;
}

char* DIFF::parseEnt(char *data,unsigned int size,ENTITY& e)
{
	char* s= data;
	bool done = false;
	char line[1024];
	while (!done)
	{
		s=readLine(s,line);
		if ( fnwsc(line) == '}' ) done = true;
		if (s-data > (int)size) done = true; // theoreticlly this never results true
		if ( fnwsc(line) == '"' )
		{
			KEY key;
			char name[100],value[100];
			readKeys(line,name,value);
			key.key = name;
			key.value = value;
			e.addKey(key);
		}
		if (fnwsc(line) == '{')
		{
			char next_line[1024];
			readLine(s,next_line);
			if (fnwsc(next_line) == 'p') // patch mode
			{
				PATCH p;
				s = parsePatch(s,/*99999,*/p);
				e.patches.push_back(p);
			}
			else if (fnwsc(next_line) == '(') // brush mode
			{
				BRUSH brush; 
				s = parseBrush(s,99999,brush); // 99999 because getChunkSize will fail, because we are allready past the first {
				e.brushes.push_back(brush);
			}
		}
	}
	return s;
}

char* DIFF::parsePatch(char *data,/*unsigned int size,*/PATCH& patch)
{
	char *s=data;
	char line[1024];
	std::stringstream oss;

	//read to patchdef2
	do
	{
		s=readLine(s,line);
	} while( strcmp(line,"patchDef2" ));

	s=readLine(s,line); // now holds second {
	s=readLine(s,line); // now holds texture
	char *p= remwsp(line);
	patch.texture = p;
	s=readLine(s,line);
	p=remwsp(line);
	sscanf(p,"%*s %d %d %d %d %d",&patch.rows,&patch.cols,&patch.u1,&patch.u2,&patch.u3);
	s=readLine(s,line); // now holds ( before point data
	PATCHPOINT pPoint;
	//PATCHPOINT pPoint2;
	char point[200];
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

	return s;
}

void DIFF::parser(char* data,unsigned int size)
{
	//int mode = PARSE_MAP;
	char *s = data;
	//bool eof = false;
	char line[1024];
	ENTITY ent;
	BRUSH brush;
	PATCH patch;
	std::stringstream oss;
	short int percent = -1;
	char* tokens;
	while (( s < &data[size] ))
	{
		s = readLine(s,line);

		float temp =(float)( s-data );
		temp /= (float)( &data[size] - data);

		if ( ((10*(temp))  > (percent+1)) && (verbose)) std::cout << ++percent <<  "...";

		tokens = strtok(line," ");
		if (tokens == 0) continue;
		if (!strcmp(tokens,"ADD"))
		{
			tokens = strtok (0," ");
			if (!strcmp(tokens,"WORLDSPAWN"))
			{
				tokens = strtok (0," ");
				if (!strcmp(tokens,"BRUSH"))
				{
					brush.clear();
					s = parseBrush(s,getChunkSize(s),brush);
					add.worldspawn.brushes.push_back(brush);
				}
				else if (!strcmp(tokens,"PATCH"))
				{
					patch.clear();
					s = parsePatch(s,/*getChunkSize(s),*/patch);
					add.worldspawn.patches.push_back(patch);
				}
				else if (!strcmp(tokens,"KEY"))
				{
					s=readLine(s,line);
					KEY key;
					char name[100],value[100];
					readKeys(line,name,value);
					key.key = name;
					key.value = value;
					add.worldspawn.keys.push_back(key);
				}
			}
			else if (!strcmp(tokens,"ENT"))
			{
				ent.clear();
				s = parseEnt(s,getChunkSize(s),ent);
				add.ents.push_back(ent);
			}
		}
		else if (!strcmp(tokens,"REMOVE"))
		{
			tokens = strtok (0," ");
			if (!strcmp(tokens,"WORLDSPAWN"))
			{
				tokens = strtok (0," ");
				if (!strcmp(tokens,"BRUSH"))
				{
					brush.clear();
					s = parseBrush(s,getChunkSize(s),brush);
					rem.worldspawn.brushes.push_back(brush);
				}
				else if (!strcmp(tokens,"PATCH"))
				{
					patch.clear();
					s = parsePatch(s,/*getChunkSize(s),*/patch);
					rem.worldspawn.patches.push_back(patch);
				}
				else if (!strcmp(tokens,"KEY"))
				{
					s=readLine(s,line);
					KEY key;
					char name[100],value[100];
					readKeys(line,name,value);
					key.key = name;
					key.value = value;
					//ent.addKey(key);
					rem.worldspawn.keys.push_back(key);
				}
			}
			else if (!strcmp(tokens,"ENT"))
			{
				ent.clear();
				s = parseEnt(s,getChunkSize(s),ent);
				rem.ents.push_back(ent);
			}
		}
		
	}
	if (verbose) std::cout<<'\n';
}

void DIFF::apply(MAP &m,char* filename)
{
	m.minusWithError(rem,err);
	m += add;

	if (err) 
	{
		if (verbose) std::cout << "\n WARNING: Some map objects could not be removed,\n          this is usually caused by more than one person\n          editing the same map object, see this file for details:\n";
		err.enforceWorldspawn();
		// Shall I add an entity that outlines all the problems as keys?
		err.writeMap(filename); // todo add worldspawn classname key/value to worldspawn ent before export!
		if (verbose==2)
		{
			//console output of err map
			std::cout << "\nERROR REPORT:\n  " << err.worldspawn.brushes.size() << " Worldspawn Brushes Not Removed\n  " 
				<< err.worldspawn.patches.size() << " Worldspawn Patches Not Removed\n  " << err.worldspawn.keys.size() << " Worldspawn Keys Not Removed\n  "
				<< err.ents.size() << " Entitys Not Removed\n\n";
		}
	}
}

void DIFF::clear()
{
	add.ents.clear();
	rem.ents.clear();
	err.ents.clear();
	verbose = 1;
}