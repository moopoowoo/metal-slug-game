/// light_cast(x, y, color, radius, brightness, overshoot)
var _x = argument[0];
var _y = argument[1];
var _color = argument[2];
var _radius = argument[3];
var _brightness = argument[4];
var _overshoot = argument[5];

var _surSize = (_radius+_overshoot*2)*2;
var _sur = surface_create(_surSize, _surSize);
surface_set_target(_sur);
draw_clear_alpha(c_black, 0);
draw_primitive_begin(pr_trianglefan);
draw_set_color(merge_color(c_black, _color, _brightness));

draw_vertex(_surSize/2, _surSize/2);
for(var i = 0; i <= 360; i += lightAngleSteps)
{
    var _l = 8;
    while(World.terrain[clamp(_x+lengthdir_x(_l, i), 0, World.width-1), clamp(_y+lengthdir_y(_l, i), 0, World.height-1)] == 0
    && _l < _radius)
    _l += lightRadiusSteps;
    _l += _overshoot;
    
    draw_vertex(_surSize/2+lengthdir_x(_l, i), _surSize/2+lengthdir_y(_l, i));
}

draw_primitive_end();

draw_primitive_begin(pr_trianglefan);

draw_vertex_colour(_surSize/2, _surSize/2, c_black, 0);
for(var i = 0; i <= 360; i += lightAngleSteps)
{
    draw_vertex_colour(_surSize/2+lengthdir_x(_surSize/2, i), _surSize/2+lengthdir_y(_surSize/2, i), c_black, 1);
}

draw_primitive_end();
draw_set_color(c_white);
surface_reset_target();

draw_set_blend_mode(bm_add);
draw_surface(_sur, _x-_surSize/2, _y-_surSize/2-view_yview);
draw_set_blend_mode(bm_normal);

surface_free(_sur);

