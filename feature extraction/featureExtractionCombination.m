%% show useful lines found by feature extraction tools (i.e. canny edges,
%% hough transform, harris method)
img = im2double(imread('Image - Castello di Miramare.jpg'));
I=rgb2gray(img);
I=imresize(I, 0.25);

%a set of useful segments
segment1=[711,340; 789,743];
segment2=[771,375; 987,394];
segment3=[817,515; 861,519];
segment4=[563,547; 625,549];
segment5=[604,662; 694,665];
segment6=[605,456; 656,458];
segment7=[304,526; 326,367];
segment8=[202,580; 268,574];
segment9=[766,641; 938,650];
segment10=[242,308; 303,300];
segment11=[179,427; 234,421];
segment12=[319,421; 348,449];
segment13=[345,301; 383,363];
segment14=[298,574; 341,607];
segment15=[77,425; 90,436];
segment16=[460,361; 516,388];
segment17=[461,574; 519,592];
segment18=[963,483; 981,527];
segment19=[674,430; 699,396];
segment20=[722,670; 768,640];
segment21=[722,534; 716,539];

segments=[segment1; segment2; segment3; segment4; segment5; segment6; segment7; segment8; segment9; segment10;
    segment11; segment12; segment13; segment14; segment15; segment16; segment17; segment18; segment19; segment20;
    segment21];

%display useful segments on the image
figure, imshow(I), hold on
numSegments=length(segments);
for k = 1:2:(numSegments)-1
   seg=segments(k:k+1,:);
   xy = [seg(1,:); seg(2,:)];
   plot(xy(:,1),xy(:,2),'LineWidth',2,'Color','green');
   % Plot beginnings and ends of lines
   plot(xy(1,1),xy(1,2),'x','LineWidth',1,'Color','yellow');
   plot(xy(2,1),xy(2,2),'x','LineWidth',1,'Color','red');
end
