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

#include "patch.h"


bool PATCHPOINT::operator== (PATCHPOINT &p)
{
	if ( fabs( x - p.x ) > PATCH_ROUNDING_ERROR ) return false;
	if ( fabs( y - p.y ) > PATCH_ROUNDING_ERROR ) return false;
	if ( fabs( z - p.z ) > PATCH_ROUNDING_ERROR ) return false;
	if ( fabs( s - p.s ) > PATCH_ROUNDING_ERROR ) return false;
	if ( fabs( t - p.t ) > PATCH_ROUNDING_ERROR ) return false;
	return true;
}

PATCHPOINT& PATCHPOINT::operator= (PATCHPOINT &p)
{
	if (&p != this)
	{
		x = p.x;
		y = p.y;
		z = p.z;
		s = p.s;
		t = p.t;
	}
	return *this;
}

bool PATCH::operator== (PATCH &p)
{
	// check patch header info
	if (rows != p.rows) return false;
	if (cols != p.cols) return false;
	if (u1 != p.u1) return false;
	if (u2 != p.u2)return false;
	if (u3 != p.u3) return false;
	if (texture != p.texture) return false;

	// check num points - do i even need this? already checked cols and rows.

	if (points.size() != p.points.size()) return false;

	std::list<PATCHPOINT>::iterator p_it = p.points.begin();
	std::list<PATCHPOINT>::iterator lp_it = points.begin();

	//bool match = false;
	
	// check all points
	while (p_it != p.points.end())
	{
		if (*p_it == *lp_it)
		{
			p_it++;
			lp_it++;
		}
		else return false;
	}
	return true;
}

PATCH& PATCH::operator= (PATCH& p)
{
	if (&p != this)
	{
		cols = p.cols;
		rows = p.rows;
		u1 = p.u1;
		u2 = p.u2;
		u3 = p.u3;
		texture = p.texture;
		points.clear();
		std::list<PATCHPOINT>::iterator p_it = p.points.begin();
		while (p_it != p.points.end())
		{
			points.push_back(*p_it++);
		}
	}
	return *this;
}

void PATCH::addPoint(PATCHPOINT &p)
{
	points.push_back(p);
}

void PATCH::write(std::ofstream &oFile)
{
	oFile.flags(oFile.fixed);
	oFile << "\n{\npatchDef2\n{\n";
	oFile << texture << '\n';
	oFile << "( " << rows << ' ' << cols << ' ' 
		  << u1 << ' ' << u2 << ' ' << u3 << " )\n";
	oFile << "(\n";
	int vertexCount = 0;
	std::list<PATCHPOINT>::iterator point_iter = points.begin();
	for (;point_iter != points.end();point_iter++)
	{
		if ((vertexCount % cols) == 0) oFile << "( ";
		oFile << "( " << point_iter->x << ' ' << point_iter->y << ' ' << point_iter->z << ' ' << point_iter->s << ' ' << point_iter->t << " ) ";
		vertexCount++;
		if ((vertexCount % cols) == 0) oFile << ")\n";
	}
	oFile << ")\n}\n}\n";	
	oFile.unsetf(  oFile.fixed );
}

void PATCH::clear()
{
	points.clear();
	rows = cols = 0;
	insides.clear();
	texture.clear();
	u1=u2=u3=0;
}