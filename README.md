# <b><font color="FF6633">Random-LSB-Steganography</font></b>
---
**利用随机LSB替换算法在bmp文件中嵌入信息**

## 一.任务简介
使用Matlab编写一个对24bit真彩色BMP图像，进行最低2个位平面随机LSB替换算法嵌入秘密信息的程序。  
要求：
- 可设定随机密钥，可选择文件嵌入/提取
- 有GUI
- 做好代码容错、注释等工作

## 二.原理说明
通过密钥$key$获得伪随机的打乱的位置，可供选择的位置有 图片高*图片宽*通道数（3）*隐藏位深（2） 个，但我们需要的存储空间大小前为
$L+32$个位置，其中$L$为隐写文件大小，而32是一个uint32的整数，用于记录隐写文件大小（嵌在随机隐写位置的前32位上），接收方通过$key$
可以得到和发送方同样的伪随机位置存储序列，从前32个位置可以获得隐写文件大小，之后根据文件大小提取隐写文件。

## 三.文件说明
文件包括实时脚本演示和一个简单的app demo。  
实时脚本部分结构如下：
```
    main.mlx -->lsbRead.m[lsb隐写函数] --> lsbEmbedding.m[获得随机嵌入位置的函数]
             -->lsbRead.m[读取隐写信息的函数]
```

脚本和函数内部都有非常清楚的markdown注释，包括原理等。依次运行cell以观看演示的结果。

app文件：demo_app.mlapp。文件运行需要matlab版本支持matlab app。app页面如下图： 

<div align = "center">
    <img src="image\illustrate\app1.jpg" alt="app1" width="304" height="228">
</div>

输入任意数字设定密钥，之后设定载体图片，写入信息，并从写有信息的图片中读取隐藏的信息。任何二进制形式文件都是可以存取的，但注意存取时
需要指定文件格式(其实这不太合理，因为隐写信息接受方不一定知道发送文件的格式，当然可以在隐写的时候像写入长度一样也将文件格式写进载体图片)

对于app,该文件提供了两个样例：
- 样例一：文字隐写——以拜伦的诗歌为例：
         text文件夹下保存有“All Is Vanity, Saieth the Preacher.txt”,利用app将其压缩到“image\Lena.bmp”中，得到图片"app_text_embedding.bmp"。
         之后利用同样的密钥提取可以得到结果“res_of_poem.txt”。对比发现结果和初始txt完全一样。
<div align = "center">
    <img src="image\illustrate\app2.jpg" alt="app2" width="300" height="500">
</div>

- 样例二：图片隐写——以表情包为例：
         image文件夹下保存有表情包“滑稽.jpg”,利用app将其压缩到“image\Lena.bmp”中，得到图片"app_embedding.bmp"。
         之后利用同样的密钥提取可以得到结果“res_image.jpg”(见result文件夹)。对比发现结果和初始表情包完全一样。
<div align = "center">
    <img src="result\res_image.jpg" alt="app3" width="60" height="60">
</div>         