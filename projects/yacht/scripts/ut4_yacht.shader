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

