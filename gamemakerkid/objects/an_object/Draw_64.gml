draw_surface(application_surface, 0, 0);

shader_set(pp_gamemakerkid) {
	var u = uniforms;
	shader_set_uniform_f(u[0], brightness, dither, 1 << crush, 1 << crush);
	shader_set_uniform_f(u[1], 256, 256);
	shader_set_uniform_f_array(u[2], colors[selection-1]);
	draw_surface_part(application_surface, 0, 0, line, 256, 0, 0);
	shader_reset();
}

var text = "hold [i] for instructions" + "\n\n" + names[selection-1] + "\n[b]rightness: " + string(brightness) + "\n[d]ither: " + string(dither) + "\n[c]rush: " + string(1 << crush);
draw_text_ext_color(2, -3, text, 9, 128, #080808, #080808, #080808, #080808, 1);
draw_text_ext_color(2, -4, text, 9, 128, #dbd2b8, #dbd2b8, #dbd2b8, #dbd2b8, 1);

if (keyboard_check(ord("I"))) {
	draw_rectangle_color(0, 0, 256, 128, #080808, #080808, #080808, #080808, false);	
	text = "there are letters in boxes, like where it says [b]rightness. if you hold that button down and then scroll the mousehweel it will change those parameters. you can press [tab] to reset the parameters, and you can press 1 through 6 to cycle through the palettes. if you hold the left mouse button and move it left and right, it changes how much of the scene shows.";
	draw_text_ext_color(2, -4, text, 9, 256, #dbd2b8, #dbd2b8, #dbd2b8, #dbd2b8, 1);
}