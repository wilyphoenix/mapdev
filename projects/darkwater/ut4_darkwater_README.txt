================================================================================
* Urban Terror Level *
--------------------------------------------------------------------------------
Title			: Dark water
Filename		: ut4_darkwater.bsp
Author			: wily duck
Date			: December 2013
E-mail address		: wily_duck_gamedev@digitalamusement.com
Homepage URL		: http://gamedev.digitalamusement.com


--------------------------------------------------------------------------------
* Includes *
--------------------------------------------------------------------------------

 - The .map source file.
 - A dev/ folder containing:
	+ An immensely useful perl script I wrote to re-version iterations of
          each release of this map. You'll wonder how you got along without it.
 - Environmental shaders that I welcome the community to harness the techniques
   used for maps needing such extreme weather. Snow storm anyone?
 - A technique that minimizes the jittery-ness of standing on a func_pendulum.
 

--------------------------------------------------------------------------------
* Level Description *
--------------------------------------------------------------------------------

Dark water. Two ships are amidst a churning sea, with players fighting to
take the other ship. The rain is heavy. The sea is violent. Survive!

This is the next iteration of ut4_raid, where my main goal was to get the heavy
rain working without crashing the server. This time, I was not only successful,
but the rain is truly volumetric in appearance, best it can be in UrT using
shaders (vs particles).

Out of the technology test, a map with gameplay emerged, thanks to
FSK405 Nikki/kitty's suggestion having the cannons on the ship could launch
players.

6vs6 is a likely scenario. If possible, pistols and knives only.

Due to the func_pendulum nature of the ship, climbing to the crow's nest is
impossible. It is possible to get stuck in parts of the ship, though getting
unstuck is easy (or a matter of time until the boat rocks the other way). My
technique for preventing getting stuck is simple: re-enforce the hull. Add
additional layers of hull under the surface, so when collision with the upper
surface fails, the second surface catches the player, sprouting them back to
the surface layer. A third layer is added for insurance.



--------------------------------------------------------------------------------
Single Player		: No, except for FFA
Gamemodes		: CTF, TDM, TS, FFA
Suggested player load	: 2-16
New Textures		: Yes
New Sounds		: Yes
--------------------------------------------------------------------------------




--------------------------------------------------------------------------------
* Construction *
--------------------------------------------------------------------------------
Map Base		: Original
Mapobjects used		: Blackrayne model (ship)
Editor used		: GTKRadiant 1.6.3 and .4
Compiler(s) used	: q3map2_urt.exe
Other utilities used	: Photoshop CS5, q3map2build, notepad, perl
Known Bugs		: Bugs stomped out by the amazing Superman test crew.
Compile machine		: AMD Phenom 2 quad-core 940 3.0ghz, 4GB RAM,
			  Win7 x64 Ultimate
Compile time, total	: 30 seconds, -bsp and -light. No -vis.
Lightmaps		: a few
Total Brushes		: not many
Total Entities		: couple
DM spawns		: some
CTF spawns		: more
Bomb spawns		: none
CaH capturepoints	: none
PK3 Compression		: Zip, fastest



--------------------------------------------------------------------------------
* Compile notes *
--------------------------------------------------------------------------------

Quick and simple compile. Compile log is in dev/.


--------------------------------------------------------------------------------
* OTHER LEVELS BY THE AUTHOR *
--------------------------------------------------------------------------------
ut_koth		: King of the Hill		: Own the hill, it's an upward struggle.
ut_cahos	: Capture and Hold Chaos	: Arena UrT CaH.
ut_deep		: Deep under the ocean		: Hold your breath, fight for air.
ut_sled		: Downhill Ice Fight		: Snowboarding the mountainside.
ut_sled_free	: Second Downhill Ice Fight	: Own the snowbowl.
ut4_pacman	: Pacman			: UrT in classic Pacman
ut_mspacman	: Ms. Pacman			: UrT in classic Ms. Pacman
ut4_mspacman1	: Ms. Pacman, level 1		: Repacked for UrT4.
ut4_mspacman2	: Ms. Pacman, level 2		: Repacked for UrT4.
ut4_mspacman3	: Ms. Pacman, level 3		: Repacked for UrT4.
ut4_mapmaker	: The Urban Terror Map Maker	: Learn to map. All tools included.
ut4_joust	: Experimental jousting		: Fly and snipe joust.
ut4_raid	: 2008 Map contest entry	: Torrential downpouring rain.
ut4_temple2	: Lost Temple			: Lots of gameplay variety.
ut4_superman	: Urban Terror Supersoldier	: Vertical gameplay in a huge map.
ut4_superman2	: The second superman		: Next iteration of superman.
ut4_darkwater	: Dark water battle		: Heavy rain on a dark sea.


--------------------------------------------------------------------------------
* CREDITS *
--------------------------------------------------------------------------------

+ Blackrayne. WTF Blackrayne - return an email or PM! You're one of the most
  important contributors to the game! We love you! :D

+ Nikki/kitty, FSK405. She's a runaway success. Her suggestion made this map playable.



Map Media and Content From External Sources
-------------------------------------------

Models:
 - Lt1/BlackRayne http://www.blackrayne.net

** NOTE ** - Please note! The br_ship model was not shadered. I have done so - you'll want to
be aware of this in case any other ship model is affected. No funky shadering,
just standard filtered lightmap. I wanted to make the sails and flag wave...
no dice.


Textures:
 - My textures.
 - Misc. textures	: Anyone's who's textures have circled the net and landed on my shores. I don't
			  have any other readme's or documents to show what came from where, so I thank
			  you, the unnamed developer, for your contributions to the community.

Sounds:
 - Free sounds from around the net.



================================================================================
* COPYRIGHT / PERMISSIONS *
--------------------------------------------------------------------------------
This level is designed for the Quake 3 Total Conversion "Urban Terror". All resources in the map are
reusable. Include credit to me if repacked.