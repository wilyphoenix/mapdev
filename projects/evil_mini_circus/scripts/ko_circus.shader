textures/ko_circus/safetynet
{	
	qer_editorimage textures/ko_circus/net.tga
	surfaceparm alphashadow
	nopicmip
	cull none
	surfaceparm nodamage
	q3map_forcemeta
	{
		map textures/ko_circus/net.tga
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
textures/ko_circus/stripeddecoration
{	
    qer_editorimage textures/ko_circus/stripeddecoration.tga
	surfaceparm alphashadow
	nopicmip
	cull none
	{
		map textures/ko_circus/stripeddecoration.tga
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
textures/ko_circus/light1
{
	qer_editorimage textures/ko_circus/light1.tga
	q3map_surfacelight 400
	surfaceparm nomarks
	surfaceparm nodamage
	{
		map $lightmap
		rgbGen identity
	}
	{
		map textures/ko_circus/light1.tga
		blendFunc GL_DST_COLOR GL_ZERO
		rgbGen identity
	}
	{
		map textures/ko_circus/light1_blend.tga
		blendfunc GL_ONE GL_ONE
	}
}
textures/ko_circus/circussign
{	
    qer_editorimage textures/ko_circus/circussign.tga
	surfaceparm alphashadow
	nopicmip
	cull none
	{
		map textures/ko_circus/circussign.tga
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
// Used to clip mostly wooden models
textures/ko_circus/woodclip
{
	qer_editorimage textures/cmm_changingroom/woodclip.tga
	qer_trans 0.40
	surfaceparm nodraw
	surfaceparm nolightmap
	surfaceparm trans
	surfaceparm nodamage
}
textures/ko_circus/metalclip
{
	qer_editorimage textures/cmm_changingroom/metalclip.tga
	qer_trans 0.40
	surfaceparm nodraw
	surfaceparm nolightmap
	surfaceparm trans
	surfaceparm nodamage
}
textures/ko_circus/ceramicclip
{
	qer_editorimage textures/ko_map2/ceramic.tga
	qer_trans 0.40
	surfaceparm nodraw
	surfaceparm nolightmap
	surfaceparm trans
	surfaceparm nodamage
}
textures/ko_circus/generalclip
{
	qer_editorimage textures/ko_map2/ceramic.tga
	qer_trans 0.40
	surfaceparm nodraw
	surfaceparm nolightmap
	surfaceparm trans
	surfaceparm nodamage
	cull none
}
textures/ko_circus/redwoodplank:q3map
{
    surfaceparm nodamage
}
textures/ko_circus/circustentwall:q3map
{
    surfaceparm nodamage
}
textures/ko_circus/oldtrunk:q3map
{
    surfaceparm nodamage
}
textures/ko_circus/whitewoodplank:q3map
{
    surfaceparm nodamage
}
textures/ko_circus/wagonwheelwood:q3map
{
    surfaceparm nodamage
}
textures/ko_circus/bathroomtiles:q3map
{
    surfaceparm nodamage
}
textures/ko_circus/circustrim2:q3map
{
    surfaceparm nodamage
}
textures/ko_circus/decal1
{
	qer_editorimage textures/ko_circus/circusdecal1.tga
	polygonOffset
	nomipmaps
	nopicmip
	surfaceparm trans
	{
		map textures/ko_circus/circusdecal1.tga
		blendfunc gl_dst_color gl_src_color
	}
}
textures/ko_circus/decal2
{
	qer_editorimage textures/ko_circus/circusdecal2.tga
	polygonOffset
	nomipmaps
	nopicmip
	surfaceparm trans
	{
		map textures/ko_circus/circusdecal2.tga
		blendfunc gl_dst_color gl_src_color
	}
}
textures/ko_circus/decal3
{
	qer_editorimage textures/ko_circus/circusdecal3.tga
	polygonOffset
	nomipmaps
	nopicmip
	surfaceparm trans
	{
		map textures/ko_circus/circusdecal3.tga
		blendfunc gl_dst_color gl_src_color
	}
}
textures/ko_circus/decal4
{
	qer_editorimage textures/ko_circus/circusdecal4.tga
	polygonOffset
	nomipmaps
	nopicmip
	surfaceparm trans
	{
		map textures/ko_circus/circusdecal4.tga
		blendfunc gl_dst_color gl_src_color
	}
}
textures/ko_circus/black_fog
{
	qer_editorimage textures/azlcmb1_pirate_land/fog.tga
	qer_trans 0.7
	surfaceparm trans
	surfaceparm nonsolid
	surfaceparm fog
	fogparms ( .3 .1 0 ) 2000
	q3map_bouncescale 0
}
textures/ko_circus/exit_sign
{
	qer_editorimage textures/ko_circus/exit_sign.tga
	q3map_surfacelight 1800
	surfaceparm nomarks
	surfaceparm nodamage
	{
		map $lightmap
		rgbGen identity
	}
	{
		map textures/ko_circus/exit_sign.tga
		blendFunc GL_DST_COLOR GL_ZERO
		rgbGen identity
	}
}
