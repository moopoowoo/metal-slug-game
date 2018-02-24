/// smoke_draw(x, y, color, radius, dispersion, quality)
var _x = argument[0];
var _y = argument[1];
var _color = argument[2];
var _radius = argument[3];
var _sd = argument[4]*(_radius/3);
var _sdq = argument[5];

draw_set_alpha(1/_sdq);

for(var i = 0; i < 360; i += 360/_sdq)
{
    draw_circle_colour(_x+lengthdir_x(_sd, i), _y+lengthdir_y(_sd, i), _radius,
    make_color_hsv(colour_get_hue(_color)+127, colour_get_saturation(_color), color_get_value(_color)),
    c_black, 0);
}

draw_set_alpha(1);

