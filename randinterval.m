%随机间隔法
%算法描述：
%输入：载体图像C、嵌入信息长度L、密钥k
%输出：嵌入位置的行向量row、列向量col；
%步骤：
%1、读取图像矩阵C，并且读出图像C的大小m*n，计算总体像素个数N
%2、计算间隔k1和k2，k1=floor(N/L),k2=k1-2;
%3、用密钥k产生一个长度为L的随机序列a;
%4、设置长度均为L的行向量row和列向量col，用来保存嵌入位置，第一个位置都为1
%5、设置两个变量r、c存放当前嵌入位置，并初始化值都为1
%6、循环从2到L，若随机数a(i)>0.5,则c=c+k1;否则c=c+k2;
%    判断c>n？，若大于，则r=r+1（换行）若r>m?,则输出载体图像太小；
%    c=mod(c,n);若c==0，则c=n（最后一个位置），将展示的r和赋给向量row和col中保存
%----------------------------------------------------------------------------------
%函数说明：
%输入：载体C，嵌入长度L，密钥k
%输出：嵌入位置对应的行向量和列向量row、col
%函数功能介绍：随机间隔法找出嵌入位置


function [row,col]=randinterval(carry,L,key)

    %读取图像矩阵，并计算矩阵大小和像素个数
    carry=imread(carry);
    [m,n]=size(carry);
    N=m*n;
    
    %计算随机间隔k1和k2
    k1=floor(N/L);  % k1是一层能容纳的嵌入长度量
    k2=k1-2;
    
    %利用key做种子， 产生一个长度为L的随机序列
    rand('seed',key);   
    gate=rand(1,L);
    
    %设置row和col、r和c
    row=zeros(1,L);
    col=zeros(1,L);
    r=1;
    c=1;
    row(1,1)=r;
    col(1,1)=c;
    
    %设置嵌入位置
    for i=2:L
        if gate(i)>0.5 
            c=c+k1;
       else
        c=c+k2;
       end
       if c>n
           r=r+1;%行数加1
           if r>m
                 error('载体图像太小不能将秘密信息隐藏进去！')
           end
           c=mod(c,n);
           if c==0
                c=1;%进入下一行的第一列
           end
        end
        row(1,i)=r;
        col(1,i)=c;
    end