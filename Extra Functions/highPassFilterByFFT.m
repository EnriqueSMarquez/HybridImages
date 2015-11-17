function [newFullImage] = highPassFilterByFFT(image,radius)

imageFFT = fft(image);


[rows, columns] = size(imageFFT(:,:,1));
circle = CircleMaker(rows,columns,radius);
imageFFTRed = imageFFT(:,:,1);
imageFFTGreen = imageFFT(:,:,2);
imageFFTBlue = imageFFT(:,:,3);

imageFFTRedC = imageFFTRed.*circle;
imageFFTGreenC = imageFFTGreen.*circle;
imageFFTBlueC = imageFFTBlue.*circle;

imageAfterFilterRed = imageFFTRed - imageFFTRedC;
imageAfterFilterGreen = imageFFTGreen - imageFFTGreenC;
imageAfterFilterBlue = imageFFTBlue - imageFFTBlueC;


inverseFFT = ifft(imageFFTRedC);
imshow(uint8(abs(inverseFFT)));

end