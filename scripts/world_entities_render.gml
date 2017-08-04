/// world_entities_render()
var _xo = -view_xview;
var _yo = -view_yview;

with(Player)
{
    // draw tools
    var i;
    
    for (i=0;i<=3;i++) {
        draw_sprite_ext(
            tool[activeTool[i,0],0],
            0,
            x+lengthdir_x(12,(activeTool[i,1]+drawRot)*90)+_xo,
            y+lengthdir_y(12,(activeTool[i,1]+drawRot)*90)+_yo,
            1,
            1,
            (activeTool[i,1]+drawRot)*90,
            c_white,
            1
        )
    }
    
    // draw legs
    for(var i = 0; i < 4; i += 1)
    {
        if(legActive[i])
        //draw_line(x, y+_yo, legX[i], legY[i]+_yo);
        {
            var _pdist = point_distance(x, y, legX[i], legY[i]);
            var _pdir = point_direction(x, y, legX[i], legY[i]);
            var _frame = 0;
            for(var j = 0; j < _pdist; j += sprite_get_width(sprPlayerArm))
            {
                draw_sprite_ext(sprPlayerArm, _frame, x+lengthdir_x(j, _pdir)+_xo, y+lengthdir_y(j, _pdir)+_yo, 1, 1, _pdir, c_white, 1);
                _frame += 1;
            }
        }
    }
    
    // draw tank
    draw_sprite(sprite_index, image_index, x+_xo, y+_yo);
    
    
    // DEBUG
    // hitbox
    /*draw_set_color(c_red);
    draw_rectangle(x+hBoxXOffset, y+hBoxYOffset+_yo, x+hBoxXOffset+hBoxWidth, y+hBoxYOffset+hBoxHeight+_yo, 1);
    draw_rectangle(x+hBoxXOffset+xVel, y+hBoxYOffset+yVel+_yo, x+hBoxXOffset+hBoxWidth+xVel, y+hBoxYOffset+hBoxHeight+yVel+_yo, 1);
    
    draw_set_color(c_white);
    
    if keyboard_check(vk_f1) draw_text(x+32,y,string(rotation)+" / "+string(drawRot));*/
}

with(projectile)
{
    draw_sprite_ext(sprite_index, image_index, x+_xo, y+_yo, image_xscale, image_yscale, direction, image_blend, image_alpha);
}

