function [newImage1] = hybridImage(image1,image2,standardDeviation)

%WINDOW SIZE DEPENDING ON SIGMA
windowSize = floor(2*standardDeviation+0.5);
%FIRST PART OF THE IMAGE AFTER HIGHPASS FILTER
part1High = GaussianSmoothing(image1, standardDeviation);
%IMAGE SIZE
image1Size = size(image1);
%HIGHPASS IMAGE WITH POSITIVE AND NEGATIVE VALUES
highPassImage = image1(windowSize:image1Size(1,1,1)-windowSize-1,windowSize:image1Size(1,2,1)-windowSize-1,:) - part1High;
%ADDING CONSTANT TO MAKE BRIGHT VALUES POSITIVE AND DARK VALUES NEGATIVE
highPassImage = highPassImage + 20;

%GETTING LOW PASS IMAGE
lowPassImage = GaussianSmoothing(image2,standardDeviation);
%FINALLY GETTING HYBRID IMAGE
newImage1 = (uint8(highPassImage) + uint8(lowPassImage));
end