/// light_cast(x, y, color, radius)
var _x = argument[0];
var _y = argument[1];
var _color = argument[2];
var _radius = argument[3];

var _sur = surface_create(_radius*2, _radius*2);
surface_set_target(_sur);
draw_clear_alpha(c_black, 0);
draw_primitive_begin(pr_trianglefan);
draw_set_color(_color);

draw_vertex(_radius, _radius);
for(var i = 0; i <= 360; i += 3)
{
    var _l = 8;
    while(World.terrain[clamp(_x+lengthdir_x(_l, i), 0, World.width-1), clamp(_y+lengthdir_y(_l, i), 0, World.height-1)] == 0
    && _l < _radius)
    _l += 2;
    _l += 8;
    
    draw_vertex(_radius+lengthdir_x(_l, i), _radius+lengthdir_y(_l, i));
}

draw_primitive_end();

draw_primitive_begin(pr_trianglefan);

draw_vertex_colour(_radius, _radius, c_black, 0);
for(var i = 0; i <= 360; i += 3)
{
    draw_vertex_colour(_radius+lengthdir_x(_radius+9, i), _radius+lengthdir_y(_radius+9, i), c_black, 1);
}

draw_primitive_end();
draw_set_color(c_white);
surface_reset_target();

draw_set_blend_mode(bm_add);
draw_surface(_sur, _x-_radius, _y-_radius);

draw_set_blend_mode(bm_normal);
surface_free(_sur);

