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
#ifndef _MAP_H
#define _MAP_H

#include "entity.h"

class MAP
{
	char* readLine(char *,char *);
	char fnwsc(char*);
	void readKeys(char* str,char* key1, char* key2);
	char *remwsp(char*);
	char *extractPatchPoint(char*,char*);
	void writeEntity(ENTITY *e,std::ofstream &oFile);
	void parser(char *data,unsigned int size);
	bool checkBrushForErrors(BRUSH &b);
	int verbose;
public:
	std::list<ENTITY> ents;
	MAP();
	ENTITY worldspawn;
	void addWorldspawn(ENTITY &e);
	void addEntity(ENTITY &e);
	bool loadMap(char *filename);
	bool writeMap(char *filename);
	//void combineMap(MAP &m);
	void operator+= (MAP &m);
	void operator-= (MAP &m);
	void minusWithError(MAP &m,MAP &err);
	void findErrors(char *filename);
	bool generateDiff(MAP &base, char *filename);
	MAP& operator= (MAP &m);
	void setVerbose(int v);
	void enforceWorldspawn();
	operator bool ();
	int cleanBouncedLight();
};

#endif