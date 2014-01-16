textures/ut4_yacht/skybox
{
	qer_editorimage env/ut4_yacht/yacht_up.jpg

	surfaceparm noimpact
	surfaceparm nomarks
	surfaceparm nolightmap
	surfaceparm sky

	skyparms env/ut4_yacht/yacht - -

	q3map_sunExt .96 .96 1 1500 30 80 1 16
	q3map_lightmapFilterRadius 0 6
	q3map_skylight 400 5

}


textures/ut4_yacht/flat_white
{
	qer_editorimage textures/ut4_yacht/flat_white.tga

	{
		map textures/ut4_yacht/flat_white.tga
	}
	{
		map $lightmap
		blendfunc filter
	}
}


// creates maximum shadow resolution (almost looks raytraced)
textures/ut4_yacht/flat_white-highres_shadow
{
	qer_editorimage textures/ut4_yacht/flat_white.tga
	q3map_lightmapsamplesize 1

	{
		map textures/ut4_yacht/flat_white.tga
	}
	{
		map $lightmap
		blendfunc filter
	}
}


textures/ut4_yacht/gridbase
{
	qer_editorimage textures/ut4_yacht/gridbase.tga
	q3map_lightmapsamplesize 1

	{
		map textures/ut4_yacht/gridbase.tga
		rgbgen identity
	}
	{
		map $lightmap
		blendfunc filter
	}
}


textures/ut4_yacht/gridbase-red
{
	qer_editorimage textures/ut4_yacht/editor/gridbase-red.tga

	{
		map textures/ut4_yacht/gridbase.tga
		rgbgen const ( 1 0 0 )
	}
	{
		map $lightmap
		blendfunc filter
	}
}


textures/ut4_yacht/gridbase-green
{
	qer_editorimage textures/ut4_yacht/editor/gridbase-green.tga

	{
		map textures/ut4_yacht/gridbase.tga
		rgbgen const ( 0 1 0 )
	}
	{
		map $lightmap
		blendfunc filter
	}
}


textures/ut4_yacht/gridbase-blue
{
	qer_editorimage textures/ut4_yacht/editor/gridbase-blue.tga

	{
		map textures/ut4_yacht/gridbase.tga
		rgbgen const ( 0 0 1 )
	}
	{
		map $lightmap
		blendfunc filter
	}
}


textures/ut4_yacht/gridbase-purple
{
	qer_editorimage textures/ut4_yacht/editor/gridbase-purple.tga

	{
		map textures/ut4_yacht/gridbase.tga
		rgbgen const ( 1 0 1 )
	}
	{
		map $lightmap
		blendfunc filter
	}
}


textures/ut4_yacht/gridbase-teal
{
	qer_editorimage textures/ut4_yacht/editor/gridbase-teal.tga

	{
		map textures/ut4_yacht/gridbase.tga
		rgbgen const ( 0 1 1 )
	}
	{
		map $lightmap
		blendfunc filter
	}
}


textures/ut4_yacht/gridbase-yellow
{
	qer_editorimage textures/ut4_yacht/editor/gridbase-yellow.tga

	{
		map textures/ut4_yacht/gridbase.tga
		rgbgen const ( 1 1 0 )
	}
	{
		map $lightmap
		blendfunc filter
	}
}


