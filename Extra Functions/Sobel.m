function [newFullImage] = Sobel(image)
%INITIALISATION OF IMAGE
image1 = image;

%IMAGE IS DIVIDED IN THE 3 COMPONENTS (R,G,B)
image1red = int8(image1(:,:,1));
image1green = int8(image1(:,:,2));
image1blue = int8(image1(:,:,3));

%GETTING SIZE OF THE IMAGE
sizeImage = size(image1red);
%CREATING NEW IMAGES TO ERASE THE BLACK BRODERS AT THE END OF THE FUNCTION
%CREATING NEW IMAGES IN X
newImage1redX = zeros(sizeImage(1,1) - 2, sizeImage(1,2) - 2);
newImage1greenX = zeros(sizeImage(1,1) - 2, sizeImage(1,2) - 2);
newImage1blueX = zeros(sizeImage(1,1) - 2, sizeImage(1,2) - 2);
%CREATING NEW IMAGES IN Y
newImage1redY = zeros(sizeImage(1,1) - 2, sizeImage(1,2) - 2);
newImage1greenY = zeros(sizeImage(1,1) - 2, sizeImage(1,2) - 2);
newImage1blueY = zeros(sizeImage(1,1) - 2, sizeImage(1,2) - 2);

%INITIALISING BOTH TEMPLATES (X AND Y)
Mx = int8([1 0 -1;2 0 -2; 1 0 -1]);
My = int8([1 2 1; 0 0 0; -1 -2 -1]);

for n=3:sizeImage(1,1)
    
for m=3:sizeImage(1,2)
    %TE TEMPLATE IS MULTIPLICATED WITH THE IMAGE AND ALL THE ELEMENTS
    %OF THE RESULTING MATRIX ARE ADDED TO A SINGLE ELEMENT THAT WILL BE
    %A PIXEL IN THE NEW MATRIX
    newImage1redX(n-2,m-2) = sum(sum(Mx.*image1red(n-2:n,m-2:m)));
    newImage1greenX(n-2,m-2) = sum(sum(Mx.*image1green(n-2:n,m-2:m)));
    newImage1blueX(n-2,m-2) = sum(sum(Mx.*image1blue(n-2:n,m-2:m)));
end
end


for n=3:sizeImage(1,1)
    
for m=3:sizeImage(1,2)
    %TE SAME AS THE LOOP ABOVE JUST THAT THIS TIME IS DONE IN VERTICAL
    %DIRECTION
    newImage1redY(n-2,m-2) = sum(sum(My.*image1red(n-2:n,m-2:m)));
    newImage1greenY(n-2,m-2) = sum(sum(My.*image1green(n-2:n,m-2:m)));
    newImage1blueY(n-2,m-2) = sum(sum(My.*image1blue(n-2:n,m-2:m)));
end
end
%THE MAGNITUD IS TAKEN USING BOTH COMPONENTS (X,Y)
newImage1red = sqrt((newImage1redX.*newImage1redX) + (newImage1redY.*newImage1redY));
newImage1green = sqrt((newImage1greenX.*newImage1greenX) + (newImage1greenY.*newImage1greenY));
newImage1blue = sqrt((newImage1blueX.*newImage1blueX) + (newImage1blueY.*newImage1blueY));
%THE THREE COMPONENTS ARE CONCATENATED INTO 1 FULL COLOR IMAGE
newFullImage = uint8(cat(3,newImage1red,newImage1green,newImage1blue));
imshow(newFullImage);

end