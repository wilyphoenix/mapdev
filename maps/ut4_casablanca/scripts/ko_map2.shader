// Shaders for CMM knockout map 2
// 
// Sky from Eezabad

textures/ko_map2/thesky
{
	qer_editorimage env/ko_map2/sky_up.tga
	q3map_lightRGB 1 1 .93
	q3map_skylight 901 6
	surfaceparm nomarks
	surfaceparm sky
	surfaceparm noimpact
	surfaceparm nodlight
	q3map_lightmapFilterRadius 0 8
	q3map_sunExt 1.000000 0.997119 0.99 260 90 55 2 4
	q3map_nolightmap
	skyparms env/ko_map2/sky - -
}

// Decals

textures/ko_map2/decal_white
{
	qer_editorimage textures/ko_map2/decal_white.tga
	polygonOffset
	nomipmaps
	nopicmip
	surfaceparm trans
	{
		map textures/ko_map2/decal_white.tga
		blendfunc filter
	}
}

textures/ko_map2/decalcasa
{
	qer_editorimage textures/ko_map2/casablancadecal.tga
	polygonOffset
	nomipmaps
	nopicmip
	surfaceparm trans
	{
		map textures/ko_map2/casablancadecal.jpg
		blendfunc gl_dst_color gl_src_color
	}
}

textures/ko_map2/alig1
{
	qer_editorimage textures/ko_map2/alig1.tga
	polygonOffset
	nomipmaps
	nopicmip
	surfaceparm trans
	{
		map textures/ko_map2/alig1.jpg
		blendfunc gl_dst_color gl_src_color
	}
}

textures/ko_map2/alig2
{
	qer_editorimage textures/ko_map2/alig2.tga
	polygonOffset
	nomipmaps
	nopicmip
	surfaceparm trans
	{
		map textures/ko_map2/alig2.jpg
		blendfunc gl_dst_color gl_src_color
	}
}

textures/ko_map2/decal_grey
{
	qer_editorimage textures/ko_map2/decal_grey.tga
	polygonOffset
	nomipmaps
	nopicmip
	surfaceparm trans
	{
		map textures/ko_map2/decal_grey.jpg
		blendfunc gl_dst_color gl_src_color
	}
}

textures/ko_map2/glass2
{
	qer_editorimage textures/ko_map2/glass2.tga
	qer_trans 0.40
	cull none
	{
		map textures/ko_map2/glass2.tga
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

textures/ko_map2/grill
{
	qer_editorimage textures/ko_map2/grill.tga
	surfaceparm alphashadow
	nopicmip
	cull none
	q3map_forcemeta
	{
		map textures/ko_map2/grill.tga
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
textures/ko_map2/hint // should NOT use surfaceparm hint.. strange but true
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
textures/ko_map2/skip
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
textures/ko_map2/woodclip
{
	qer_editorimage textures/cmm_changingroom/woodclip.tga
	qer_trans 0.40
	surfaceparm nodraw
	surfaceparm nolightmap
	surfaceparm trans
}

// Used to clip metal models (containers)
textures/ko_map2/metalclip
{
	qer_editorimage textures/cmm_changingroom/metalclip.tga
	qer_trans 0.40
	surfaceparm nodraw
	surfaceparm nolightmap
	surfaceparm trans
}

textures/ko_map2/ceramicclip
{
	qer_editorimage textures/ko_map2/ceramic.tga
	qer_trans 0.40
	surfaceparm nodraw
	surfaceparm nolightmap
	surfaceparm trans
}

textures/ko_map2/light1
{
	qer_editorimage textures/ko_map2/light1.tga
	q3map_surfacelight 5000
	surfaceparm nomarks
	surfaceparm nodamage
	{
		map $lightmap
		rgbGen identity
	}
	{
		map textures/ko_map2/light1.tga
		blendFunc GL_DST_COLOR GL_ZERO
		rgbGen identity
	}
	{
		map textures/ko_map2/light1_blend.tga
		blendfunc GL_ONE GL_ONE
	}
}

models/mapobjects/cmm_palmtree/palmtree
{
	qer_editorimage models/mapobjects/cmm_palmtree/palmtree.tga
	surfaceparm alphashadow
	nopicmip
	cull none
	q3map_forcemeta
	{
		map models/mapobjects/cmm_palmtree/palmtree.tga
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


models/mapobjects/azlcmb1_jump_plants/spikey
{
	qer_editorimage models/mapobjects/azlcmb1_jump_plants/spikey.tga
	surfaceparm alphashadow
	nopicmip
	cull none
	q3map_forcemeta
	{
		map models/mapobjects/azlcmb1_jump_plants/spikey.tga
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

models/mapobjects/azlcmb1_jump_plants/cheese
{
	qer_editorimage models/mapobjects/azlcmb1_jump_plants/cheese.tga
	surfaceparm alphashadow
	nopicmip
	cull none
	q3map_forcemeta
	{
		map models/mapobjects/azlcmb1_jump_plants/cheese.tga
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
models/mapobjects/azlcmb1_jump_plants/donkey
{
	qer_editorimage models/mapobjects/azlcmb1_jump_plants/donkey.tga
	surfaceparm alphashadow
	nopicmip
	cull none
	q3map_forcemeta
	{
		map models/mapobjects/azlcmb1_jump_plants/donkey.tga
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
models/mapobjects/azlcmb1_jump_plants/fern
{
	qer_editorimage models/mapobjects/azlcmb1_jump_plants/fern.tga
	surfaceparm alphashadow
	nopicmip
	cull none
	q3map_forcemeta
	{
		map models/mapobjects/azlcmb1_jump_plants/fern.tga
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

