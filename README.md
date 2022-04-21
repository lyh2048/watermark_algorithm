# 数字水印算法

> 数字水印技术是指将含有可以证明自己产权或者隐私的水印信息嵌入到图像数据中，从而达到维护自身合法利益的目的。
>
> 数字水印技术的本质就是修改图像像素值来完成水印数据的嵌入，并且按照一定方法提取水印数据。
>
> 数字水印是利用数字作品中普遍存在的冗余数据和随机性，把标识版权的水印信息嵌入到数字作品中，从而可以起到保护数字作品的版权或其完整性的一种技术。
>
> 一个有效的数字水印系统至少具备以下三个最基本的特性：
>
> 1. 安全性：数据信息隐藏于数据图像中，不是文件头中，文件格式的变换不应导致水印信息的丢失
> 2. 隐蔽性：在数字图像作品中嵌入数字水印不会引起图像的明显降质，即含水印的图像与原始图像对人的感觉器官的刺激应该是无差别或差别很小，主观感觉变化很小
> 3. 鲁棒性：是指在经历有意或无意的信号处理过程后，水印信息仍能保持完整性或仍能被准确鉴别
>
> 数字水印的基本应用领域是版权保护、隐藏标识、认证和安全不可见通信等。

## 空间域算法

数字水印直接加在原始数据上，还可以细分为如下几种方法：

（1）最低有效位（LSB）

（2）Patchwork方法及纹理块映射编码方法

## 变换域算法

基于变换域的技术可以嵌入大量比特数据而不会导致可察觉的缺陷，往往采用类似扩频图像的技术来隐藏数字水印信息。

这类技术一般基于常用的图像变换，基于局部或是全部的变换，这些变换包括离散余弦变换(DCT)、小波变换(WT)、傅氏变换(FT或FFT)以及哈达马变换(Hadamardtransform)等等。

## NEC算法

该算法具有较强的鲁棒性、安全性、透明性等。由于采用特殊的密钥，故可防止IBM攻击，而且该算法还提出了增强水印鲁棒性和抗攻击算法的重要原则，即水印信号应该嵌入源数据中对人感觉最重要的部分，这种水印信号由独立同分布随机实数序列构成，且该实数序列应具有高斯分布N(0, 1)的特征。
