/// noise(x, y, seed);

var n;

/*n = floor(argument[0]) + floor(argument[1]) * 57;
n = ((n << 13) + floor(argument[2])) ^ n;*/
n = (floor(argument[0]) + floor(argument[1]) * 57) ^ floor(argument[2]);

//return (1 - ((n * (n * n * 15731 + 789221) + 1376312589) & 2147483647) / 1073741824);
return (1 - ((n * (n * n * 15 + 789) + 1376) & 2147) / 1073);

