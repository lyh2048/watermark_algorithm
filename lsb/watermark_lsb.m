% 将水印嵌入到载体图像的最低位
close all;
clear; clc;
% 读取载体图像
I = imread("D:/code/matlab/in/lena_std.png");
% 预处理
I = rgb2gray(I);
% 读取水印
W = imread("D:/code/matlab/in/lyh.png");
% 预处理
W = rgb2gray(W);
W = imbinarize(W);
subplot(2, 2, 1);
imshow(I, []);
title('原始图像');
subplot(2, 2, 2);
imshow(W, []);
title('水印图像');
% 嵌入
I_w = I;
[h, w] = size(W);
i = 1:h*w;
I_w(i) = bitset(I_w(i), 1, W(i));
subplot(2, 2, 3);
imshow(I_w, []);
title('含有水印的图像');
% 提取
w = zeros(size(W));
w(i) = bitget(I_w(i), 1);
w = double(w);
subplot(2, 2, 4);
imshow(w, []);
title('提取的水印图像');