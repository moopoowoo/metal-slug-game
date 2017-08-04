/// ridgedMF(x, y, seed, lacunarity, gain, offset, octaves, xScale, yScale);

var sum, amplitude, frequency, prev, cx, cy, n;

sum = 0;
amplitude = 0.5;
frequency = 1;
prev = 1;

cx = floor(argument[0]) * argument[7];
cy = floor(argument[1]) * argument[8];

for (i = 0; i < floor(argument[6]); i += 1)
{
    n = ridge(interpolatedNoise((cx * frequency), (cy * frequency), floor(argument[2])), argument[5]);
    sum += n * amplitude * prev;
    prev = n;
    frequency *= argument[3];
    amplitude *= argument[4];
}

return sum;

