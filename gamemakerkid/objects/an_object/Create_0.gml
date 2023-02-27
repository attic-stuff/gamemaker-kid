var size = 256;
var window = 2;
window_set_size(size * window, size * window);
surface_resize(application_surface, size, size);
display_set_gui_size(size, size);
application_surface_draw_enable(false);

line = 128;

brightness = 4;
dither = 0.05;
crush = 1;

var rgb = 3;
var count = 4;

uniforms = array_create(3);
uniforms[0] = shader_get_uniform(pp_gamemakerkid, "parameters");
uniforms[1] = shader_get_uniform(pp_gamemakerkid, "dimensions");
uniforms[2] = shader_get_uniform(pp_gamemakerkid, "colors");

draw_set_font(font);

names = [ "g a m e b o y", "o n e b o y", "g r a v e b o y", "v i r t u a l b o y", "n o k i a", "p o p p e s h o p p e", "p p p" ];
colors = [
	[ 15, 56, 15, 48, 98, 48, 139, 172, 15, 155, 188, 15 ],
	[ 0, 0, 0, 0, 0, 0, 255, 255, 255, 255, 255, 255 ],
	[ 8, 8, 8, 97, 17, 4, 215, 141, 24, 219, 210, 184 ],
	[ 0, 0, 0, 45, 0, 0, 120, 0, 0, 255, 0, 0 ],
	[  67, 82, 61, 67, 82, 61, 199, 240, 216, 199, 240, 216 ],
	[  0, 5, 10, 154, 11, 57, 81, 111, 94, 242, 201, 136 ],
	[ 41, 4, 4, 170, 32, 32, 242, 78, 78, 246, 191, 191 ]
];

normalize_rgb_ext(colors[0]);
normalize_rgb_ext(colors[1]);
normalize_rgb_ext(colors[2]);
normalize_rgb_ext(colors[3]);
normalize_rgb_ext(colors[4]);
normalize_rgb_ext(colors[5]);
normalize_rgb_ext(colors[6]);

selection = 1;