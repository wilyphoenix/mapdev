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
#ifndef _PATCH_H
#define _PATCH_H

#include <string>
#include <list>
#include <fstream>

#define PATCH_ROUNDING_ERROR 0.001

class PATCHPOINT
{
public:
	double x,y,z,s,t;
	bool operator == (PATCHPOINT &p);
	PATCHPOINT& operator= (PATCHPOINT &p);
};

class PATCH
{
public:
	std::string insides;
	bool operator== (PATCH &p);
	PATCH& operator= (PATCH& p);
	std::string texture;
	int rows;
	int cols;
	int u1,u2,u3;
	std::list<PATCHPOINT> points;
	void addPoint(PATCHPOINT &p);
	void write(std::ofstream &oFile);
	void clear();
};


// PATCH COMPARISONS MUST USE TOLLERANCES!!! THIS MEANS CONVERTING DATA TO FLOATS

// TOLLERANCE CAN BE 3-4 decimal places at most

#endif