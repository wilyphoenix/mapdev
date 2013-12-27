// Shaders for CMM knockout map australia
textures/ko_australia/thesky
{
	q3map_lightRGB 1 1 .93
	q3map_skylight 901 6
	surfaceparm nomarks
	surfaceparm sky
	surfaceparm noimpact
	surfaceparm nodlight
	q3map_lightmapFilterRadius 0 8
	q3map_sunExt 1.000000 0.997119 0.99 260 90 55 2 4
	q3map_nolightmap
	skyparms env/ko_australia/sky - -
}
// Decals
textures/ko_australia/decal_1
{
	polygonOffset
	nomipmaps
	nopicmip
	surfaceparm trans
	{
		map textures/ko_australia/decal_1.tga
		blendfunc gl_dst_color gl_src_color
	}
}
textures/ko_australia/glass
{
	cull none
	{
		map textures/ko_australia/glass.tga
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
textures/ko_australia/light1
{
	q3map_surfacelight 5000
	surfaceparm nomarks
	surfaceparm nodamage
	{
		map $lightmap
		rgbGen identity
	}
	{
		map textures/ko_australia/light1.tga
		blendFunc GL_DST_COLOR GL_ZERO
		rgbGen identity
	}
	{
		map textures/ko_australia/light1_blend.tga
		blendfunc GL_ONE GL_ONE
	}
}
