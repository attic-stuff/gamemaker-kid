function normalize_rgb(v) {
	return v / 255;
}

function normalize_rgb_ext(array) {
	for (var i = 0, length = array_length(array); i < length; i++) {
		array[i] = normalize_rgb(array[i]);
	}
}