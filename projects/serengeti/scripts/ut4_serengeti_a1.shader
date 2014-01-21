textures/ut4_serengeti_a1/skybox
{
	qer_editorimage env/ut4_serengeti_a1/genericblue_up.jpg

	surfaceparm noimpact
	surfaceparm nomarks
	surfaceparm nolightmap
	surfaceparm sky

	skyparms env/ut4_serengeti_a1/genericblue - -

	q3map_sunExt .96 .96 1 1500 30 80 1 16
	q3map_lightmapFilterRadius 0 6
	q3map_skylight 400 5

}


textures/ut4_serengeti_a1/flat_white
{
	qer_editorimage textures/ut4_serengeti_a1/flat_white.tga

	{
		map textures/ut4_serengeti_a1/flat_white.tga
	}
	{
		map $lightmap
		blendfunc filter
	}
}


// creates maximum shadow resolution (almost looks raytraced)
textures/ut4_serengeti_a1/flat_white-highres_shadow
{
	qer_editorimage textures/ut4_serengeti_a1/flat_white.tga
	q3map_lightmapsamplesize 1

	{
		map textures/ut4_serengeti_a1/flat_white.tga
	}
	{
		map $lightmap
		blendfunc filter
	}
}


textures/ut4_serengeti_a1/gridbase
{
	qer_editorimage textures/ut4_serengeti_a1/gridbase.tga
	q3map_lightmapsamplesize 1

	{
		map textures/ut4_serengeti_a1/gridbase.tga
		rgbgen identity
	}
	{
		map $lightmap
		blendfunc filter
	}
}


textures/ut4_serengeti_a1/gridbase_alpha
{
	qer_trans 0.30
	qer_editorimage textures/ut4_serengeti_a1/gridbase_alpha.tga

	surfaceparm alphashadow
	surfaceparm detail
	surfaceparm trans
	surfaceparm noimpact
	surfaceparm playerclip
	surfaceparm nolightmap

	cull none

	{
		map textures/ut4_serengeti_a1/gridbase_alpha.tga
		blendfunc blend
		depthWrite
		rgbGen identity
	}
}


textures/ut4_serengeti_a1/gridbase_dark
{
	qer_editorimage textures/ut4_serengeti_a1/gridbase_alpha.tga

	{
		map textures/ut4_serengeti_a1/gridbase_alpha.tga
		rgbGen identity
	}
	{
		map $lightmap
		rgbGen identity
		blendFunc GL_DST_COLOR GL_ZERO
	}

}


textures/ut4_serengeti_a1/gridbase-red
{
	qer_editorimage textures/ut4_serengeti_a1/editor/gridbase-red.tga

	{
		map textures/ut4_serengeti_a1/gridbase.tga
		rgbgen const ( 1 0 0 )
	}
	{
		map $lightmap
		blendfunc filter
	}
}


textures/ut4_serengeti_a1/gridbase-green
{
	qer_editorimage textures/ut4_serengeti_a1/editor/gridbase-green.tga

	{
		map textures/ut4_serengeti_a1/gridbase.tga
		rgbgen const ( 0 1 0 )
	}
	{
		map $lightmap
		blendfunc filter
	}
}


textures/ut4_serengeti_a1/gridbase-blue
{
	qer_editorimage textures/ut4_serengeti_a1/editor/gridbase-blue.tga

	{
		map textures/ut4_serengeti_a1/gridbase.tga
		rgbgen const ( 0 0 1 )
	}
	{
		map $lightmap
		blendfunc filter
	}
}


textures/ut4_serengeti_a1/gridbase-purple
{
	qer_editorimage textures/ut4_serengeti_a1/editor/gridbase-purple.tga

	{
		map textures/ut4_serengeti_a1/gridbase.tga
		rgbgen const ( 1 0 1 )
	}
	{
		map $lightmap
		blendfunc filter
	}
}


textures/ut4_serengeti_a1/gridbase-cyan
{
	qer_editorimage textures/ut4_serengeti_a1/editor/gridbase-cyan.tga

	{
		map textures/ut4_serengeti_a1/gridbase.tga
		rgbgen const ( 0 1 1 )
	}
	{
		map $lightmap
		blendfunc filter
	}
}


textures/ut4_serengeti_a1/gridbase-yellow
{
	qer_editorimage textures/ut4_serengeti_a1/editor/gridbase-yellow.tga

	{
		map textures/ut4_serengeti_a1/gridbase.tga
		rgbgen const ( 1 1 0 )
	}
	{
		map $lightmap
		blendfunc filter
	}
}


textures/ut4_serengeti_a1/gridbase-orange
{
	qer_editorimage textures/ut4_serengeti_a1/editor/gridbase-orange.tga

	{
		map textures/ut4_serengeti_a1/editor/gridbase-orange.tga
		rgbgen const ( 1 .5 0 )
	}
	{
		map $lightmap
		blendfunc filter
	}
}


textures/ut4_serengeti_a1/gridbase-bright_red
{
	qer_editorimage textures/ut4_serengeti_a1/editor/gridbase-bright_red.tga

	{
		map textures/ut4_serengeti_a1/editor/gridbase-bright_red.tga
	}
	{
		map $lightmap
		blendfunc filter
	}
}


textures/ut4_serengeti_a1/gridbase-bright_green
{
	qer_editorimage textures/ut4_serengeti_a1/editor/gridbase-bright_green.tga

	{
		map textures/ut4_serengeti_a1/editor/gridbase-bright_green.tga
	}
	{
		map $lightmap
		blendfunc filter
	}
}


textures/ut4_serengeti_a1/gridbase-bright_blue
{
	qer_editorimage textures/ut4_serengeti_a1/editor/gridbase-bright_blue.tga

	{
		map textures/ut4_serengeti_a1/editor/gridbase-bright_blue.tga
	}
	{
		map $lightmap
		blendfunc filter
	}
}


textures/ut4_serengeti_a1/gridbase-bright_purple
{
	qer_editorimage textures/ut4_serengeti_a1/editor/gridbase-bright_purple.tga

	{
		map textures/ut4_serengeti_a1/editor/gridbase-bright_purple.tga
	}
	{
		map $lightmap
		blendfunc filter
	}
}


textures/ut4_serengeti_a1/gridbase-bright_cyan
{
	qer_editorimage textures/ut4_serengeti_a1/editor/gridbase-bright_cyan.tga

	{
		map textures/ut4_serengeti_a1/editor/gridbase-bright_cyan.tga
	}
	{
		map $lightmap
		blendfunc filter
	}
}


textures/ut4_serengeti_a1/gridbase-bright_yellow
{
	qer_editorimage textures/ut4_serengeti_a1/editor/gridbase-bright_yellow.tga

	{
		map textures/ut4_serengeti_a1/editor/gridbase-bright_yellow.tga
	}
	{
		map $lightmap
		blendfunc filter
	}
}


textures/ut4_serengeti_a1/gridbase-bright_orange
{
	qer_editorimage textures/ut4_serengeti_a1/editor/gridbase-bright_orange.tga

	{
		map textures/ut4_serengeti_a1/editor/gridbase-bright_orange.tga
	}
	{
		map $lightmap
		blendfunc filter
	}
}


