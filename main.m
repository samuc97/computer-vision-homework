%% Do all
% load the image
clear;
close all;
image = imread('Image - Castello di Miramare.JPG');
img=imresize(image, 0.25);

%affine rectification
affine

%show affinely rectified image
figure(1);
imshow(imgAffRect), title('affine rectification result');

%metric rectification
metric;

%show result of metric rectification
figure(3);
imshow(imgMetRect),title('metric rectification result');

%calibration
calib

%localization
localization

%reconstruction of a vertical face
vertReconstruction

%show the result of the reconstruction of a vertical facade
figure(10);
imshow(vertRec), title('vertical face reconstruction result');