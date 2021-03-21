%% 低通滤波
clc;
clear vars;
close all;

%% 导入图像
a= imread('a.png');

%% 设定参数 进行低通滤波
PQ=paddedsize(size(a));                             %填充输入图像，使得形成的方形图像大小最接近2的整数次幂
D0=0.05*PQ(2);                                      %设定截止参数
H=lpfilter('gaussian',PQ(1),PQ(2),D0,1);            %设定低通滤波器
G=fftshift(lpfilter('gaussian',PQ(1),PQ(2),D0));    %将0频分量转移到频谱中心

%% 绘制图像
figure;
subplot(2,2,1);
mesh(G(1:10:PQ(1),1:10:PQ(2)));
title('低通滤波器的图像');

subplot(2,2,2);
imshow(G,[]);
title('低通滤波器的图像');

subplot(2,2,3);
imshow(a,[]);
title('原图');

g=dftfilt(a,H);
subplot(2,2,4);
imshow(g,[]);
title('经过低通滤波之后的图像');