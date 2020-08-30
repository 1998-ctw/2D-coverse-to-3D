clc
clear
load('���ڱ궨���.mat');%load calibration result mat  

I1 =imread('11.jpg');
I2 =imread('21.jpg');
%rectify the images
[J1,J2] = rectifyStereoImages(I1,I2,stereoParams);
figure;
imshow(stereoAnaglyph(I1,I2),'InitialMagnification',50);
title('���߻���У��֮ǰ');
figure;
imshow(stereoAnaglyph(J1,J2),'InitialMagnification',50);
title('���߻���У��֮��');
figure,imshow(J1),title('J1')
figure,imshow(J2),title('J2')
%disparity
disparityRange=[0 320]; %%range
%method��BlockMatching
 disparityMap = disparity(rgb2gray(J1),rgb2gray(J2),'BlockSize',15,'DisparityRange',disparityRange,'UniquenessThreshold',0,'DistanceThreshold',0);
figure;
imshow(disparityMap,disparityRange,'InitialMagnification',50);
title('�Ӳ�');
colormap('jet');
colorbar;
title('Disparity Map');
%%
%3D consturction
point3D = reconstructScene(disparityMap,stereoParams);
point3D=point3D/100;%meters

z=double(point3D( :, :, 3));
maxZ = 5;%40
minZ = -20;
zdisp = z;
zdisp(z<minZ|z>maxZ) = NaN;
point3Ddisp = point3D;
point3Ddisp( :, :, 3) = zdisp;
figure
pcshow(point3Ddisp,J1,'VerticalAxis','Y','VerticalAxisDir','Down');
xlabel('X');
ylabel('Y');
zlabel('Z');