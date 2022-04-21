close all;
clear; clc;
% 载体图像
I = imread("D:/code/matlab/in/lena_std.png");
% 水印图像
w = imread("D:/code/matlab/in/lyh.png");
% 预处理
I = rgb2gray(I);
I = im2double(I);
w = rgb2gray(w);
w = imresize(w, size(I) / 2);
w = im2double(w);
% dwt
[LL, LH, HL, HH] = dwt2(I, 'haar');
% svd
[U, S, V] = svd(LL);
[Uw, Sw, Vw] = svd(w);
% 嵌入量
alpha = 0.2;
% 嵌入
S2 = S + alpha * Sw;
LL2 = U * S2 * V';
I_w = idwt2(LL2, LH, HL, HH, 'haar');
subplot(221); imshow(I); title('载体图像');
subplot(222); imshow(w); title('水印图像');
subplot(223); imshow(I_w); title('含有水印的图像');
% 提取水印
[LL3, LH3, HL3, HH3] = dwt2(I_w, 'haar');
[U3, S3, V3] = svd(LL3);
S4 = (S3 - S) / alpha;
w1 = Uw * S4 * Vw';
subplot(224); imshow(w1); title('提取的水印图像');
