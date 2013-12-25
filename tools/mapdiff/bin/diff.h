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
#ifndef _DIFF_H
#define _DIFF_H

#include "map.h"

class DIFF
{
	void parser(char *data,unsigned int size);
	char* parseBrush(char *data,unsigned int size,BRUSH& b);
	char* parseEnt(char *data,unsigned int size,ENTITY& e);
	char* parsePatch(char *data,/*unsigned int size,*/PATCH& patch);
	//char* parseKey(char* data,unsigned int size,KEY& k);
	unsigned int  getChunkSize(char* data);
	char* readLine(char *,char *);
	void readKeys(char* str,char* key1, char* key2);
	char fnwsc(char*i);
	char *remwsp(char *s);
	char *extractPatchPoint(char*,char*);
	int verbose;
public:
	DIFF();
	MAP add,rem,err;
	bool loadDiff(char *filename);
	void apply(MAP &m,char* filename);
	void setVerbose(int v);
	void clear();
};

#endif