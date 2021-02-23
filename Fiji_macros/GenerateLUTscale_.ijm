newImage("Untitled", "8-bit white", 25, 256, 1);
getDimensions(width, height, channels, slices, frames);
print(width +" "+height);
for (x = 0; x < height; x++) {
	for (y = 0; y < width; y++) {
		setPixel(y, x, x);
	}
}
