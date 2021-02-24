%% Calibration
figure(4); imshow(img);
title('Draw two pairs of parallel segments and press enter')
%% select two pairs of segments that are image of parallel lines in the scene

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
h2 = cross(l1,l2);
h2 = h2./h2(3);
h3 = cross(m1,m2);
h3 = h3./h3(3);

% compute the image of the line at infinity
imLinfty = cross(h2,h3);
imLinfty = imLinfty./(imLinfty(3));


figure(5); imshow(img);

title('Draw 2 more lines on the plane, orthogonal to the previous couples and press enter');
fprintf('Draw 2 more lines on the plane, orthogonal to the previous couples and press enter\n');

segment5 = drawline('Color','green');
segment6 = drawline('Color','yellow');

fprintf('Press enter to continue\n');
pause

n1 = segToLine(segment5.Position);
o1 = segToLine(segment6.Position);
%compute 2 more vanishing points
h1 = cross(n1,imLinfty);
h1 = h1./h1(3);
h4 = cross(o1,imLinfty);
h4 = h4./h4(3);

figure(6); imshow(img);
title('Draw a pair of parallel segments ortoghonal to the plane PI and press enter')

fprintf('Draw parallel segments\n');

% select a pair of segments (images of 2 parallel lines)
segment7 = drawline('Color','cyan');
segment8 = drawline('Color','cyan');

fprintf('Press enter to continue\n');
pause

%lines orthogonal to the plane PI
v1 = segToLine(segment7.Position);
v2 = segToLine(segment8.Position);

% compute the vanishing point 
v = cross(v1,v2);
v = v./v(3);

syms x y z w
eqn1 = h1'*[x, 0, y; 0, 1, z; y, z, w]*h2 == 0;
eqn2 = h3'*[x, 0, y; 0, 1, z; y, z, w]*h4 == 0;
eqn3 = v'*[x, 0, y; 0, 1, z; y, z, w]*h1 == 0;
eqn4 = v'*[x, 0, y; 0, 1, z; y, z, w]*h2 == 0;

[A,B] = equationsToMatrix([eqn1, eqn2, eqn3, eqn4], [x, y, z, w]);

X = linsolve(A,B);
digits(7);

x=X(1);
y=X(2);
z=X(3);
w=X(4);

omega=vpa([x, 0, y;
			0, 1, z;
            y, z, w]);

%%cholesky(omega)--> find k (cholesky not needed, estimate k from omega)
a = sqrt(omega(1, 1));
u = -omega(1, 3)/omega(1, 1);
v = -omega(2, 3);
fy = sqrt(omega(3, 3) - omega(1, 1)*u^2 - v^2);
fx = fy/a;

K = [fx,  0, u;
     0,  fy, v;
     0,   0, 1];
