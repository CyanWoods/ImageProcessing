%% 椒盐噪声的降噪处理
clc;
clear vars;
close all;

%% 将图像转换为灰度级图像
a=rgb2gray(imread('b.png'));

%% 添加噪声 对噪声进行两种滤波
g=imnoise(a,'salt & pepper');
[M,N]=size(a);
means=spfilt(g,'amean');
mid=medfilt2(g);

%% 计算几何平均下的降噪性能
A1=means-a;
MSE1=sum(A1(:).*A1(:))/numel(A1);
RMSE1=(MSE1)^0.5;

SNR1=10*log10(sum(means(:).*means(:))/sum((g(:)-a(:)).*(g(:)-a(:))));
PSNR1 = 10*log10(255^2/MSE1);
MAE1=mean(mean(abs(A1)));

%% 计算中值滤波条件下的降噪性能
A2=mid-a;
MSE2=sum(A2(:).*A2(:))/numel(A2);
RMSE2=(MSE2)^0.5;

SNR2=10*log10(sum(mid(:).*mid(:))/sum((g(:)-a(:)).*(g(:)-a(:))));
PSNR2 = 10*log10(255^2/MSE2);
MAE2=mean(mean(abs(A2)));

%% 绘制图像
figure(1);
subplot(3,2,1);
imshow(A1,[]);
title('经过几何平均之后的图像与原图的差值');
subplot(3,2,2);
imshow(A2,[]);
title('经过中值滤波之后的图像与原图的差值');
subplot(3,2,3);
imshow(a,[]);
title('原始图像');
subplot(3,2,4);
imshow(g,[]);
title('加椒盐噪声之后的图像');
subplot(3,2,5);
imshow(means,[]);
title('几何平均降噪之后的图像');
subplot(3,2,6);
imshow(mid,[]);
title('中值滤波降噪之后的图像');

%% 展示数据
context1=['几何平均下的性能数据：','均方根误差为',num2str(RMSE1),'、信噪比为',num2str(SNR1),'、信噪比峰值为',num2str(PSNR1),'、最大绝对误差为:',num2str(MAE1)];
disp(context1);
context2=['中值滤波下的性能数据：','均方根误差为',num2str(RMSE2),'、信噪比为',num2str(SNR2),'、信噪比峰值为',num2str(PSNR2),'、最大绝对误差为:',num2str(MAE2)];
disp(context2);