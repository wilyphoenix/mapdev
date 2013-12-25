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
#ifndef _ENTITY_H
#define _ENTITY_H

#include "brush.h"
#include "key.h"
#include "patch.h"

class ENTITY
{
	//keys
	//brushes
	//patches
public:
	std::list<KEY> keys;
	std::list<BRUSH> brushes;
	std::list<PATCH> patches;

	void addKey(KEY &k);
	void addBrush(BRUSH &b);
	void addPatch(PATCH &p);

	void findKey(std::string &k,std::string &v);
	bool setKey(std::string &k,std::string &v);

	bool operator== (ENTITY &e);
	ENTITY& operator= (ENTITY& e);

	void clear();

};

#endif