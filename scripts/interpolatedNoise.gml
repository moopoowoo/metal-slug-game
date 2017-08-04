/// interpolatedNoise(x, y, seed);

var integerX, fractionalX, integerY, fractionalY, v1, v2, v3, v4, i1, i2;

integerX = floor(argument[0]);
fractionalX = argument[0] - integerX;

integerY = floor(argument[1]);
fractionalY = argument[1] - integerY;

v1 = smoothNoise(integerX, integerY, floor(argument[2]));
v2 = smoothNoise(integerX + 1, integerY, floor(argument[2]));
v3 = smoothNoise(integerX, integerY + 1, floor(argument[2]));
v4 = smoothNoise(integerX + 1, integerY + 1, floor(argument[2]));

i1 = interpolate(v1, v2, fractionalX);
i2 = interpolate(v3, v4, fractionalX);

return interpolate(i1, i2, fractionalY);

