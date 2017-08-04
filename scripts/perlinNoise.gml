/// perlinNoise(x, y, p, octaves, seed);

var total, n, frequency, amplitude;

total = 0;
n = floor(argument[3] - 1);

for (i = 0; i <= n; i += 1)
{
    frequency = 2 * i;
    amplitude = argument[2] * i;

    total = total + interpolatedNoise(argument[0] * frequency, argument[1] * frequency, argument[4]) * amplitude;
}

return total;

