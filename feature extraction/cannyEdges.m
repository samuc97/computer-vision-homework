%% Canny edges
img = im2double(imread('Image - Castello di Miramare.jpg'));
I=rgb2gray(img);
I=imresize(I, 0.25);

%adjust contrast of the image
I = imadjust(I,[0.2 1],[]); 

threshold=0.05;
%find edges
edges = edge(I, 'canny',threshold);
%show edges
figure(2), imshow( edges), title('canny edge');
imshow(edges);