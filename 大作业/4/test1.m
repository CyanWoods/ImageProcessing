%% 膨胀 腐蚀 开 闭 测试
clc;
clear vars;
close all;

%% 导入图像与结构元素
I = imread('1.png');
I=rgb2gray(I);
I=imbinarize(I);
mask=[0,1,0;1,1,1;0,1,0];

%% 膨胀 腐蚀
pz=imdilate(I,mask);
fs=imerode(I,mask);

%% 显示图像
figure(1);
subplot(2,3,1);
imshow(I);
subplot(2,3,2);
imshow(pz);
subplot(2,3,3);
imshow(fs);

subplot(2,3,5);
imshow(pz-I);
subplot(2,3,6);
imshow(I-fs);

%% 开闭运算
op=imopen(I,mask);
cl=imclose(I,mask);

%% 打印图像
figure(2);
subplot(2,3,1);
imshow(I);
subplot(2,3,2);
imshow(op);
subplot(2,3,3);
imshow(cl);

subplot(2,3,5);
imshow(I-op);
subplot(2,3,6);
imshow(cl-I);