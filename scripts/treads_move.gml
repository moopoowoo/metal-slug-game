/// treads_move(speed, rotation);
for(var i = 0; i < tread_parts; i += 1)
{
    if(tread_partX[i]+lengthdir_x(tread_r, tread_a+90) >= tread_x+lengthdir_x(tread_l, tread_a))
    {
        // reached, or is currently in, right-most turn
        tread_partAngle[i] += argument1;
        tread_partX[i] = tread_x+lengthdir_x(tread_l, tread_a)+lengthdir_x(tread_r, -tread_partAngle[i]+90);
        tread_partY[i] = tread_y+lengthdir_y(tread_l, tread_a)+lengthdir_y(tread_r, -tread_partAngle[i]+90);
    }
    else if(tread_partX[i]+lengthdir_x(tread_r, tread_a+90) <= tread_x)
    {
        // reached, or is currently in, left-most turn
        tread_partAngle[i] += argument1;
        tread_partX[i] = tread_x+lengthdir_x(tread_r, -tread_partAngle[i]+90);
        tread_partY[i] = tread_y+lengthdir_y(tread_r, -tread_partAngle[i]+90);
    }
    else if(abs(angle_difference(tread_partAngle[i], tread_a)) >= 170)
    {
        // move left
        tread_partAngle[i] = tread_a+180;
        tread_partX[i] += lengthdir_x(argument0, tread_a+180);
        tread_partY[i] += lengthdir_y(argument0, tread_a+180);
    }
    else
    {
        // move right
        tread_partAngle[i] = tread_a;
        tread_partX[i] += lengthdir_x(argument0, tread_a);
        tread_partY[i] += lengthdir_y(argument0, tread_a);
    }
}

