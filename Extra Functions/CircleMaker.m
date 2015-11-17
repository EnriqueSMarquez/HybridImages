function [circlePixels] = CircleMaker(imageSizeX,imageSizeY,radius)

%OBTAINING VALUES FOR IMAGE
[columnsInImage, rowsInImage] = meshgrid(1:imageSizeX, 1:imageSizeY);
%GETTING THE CENTRE
centreX = floor(imageSizeX / 2);
centreY = floor(imageSizeY / 2);
%0 IF IS NOT IN THE CENTRE, 1 OTHERWISE
circlePixels = (rowsInImage - centreY).^2 + (columnsInImage - centreX).^2 <= radius.^2;

end