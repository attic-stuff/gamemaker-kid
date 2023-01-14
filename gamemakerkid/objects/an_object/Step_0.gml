var rsmash = mouse_check_button(mb_left);
if (rsmash) {
	line = mouse_x;
}

var mouse = mouse_wheel_up() - mouse_wheel_down();

brightness = keyboard_check(ord("B")) ? clamp(brightness + (mouse * 0.5), 1, 100) : brightness;
dither = keyboard_check(ord("D")) ? clamp(dither + (mouse * 0.01), 0, 1) : dither;
crush = keyboard_check(ord("C")) ? clamp((crush + (mouse * 1)), 0, 8) : crush;

if (keyboard_check_pressed(vk_tab)) {
	brightness = 4;
	dither = 0.05;
	crush = 1;
	selection = 1;
	line = 128;
}

for (var i = 1; i <= 6; i++) {
	if (keyboard_check_pressed(ord(string(i)))) {
		selection = i;
		break;
	}
}
