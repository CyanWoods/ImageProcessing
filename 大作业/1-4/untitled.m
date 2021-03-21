clc;
im = imread('e.jpg');
 
% 1.图像分割 代表色彩选择 
n = 8;  %8 * 8 = 64块
[height,width,channal] = size(im);
block_h = fix(height/n); %块高度
block_w = fix(width/n);  %块宽度
im_n = zeros(n,n,channal);  %存放8x8的微小图像
for i = 1:n
    for j = 1:n
        for k = 1:channal
            % 确定块 
            a = block_h * (i-1)+1;  b = block_h * i; %高 a-b
            c = block_w * (j-1)+1;  d = block_w * j; %宽 c-d
            % 边界情况（右下块）
            if(i == n)   
                b = height;  end
            if(j == n)
                d = width;   end
            % 块代表色选择 这里选择平均值
            pix = mean(mean(im(a:b,c:d,k))); %计算块中像素平均值
            im_n(i,j,k) =  pix;              %赋值
        end
    end
end
%disp(im_n);%im_n即为每一块中所有像素各颜色分量的平均值
 
% 2.转换为YCbCr色彩空间 取值范围
im_YCbCr = rgb2ycbcr(im_n);  
%disp(im_YCbCr);
 
% 3.DCT变换
A = dctmtx(8); %调用D = dctmtx(N)函数，式中D是返回N×N的DCT变换矩阵，如果矩阵A是N×N方阵，则A的DCT变换可用D×A×D’来计算
im_DCT = zeros(n,n,channal); %存放结果
im_DCT(:,:,1) = A * im_YCbCr(:,:,1) * A'; %DCT_Y
im_DCT(:,:,2) = A * im_YCbCr(:,:,2) * A'; %DCT_Cb
im_DCT(:,:,3) = A * im_YCbCr(:,:,3) * A'; %DCT_Cr
%disp(im_DCT);%进行DCT变换后的结果

% 4.使用q(量化矩阵)进行量化 典型的量化矩阵(质量为原始JPEG标准中规定的50%)
q = [16  11  10  16   24   40   51   61
     12  12  14  19   26   58   60   55
     14  13  16  24   40   57   69   56
     14  17  22  29   51   87   80   62
     18  22  37  56   68  109  103   77
     24  35  55  64   81  104  113   92
     49  64  78  87  103  121  120  101
     72  92  95  98  112  100  103   99];
im_DCT(:,:,1) = im_DCT(:,:,1)./q;
im_DCT(:,:,2) = im_DCT(:,:,2)./q;
im_DCT(:,:,3) = im_DCT(:,:,3)./q;

% 5.按照zig扫描im_DCT 存储到descript中
zig = [1     2     6     7    15    16    28    29
       3     5     8    14    17    27    30    43
       4     9    13    18    26    31    42    44
      10    12    19    25    32    41    45    54
      11    20    24    33    40    46    53    55
      21    23    34    39    47    52    56    61
      22    35    38    48    51    57    60    62
      36    37    49    50    58    59    63    64 ];

D(1,:) = reshape(im_DCT(:,:,1)',1,64); %B = reshape(A,m,n)  将矩阵A的元素返回到一个m×n的矩阵B。如果A中没有m×n个元素则返回一个错误
D(2,:) = reshape(im_DCT(:,:,2)',1,64);
D(3,:) = reshape(im_DCT(:,:,3)',1,64);

Descriptor = D(:,zig); % 对im_DCT按照查表方式取元素，得到 zig 扫描结果
CLD = Descriptor; %从工作区中查看
