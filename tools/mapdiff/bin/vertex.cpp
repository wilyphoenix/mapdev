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

#include <cmath>

#include "vertex.h"

bool VERTEX::operator==(VERTEX &v1)
{
	//if ( (v1.x == x) && (v1.y == y) && (v1.z == z) ) return true;

	if (fabs( v1.x - x ) > VERTEX_ROUNDING_ERROR) return false;
	if (fabs( v1.y - y ) > VERTEX_ROUNDING_ERROR) return false;
	if (fabs( v1.z - z ) > VERTEX_ROUNDING_ERROR) return false;

	return true;
}

VERTEX& VERTEX::operator=(VERTEX &v)
{
	if (&v != this)
	{
		x = v.x;
		y = v.y;
		z = v.z;
	}
	return *this;
}