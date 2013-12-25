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

#include <iostream>

#include "entity.h"

void ENTITY::addKey(KEY &k)
{
	keys.push_back(k);
}

void ENTITY::addBrush(BRUSH &b)
{
	brushes.push_back(b);
}

void ENTITY::addPatch(PATCH &p)
{
	patches.push_back(p);
}

bool ENTITY::operator== (ENTITY &e)
{
	// WHOLE ENTITY COMPARISON
	// KEYS
	// BRUSHES
	// PATCHES

	//remember they wont be in the same order!

	// chcek number of entrys in each list

	if (keys.size() != e.keys.size()) return false;
	if (brushes.size() != e.brushes.size()) return false;
	if (patches.size() != e.patches.size()) return false;

	int i;
	bool compared[34000]; 

	// keys first, i dont think i need compaarison checking for this one

	std::list<KEY>::iterator lk_it = keys.begin();
	while (lk_it != keys.end())
	{
		bool found = false;
		std::list<KEY>::iterator k_it = e.keys.begin();
		while (!found && (k_it != e.keys.end())) if (*k_it++ == *lk_it) found = true;
		if (found == false) return false;
		lk_it++;
	}

	// patches
	for (i=0;i<34000;i++) compared[i] = false;
	std::list<PATCH>::iterator lp_it = patches.begin();
	while ( lp_it != patches.end())
	{
		bool found = false;
		std::list<PATCH>::iterator p_it = e.patches.begin();
		i=0;
		while (!found && (p_it != e.patches.end())) 
		{
			if (compared[i] == false)
			{
				if (*lp_it == *p_it) 
				{
					found = true;
					compared[i] = true;
				}
				else
				{
					i=i+0;
				}
			}
			i++;
			p_it++;
		}
		if (found == false) 
		{
			return false;
		}
		lp_it++;
	}

	// brushes

	// how to improve efficientcy
	// 1, copy brushes list and remove matched brushes when mathched

	std::list<BRUSH> copy = e.brushes;

	std::list<BRUSH>::iterator lb_it = brushes.begin();
	while (lb_it != brushes.end())
	{
		bool found = false;
		i=0;
		std::list<BRUSH>::iterator b_it = copy.begin();
		while (!found && (b_it != copy.end()))
		{
			if (*b_it == *lb_it)
			{
				found = true;
				copy.erase(b_it);
			}
			else 
			{
				b_it++;
			}
			i++;
		}
		if (found == false) 
		{
			return false;
		}
		lb_it++;
	}

	return true;
}

void ENTITY::findKey(std::string &k,std::string &v)
{
	std::list<KEY>::iterator it=keys.begin();
	bool found =false;
	v = "";
	while (!found && it!=keys.end())
	{
		if (k == it->key) 
		{
			v=it->value;
			found = true;
		}
		it++;
	}
}

bool ENTITY::setKey(std::string &k,std::string &v)
{
	bool found = false;
	for (std::list<KEY>::iterator it=keys.begin();it!=keys.end();it++)
	{
		if (k == it->key)
		{
			it->value = v;
			found = true;
		}
	}
	if (!found) // must create keys
	{
		KEY nk;
		nk.key = k;
		nk.value = v;
		addKey(nk);
	}
	return found;
}

ENTITY& ENTITY::operator= (ENTITY& e)
{
	if (&e != this)
	{
		BRUSH b;
		PATCH p;
		KEY k;

		std::list<BRUSH>::iterator b_it = e.brushes.begin();
		std::list<PATCH>::iterator p_it = e.patches.begin();
		std::list<KEY>::iterator k_it = e.keys.begin();

		brushes.clear();
		patches.clear();
		keys.clear();

		while (b_it != e.brushes.end())
		{
			b = *b_it++;
			brushes.push_back(b);
		}

		while (p_it != e.patches.end())
		{
			p = *p_it++;
			patches.push_back(p);
		}

		while(k_it != e.keys.end())
		{
			k = *k_it++;
			keys.push_back(k);
		}
	}
	return *this;
}

void ENTITY::clear()
{
	brushes.clear();
	keys.clear();
	patches.clear();
}