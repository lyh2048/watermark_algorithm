close all;
clear; clc;
% 加权因子
a1 = 0.02; a2 = 0.01; a3 = 0.01; a4 = 0.01;
% 载体图像
I = imread("D:/code/matlab/in/lena_std.png");
% 水印图像
w = imread("D:/code/matlab/in/sdust.png");
% 图像预处理
I = rgb2gray(I);
w = rgb2gray(w);
w = imresize(w, size(I) / 4);
I = im2double(I);
w = im2double(w);
% dwt
[ca1, ch1, cv1, cd1] = dwt2(w, 'haar');
% 载体图像进行三级小波分解
[c, s] = wavedec2(I, 3, 'haar');
cA3 = appcoef2(c, s, 'haar', 3);
cH3 = detcoef2('h', c, s, 3);
cV3 = detcoef2('v', c, s, 3);
cD3 = detcoef2('d', c, s, 3);

cH2 = detcoef2('h', c, s, 2);
cV2 = detcoef2('v', c, s, 2);
cD2 = detcoef2('d', c, s, 2);

cH1 = detcoef2('h', c, s, 1);
cV1 = detcoef2('v', c, s, 1);
cD1 = detcoef2('d', c, s, 1);

% 嵌入
cA3 = cA3 + a1 * ca1;
cH3 = cH3 + a2 * ch1;
cV3 = cV3 + a3 * cv1;
cD3 = cD3 + a4 * cd1;
% 重构
I_w = idwt2(cA3, cH3, cV3, cD3, 'haar');
I_w = idwt2(I_w, cH2, cV2, cD2, 'haar');
I_w = idwt2(I_w, cH1, cV1, cD1, 'haar');

subplot(221); imshow(I, []); title('原始图像');
subplot(222); imshow(w, []); title('水印图像');
subplot(223); imshow(I_w, []); title('含水印图像');

% 提取水印
% 对原始图像进行三级小波变换
[c, s] = wavedec2(I, 3, 'haar');
cA3 = appcoef2(c, s, 'haar', 3);
cH3 = detcoef2('h', c, s, 3);
cV3 = detcoef2('v', c, s, 3);
cD3 = detcoef2('d', c, s, 3);
% 对含有水印的图像进行三级小波变换
[c1, s1] = wavedec2(I_w, 3, 'haar');
I_w_ca3 = appcoef2(c1, s1, 'haar', 3);
I_w_ch3 = detcoef2('h', c1, s1, 3);
I_w_cv3 = detcoef2('v', c1, s1, 3);
I_w_cd3 = detcoef2('d', c1, s1, 3);

% 提取
w_ca1 = (I_w_ca3 - cA3) / a1;
w_ch1 = (I_w_ch3 - cH3) / a2;
w_cv1 = (I_w_cv3 - cV3) / a3;
w_cd1 = (I_w_cd3 - cD3) / a4;
w1 = idwt2(w_ca1, w_ch1, w_cv1, w_cd1, 'haar');
subplot(224); imshow(w1, []); title('提取的水印图像');