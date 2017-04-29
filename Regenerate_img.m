function[st]=Regenerate_img(s)
L2=4;
L1=4;

for a=1:L1 % subimage number from 1...L1(we kept L1=L2=4)
    for b=1:L2 %subimage number from 1...L2(we kept L1=L2=4)
        mat=s{a,b};
        for ka=0:63 % paremeter ranging from 1..(n1/L1)-1 ,n1*n2 image dimension here it is 256*256...that will decide no of rows in sub image
            for kb=0:63 %paremeter ranging from 1..(n2/L2)-1 ,n1*n2 image dimension here it is 256*256...that will decide no of columns in sub image
              row=a+ka*L1;
              col=b+kb*L2;
              %im1=img(row,col); 
              %disp(im1);
               st(row,col)= mat(ka+1,kb+1);
            end
        end
        %imshow(temp);
       % s{a,b}=temp;
        %clear temp;
    end
end
end