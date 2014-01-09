textures/devdepo/vanilla_sky
{
	qer_editorimage env/devdepo/editor_image.tga

	surfaceparm noimpact
	surfaceparm nomarks
	surfaceparm nolightmap
	surfaceparm sky

	skyparms env/devdepo/devbox - -

// low quality
//	q3map_sun .96 .96 1 1000 0 65

// medium quality
//	q3map_sunExt .96 .96 1 1500 0 65 1 4

// high quality
//	q3map_sunExt .96 .96 1 2000 0 65 1 8
//	q3map_skylight 200 3

// final lighting
	q3map_sunExt .96 .96 1 1500 45 60 1 16
	q3map_lightmapFilterRadius 0 6
	q3map_skylight 400 5

}


textures/devdepo/whitegrid-32px
{
	qer_editorimage textures/devdepo/whitegrid-32px.tga
	surfaceparm nodamage

	{
		map textures/devdepo/whitegrid-32px.tga
	}
	{
		map $lightmap
		blendfunc filter
	}
}


textures/devdepo/whitegrid_shadow
{
	qer_editorimage textures/devdepo/whitegrid-32px.tga
	q3map_lightmapsamplesize 1

	surfaceparm nodamage

	{
		map textures/devdepo/whitegrid-32px.tga
	}
	{
		map $lightmap
		blendfunc filter
	}
}

