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

#include "plane.h"

PLANE::PLANE()
{
}

bool PLANE::operator== (PLANE &p)
{
	// check texture settings first
	// calc normals with crossproduct
	// calc vectors from v1 to p.v1 & p.v2 & p.v3
	// check all have dot product == 0 (within tollerance)

	// CHECK TEXTURES

	//TODO: CHANGE THESE TO INCLUDE ROUNDING TO SUPPORT 1.5.0 on floats

	if (texture != p.texture) return false;
	if (flags != p.flags) return false;
	if (fabs(rotate-p.rotate) > PLANE_ROUNDING_ERROR) return false;

	if (fabs(unknown1-p.unknown1) > PLANE_ROUNDING_ERROR) return false;
	if (fabs(unknown2-p.unknown2) > PLANE_ROUNDING_ERROR) return false;
	if (fabs(xOffset-p.xOffset) > PLANE_ROUNDING_ERROR) return false;
	if (fabs(yOffset-p.yOffset) > PLANE_ROUNDING_ERROR) return false;
	if (fabs(xScale-p.xScale) > PLANE_ROUNDING_ERROR) return false;
	if (fabs(yScale-p.yScale) > PLANE_ROUNDING_ERROR) return false;

	// CHECK NORMALS 
	VECTOR norm1;
	VECTOR norm2;

	getNormal(norm1);
	p.getNormal(norm2);

	if (norm1 == norm2)
	{
		// CHECK VERTEX TO VERTEX CALCS
		// (p1v1 - p2v1 & p1v1 - p2v2 & p1v1 - p2v3) X either normal
		norm2.x = p.v1.x - v1.x;
		norm2.y = p.v1.y - v1.y;
		norm2.z = p.v1.z - v1.z;
		//dot product with norm1 axbx+ayby+azbz should equal 0
		double dot = norm1.x*norm2.x + norm1.y*norm2.y + norm1.z*norm2.z;

		if (fabs(dot) > PLANE_ROUNDING_ERROR) return false;

		norm2.x = p.v2.x - v1.x;
		norm2.y = p.v2.y - v1.y;
		norm2.z = p.v2.z - v1.z;
		dot = norm1.x*norm2.x + norm1.y*norm2.y + norm1.z*norm2.z;
		if (fabs(dot) > PLANE_ROUNDING_ERROR) return false;

		norm2.x = p.v3.x - v1.x;
		norm2.y = p.v3.y - v1.y;
		norm2.z = p.v3.z - v1.z;
		dot = norm1.x*norm2.x + norm1.y*norm2.y + norm1.z*norm2.z;
		if (fabs(dot) > PLANE_ROUNDING_ERROR) return false;
	}
	else return false;
	return true;
}

void PLANE::getNormal(VECTOR &v)
{
	//USE CROSS PRODUCT

	VECTOR a1; // from p1-p2
	VECTOR a2; // from p2-p3

	a1.x = v2.x - v1.x;
	a1.y = v2.y - v1.y;
	a1.z = v2.z - v1.z;

	a2.x = v3.x - v2.x;
	a2.y = v3.y - v2.y;
	a2.z = v3.z - v2.z;


	// v = cross result
	v.x = (a1.y * a2.z) - (a1.z * a2.y); // 1y2z -1z2y
	v.y = (a1.z * a2.x) - (a1.x * a2.z); // 1z2x - 1x2z
	v.z = (a1.x * a2.y) - (a1.y * a2.x); // uxvy - uyvx
	v.normalise();

}

PLANE& PLANE::operator= (PLANE &p)
{
	if (&p != this)
	{
		v1 = p.v1;
		v2 = p.v2;
		v3 = p.v3;
		texture = p.texture;
		unknown1 = p.unknown1;
		unknown2 = p.unknown2;
		rotate = p.rotate;
		normal = p.normal;
		xOffset = p.xOffset;
		yOffset = p.yOffset;
		xScale = p.xScale;
		yScale = p.yScale;
	}
	return *this;
}