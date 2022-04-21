close all;
clear; clc;
size = 512; N = 32; K = 8; D = zeros(size); E = 0.01;
% 载体图像
I = imread("D:/code/matlab/in/lena_std.png");
I = rgb2gray(I);
figure;
subplot(2, 2, 1); imshow(I); title('原始图像');
I = im2double(I);
% 水印图像
J = imread("D:/code/matlab/in/sdust.png");
J = rgb2gray(J);
subplot(2, 2, 2); imshow(J); title('水印图像');
% 对水印缩放
J = imresize(J, [64 64]);
J = imbinarize(J);
J = im2uint8(J);
subplot(2, 2, 3); imshow(J, []); title('水印图像');
% 嵌入水印
for p = 1:size / K
    for q = 1: size / K
        x = (p - 1) * K + 1;
        y = (q - 1) * K + 1;
        I_dct = I(x:x+K-1, y:y+K-1);
        I_dct1 = dct2(I_dct);
        if J(p, q) == 0
            a = -1;
        else
            a = 1;
        end
        I_dct2 = I_dct1 + a * E;
        I_dct = idct2(I_dct2);
        D(x:x+K-1, y:y+K-1) = I_dct;
    end
end
subplot(2, 2, 4); imshow(D); title('含水印的图像');
% 提取水印
W = zeros(64);
for p = 1:size / K
    for q = 1:size / K
        x = (p - 1) * K + 1;
        y = (q - 1) * K + 1;
        I1 = I(x:x+K-1, y:y+K-1);
        I2 = D(x:x+K-1, y:y+K-1);
        I_dct1 = dct2(I1);
        I_dct2 = dct2(I2);
        if I_dct2 > I_dct1
            W(p, q) = 255;
        else
            W(p, q) = 0;
        end
    end
end
figure;
subplot(2, 2, 1); 
imshow(W, []); 
title('不攻击');
% 对加入水印的图像进行各种攻击
% 滤波攻击
fs = fspecial('gaussian', 3, 0.2);
R1 = filter2(fs, D);
for p = 1:size / K
    for q = 1:size / K
        x = (p - 1) * K + 1;
        y = (q - 1) * K + 1;
        I1 = I(x:x+K-1, y:y+K-1);
        I2 = R1(x:x+K-1, y:y+K-1);
        I_dct1 = dct2(I1);
        I_dct2 = dct2(I2);
        if I_dct2 > I_dct1
            W(p, q) = 255;
        else
            W(p, q) = 0;
        end
    end
end
subplot(2, 2, 2); 
imshow(W, []); 
title('滤波攻击');
% 旋转攻击
R2 = imrotate(D, 10,'bilinear','crop');
for p = 1:size / K
    for q = 1:size / K
        x = (p - 1) * K + 1;
        y = (q - 1) * K + 1;
        I1 = I(x:x+K-1, y:y+K-1);
        I2 = R2(x:x+K-1, y:y+K-1);
        I_dct1 = dct2(I1);
        I_dct2 = dct2(I2);
        if I_dct2 > I_dct1
            W(p, q) = 255;
        else
            W(p, q) = 0;
        end
    end
end
subplot(2, 2, 3); 
imshow(W, []); 
title('旋转攻击');
% 剪切攻击
R3 = D;
R3(1:32, 1:32) = 0;
for p = 1:size / K
    for q = 1:size / K
        x = (p - 1) * K + 1;
        y = (q - 1) * K + 1;
        I1 = I(x:x+K-1, y:y+K-1);
        I2 = R3(x:x+K-1, y:y+K-1);
        I_dct1 = dct2(I1);
        I_dct2 = dct2(I2);
        if I_dct2 > I_dct1
            W(p, q) = 255;
        else
            W(p, q) = 0;
        end
    end
end
subplot(2, 2, 4); 
imshow(W, []); 
title('剪切攻击');