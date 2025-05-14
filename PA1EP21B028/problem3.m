rawimg1 = load("Copy of RawImage1.mat").RawImage1;
rawimg2 = load("Copy of RawImage2.mat").RawImage2;
rawimg3 = load("Copy of RawImage3.mat").RawImage3;
%%
image1 = demosaic(rawimg1,"rggb");
image2 = demosaic(rawimg2,"grbg");
image3 = demosaic(rawimg3,"rggb");
%%
tiledlayout(3,1)

nexttile
imshow(image1)
title("demosaic img 1")

nexttile
imshow(image2)
title("demosiac image 2")

nexttile
imshow(image3)
title("demosaic image 3")
%%


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
A1 = im2double(image1(105:165,54:114,:));

bbox1=[105,54,165-105,174-114];
labels="1";
annimage1  = insertObjectAnnotation(image1,"Rectangle",bbox1,labels);


% Initialize the list for standard deviations
std_dev = [];


if size(A1, 3) == 1
    % Grayscale image: compute standard deviation
    std_dev = std(A1(:));
else
    % RGB image: compute standard deviation for each channel
    std_dev(1) = std(A1(:,:,1), 0, 'all'); % Red channel
    std_dev(2) = std(A1(:,:,2), 0, 'all'); % Green channel
    std_dev(3) = std(A1(:,:,3), 0, 'all'); % Blue channel
end
std_r = std_dev*1.95;
std_s =  [2.5,2.5,2.5];

blfimage1 = zeros(size(image1));
for i= 1:3
blfimage1(:,:,i) = Copy_of_bfilter2(im2double(image1(:,:,i)),11,[std_r(i),std_s(i)]);
end
blfA1 = blfimage1(105:165,54:114,:)
%%

tiledlayout(2,2,"TileSpacing","Compact")

nexttile
imshow(annimage1)
title("Image 1")

nexttile
imshow(blfimage1)
title("Bi-linear filterd image 1")

nexttile
imshow(A1)
title("Image 1 zoomed part (used for std)")

nexttile
imshow(blfA1)
title("Bi-linear filterd image (zoomed)")

%%
A2 = im2double(image2(705:765,924:984,:));
bbox2=[705,924,765-705,984-924];
label  = "Selected area" 
annimage2  = insertObjectAnnotation(image2,"Rectangle",bbox2,label);


% Initialize the list for standard deviations
std_dev = [];

if size(A2, 3) == 1
    % Grayscale image: compute standard deviation
    std_dev = std(A2(:));
else
    % RGB image: compute standard deviation for each channel
    std_dev(1) = std(A2(:,:,1), 0, 'all'); % Red channel
    std_dev(2) = std(A2(:,:,2), 0, 'all'); % Green channel
    std_dev(3) = std(A2(:,:,3), 0, 'all'); % Blue channel
end
std_r = std_dev*1.95
std_s =  [2.5,2.5,2.5]

blfimage2 = zeros(size(image2));
for i= 1:3
blfimage2(:,:,i) = Copy_of_bfilter2(im2double(image2(:,:,i)),11,[std_r(i),std_s(i)]);
end
%%
blfA2 = im2double(blfimage2(705:765,924:984,:));

tiledlayout(2,2)

nexttile
imshow(annimage2)
title("Image 2")

nexttile
imshow(blfimage2)
title("Bi-linear filterd image 2")

nexttile
imshow(A2)
title("Image 2 zoomed part (used for std)")

nexttile
imshow(blfA2)
title("Bi-linear filterd image (zoomed)")
%%
A3 = im2double(image3(105:165,124:184,:));
bbox1=[105,124,165-105,164-124];
labels="1";
annimage3 = insertObjectAnnotation(image3,"Rectangle",bbox1,labels);

% Initialize the list for standard deviations
std_dev = [];


if size(A3, 3) == 1
    % Grayscale image: compute standard deviation
    std_dev = std(A3(:));
else
    % RGB image: compute standard deviation for each channel
    std_dev(1) = std(A3(:,:,1), 0, 'all'); % Red channel
    std_dev(2) = std(A3(:,:,2), 0, 'all'); % Green channel
    std_dev(3) = std(A3(:,:,3), 0, 'all'); % Blue channel
end
std_r = std_dev*1.95;
std_s =  [2.5,2.5,2.5];

blfimage3 = zeros(size(image3));
for i= 1:3
blfimage3(:,:,i) = Copy_of_bfilter2(im2double(image3(:,:,i)),11,[std_r(i),std_s(i)]);
end
%%
blfA3 = blfimage3(105:165,54:114,:)

tiledlayout(2,2)

nexttile
imshow(annimage3)
title("Image 3")

nexttile
imshow(blfimage3)
title("Bi-linear filterd image 3")

nexttile
imshow(A3)
title("Image 3 zoomed part (used for std)")

nexttile
imshow(blfA3)
title("Bi-linear filterd image (zoomed)")
