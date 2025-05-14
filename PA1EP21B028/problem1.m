img = load("Copy of RawImage1.mat").RawImage1;
bayer1 = load("Copy of bayer1.mat").bayer1;
[x,y] = size(bayer1);
[X, Y] = meshgrid(1:y, 1:x);


red_id = (bayer1 == 1);
green_id = (bayer1 ==2);
blue_id = (bayer1 ==3) ;
%% 

red_coord = [X(red_id),Y(red_id)];
green_coord = [X(green_id),Y(green_id)];
blue_coord = [X(blue_id),Y(blue_id)];

%% 

red_val = double(img(bayer1 == 1));
green_val = double(img(bayer1 == 2));
blue_val = double(img(bayer1 == 3));
%% 

red_l_int = griddata(red_coord(:,1), red_coord(:,2), red_val, X, Y, 'linear');
green_l_int = griddata(green_coord(:,1), green_coord(:,2), green_val, X, Y, 'linear');
blue_l_int = griddata(blue_coord(:,1), blue_coord(:,2), blue_val, X, Y, 'linear');

bl_int_img = cat(3,red_l_int/max(red_l_int(:)),green_l_int/max(green_l_int(:)),blue_l_int/max(blue_l_int(:)));
%%
imshow(img)
%%
%%
imshow(bl_int_img)

%% 

red_l_int = griddata(red_coord(:,1), red_coord(:,2), red_val, X, Y, 'cubic');
green_l_int = griddata(green_coord(:,1), green_coord(:,2), green_val, X, Y, 'cubic');
blue_l_int = griddata(blue_coord(:,1), blue_coord(:,2), blue_val, X, Y, 'cubic');
%% 

bc_int_img = cat(3,red_l_int/max(red_l_int(:)),green_l_int/max(green_l_int(:)),blue_l_int/max(blue_l_int(:)));

imshow(bc_int_img)
title("Image reconstructed using bicubic interpolation")
%%
demo_img = demosaic(img,"rggb");
%%
imshow(demo_img)
%%
imagelist = {img,bl_int_img,bc_int_img,demo_img};
figure
montage(imagelist)
%%
kodim_img = load("Copy of kodim19.mat").raw;
kodim_cfa = load("Copy of kodim_cfa.mat").cfa;


[x,y] = size(kodim_cfa);
[X,Y] = meshgrid(1:y,1:x);


red_id = (kodim_cfa == 1);
green_id = (kodim_cfa ==2);
blue_id = (kodim_cfa ==3) ;


red_coord = [X(red_id),Y(red_id)];
green_coord = [X(green_id),Y(green_id)];
blue_coord = [X(blue_id),Y(blue_id)];


red_val = double(kodim_img(kodim_cfa == 1));
green_val = double(kodim_img(kodim_cfa == 2));
blue_val = double(kodim_img(kodim_cfa == 3));


red_l_int = griddata(red_coord(:,1), red_coord(:,2), red_val, X, Y, 'cubic');
green_l_int = griddata(green_coord(:,1), green_coord(:,2), green_val, X, Y, 'cubic');
blue_l_int = griddata(blue_coord(:,1), blue_coord(:,2), blue_val, X, Y, 'cubic');

bc_int_kodim_img = cat(3,red_l_int/max(red_l_int(:)),green_l_int/max(green_l_int(:)),blue_l_int/max(blue_l_int(:)));

imshow(bc_int_kodim_img);
%%
Y_kodim_img = rgb2ycbcr(bc_int_kodim_img);

Y  = Y_kodim_img(:,:,1);
Cr = Y_kodim_img(:,:,2);
Cb = Y_kodim_img(:,:,3);

eCr = medfilt2(Cr,[10 10]);
eCb = medfilt2(Cb,[10 10]);

eY_kodim_img = cat(3,Y,eCr,eCb);
e_kodim_img =  ycbcr2rgb(eY_kodim_img);
%%
imshow(Y_kodim_img)
%%

imshow(e_kodim_img)

%%
or_kodim_img = imread("Copy of kodim19.png");
imshow(or_kodim_img)
%%
imagelist = {or_kodim_img,bc_int_kodim_img,e_kodim_img};
figure
montage(imagelist)
%%
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







