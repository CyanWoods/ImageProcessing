%% 图像边界提取与填充
clc;
clear vars;
close all;

%% 读取原图
I = imread('a.png');
I=rgb2gray(I);                  %将图像转换为灰度图像
I=imbinarize(I);                %将灰度图像转换为二值图像（黑白图像）
mask=[1,0,1;0,0,0;1,0,1];       %设定结构元素(黑十字)
subplot(3,1,1);
imshow(I,[]);
title('原图');

%% 边界提取
boundary=I-imerode(I,mask);     %原图减去经结构元素腐蚀的图像，得到边界
subplot(3,1,2);
imshow(boundary,[]);
title('提取的边界');

%% 内容填充
% seed-location=(83,168);       %找的一个图像内部的点，作为膨胀的初始点


AC=ones(166,336)-boundary;      %边界图像的补集
plat=zeros(166,336);            %一个空图像（全黑）
plat(83,168)=1;                 %将初始点"染白"
CE=ones(3,3)-mask;              %把结构元素换成"白十字"

for counter=1:250               %对有白点的图像进行膨胀处理，再和补集作积，如此循环250次
    plat=imdilate(plat,CE);
    plat=plat.*(AC);
    
end

plat=plat+boundary;             %将填充的图像与刚刚提取的边界求并集（其实就是想保存最右边的白框框做对比）

subplot(3,1,3);
imshow(plat,[]);
title('对提取的边界进行区域填充');

