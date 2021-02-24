%% Hough transform
%number of peaks i want to find
numPeaks=100;
cannyEdges;


%figure, imshow(edges), hold on

%HOUGH TRANSFORM
%Create the Hough transform using the binary image.
[H,T,R] = hough(edges, 'RhoResolution',1,'Theta',-90:0.1:89); %default: 1, -90:89

figure, imshow(H,[],'XData',T,'YData',R,...
            'InitialMagnification','fit');
xlabel('\theta'), ylabel('\rho');
axis on, axis normal, hold on;

%Find peaks in the Hough transform of the image.
P  = houghpeaks(H,numPeaks,'Threshold',0.7*max(H(:)), 'Theta', -90:0.1:89);  %default:0.5*max(H(:)) , -90:89
x = T(P(:,2)); y = R(P(:,1));
plot(x,y,'s','color','white');

%Find lines and plot them.
lines = houghlines(edges,T,R,P,'FillGap',10,'MinLength',30);   %default: 20, 40

figure, imshow(I), hold on
max_len = 0;
for k = 1:length(lines)
   xy = [lines(k).point1; lines(k).point2];
   plot(xy(:,1),xy(:,2),'LineWidth',2,'Color','green');
   % Plot beginnings and ends of lines
   plot(xy(1,1),xy(1,2),'x','LineWidth',1,'Color','yellow');
   plot(xy(2,1),xy(2,2),'x','LineWidth',1,'Color','red');
end
