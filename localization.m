%% Localization

%take calibrated image and reconstructed image(upper face)
im1=img;%original image
%im1=imresize(im1, 0.25);
im2=imgMetRect;%metric rectified image
im1f=figure(7); imshow(im1);
title('pick four points on the first image and the corresponding four points on the second one')
fprintf('pick four points on the first image and the corresponding four points on the second one\n');

im2f=figure(8); imshow(im2);

%manually pick four points in the first image, and four corresponding points on the second image
figure(im1f), [x1,y1]=getpts
figure(im2f), [x2,y2]=getpts
figure(im1f), hold on, plot(x1,y1,'oy', 'LineWidth', 5, 'MarkerSize', 10);
figure(im2f), hold on, plot(x2,y2,'oy', 'LineWidth', 5, 'MarkerSize', 10);

%given four points and their transformed ones, which is the minimal information which defines an homography, find the corresponding homography from the rectified image to the original picture
H=maketform('projective',[x2 y2],[x1 y1]);
%this is the computed homography, a 3x3 matrix. It transforms the second image to match the first.

%find the pose(position and orientation) of the planar pbject relative to the camera
%M=inv(k)*H.tdata.T     %H= homography from the planar face to its image
M=K\(H.tdata.T')
i=M(:,1)/norm(M(:,1))
j=M(:,2)/norm(M(:,1))
o=M(:,3)/norm(M(:,1))

c=cross(i,j);
% The rotation matrix of the camera in the object reference frame is 
% the transpose of the rotation matrix of the object in the camera
% frame
R = [i, j, c];
% approximate R, since due to numerical error it might not be a rotation matrix
[U, ~, V] = svd(R);
R = U * V'
% compute the translation vector 
t = - R.' * o

