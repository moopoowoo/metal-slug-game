/// particle_spawn(x, y, hspd, vspd, col);
var _x = argument[0];
var _y = argument[1];
var _hspd = argument[2];
var _vspd = argument[3];
var _col = argument[4];

for(var i = 0; i < World.maxParticles; i += 1)
{
    if(!World.particle_vis[i])
    {
        World.particle_x[i] = _x;
        World.particle_y[i] = _y;
        World.particle_hspd[i] = _hspd;
        World.particle_vspd[i] = _vspd;
        World.particle_col[i] = _col;
        World.particle_vis[i] = 1;
        break;
    }
}

