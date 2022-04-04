img = imread("Kymograph_alongPilus.tif");

size(img)
X = linspace(1,272,272);
Y = linspace(1,110,110);

[X,Y] = meshgrid(X,Y);
surf(transpose(X),transpose(Y),img);