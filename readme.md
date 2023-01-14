# gamemaker kid

### gameboy type shader thing for gamemaker

perhaps you always wanted your game to look like a gameboy, or a nokia. maybe you wanted to make the pixels crunchier? mayhaps you wanted your game to only use two colors or three colors and consider gameboy's four colors to be a luxury of wanton excess! and dithering what about dithering!?

gamemaker kid is all that—its a post processing shader that can crush your game into a pixelated mess of two, three, or even four colors swirling around a bayer matrix milkshake. for example here are a bunch of moving pictures of the effect applied to a sick gif of a pancake situation:

| ![](https://github.com/attic-stuff/gamemaker-kid/blob/main/00.gif) | ![](https://github.com/attic-stuff/gamemaker-kid/blob/main/03.gif) | ![](https://github.com/attic-stuff/gamemaker-kid/blob/main/02.gif) | ![](https://github.com/attic-stuff/gamemaker-kid/blob/main/04.gif) |
| :----------------------------------------------------------: | :----------------------------------------------------------: | :----------------------------------------------------------: | :----------------------------------------------------------: |

the first one shows the sick pancake gif. the second one is the default gameboy pallette with a smidge of bitcrushing and dithering. third shows a two color palette with high dithering and no bitcrushing, and the last one is a side by side of a custom palette with low dithering but high bitcrushing.

### how 2 use

there is an example project yyz you can download and check out, otherwise you can copy and paste the fragment and vertex shaders from this repo into your own game. if you are new to shaders in gamemaker you may want to take some time to brush up on how they work, otherwise: here are the uniforms:

| vec4 parameters                                              |
| ------------------------------------------------------------ |
| parameters.x is **brightness**. the palette swap is done by converting the frame to greyscale and then mapping the new colors to the frame based on how bright or dark they are. so raising or lowering the brightness will change how to colors effect your scene. a bright scene will have less of the darker color, and a dark scene will have less of the bright color. |
| parameters.y is **dither**. dithering is done using a 4x4 bayer matrix to mix colors across bands. low number means less dithering, and high number means lots of dither. |
| parameters.z is **bitcrushing**. this increases the size of the pixels if you use the pixelization effect. this value is a kind of interpolation, so if you want it to be pixel perfect you will want to use a value that goes into the width and height of your frame nice and evenly. for example, the pancake frame is 256x256 so i use power of two bitcrush values to keep it nice and aligned. the key is to use a value that goes into both your width and height evenly. |

| vec2 dimensions                                              |
| ------------------------------------------------------------ |
| dimensions.x is the **width** of your frame. since this is a post processing effect, its the width of your application surface. it is not the size of your window, not the size of your view, not the size of your gui, and not the size of your viewport. |
| dimensions.y is the **height** of your frame. just like width, this one is the height of your application surface. |

| vec3 colors[4]                                               |
| ------------------------------------------------------------ |
| colors[0].xyz is the **normalized rgb** value of the darkest color in your palette. |
| colors[1].xyz is the **normalized rgb** value of the dark color in your palette. |
| colors[2].xyz is the **normalized rgb** value of the light color in your palette. |
| colors[3].xyz is the **normalized rgb** value of the lightest color in your palette. |
| these are the colors for your palette swapping. they have to be in a normalized 0 to 1 format, and they have to be in a flattened array on the gml side of your code. to get the normalized value, you just divide the value by 255. for example red in rgb format looks like 255, 0, 0 so if we wanted to normalize it we would do 255/255, 0/255, 0/255 and we would get 1, 0, 0. simple! the layout of the flattened array looks like this: <br />`colors = [ r0, g0, b0, r1, g1, b1, r2, g2, b2, r3, g3, b3 ]` |

### example

alright lets pretend you have a game about pancakes and you want it to use the same two-color palette of an old nokia phone.

```js
/* CREATE EVENT */
//turn drawing the app surface off for the pp effect
application_surface_draw_enable(false);
//set some cool values
brightness = 3.5;
dither = 0.24;
bitcrush = 2;
//set the colors. i like to start with rgb values stacked in the right order, darkest to lightest
colors = [
	67, 82, 61,
	67, 82, 61,
	199, 240, 216,
	199, 240, 216
];
//then loop through and normalize them
for (var i = 0, dim = array_length(colors); i < dim; i++) {
	colors[i] = colors[i] / 255;
}
//cache the uniform handles
uniforms = array_create(3);
uniforms[0] = shader_get_uniform(pp_gamemakerkid, "parameters");
uniforms[1] = shader_get_uniform(pp_gamemakerkid, "dimensions");
uniforms[2] = shader_get_uniform(pp_gamemakerkid, "colors");

/* POST DRAW EVENT */
shader_set(pp_gamemakerkid) {
    //access uniforms array once
    var u = uniforms;
	//set brightness, dither, and bitcrush
    shader_set_uniform_f(u[0], brightness, dither, bitcrush);
    //set the appsurface dimensions
	var target = application_surface;
    var width = surface_get_width(target);
    var height = surface_get_height(target);
    shader_set_uniform_f(u[1], width, height);
    //pass the array of color values
    shader_set_uniform_f_array(u[2], colors);
	
    //draw the rest of the owl
	draw_surface(target);
    
    //switch back to passthru shader
    shader_reset();
}
```

![](https://github.com/attic-stuff/gamemaker-kid/blob/main/insert.png)

