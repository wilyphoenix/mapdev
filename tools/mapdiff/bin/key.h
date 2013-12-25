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
#ifndef _KEY_H
#define _KEY_H

#include <string>
#include <fstream>

class KEY
{
public:
	std::string key;
	std::string value;
	KEY();
	bool operator== (KEY &k);
	KEY& operator= (KEY& k);
	void write(std::ofstream &oFile);
	void clear();
};

#endif