%% Harris method for corner detection
%load the image, convert into grayscale and resize it 
img = im2double(imread('Image - Castello di Miramare.jpg'));
I=rgb2gray(img);
I=imresize(I, 0.25);

%find corners features with harris measure, 'MinQuality' is set to a low
%value due to the difficulties to detect some corner in the picture
corners = detectHarrisFeatures(I,'MinQuality', 0.0001);
%show image with detected corners
imshow(I); hold on;
plot(corners);
