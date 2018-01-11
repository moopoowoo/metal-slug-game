/// draw_hologram(x,y,sprite,image,string)

var xx=argument0, yy=argument1, spr=argument2, img=argument3, str=argument4, rectangleWidth=sprite_get_width(spr)+(string_length(str)*8), _xo = -view_xview, _yo = -view_yview;

draw_set_color($0ec949);
draw_set_alpha(random_range(.8,.9)); // the random range here is for the flicker effect

draw_triangle(Player.x+_xo,Player.y+_yo,xx-1,yy+16,xx-1,yy,0);
draw_triangle(Player.x+_xo,Player.y+_yo,xx-2,yy-1,xx+rectangleWidth,yy-1,0);
draw_rectangle(xx,yy,xx+rectangleWidth,yy+16,0); // draw the rectangle for the hologram

draw_set_color($d3ffc6);
draw_sprite(spr,img,xx+1,yy+1);

draw_set_font(fntHologram);
draw_text(xx+1+sprite_get_width(spr),yy+1,str);
draw_set_alpha(1);

with (instance_create(xx,yy,Light)) {
    lightColor=$d3ffc6;
    lightBrightness=1.1;
    lightRadius=128;
    lightOvershoot=24;
    lightFadeSpeed=1;
    lightRadiusSteps=8;
    lightAngleSteps=8;
}
