draw_set_blend_mode(bm_normal);

if(surface_exists(global.surTemporaryLightSource)
&& surface_exists(global.surLightSources))
{
    with(LightSource)
    {
        if(point_distance(x, y, objPlayer.x, objPlayer.y) <= radius)
        {
            surface_set_target(global.surTemporaryLightSource);
            //draw_clear(c_black);
            draw_set_color(c_black);
            draw_rectangle(0, 0, surface_get_width(application_surface), surface_get_height(application_surface), 0);
            //draw_set_color(c_white);
            
            with(objPlayer)
            {
                if(point_distance(x, y, other.x, other.y) <= other.radius)
                {
                    // Draw tank parts illuminated
                    var _sprNum = sprite_get_number(sprTankTreadIllum);
                    var _factor = 360/_sprNum;
                    if(scale)
                    {
                        var _illumRot = _sprNum + round(point_direction(x, y, other.x, other.y)/_factor)-3;
                    }
                    else
                    {
                        var _illumRot = _sprNum - round(point_direction(x, y, other.x, other.y)/_factor)+1;
                    }
                    var dist = abs(1-point_distance(x, y, other.x, other.y)/other.radius);
                    
                    //draw_rectangle(0, 0, window_get_width(), window_get_height(), 0);
                   
                    draw_sprite_ext(sprTankTreadIllum, _illumRot, (x - view_xview) + (5 * objPlayer.scale), y + (sprite_get_height(sprTankTread) / 2) - view_yview, image_xscale, image_yscale, image_angle, other.color, dist*other.intensity);
                    draw_sprite_ext(sprTankHeadpieceIllum, _illumRot, (x - view_xview) + (10 * objPlayer.scale), y - (sprite_get_height(sprTankHeadpiece) / 1.4) + add - view_yview, scale, 1, add + rot, other.color, dist*other.intensity);
                    draw_sprite_ext(sprTankBodyIllum, _illumRot, x + add - view_xview, y - view_yview, scale, 1, add + rot, other.color, dist*other.intensity);
                    
                    var pdir = point_direction(x, y, other.x, other.y);
                    draw_sprite_ext(sprPixel, 0, x - view_xview, y - view_yview, 400, 400, pdir-90, c_black, 1);
                }
                //window_set_caption(string(dist));
            }
            
            surface_reset_target();
            surface_set_target(global.surLightSources);
            
            draw_set_blend_mode(bm_add);
            draw_surface(global.surTemporaryLightSource, 0, 0);
            draw_set_blend_mode(bm_normal);
             
            surface_reset_target();
        }
    }
}

