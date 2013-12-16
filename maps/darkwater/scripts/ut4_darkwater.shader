textures/ut4_darkwater/darksky
// Yea, RAID shader! Woo! It's a wet map, but someone has to make it.


{

// Combo shader, borrowed from ut4_cemetery666, and superman2.
// So why the cemetery sky shader? Cause Horse-A-F worked around the
// unimplemented shader features found in the Shader Manual, Appendix A.
// UrT forked Q3 before this was in the codebase. I previously made a
// killer awesome lightning shader that uses this App.A technique.
// Guess what? Doesn't work. Frozen Sand - looking at you!

	nopicmip
	nomipmaps
	sort 2

	qer_editorimage env/ut4_darkwater/darksky_up.tga

	q3map_sunExt .93 .93 1 400 40 82 1 16
//	q3map_skylight 200 3

	surfaceparm sky
	surfaceparm noimpact
	surfaceparm nomarks
	surfaceparm nolightmap

	skyparms env/ut4_darkwater/darksky 2048 -

	{
		map env/ut4_darkwater/darksky_up.tga
		tcMod scale 1 1
		tcMod scroll 0.005 -0.0125
		rgbGen identityLighting
	}

	{
		animMap .9 env/ut4_darkwater/lightning3.tga env/ut4_darkwater/black.tga env/ut4_darkwater/black.tga env/ut4_darkwater/lightning4.tga env/ut4_darkwater/lightning5.tga env/ut4_darkwater/black.tga  env/ut4_darkwater/lightning6.tga
		blendFunc add
		rgbGen identity
		rgbGen wave Sin 0 1 0 1.1
	}
}


textures/ut4_darkwater/cloudlevel_darksky
{

	q3map_noTJunc
	q3map_noClip

	sort 9
//	fogparms ( .0025 .005 .01 ) 512
	fogparms ( 0 0 0 ) 512

	surfaceparm fog
	surfaceparm trans
	surfaceparm nonsolid
	surfaceparm nomarks
	surfaceparm nolightmap
	surfaceparm noimpact

	qer_editorimage env/ut4_darkwater/sky_clouds2.tga
	qer_trans 0.8
	
}


textures/ut4_darkwater/raid_rain1
{
	q3map_cloneshader textures/ut4_darkwater/raid_rain1_invert
	q3map_noTJunc
	q3map_noClip
	q3map_tessSize 4096

	sort 9
	deformvertexes wave 256 sin 0 128 1 .05
	deformvertexes wave 512 sin 0 128 1 .04
	cull none

	surfaceparm noimpact
	surfaceparm nolightmap
	surfaceparm nomarks
	surfaceparm nonsolid
	surfaceparm trans

	qer_editorimage textures/ut4_darkwater/light_water2.tga
	qer_trans 1
	qer_nocarve

	{
		map textures/ut4_darkwater/light_water2.tga
		alphafunc lt128
		blendfunc blend
//		tcMod scale 4 .2
		tcMod scale 6 .4
		tcMod scroll 1.5 -1.15
	}

}


textures/ut4_darkwater/raid_rain1_invert
{
	q3map_invert
	q3map_noTJunc
	q3map_noClip
	q3map_tessSize 4096

	sort 9
//	deformvertexes wave 224 sin 0 128 1 .09
//	deformvertexes wave 128 sin 0 256 1 .07
	deformvertexes wave 224 sin 0 192 1 .04
	deformvertexes wave 96 sin 0 128 1 .05
	cull none

	qer_nocarve

	surfaceparm noimpact
	surfaceparm nolightmap
	surfaceparm nomarks
	surfaceparm nonsolid
	surfaceparm trans

	{
		map textures/ut4_darkwater/light_water2.tga
		alphafunc lt128
		blendfunc blend
		tcMod scale 5 .3
		tcMod scroll -1 -1.0
	}

}


textures/ut4_darkwater/dark_water
{

//	q3map_fancywater 10 0.85 0.8 0.75 // BAH!!! I FART IN YOUR GENERAL DIRECTION ;)
// Really though, this .shader in whole has taken a great amount of effort to build.

	q3map_cloneshader textures/ut4_darkwater/dark_water_reglow
	q3map_noTJunc
	q3map_noClip
	q3map_globaltexture
	q3map_tessSize 512
	q3map_vertexscale .2

//	deformvertexes wave 192 sin 0 64 1 .35
//	deformVertexes bulge 16 16 1
	deformvertexes wave 192 sin 0 96 1 .08
	deformvertexes wave 192 sin 0 96 1 .015
	deformVertexes bulge 22 22 1

	sort 8

	surfaceparm trans

	qer_editorimage textures/ut4_darkwater/dark_water1.tga
	qer_nocarve
	qer_trans 0.6

	{
		map textures/ut4_darkwater/dark_water_clouds.tga
		blendfunc gl_one gl_src_color
		tcmod scale 2 2
		tcMod scroll -.1 -.05
		tcgen environment
	}
	{
		map textures/ut4_darkwater/dark_water_clouds.tga
		blendfunc gl_dst_color gl_src_color
		tcmod scale 2 2
		tcMod scroll -.05 -.1
		tcgen environment
	}
	{
		map textures/ut4_darkwater/dark_water1.tga
		blendfunc gl_dst_color gl_src_color
		tcmod scale 1 1
		tcMod scroll -.15 -.15
	}

}



textures/ut4_darkwater/dark_water_reglow
{

	qer_editorimage textures/ut4_darkwater/editor/shader_effect.tga

	q3map_globaltexture
	q3map_invert
	q3map_noTJunc
	q3map_noClip
	q3map_tessSize 512
	q3map_vertexscale .2

	deformvertexes wave 224 sin 0 84 1 .09
	deformvertexes wave 128 sin 0 92 1 .07
	deformVertexes bulge 22 22 1

	sort 10

	surfaceparm trans

	{
		map textures/ut4_darkwater/dark_water_clouds.tga
		blendfunc gl_dst_color gl_src_color
		tcmod scale .2 .2
		tcMod scroll -0.02 -0.01
	}
	{
		map textures/ut4_darkwater/dark_water1.tga
		blendfunc gl_dst_color gl_one
		tcmod scale .3 .3
		tcMod scroll 0.03 0.03
	}
        {
		map textures/ut4_darkwater/dark_water_clouds.tga
		blendfunc gl_dst_color gl_src_color
		tcMod scale 0.25 0.25
		tcMod scroll 0.02 0.01
        }

}


textures/ut4_darkwater/black_nonsolid
{

	surfaceparm nolightmap
	surfaceparm nonsolid
	surfaceparm trans
	surfaceparm nomarks

	qer_editorimage textures/ut4_darkwater/black.jpg

	{
		map textures/ut4_darkwater/black.jpg
	}
}




/////////////////////////////////////////
//// qer editor and behavioral stuff ////
/////////////////////////////////////////

textures/ut4_darkwater/watercaulk
{
	qer_editorimage textures/ut4_darkwater/editor/watercaulk.tga
	qer_nocarve
	qer_trans 0.40

	surfaceparm water
	surfaceparm nodraw
	surfaceparm nolightmap
	surfaceparm nonsolid
	surfaceparm trans


}


textures/ut4_darkwater/nodrop
{
	qer_editorimage textures/ut4_darkwater/editor/nodrop.tga
	qer_nocarve
	qer_trans 0.5

	surfaceparm nodraw
	surfaceparm nolightmap
	surfaceparm nonsolid
	surfaceparm trans
	surfaceparm nomarks
	surfaceparm nodrop
}




///////////////////////////
//// br_ship shadering ////
///////////////////////////


models/mapobjects/br_ship/br_sail
{
	cull none

	{
		map models/mapobjects/br_ship/br_sail2.jpg
	}
	{
		map $lightmap
		blendfunc filter
	}

}


models/mapobjects/br_ship/br_sail1
{
	cull none

	{
		map models/mapobjects/br_ship/br_sail1.jpg
	}
	{
		map $lightmap
		blendfunc filter
	}

}


models/mapobjects/br_ship/br_sail2
{
	cull none

	{
		map models/mapobjects/br_ship/br_sail2.jpg
	}
	{
		map $lightmap
		blendfunc filter
	}

}


models/mapobjects/br_ship/br_ship1
{
	cull none

	{
		map models/mapobjects/br_ship/br_ship1.jpg
	}
	{
		map models/mapobjects/br_ship/br_ship1.jpg
		tcmod scale .25 .25
		tcgen environment
		blendfunc gl_dst_color gl_src_color
	}
	{
		map $lightmap
		blendfunc gl_dst_color gl_zero
		rgbGen identity
	}

}


models/mapobjects/br_ship/br_ship2
{
	cull none

	{
		map models/mapobjects/br_ship/br_ship2.jpg
	}
	{
		map $lightmap
		blendfunc filter
	}

}


models/mapobjects/br_ship/br_ship3
{
	cull none

	{
		map models/mapobjects/br_ship/br_ship3.jpg
	}
	{
		map $lightmap
		blendfunc filter
	}

}


models/mapobjects/br_ship/br_ship4
{
	cull none

	{
		map models/mapobjects/br_ship/br_ship4.jpg
	}
	{
		map $lightmap
		blendfunc filter
	}

}


models/mapobjects/br_ship/br_ship5
{
	cull none

	{
		map models/mapobjects/br_ship/br_ship5.jpg
	}
	{
		map $lightmap
		blendfunc filter
	}

}


models/mapobjects/br_ship/br_ship6
{
	cull none

	{
		map models/mapobjects/br_ship/br_ship6.jpg
	}
	{
		map $lightmap
		blendfunc filter
	}

}


models/mapobjects/br_ship/br_ship7
{
	cull none

	{
		map models/mapobjects/br_ship/br_ship7.jpg
	}
	{
		map $lightmap
		blendfunc filter
	}

}


models/mapobjects/br_ship/br_flag1
{
// Can't get the model to deform...abandoning. sucks! Sails should flow too... :(
//	deformvertexes wave 30 sin 0 20 1 .65
//	deformvertexes wave 34 sin 0 18 1 .5
//	deformVertexes bulge 8 8 1

	cull none

	{
		map models/mapobjects/br_ship/br_flag1.tga
//		blendfunc blend
	}
	{
		map $lightmap
		blendfunc filter
	}

}



