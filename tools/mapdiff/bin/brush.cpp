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

#include "brush.h"

BRUSH::BRUSH()
{
	numFaces = 0;
}

bool BRUSH::operator== (BRUSH &b)
{
	//compare numFaces then compare faces;
	if (numFaces != b.numFaces) return false;

	// FACE COMPARE
	std::list<PLANE>::iterator iter1 = faces.begin();
	
	bool compared[128]; // Whats the max number of faces? 32?
	bool status = true;
	int i;
	for (i=0;i<64;i++) compared[i] = false;


	while ( status & (iter1 != faces.end()) ) // interate through local faces list
	{ 
		std::list<PLANE>::iterator iter2 = b.faces.begin();
		bool found = false;
		i=0;

		// loop through 2nd brush's faces
		while (!found & (iter2 != b.faces.end()))
		{

			if (compared[i] == false)
			{
				if (*iter1 == *iter2) 
				{
					//set compared
					compared[i] = true;
					found = true;
				}
			}
			iter2++;
			i++;
		}
		if (found == false) status = false;
		iter1++;
	}
	return status;
}

int BRUSH::addFace(PLANE &f)
{
	faces.push_back(f);
	return ++numFaces;
}

BRUSH& BRUSH::operator= (BRUSH &b)
{
	if (&b != this)
	{
		numFaces = b.numFaces;
		std::list<PLANE>::iterator p_it = b.faces.begin();
		faces.clear();
		while (p_it != b.faces.end())
		{
			faces.push_back(*p_it++);
		}
	}
	return *this;
}

void BRUSH::write(std::ofstream &oFile)
{
	oFile << "\n{\n"; 
			
	//faces
	std::list<PLANE>::iterator plane_iter = faces.begin();

	for (;plane_iter != faces.end();plane_iter++)
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

void BRUSH::clear()
{
	numFaces = 0;
	faces.clear();
}