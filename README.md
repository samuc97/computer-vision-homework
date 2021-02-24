# computer-vision-homework

Matlab program that analyzes an image of the Castello di Miramare in order to extract the following information items:

## Image Processing
- Feature extraction. Find edges, corner features and straight lines in the image.

## Geometry
- 2D reconstruction. Rectification of an horizontal plane Π from the useful selected image lines and features, divided in 2 steps:
  - affine rectification;
  - affine to metric rectification;
- Calibration. Estimation of the calibration matrix K containing the intrinsic parameters of the camera, namely focal distance, aspect ratio and position of principal point;
- Localization. Determining the relative pose (i.e. position and orientation) between the reference attached to the horizontal plane Π and the camera reference;
- Reconstruction. Rectification of a vertical facade.
