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

#include "key.h"

KEY::KEY()
{
	key = "";
	value = "";
}

bool KEY::operator== (KEY &k)
{
	if ((key == k.key) && (value == k.value)) return true;
	return false;
}

KEY& KEY::operator= (KEY& k)
{
	if (&k != this)
	{
		key = k.key;
		value = k.value;
	}
	return *this;
}

void KEY::write(std::ofstream &oFile)
{
	oFile << key << ' ' << value << '\n';
}

void KEY::clear()
{
	KEY();
}