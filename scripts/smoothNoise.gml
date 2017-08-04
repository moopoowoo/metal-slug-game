/// smoothNoise(x, y, seed);

var corners, sides, center;

corners = (noise(argument[0] - 1, argument[1] - 1, floor(argument[2])) + noise(argument[0] + 1, argument[1] - 1, floor(argument[2])) + noise(argument[0] - 1, argument[1] + 1, floor(argument[2]))
    + noise(argument[0] + 1, argument[1] + 1, floor(argument[2]))) / 16;
sides = (noise(argument[0] - 1, argument[1], floor(argument[2])) + noise(argument[0] + 1, argument[1], floor(argument[2])) + noise(argument[0], argument[1] - 1, floor(argument[2])) + noise(argument[0], argument[1] + 1, floor(argument[2]))) / 8;
center = noise(argument[0], argument[1], floor(argument[2])) / 4;

return corners + sides + center;

