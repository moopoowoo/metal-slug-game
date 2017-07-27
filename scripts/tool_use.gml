///tool_use(tool id, tool direction)
var toolid, tooldir;
toolid=argument0;
tooldir=argument1;

switch toolid {
    case 0:
        // action for tool 0
        part_particles_create(sys,x+lengthdir_x(16,tooldir),y+lengthdir_y(16,tooldir),part,1);
    break;
    case 1:
        // action for tool 1
        part_particles_create(sys,x+lengthdir_x(32,tooldir),y+lengthdir_y(32,tooldir),part,1);
    break;
    case 2:
        // etc...
        part_particles_create(sys,x+lengthdir_x(48,tooldir),y+lengthdir_y(48,tooldir),part,1);
    break;
    case 3:
        part_particles_create(sys,x+lengthdir_x(64,tooldir),y+lengthdir_y(64,tooldir),part,1);
    break;
}
