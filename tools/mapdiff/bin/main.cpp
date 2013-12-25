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
#include <cstdlib>
#include <sstream>
#include <cstring>

#include "map.h"
#include "diff.h"

enum function {
	_MERGE,
	_DIFF,
	_MAPC,
	_UNKNOWN
};

#ifndef ___DLL

void outputInfo()
{
	std::cout << "\nQ3 Map Diff/Merge Tool Version 1.0";
	std::cout << "\nby $NulL, "<< __DATE__ << ",   " << __TIME__ <<"\n\n";
}

void cleanBohemiaBounce()
{
	MAP b1,b2,b3,b4,b5,b6,b7,b8;
	MAP b9;
	MAP b10;
	MAP b11;
	MAP b12;
	MAP b13;
	MAP b14;
	MAP b15;
	MAP b16;
	MAP b17;
	MAP b18;
	MAP b19;
	MAP b20;

	b1.loadMap("G:/Games/UrbanTerror/q3ut4/maps/ut4_bohemia_bounce_000.map");
	b2.loadMap("G:/Games/UrbanTerror/q3ut4/maps/ut4_bohemia_bounce_001.map");
	b3.loadMap("G:/Games/UrbanTerror/q3ut4/maps/ut4_bohemia_bounce_002.map");
	b4.loadMap("G:/Games/UrbanTerror/q3ut4/maps/ut4_bohemia_bounce_003.map");
	b5.loadMap("G:/Games/UrbanTerror/q3ut4/maps/ut4_bohemia_bounce_004.map");
	b6.loadMap("G:/Games/UrbanTerror/q3ut4/maps/ut4_bohemia_bounce_005.map");
	b7.loadMap("G:/Games/UrbanTerror/q3ut4/maps/ut4_bohemia_bounce_006.map");
	b8.loadMap("G:/Games/UrbanTerror/q3ut4/maps/ut4_bohemia_bounce_007.map");
	b9.loadMap("G:/Games/UrbanTerror/q3ut4/maps/ut4_bohemia_bounce_008.map");
	b10.loadMap("G:/Games/UrbanTerror/q3ut4/maps/ut4_bohemia_bounce_009.map");
	b11.loadMap("G:/Games/UrbanTerror/q3ut4/maps/ut4_bohemia_bounce_010.map");
	b12.loadMap("G:/Games/UrbanTerror/q3ut4/maps/ut4_bohemia_bounce_011.map");
	b13.loadMap("G:/Games/UrbanTerror/q3ut4/maps/ut4_bohemia_bounce_012.map");
	b14.loadMap("G:/Games/UrbanTerror/q3ut4/maps/ut4_bohemia_bounce_013.map");
	b15.loadMap("G:/Games/UrbanTerror/q3ut4/maps/ut4_bohemia_bounce_014.map");
	b16.loadMap("G:/Games/UrbanTerror/q3ut4/maps/ut4_bohemia_bounce_015.map");
	b17.loadMap("G:/Games/UrbanTerror/q3ut4/maps/ut4_bohemia_bounce_016.map");
	b18.loadMap("G:/Games/UrbanTerror/q3ut4/maps/ut4_bohemia_bounce_017.map");
	b19.loadMap("G:/Games/UrbanTerror/q3ut4/maps/ut4_bohemia_bounce_018.map");
	b20.loadMap("G:/Games/UrbanTerror/q3ut4/maps/ut4_bohemia_bounce_019.map");

	std::cout << "Adding";
	b1 += b2;std::cout << ".";
	b1 += b3;std::cout << ".";
	b1 += b4;std::cout << ".";
	b1 += b5;std::cout << ".";
	b1 += b6;std::cout << ".";
	b1 += b7;std::cout << ".";
	b1 += b8;std::cout << ".";
	b1 += b9;std::cout << ".";
	b1 += b10;std::cout << ".";
	b1 += b11;std::cout << ".";
	b1 += b12;std::cout << ".";
	b1 += b13;std::cout << ".";
	b1 += b14;std::cout << ".";
	b1 += b15;std::cout << ".";
	b1 += b16;std::cout << ".";
	b1 += b17;std::cout << ".";
	b1 += b18;std::cout << ".";
	b1 += b19;std::cout << ".";
	b1 += b20;std::cout << ".\n";

	b1.cleanBouncedLight();

	b1.writeMap("G:/Games/UrbanTerror/q3ut4/maps/ut4_bohemia_bounce_total.map");
}

int main(int argc, char *argv[])
{
	// Bohemia Specific Stuff
	cleanBohemiaBounce();
	return 0;

	function mode = _UNKNOWN;
	int verbose = 1;
	char file1[2000];
	char file2[2000];
	char oFile[2000];

	int i=0;
	while (i<argc)
	{
		//std::cout << argv[i] << '\n';

		if ( !strcmp(argv[i],"-merge") || !strcmp(argv[i],"-m") || !strcmp(argv[i],"-M"))
		{
			if (argc >= i+4)
			{
				mode = _MERGE;
				strcpy(file1,argv[argc-3]);
				strcpy(file2,argv[argc-2]);
				strcpy(oFile,argv[argc-1]);
			}
			else
			{
				if (verbose) std::cout << "Not Enough Parameters For -merge\n";
			}
		}
		else if ( !strcmp(argv[i],"-diff") || !strcmp(argv[i],"-d") || !strcmp(argv[i],"-D") )
		{
			if (argc >= i+4)
			{
				mode = _DIFF;
				strcpy(file1,argv[argc-3]);
				strcpy(file2,argv[argc-2]);
				strcpy(oFile,argv[argc-1]);
			}
			else
			{
				if (verbose) std::cout << "Not Enough Parameters For -diff\n";
			}
		}
		else if (!strcmp(argv[i],"-v"))
		{
			verbose = 2;
		}
		else if (!strcmp(argv[i],"-no"))
		{
			verbose = 0;
		}
		

		i++;
	}

	if (verbose) outputInfo();

	// if nothing as been passed to the program, output usage instructions & exit program
	if ( (argc == 1) && verbose )
	{
		// Instructions
		std::cout << "USAGE:\n";
		std::cout << "     mapdiff -merge [options] map_file      diff_file     merged_output_file\n";
		std::cout << "     mapdiff -diff  [options] old_map_file  new_map_file  diff_file\n";
		std::cout << "     mapdiff -mapc  [options] map_file  Repo_Name Revision_Number\n\n     OPTIONS:\n";
		std::cout << "         -v    Extra Verbose Output\n";
		std::cout << "         -no   No Output\n\n";
		return 0;
	}

	if (mode == _MERGE)
	{
		MAP map;
		DIFF diff;
		diff.setVerbose(verbose);
		if (map.loadMap(file1) && diff.loadDiff(file2))
		{
			//std::cout << outFilename << '\n';
			char errFile[2000];
			strcpy(errFile,file1);
			char* pdot = strrchr(errFile,'.');
			if (pdot)
			{
				strcpy(pdot,"_merge_errors.map");
			}
			else
			{
				strcat(errFile,"_merge_errors.map");
			}
			diff.apply(map,errFile);
			map.writeMap(oFile);
		}
		else
		{
			if (verbose) std::cout << "ERROR: Couldnt load input files, bailing out.";
			return 1;
		}
	}
	else if (mode == _DIFF)
	{
		MAP oldMap,newMap;
		newMap.setVerbose(verbose);
		oldMap.setVerbose(verbose);
		if (oldMap.loadMap(file1) && newMap.loadMap(file2))
		{
			newMap.generateDiff(oldMap,oFile);
		}
		else
		{
			if (verbose) std::cout << "ERROR: Couldnt load input files, bailing out.";
			return 1;
		}
	}
	return 0;
}

#endif

#ifdef ___DLL

#include <windows.h>

// DLL functions go here

BOOL APIENTRY DllMain( HMODULE hModule,
                       DWORD  ul_reason_for_call,
                       LPVOID lpReserved
					 )
{
	switch (ul_reason_for_call)
	{
	case DLL_PROCESS_ATTACH:
	case DLL_THREAD_ATTACH:
	case DLL_THREAD_DETACH:
	case DLL_PROCESS_DETACH:
		break;
	}
	return TRUE;
}

/*

	1: Add details to a map file (char *reponame, int revision, char *filename) 

	2: Get details from a map file (char *filename, int &rev, char* reponame)

	3: Get a .diff of two maps

	4: Merge a diff and .map and pass output filename


*/

// Function Declarations

// 1
extern "C" __declspec(dllexport) bool __cdecl map_addinfo(char* filename,int revision,char*reponame);

// 2
extern "C" __declspec(dllexport) int __cdecl map_getinfo(char*filename,int &revision,char* &reponame);

// 3
extern "C" __declspec(dllexport) bool __cdecl map_makediff(char*map1,char*map2,char*diff);

// 4
extern "C" __declspec(dllexport) bool __cdecl map_merge(char*map1,char*diff,char*outmap);



// Function Definitions

__declspec(dllexport) bool __cdecl map_addinfo(char* filename,int revision,char*reponame)
{
	MAP map;
	if (map.loadMap(filename))
	{
		std::string key,value;
		key = "\"MC_REPO\"";
		std::stringstream oss;
		oss << revision;
		std::string rn = "\"";
		rn += reponame;
		rn += "\"";
		map.worldspawn.setKey(key,rn);
		key = "\"MC_REV\"";
		std::string rev = '\"' + oss.str() + '\"';
		map.worldspawn.setKey(key,rev);
		map.writeMap(filename); // G:/Games/UrbanTerror/q3ut4/maps/arch12.map
		return true;
	}
	return false; // Map didnt load
}

__declspec(dllexport) int __cdecl map_getinfo(char*filename,int &revision,char* &reponame)
{
	MAP map;
	revision = -1;
	char *p,temp[50];
	if ( map.loadMap(filename) )
	{
		
		std::string key = "\"MC_REPO\"";
		std::string value;
		map.worldspawn.findKey(key,value);
		if (value == "") return revision;
		strcpy(temp,value.c_str());
		p = temp;			  // remove leading "
		p++;
		p[strlen(p)-1] = 0; // remove trailing "
		strcpy(reponame,p);
		key = "\"MC_REV\"";
		map.worldspawn.findKey(key,value);
		if (value == "") return revision;
		strcpy(temp,value.c_str());
		p = temp;			  // remove leading "
		p++;
		p[strlen(p)-1] = 0; // remove trailing "
		revision = atoi(p);
	}
	return revision;
}

__declspec(dllexport) bool __cdecl map_makediff(char*map1,char*map2,char*diff)
{
	MAP oldMap,newMap;
	newMap.setVerbose(0);
	oldMap.setVerbose(0);
	if (oldMap.loadMap(map1) && newMap.loadMap(map2))
	{
		newMap.generateDiff(oldMap,diff);
		return true;
	}
	return false;
}

__declspec(dllexport) bool __cdecl map_merge(char*map1,char*indiff,char*outmap)
{
	MAP map;
	DIFF diff;
	map.setVerbose(0);
	diff.setVerbose(0);
	if (map.loadMap(map1) && diff.loadDiff(indiff))
	{
		//std::cout << outFilename << '\n';
		char errFile[2000];
		strcpy(errFile,map1);
		char* pdot = strrchr(errFile,'.');
		if (pdot)
		{
			strcpy(pdot,"_merge_errors.map");
		}
		else
		{
			strcat(errFile,"_merge_errors.map");
		}
		diff.apply(map,errFile);
		map.writeMap(outmap);
		return true;
	}
	return false;
}

#endif