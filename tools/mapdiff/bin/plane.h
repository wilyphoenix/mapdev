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
#ifndef _PLANE_H
#define _PLANE_H

#include <string>

#include "vector.h"

#define PLANE_ROUNDING_ERROR 0.001

class PLANE
{
public:

	VERTEX v1,v2,v3;
	std::string texture;
	double xOffset;
	double yOffset;
	double rotate;
	double xScale;
	double yScale;
	long int flags;
	double unknown1;
	double unknown2;

	VECTOR normal;
	PLANE();
	bool operator== (PLANE &p);
	PLANE& operator= (PLANE &p);
	void getNormal(VECTOR &v);
};


// ( 72 -80 -48 ) ( 72 -16 -48 ) ( 72 -80 80 ) ps_test/ps_fire 96 32 12 -0.500000 0.500000 134217728 0 0

//  VERTEX          VERTEX          VERTEX         TEXTURE     X  Y  R   X Scale    y Scale  DETAIL UNKNOWN UNKNOWN
//                                                  string     f  f  f     f            f      int    f      f

#endif