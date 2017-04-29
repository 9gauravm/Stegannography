%clear all;
%I = imread('D:\MTech-II\Research\Stega-resourse\Project\stego_DWT\algorithm\1.jpg');
%imshow(I)
%im=imresize(I,[256 256]);
%img=rgb2gray(im);
function[s]=Subimages(img,L1,L2)


s=cell(L1,L2);
%temp[64:64];
for a=1:L1 % subimage number from 1...L1(we kept L1=L2=4)
    for b=1:L2 %subimage number from 1...L2(we kept L1=L2=4)
        for ka=0:63 % paremeter ranging from 1..(n1/L1)-1 ,n1*n2 image dimension here it is 256*256...that will decide no of rows in sub image
            for kb=0:63 %paremeter ranging from 1..(n2/L2)-1 ,n1*n2 image dimension here it is 256*256...that will decide no of columns in sub image
              row=a+ka*L1;
              col=b+kb*L2;
              im1=img(row,col); 
                temp(ka+1,kb+1)= im1;
            end
        end
        s{a,b}=temp;
    end
end
