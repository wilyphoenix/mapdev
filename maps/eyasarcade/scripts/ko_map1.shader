// Shaders for CMM knockout map 1

textures/ko_map1/thesky
{
	qer_editorimage env/ko_map1/sky_ft.tga
	q3map_lightRGB .92 .9 1
	q3map_skylight 400 6
	surfaceparm nomarks
	surfaceparm sky
	surfaceparm noimpact
	surfaceparm nodlight
	q3map_lightmapFilterRadius 0 8
	q3map_sunExt 1.000000 0.997119 0.99 260 90 55 2 4
	q3map_nolightmap
	skyparms env/ko_map1/sky - -
}

// Decals - this one is the arcade sign

textures/ko_map1/decal_white
{
	qer_editorimage textures/ko_map1/decal_white.tga
	polygonOffset
	nomipmaps
	nopicmip
	surfaceparm trans
	{
		map textures/ko_map1/decal_white.tga
		blendfunc filter
	}
}

// Decal for white lines on ground (parking)

textures/ko_map1/decal_line
{
	qer_editorimage textures/ko_map1/decal_line.tga
	polygonOffset
	nomipmaps
	nopicmip
	surfaceparm trans
	{
		map textures/ko_map1/decal_line.jpg
		blendfunc gl_dst_color gl_src_color
	}
}

// CMM - we ship your shit shader

textures/ko_map1/decal_containers
{
	qer_editorimage textures/ko_map1/decal_containers.tga
	polygonOffset
	nomipmaps
	nopicmip
	surfaceparm trans
	{
		map textures/ko_map1/decal_containers.jpg
		blendfunc gl_dst_color gl_src_color
	}
}

// Decal for no parking sign

textures/ko_map1/decal_grey
{
	qer_editorimage textures/ko_map1/decal_grey.tga
	polygonOffset
	nomipmaps
	nopicmip
	surfaceparm trans
	{
		map textures/ko_map1/decal_grey.jpg
		blendfunc gl_dst_color gl_src_color
	}
}

// Shader for glass, Picola made this image

textures/ko_map1/glass2
{
	qer_editorimage textures/ko_map1/glass2.tga
	qer_trans 0.40
	cull none
	{
		map textures/ko_map1/glass2.tga
		blendFunc GL_DST_COLOR GL_ZERO
		rgbGen identity
		alphaFunc GT0
		depthWrite
	}
	{
		map $lightmap
		blendFunc GL_DST_COLOR GL_ONE
		rgbGen identity
		depthFunc equal
	}
}

// Metal grid fence

textures/ko_map1/grill
{
	qer_editorimage textures/ko_map1/grill.tga
	surfaceparm alphashadow
	nopicmip
	cull none
	q3map_forcemeta
	{
		map textures/ko_map1/grill.tga
		blendFunc GL_ONE GL_ZERO
		alphaFunc GE128
		depthWrite
	}
	{
		map $lightmap
		blendfunc filter
		depthFunc equal
	}
}

// Hint shader

textures/ko_map1/hint // should NOT use surfaceparm hint.. strange but true
{
	qer_editorimage textures/waterwood.tga
	qer_nocarve
	qer_trans 0.30
	surfaceparm nodraw
	surfaceparm nonsolid
	surfaceparm structural
	surfaceparm trans
	surfaceparm noimpact
	surfaceparm hint	// ydnar: yes it should.
}

// Skip shader

textures/ko_map1/skip
{
	qer_editorimage textures/skip.tga
	qer_nocarve
	qer_trans 0.5
	surfaceparm nodraw
	surfaceparm nonsolid
	surfaceparm structural
	surfaceparm trans
	surfaceparm noimpact
	surfaceparm skip
}

// Used to clip mostly wooden models

textures/ko_map1/woodclip
{
	qer_editorimage textures/cmm_changingroom/woodclip.tga
	qer_trans 0.40
	surfaceparm nodraw
	surfaceparm nolightmap
	surfaceparm trans
}

// Used to clip metal models (containers)

textures/ko_map1/metalclip
{
	qer_editorimage textures/cmm_changingroom/metalclip.tga
	qer_trans 0.40
	surfaceparm nodraw
	surfaceparm nolightmap
	surfaceparm trans
}

// General light shader, used on all light models

textures/ko_map1/light1
{
	qer_editorimage textures/ko_map1/light1.tga
	q3map_surfacelight 5000
	surfaceparm nomarks
	surfaceparm nodamage
	{
		map $lightmap
		rgbGen identity
	}
	{
		map textures/ko_map1/light1.tga
		blendFunc GL_DST_COLOR GL_ZERO
		rgbGen identity
	}
	{
		map textures/ko_map1/light1_blend.tga
		blendfunc GL_ONE GL_ONE
	}
}

////////////////////////////////////////////////////////////////////////
//
// CMM CABINETS ARCADE MACHINES
// ----------------------------
// Suggested shaders for video screens, copy these to your shaders file
//
////////////////////////////////////////////////////////////////////////

models/mapobjects/cmm_cabinet_arcade/asteroidscreen
{
	qer_editorImage textures/azlcmb1_arcadia/asterlight.tga
	light 1
	surfaceparm nomarks
	q3map_surfacelight 300
	surfaceparm trans
	q3map_lightimage textures/azlcmb1_arcadia/asterlight.tga
	q3map_forcemeta
	{

		map $lightmap
		rgbGen identity
		blendfunc gl_dst_color gl_src_color
	}
	{
			videoMap asteroids.roq
			rgbGen identity
	}
}

////////////////////////////////////////////////////////////////////////

models/mapobjects/cmm_cabinet_arcade/pacmanscreen
{
	qer_editorImage models/mapobjects/cmm_cabinet_arcade/pacmanscreen.tga
	light 1
	surfaceparm nomarks
	q3map_surfacelight 200
	surfaceparm trans
	q3map_lightimage models/mapobjects/cmm_cabinet_arcade/pacmanscreen.tga
	q3map_forcemeta
	{
		map $lightmap
		rgbGen identity
		blendfunc gl_dst_color gl_src_color
	}
	{
		map models/mapobjects/cmm_cabinet_arcade/pacmanscreen.tga
		rgbGen identity

	}
}

////////////////////////////////////////////////////////////////////////

models/mapobjects/cmm_cabinet_arcade/mspacmanscreen
{
	qer_editorImage models/mapobjects/cmm_cabinet_arcade/mspacmanscreen.tga
	light 1
	surfaceparm nomarks
	q3map_surfacelight 200
	surfaceparm trans
	q3map_lightimage models/mapobjects/cmm_cabinet_arcade/mspacmanscreen.tga
	q3map_forcemeta
	{
		map $lightmap
		rgbGen identity
		blendfunc gl_dst_color gl_src_color
	}
	{
		map models/mapobjects/cmm_cabinet_arcade/mspacmanscreen.tga
		rgbGen identity

	}
}

////////////////////////////////////////////////////////////////////////

models/mapobjects/cmm_cabinet_arcade/spacescreen
{
	qer_editorImage models/mapobjects/cmm_cabinet_arcade/spacescreen.tga
	light 1
	surfaceparm nomarks
	q3map_surfacelight 200
	surfaceparm trans
	q3map_lightimage models/mapobjects/cmm_cabinet_arcade/spacescreen.tga
	q3map_forcemeta
	{
		map $lightmap
		rgbGen identity
		blendfunc gl_dst_color gl_src_color
	}
	{
		map models/mapobjects/cmm_cabinet_arcade/spacescreen.tga
		rgbGen identity

	}
}

////////////////////////////////////////////////////////////////////////

models/mapobjects/cmm_cabinet_arcade/kongscreen
{
	qer_editorImage models/mapobjects/cmm_cabinet_arcade/kongscreen.tga
	light 1
	surfaceparm nomarks
	q3map_surfacelight 200
	surfaceparm trans
	q3map_lightimage models/mapobjects/cmm_cabinet_arcade/kongscreen.tga
	q3map_forcemeta
	{
		map $lightmap
		rgbGen identity
		blendfunc gl_dst_color gl_src_color
	}
	{
		map models/mapobjects/cmm_cabinet_arcade/kongscreen.tga
		rgbGen identity

	}
}

////////////////////////////////////////////////////////////////////////

models/mapobjects/cmm_cabinet_arcade/urtscreen
{
	qer_editorImage models/mapobjects/cmm_cabinet_arcade/urtscreen.tga
	light 1
	surfaceparm nomarks
	q3map_surfacelight 200
	surfaceparm trans
	q3map_lightimage models/mapobjects/cmm_cabinet_arcade/urtscreen.tga
	q3map_forcemeta
	{
		map $lightmap
		rgbGen identity
		blendfunc gl_dst_color gl_src_color
	}
	{
		map models/mapobjects/cmm_cabinet_arcade/urtscreen.tga
		rgbGen identity

	}
}

// Cold drinks models, all have illuminated signs

models/mapobjects/cmm_colddrinks/greendrink
{
	qer_editorimage models/mapobjects/cmm_colddrinks/greendrink.tga
	light 1
	surfaceparm nomarks
	q3map_surfacelight 800
	surfaceparm trans
	q3map_lightimage models/mapobjects/cmm_colddrinks/greendrink.tga
	q3map_forcemeta
	{
		map $lightmap
		rgbGen identity
		blendfunc gl_dst_color gl_src_color
	}
	{
		map models/mapobjects/cmm_colddrinks/greendrink.tga
	}
}

models/mapobjects/cmm_colddrinks/orangedrink
{
	qer_editorimage models/mapobjects/cmm_colddrinks/orangedrink.tga
	light 1
	surfaceparm nomarks
	q3map_surfacelight 800
	surfaceparm trans
	q3map_lightimage models/mapobjects/cmm_colddrinks/orangedrink.tga
	q3map_forcemeta
	{
		map $lightmap
		rgbGen identity
		blendfunc gl_dst_color gl_src_color
	}
	{
		map models/mapobjects/cmm_colddrinks/orangedrink.tga
	}
}

models/mapobjects/cmm_colddrinks/reddrink
{
	qer_editorimage models/mapobjects/cmm_colddrinks/reddrink.tga
	light 1
	surfaceparm nomarks
	q3map_surfacelight 800
	surfaceparm trans
	q3map_lightimage models/mapobjects/cmm_colddrinks/reddrink.tga
	q3map_forcemeta
	{
		map $lightmap
		rgbGen identity
		blendfunc gl_dst_color gl_src_color
	}
	{
		map models/mapobjects/cmm_colddrinks/reddrink.tga
	}
}

models/mapobjects/cmm_colddrinks/cokefront
{
	qer_editorimage models/mapobjects/cmm_colddrinks/cokefront.tga
	light 1
	surfaceparm nomarks
	q3map_surfacelight 800
	surfaceparm trans
	q3map_lightimage models/mapobjects/cmm_colddrinks/cokefront.tga
	q3map_forcemeta
	{
		map $lightmap
		rgbGen identity
		blendfunc gl_dst_color gl_src_color
	}
	{
		map models/mapobjects/cmm_colddrinks/cokefront.tga
	}
}

models/mapobjects/cmm_colddrinks/pepsifront
{
	qer_editorimage models/mapobjects/cmm_colddrinks/pepsifront.tga
	light 1
	surfaceparm nomarks
	q3map_surfacelight 800
	surfaceparm trans
	q3map_lightimage models/mapobjects/cmm_colddrinks/pepsifront.tga
	q3map_forcemeta
	{
		map $lightmap
		rgbGen identity
		blendfunc gl_dst_color gl_src_color
	}
	{
		map models/mapobjects/cmm_colddrinks/pepsifront.tga
	}
}

models/mapobjects/cmm_colddrinks/fanta
{
	qer_editorimage models/mapobjects/cmm_colddrinks/fanta.tga
	light 1
	surfaceparm nomarks
	q3map_surfacelight 800
	surfaceparm trans
	q3map_lightimage models/mapobjects/cmm_colddrinks/fanta.tga
	q3map_forcemeta
	{
		map $lightmap
		rgbGen identity
		blendfunc gl_dst_color gl_src_color
	}
	{
		map models/mapobjects/cmm_colddrinks/fanta.tga
	}
}


models/mapobjects/cmm_colddrinks/mount
{
	qer_editorimage models/mapobjects/cmm_colddrinks/mount.tga
	light 1
	surfaceparm nomarks
	q3map_surfacelight 800
	surfaceparm trans
	q3map_lightimage models/mapobjects/cmm_colddrinks/mount.tga
	q3map_forcemeta
	{
		map $lightmap
		rgbGen identity
		blendfunc gl_dst_color gl_src_color
	}
	{
		map models/mapobjects/cmm_colddrinks/mount.tga
	}
}

// Red light used on Eyas sign model

textures/ko_map1/redlight
{
	qer_editorimage textures/ko_map1/redlight.tga
	light 1
	surfaceparm nomarks
	q3map_surfacelight 800
	q3map_lightimage textures/ko_map1/redlight.tga

	{
		map $lightmap
		rgbGen identity
		blendfunc gl_dst_color gl_src_color
	}
	{
		map textures/ko_map1/redlight.tga
	}
}

// Blue light on top of tardis model

models/mapobjects/cmm_tardis/bluelight
{
	qer_editorimage textures/ko_map1/bluelight.tga
	light 1
	surfaceparm nomarks
	q3map_surfacelight 800
	q3map_lightimage textures/ko_map1/bluelight.tga

	{
		map $lightmap
		rgbGen identity
		blendfunc gl_dst_color gl_src_color
	}
	{
		map textures/ko_map1/bluelight.tga
	}
}

// Urban zone league logo on advertising signs

models/mapobjects/cmm_advertising/sign2
{
	qer_editorimage models/mapobjects/cmm_advertising/sign2.tga
	light 1
	surfaceparm nomarks
	q3map_surfacelight 800
	surfaceparm trans
	q3map_lightimage models/mapobjects/cmm_advertising/sign2.tga
	q3map_forcemeta
	{
		map $lightmap
		rgbGen identity
		blendfunc gl_dst_color gl_src_color
	}
	{
		map models/mapobjects/cmm_advertising/sign2.tga
	}
}
