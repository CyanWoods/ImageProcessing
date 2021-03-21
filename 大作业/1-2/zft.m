%% 直方图均衡化
clc;
clear vars;
close all;

%% 导入图像
a=rgb2gray(imread('aa.png'));

%% 直方图均衡化
g=histeq(a,256);        

%% 绘制图像
figure;
subplot(2,2,1)
imshow(a);
title('原图');
subplot(2,2,2)
imhist(a);



subplot(2,2,3)
imshow(g);
title('均衡化之后的图像');
subplot(2,2,4)
imhist(g);
