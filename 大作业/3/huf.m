%% 霍夫曼编码
clear;
clear vars;
close all;

%% 二叉树
a=[0.11,0.02,0.08,0.04,0.39,0.05,0.06,0.25];
c=huffman(a);
disp(c);

%% 将图像转换为八灰度级
I = imread('cameraman.tif');
[m,n]=size(I);
J=zeros(m,n);
for i=1:m
    for j=1:n
        J(i,j)=floor(I(i,j)/32);
    end
end
K=uint8(J);

%% 霍夫曼编码
[M,N] = size(K);
 I1 = K(:);                     %之字形扫描，将灰度值填入到一个列向量中
 P = zeros(1,256);
 
 %% 获取各符号的概率；
 for i = 0:255
     P(i+1) = length(find(I1 == i))/(M*N);  %计算各灰度级出现的概率(0-8)
 end

 k = 0:255;
 dict = huffmandict(k,P);       %生成字典
 enco = huffmanenco(I1,dict);   %编码
 
 %% 霍夫曼译码
 deco = huffmandeco(enco,dict); %解码
 Ide = col2im(deco,[M,N],[M,N],'distinct'); %把向量重新转换成图像块；

 %% 绘图
 subplot(1,2,1);imshow(K,[]);title('原始图像');
 subplot(1,2,2);imshow(uint8(Ide),[]);title('经过编码译码后的图像');
