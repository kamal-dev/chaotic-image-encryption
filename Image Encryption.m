clear;clc;
img = imread('lena.png');
img = rgb2gray(img);
figure(10)
imshow(img);
tic
timg = img;
r = 3.62;
x(1) = 0.7;
row = size(img,1);
col = size(img,2);
s = row*col;
%Creation of Logistic function
for n=1:s-1
    x(n+1) = r*x(n)*(1-x(n));
end

[so,in] = sort(x);

%Start of Confusion
timg = timg(:);
for m = 1:size(timg,1)
    
    t1 = timg(m);
    timg(m)=timg(in(m));
    timg(in(m))=t1;
    
end
%End of confussion


%Creation of diffusion key

p=3.628;
k(1)=0.632;
for n=1:s-1
    k(n+1) = cos(p*acos(k(n)));
end
k = abs(round(k*255));

ktemp = de2bi(k);
ktemp = circshift(ktemp,1);
ktemp = bi2de(ktemp)';
key = bitxor(k,ktemp);

%Ending creation of diffusion key


%Final Encryption Starts
timg = timg';
timg = bitxor(uint8(key),uint8(timg));
himg = reshape(timg,[row col]);
figure(1)
imshow(himg);
%Final Encryption Ends
toc
%Decryption Start
timg = bitxor(uint8(key),uint8(timg));
timg = timg(:);
for m = size(timg,1):-1:1
    
    t1 = timg(m);
    timg(m)=timg(in(m));
    timg(in(m))=t1;
    
end
%Decryption End
timg = reshape(timg,[row col]);

figure(2)
imshow(timg);

figure(3)
imhist(img);

figure(4)
imhist(himg);

%Entropy Test

E = entropy(himg)

%Cross Correlation - Value should be lesser <<<<1


cc=corr2(img,himg)

%PSNR - Value should be high

origImg = double(img);
distImg = double(timg);

[M N] = size(origImg);
error = origImg - distImg;
MSE = sum(sum(error .* error)) / (M * N);

if(MSE > 0)
    PSNR = 10*log(255*255/MSE) / log(10)
else
    PSNR = 99
end

%Pixel Correlation

    %hprizontal
    A=double(img);
    A2 = double(himg);
    x1 = A(:,1:end-1);  
    y1 = A(:,2:end);
    kyatayO=hesap(x1,y1);
    %Vertical
    x2 = A(1:end-1,:);  
    y2 = A(2:end,:);    
    kdikeyO=hesap(x2,y2);
    %diagonal
    x3 = A(1:end-1,1:end-1);  
    y3 = A(2:end,2:end);     
    kkosegenO=hesap(x3,y3);

    %==================================================
    %for encrypted image
    %horizontal
    x4 = A2(:,1:end-1);  
    y4 = A2(:,2:end);
    kyatayI=hesap(x4,y4);
    %Vertical
    x5 = A2(1:end-1,:);  
    y5 = A2(2:end,:);    
    kdikeyI=hesap(x5,y5);
    %diagonal
    x6 = A2(1:end-1,1:end-1);  
    y6 = A2(2:end,2:end);     
    kkosegenI=hesap(x6,y6);
    %==================================================
    %graphics
    h=figure;
    subplot(3,2,1),grafik(x1,y1),title('Horizontal');
    subplot(3,2,3),grafik(x2,y2),title('Vertical');
    subplot(3,2,5),grafik(x3,y3),title('Diagonal');
    subplot(3,2,2),grafik(x4,y4),title('Horizontal');
    subplot(3,2,4),grafik(x5,y5),title('Vertical');
    subplot(3,2,6),grafik(x6,y6),title('Diagonal');