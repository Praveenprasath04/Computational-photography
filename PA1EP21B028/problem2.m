function deimg = demosaic1(img,cfa,type)
    [x,y] = size(cfa);
    [X, Y] = meshgrid(1:y, 1:x);
    
    red_id = (cfa == 1);
    green_id = (cfa ==2);
    blue_id = (cfa ==3) ;
    
    red_coord = [X(red_id),Y(red_id)];
    green_coord = [X(green_id),Y(green_id)];
    blue_coord = [X(blue_id),Y(blue_id)];
    
    
    
    red_val = double(img(cfa == 1));
    green_val = double(img(cfa == 2));
    blue_val = double(img(cfa == 3));
    
    red_l_int = griddata(red_coord(:,1), red_coord(:,2), red_val, X, Y, type);
    green_l_int = griddata(green_coord(:,1), green_coord(:,2), green_val, X, Y, type);
    blue_l_int = griddata(blue_coord(:,1), blue_coord(:,2), blue_val, X, Y, type);
    
    deimg= cat(3,red_l_int/max(red_l_int(:)),green_l_int/max(green_l_int(:)),blue_l_int/max(blue_l_int(:)));
        
    end
%%

rawimg1 = load("Copy of RawImage1.mat").RawImage1;
rawimg2 = load("Copy of RawImage2.mat").RawImage2;
rawimg3 = load("Copy of RawImage3.mat").RawImage3;

bayer_1 = load("Copy of bayer1.mat").bayer1;
bayer_2 = load("Copy of bayer2.mat").bayer2;
bayer_3 = load("Copy of bayer3.mat").bayer3;

%%
demosaic_img1 = demosaic1(rawimg1,bayer_1,"cubic");
demosaic_img2 = demosaic1(rawimg2,bayer_2,"cubic");
demosaic_img3 = demosaic1(rawimg3,bayer_3,"cubic");
%%
size(demosaic_img3)
inpict = im2double(demosaic_img3);
RGBavg = mean(inpict,1:2,"omitnan")


%%
tiledlayout(2,2)

nexttile
imshow(demosaic_img1)
title("demosaic image 1")

nexttile
imshow(demosaic_img2)
title("demosiac image 2")

nexttile
imshow(demosaic_img3)
title("demosaic image 3")

%%
function [outpict1,outpict2] = greybalancing(img,gray)

inpict = im2double(img);

RGBavg = mean(inpict,1:2,"omitnan");
meanRGB = mean(RGBavg);

Krgb = meanRGB./RGBavg;
grbg = gray./RGBavg;

outpict_1 = inpict.*Krgb;
outpict_2 = inpict.*grbg;



outpict1 = im2uint8(outpict_1);
outpict2 = im2uint8(outpict_2);

end
%%
[g1_rawimg1,g2_rawimg1] = greybalancing(demosaic_img1,0.5);

[g1_rawimg2,g2_rawimg2] = greybalancing(demosaic_img2,0.5);

[g1_rawimg3,g2_rawimg3] = greybalancing(demosaic_img3,0.5);
%%
tiledlayout(3,2)

nexttile
imshow(g1_rawimg1)
title("Avg gray Image 1")

nexttile
imshow(g2_rawimg1)
title("0.5 = gray Image 1")

nexttile
imshow(g1_rawimg2)
title("Avg gray Image 2")

nexttile
imshow(g2_rawimg2)
title("0.5 = gray Image 2")

nexttile
imshow(g1_rawimg3)
title("Avg gray Image 3")

nexttile
imshow(g2_rawimg3)
title("0.5 = gray Image 3")
%%
function outpict1 = whiteposbalancing(img,pos)

inpict = im2double(img);

RGB =inpict(pos(1),pos(2),:)

Krgb = 1./RGB;

outpict_1 = inpict.*Krgb;



outpict1 = im2uint8(outpict_1);
end
%%
size(rawimg2)
%%
%%
w_rawimg1 = whiteposbalancing(demosaic_img1,[814,830]);

w_rawimg2 = whiteposbalancing(demosaic_img2,[280,1165]);

w_rawimg3 = whiteposbalancing(demosaic_img3,[675,175]);
%%
tiledlayout(3,2)

nexttile
imshow(demosaic_img1)
title("demosaic 1")

nexttile
imshow(w_rawimg1)
title("bright pixel est 1")

nexttile
imshow(demosaic_img2)
title("demosaic Image 2")

nexttile
imshow(w_rawimg2)
title("bright pixel est 2")

nexttile
imshow(demosaic_img3)
title("demosaic Image 3")

nexttile
imshow(w_rawimg3)
title("bright pixel est 3")
%%
function outpict1 = neutralposbalancing(img,pos)

inpict = im2double(img);

RGBavg=inpict(pos(1),pos(2),:);

meanRGB = mean(RGBavg);

Krgb = meanRGB./RGBavg;

outpict_1 = inpict.*Krgb;



outpict1 = im2uint8(outpict_1);

end
%%
n_rawimg1 = neutralposbalancing(demosaic_img1,[435,2000]);

n_rawimg2 = neutralposbalancing(demosaic_img2,[715,445]);

n_rawimg3 = neutralposbalancing(demosaic_img3,[565,1550]);
%%
tiledlayout(3,2)

nexttile
imshow(demosaic_img1)
title("demosaic 1")

nexttile
imshow(n_rawimg1)
title("neutral pixel est 1")

nexttile
imshow(demosaic_img2)
title("demosaic Image 2")

nexttile
imshow(n_rawimg2)
title("neutal pixel est 2")

nexttile
imshow(demosaic_img3)
title("demosaic Image 3")

nexttile
imshow(n_rawimg3)
title("neutal pixel est 3")
%%
hist1 = histeq(n_rawimg1);
hist2 = histeq(n_rawimg2);
hist3 = histeq(n_rawimg3);
%%
tiledlayout(3,1)

nexttile
imshow(hist1)
title("Histogram Equalization 1")


nexttile
imshow(hist2)
title("Histogram Equalization 2")


nexttile
imshow(hist3)
title("Histogram Equalization 3")
%%
g= [0.5,0.7,0.9]
pimg = {n_rawimg1,n_rawimg2,n_rawimg3}
imagelist = []

tiledlayout(3,4,'TileSpacing','Compact');


for i = 1:3
    nexttile
    imshow(pimg{i})
    title(sprintf("Image %.1f",i))
    for j = 1:3
        jg = g(j);
        img = im2double(pimg{i});
        eimg = img.^jg;
        nexttile;
        imshow(eimg)
        title(sprintf("gamma:%.2f",jg))
    end
end
        


