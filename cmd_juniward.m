
clc;
clear all;

I=imresize(imread('C:\Users\yday\Desktop\J-UNIWARD_matlab\matlab\18.jpg'),[256 256]); 

%I=rgb2gray(a1);%cover image
%I=im2double(I2);
%Y=rgb2gray(a1);%stego image
D=[];
payload=0.2;
%C=rgb2gray(a1);%cost by wow of Y
%arr=[];
%pplus=[];
%pminus=[];
%Create Subimages of Input Cover Image ans store in to Subimage Cell Array
%size of subimage Depends on L1,L2 parameters
wetConst = 10^13;
L1=4;% subimage size
L2=4; % subimage size
[subimage]=Subimages(I,L1,L2);%Create Cell of subimages
subimage1=subimage;
%Get Message and Divide in to Small Chunks of Size m/L1*L2
%[message]=file2bin('5')
Data = 'walchand college of engineering.';
%{
password='P12@wce';
%Encrypt message with password using L8 encryption al
[Emessage]=L8encrypt(Data,password);
Data2=Emessage(:);
bin=dec2bin(Data2,8)';
message=bin(:);
[dEmessage]=L8decrypt(Emessage,password);
%}
secret_msg_bin = str2bin(Data);

sub_msg_size=length(secret_msg_bin)/(L1*L2);

%submesage=vec2mat(secret_msg_bin,sub_msg_size);
%ctr=1;
stego=cell(L1,L2);
m=[];
arr=[];
for i=1:256
    for j=1:256
        img(i,j)=255;
        
    end
end
%{
 for i=1:L1
     for j=1:L2
         msg=submesage(ctr,:);
        [stego{i,j}]=steganography_image_lsb(subimage{i,j},msg);
        %disp(ctr);
        ctr=ctr+1;
     end
 end
%}
% Regenetrate stego image
%[stego_image]=Regenerate_img(stego);
%imshow(uint8(stego_image));
%store stego image in folder
%imwrite(uint8(stego_image),'D:\MTech-II\Research\Stega-resourse\Project\stego_DWT\algorithm\CMD_LSB\_5_Lsb_1.jpg');
%imwrite(uint8(stego{1,1}),'C:\Users\ADI\Desktop\1.jpg');
%disp('Image Encrypted');
%{
%Decrypt
Message=cell(L1,L2);

[Message]=Test_start_Decrypt(stego_image);
temp=[];
ms=[];
for i=1:L1
     for j=1:L2
        temp=Message{i,j};
        Message{i,j}=temp(1:sub_msg_size);
     ms=horzcat(ms,Message{i,j}) ;  
     end
end


decrypted_msg= bin2str(ms);

%}
%[PSNR]=Performance_evaluation(I,stego_image);

ex=cat(1,cat(2,subimage{1,1},subimage{1,2},subimage{1,3},subimage{1,4}),cat(2,subimage{2,1},subimage{2,2},subimage{2,3},subimage{2,4}),cat(2,subimage{3,1},subimage{3,2},subimage{3,3},subimage{3,4}),cat(2,subimage{4,1},subimage{4,2},subimage{4,3},subimage{4,4}));

%passing subimage for encryption

for i=1:L1
     for j=1:L2
         
        if(L1==1 & L2==1)
            Y=ex; 
        end

 Y=cat(1,cat(2,subimage{1,1},subimage{1,2},subimage{1,3},subimage{1,4}),cat(2,subimage{2,1},subimage{2,2},subimage{2,3},subimage{2,4}),cat(2,subimage{3,1},subimage{3,2},subimage{3,3},subimage{3,4}),cat(2,subimage{4,1},subimage{4,2},subimage{4,3},subimage{4,4}));

        
D=Y-ex;

imwrite(uint8(Y),'C:\Users\yday\Desktop\J-UNIWARD_matlab\matlab\Temp\y.jpg');
coverPath='C:\Users\yday\Desktop\J-UNIWARD_matlab\matlab\Temp\y.jpg';

%MEXstart = tic;
%[rhoP1,rhoM1,rho]=WO(Y,payload,params);% cost of stego image
[C_COEFFS,nzAC,rho]=J_UNIWARD(Y,coverPath);%need to write image at cover path

%MEXend = toc(MEXstart);
%fprintf(' - DONE');

C=rho;

for x=1:256
    for y=1:256
    x1=x+1;
    y1=y+1;
    x2=x-1;
    y2=y-1;
    
        if((x1<=256)&&(x1>=1))
            a=D(x1,y);
             arr(end+1)=a;
          
        end
         if( (y1<=256) &&(y1>=1))
            b=D(x,y1);
            arr(end+1)=b;
         end  
             
         if((x2<=256)&& (x2>=1))
            c=D(x2,y);
             arr(end+1)=c;
        end
        
         if((y2<=256)&& (y2>=1) )
            d=D(x,y2);
             arr(end+1)=d;
         end
         
   
    zvalue=0;%calculating conditions for updating condition in p matrix
    zvalue1=0;
    for l=1:length(arr)
        z=arr(l)-1;
        if(z~=0)
            zvalue=zvalue+0;
        else
            zvalue=zvalue+1;
        end
       z=arr(l)+1;
       if(z~=0)
           zvalue1=zvalue1+0;
       else
           zvalue1=zvalue1+1;
       end    
    end
   arr=[];
   
    
    %initializinbg p matrices
    alfa=9;%alfa set to 9
        if(zvalue>zvalue1)  
            c1=C(x,y);
            pplus(x,y)=c1/alfa;
        else
             c1=C(x,y);
             pplus(x,y)=c1;
        end
        
        if(zvalue1>zvalue)
            c1=C(x,y);
            pminus(x,y)=c1/alfa;
        else
             c1=C(x,y);
            pminus(x,y)=c1;
            
        end   
    end
end

rhoM1_pm = pminus;
rhoP1_ps = pplus;

rhoP1_ps(rhoP1_ps > wetConst) = wetConst;
rhoP1_ps(isnan(rhoP1_ps)) = wetConst;    
rhoP1_ps(C_COEFFS > 1023) = wetConst;
    
rhoM1_pm(rhoM1_pm > wetConst) = wetConst;
rhoM1_pm(isnan(rhoM1_pm)) = wetConst;
rhoM1_pm(C_COEFFS < -1023) = wetConst;

i1=subimage{L1,L2};
for p=1:64
    for q=1:64
        img(p,q)=i1(p,q);
    end
end

substeg=EmbeddingSimulator(img,rhoP1_ps,rhoM1_pm,round(sub_msg_size*payload*nzAC));

for p=1:64
    for q=1:64
        sub(p,q)=substeg(p,q);
    end
end

subimage{L1,L2}=sub;


end
end

%disp('Done');  

%imshow(double(subimage{L1,L2}));
mpn=Regenerate_img(subimage);
mpn1=Regenerate_img(subimage1);
figure;
imshow(mpn);%Stego Image

figure;
imshow(mpn1);%Cover Image

%diff=mpn-mpn1;
%nn=nnz(diff);

