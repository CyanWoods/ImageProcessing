%% 几种边界检测
clc;
clear vars;
close all;

%% 导入图像
img = imread('a.png');
img = rgb2gray(img);
subplot(2,2,1);
imshow(img);
title('原始图像');
[m,n] = size(img);
T = 20;

%% Roberts算子
imgr = zeros(m,n);
for i=2:m-1
    for j=2:n-1
        imgr(i,j)= abs(img(i,j)-img(i+1,j+1)) + abs(img(i+1,j)-img(i,j+1));
        if imgr(i,j)<T
            imgr(i,j) = 0;
        else
            imgr(i,j) = 255;
        end
    end
end
subplot(2,2,2);
imshow(imgr);
title('Roberts算子图像');

%% Laplace算子
imgl = zeros(m,n);
for i=2:m-1
    for j=2:n-1
        imgl(i,j)= abs(img(i+1,j)+img(i-1,j)+img(i,j+1)+img(i,j-1)-4*img(i,j));
        if imgl(i,j)<T
            imgl(i,j) = 0;
        else
            imgl(i,j) = 255;
        end
    end
end
subplot(2,2,3);
imshow(imgl);
title('Laplace算子图像');

%% Sobel算子
imgs = zeros(m,n);
for i=2:m-1
    for j=2:n-1
        imgs(i,j)= abs(img(i-1,j+1)+2*img(i,j+1)+img(i+1,j+1)-img(i-1,j-1)-2*img(i,j-1)-img(i+1,j-1)) + abs(img(i+1,j-1)+2*img(i+1,j)+img(i+1,j+1)-img(i-1,j-1)-2*img(i-1,j)-img(i-1,j+1));
        if imgs(i,j)<T
            imgs(i,j) = 0;
        else
            imgs(i,j) = 255;
        end
    end
end
subplot(2,2,4);
imshow(imgs);
title('Sobel算子图像');

