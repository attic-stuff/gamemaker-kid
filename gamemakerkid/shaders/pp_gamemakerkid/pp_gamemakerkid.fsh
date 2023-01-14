varying vec2 vv_tex;
varying vec4 vv_col;

const vec3 grey = vec3(0.229, 0.587, 0.114);
const mat4 bayer = mat4(0.0, 8.0, 2.0, 10.0, 12.0, 4.0, 14.0, 6.0, 3.0, 11.0, 1.0, 9.0, 15.0, 7.0, 13.0, 5.0) * (1.0 / 16.0);

uniform vec3 parameters;
uniform vec2 dimensions;
uniform vec3 colors[4];

void main() {
	vec2 size = parameters.z / dimensions;
	vec2 coordinates = floor((vv_tex * dimensions) / parameters.z);
	vec2 uv = size * coordinates;
	
	vec3 pixel;
	pixel = texture2D(gm_BaseTexture, uv).rgb;
	int x = int(mod(coordinates.x, 4.0));
	int y = int(mod(coordinates.y, 4.0));
	pixel = pixel + (bayer[x][y] * parameters.y);
	
	float posterization = floor(dot(pixel, grey) * parameters.x);
    
    pixel = mix(colors[0], colors[1], clamp(posterization, 0.0, 1.0));
    pixel = mix(pixel, colors[2], clamp(posterization - 1.0, 0.0, 1.0));
    pixel = mix(pixel, colors[3], clamp(posterization - 2.0, 0.0, 1.0));
	
	gl_FragColor = vec4(pixel, 1.0);
}