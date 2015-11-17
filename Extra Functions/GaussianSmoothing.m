function [newFullImage] = GaussianSmoothing(image,standardDeviation)
% covariance is being asumed as 1
sigma = standardDeviation;  %SIGMA DECLARATION

if sigma == 0   %%TAKING CARE OF ERRORS THAT MIGHT HAPPEND
sigma = 1;
end

size2 = floor(2*sigma+0.5);     %WINDOW SIZE OF TEMPLATE
if mod(size2,2) ~= 0            %WINDOW SIZE HAS TO BE ODD
    size2 = size2 + 1;
end
%%GETTING VALUES FOR X AND Y FOR GAUSSIAN DISTRIBUTION BETWEEN -WINDOWSIZE
%%AND WINDOW SIZE
[xx,yy] = meshgrid(-size2:size2, -size2:size2); 
%%VALUE OF Z GIVEN X AND Y
zz = exp(-1/(2*sigma^2)*(xx.^2 + yy.^2));
%RESULTING TEMPLATE
template = zz/(2*sigma*sigma*pi);

%INITIALISATION OF IMAGE TO DO GAUSSIAN SMOOTHING
image1 = image;
%DIVIDE RGB IMAGE INTO E SEPARATE IMAGES RED, GREEN AND BLUE
image1red = image1(:,:,1);
image1green = image1(:,:,2);
image1blue = image1(:,:,3);
%GETTING THE SIZE OF THE TEMPLATE
[rowsTemplate, columnsTemplate] = size(template);
%GETTING SIZE OF IMAGE (SINGLE COMPONENT IN THIS CASE RED)
sizeImage1 = size(image1red);
%INITIALISING NEW IMAGE PARAMETERS BASED ON THE SIZE OF THE TEMPLATE
newImage1red = zeros(sizeImage1(1,1)-rowsTemplate+1, sizeImage1(1,2) - columnsTemplate +1);
newImage1green = zeros(sizeImage1(1,1)-rowsTemplate +1, sizeImage1(1,2) - columnsTemplate +1);
newImage1blue = zeros(sizeImage1(1,1)-rowsTemplate +1, sizeImage1(1,2) - columnsTemplate +1);

%LOOP IN THE COLUMNS
for n=columnsTemplate:sizeImage1(1,2)
%LOOP IN THE ROWS
for m=rowsTemplate:sizeImage1(1,1)
    %GET NEW PIXEL FOR NEW IMAGE, AT THE END OF THE LOOPS ALL THE PIXELS
    %IN THE NEW IMAGE ARE GOING TO BE SETTED. THE NEW PIXEL WILL BE THE
    %ADDITION OF ALL THE ELEMENTS IN THE RESULTING MATRIX OF THE
    %ELEMENT-WISE MULTIPLICATION BEETWEN THE PART OF THE IMAGE MATRIX AND
    %THE TEMPLATE. THIS WILL THEREFORE GIVE US THE CONVOLUTION BETWEEN THE
    %TEMPLATE AND THE IMAGE. THIS IS DONE IN EACH COMPONENT (RED,GREEN,BLUE).
    
    newImage1red(m-(rowsTemplate-1),n-(columnsTemplate-1)) = sum(sum(double(template).*double(image1red(m-(rowsTemplate-1):m,n-(columnsTemplate-1):n))));
    newImage1green(m-(rowsTemplate-1),n-(columnsTemplate-1)) = sum(sum(double(template).*double(image1green(m-(rowsTemplate-1):m,n-(columnsTemplate-1):n))));
    newImage1blue(m-(rowsTemplate-1),n-(columnsTemplate-1)) = sum(sum(double(template).*double(image1blue(m-(rowsTemplate-1):m,n-(columnsTemplate-1):n))));
end
end
%CONCATENATE 3 COMPONENTS IN ONLY ONE IMAGE IN ORDER TO SEE THE FULL RGB
%IMAGE
newFullImage = uint8(cat(3,newImage1red,newImage1green,newImage1blue));

end