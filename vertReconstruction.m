%% Vertical facade reconstruction
% show the image
figure(9); imshow(img);
title('Draw two pairs of parallel segments on a vertical facade and press enter')
% select two pairs of segments that are image of parallel lines in the scene
fprintf('Draw parallel segments\n');

% select a first pair of segments (images of 2 parallel lines)
segment1 = drawline('Color','red');
segment2 = drawline('Color','red');

% select a second pair of segments (images of 2 parallel lines)
segment3 = drawline('Color','blue');
segment4 = drawline('Color','blue');

fprintf('Press enter to continue\n');
pause

%% compute the image of the line at infinity

l1 = segToLine(segment1.Position);
l2 = segToLine(segment2.Position);

m1 = segToLine(segment3.Position);
m2 = segToLine(segment4.Position);

% compute the vanishing points 
L = cross(l1,l2);
L = L./L(3);
M = cross(m1,m2);
M = M./M(3);

% compute the image of the line at infinity
imLinfty = cross(L,M);
imLinfty = imLinfty./(imLinfty(3));

% dispaly the selection
figure;
hold all;
% plot vanishing points
plot(L(1),L(2),'r.','MarkerSize',100);
plot(M(1),M(2),'b.','MarkerSize',100);
imshow(img);
% plot vanishing line
line([L(1),M(1)],[L(2),M(2)],'Color','Green','Linewidth',3);
% plot selected segments
line([segment1.Position(1,1),segment1.Position(2,1)],[segment1.Position(1,2),segment1.Position(2,2)],'Color','red','Linewidth',3);
line([segment2.Position(1,1),segment2.Position(2,1)],[segment2.Position(1,2),segment2.Position(2,2)],'Color','red','Linewidth',3);
line([segment3.Position(1,1),segment3.Position(2,1)],[segment3.Position(1,2),segment3.Position(2,2)],'Color','blue','Linewidth',3);
line([segment4.Position(1,1),segment4.Position(2,1)],[segment4.Position(1,2),segment4.Position(2,2)],'Color','blue','Linewidth',3);
hold off;
legend('Vanishing point 1', 'Vanishing point 2','Image of l_\infty');
set(gca,'FontSize',20)

%%find i and j
%solve the system of equation to find i and j, the intersection between
%omega and the image of the line at the infinity
x = sym('x');
y = sym('y');
eqn1= [x, y, 1]*omega*[x;y;1]==0;
eqn2= [x,y,1]*imLinfty==0;

eqns = [eqn1, eqn2];
sol = solve(eqns);
r = [double(sol.x), double(sol.y)];

%find i and j
imageOfi=[double(sol.x(1)), double(sol.y(1)), 1]';
imageOfj=[double(sol.x(2)), double(sol.y(2)), 1]';
%% image of the conic dual to the circular points: Cinf*'=i'*j'^t + j'*i'^t
imCDCPoints= imageOfi*imageOfj' + imageOfj*imageOfi';

[U,S, V ]=svd(imCDCPoints);

Hrect=U';
%apply the transformation
tform = projective2d(Hrect');
vertRec = imwarp(img,tform);

