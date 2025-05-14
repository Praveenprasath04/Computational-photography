background = imread("data/background.png");
redcar = imread("data/redcar.png");
background = im2double(background);
redcar = im2double(redcar*2);
[m,n,c] = size(redcar);
figure
tiledlayout(1,2)
nexttile
imshow(background);
title("background")

nexttile
imshow(redcar);
title("redcar")
%%
load("data\CameraT.mat")
CameraT
% Assuming redcar and background are already defined images
[m, n, c] = size(background); % Get the size of the background image
blured_image = zeros(m, n, c);% Initialize the blurred image with the correct type
last_background = zeros(m,n,c);
% Loop to create the blur effect by translating the red car
for i = 0:51
    % Translate the red car image
    tcar1 = imtranslate(redcar, [i, 0]);
    frame = tcar1;

    % Replace zero pixels with the corresponding background pixels
    frame(tcar1 == 0) = background(tcar1 == 0);
    
    
    
    % Accumulate the translated image into the blurred image
    blured_image = blured_image + frame/52;
    
    % Accumulate the translated image into the blurred image
end


% Average the accumulated image to create the blur effect
 % Divide by the number of translations

% Display the final blurred image
imshow(blured_image);
%%

% Assuming redcar and background are already defined images
[m, n, c] = size(background); % Get the size of the background image
blured_imageT = zeros(m, n+51, c); % Initialize the blurred image with the correct type
ex_redcar = zeros(m,n+51,c);
ex_background = zeros(m,n+51,c);
ex_redcar(1:m,1:n,1:c) = redcar(1:m,1:n,1:c);
ex_background(1:m,1:n,1:c) = background(1:m,1:n,1:c);

% Loop to create the blur effect by translating the red car
for i = 0:51
    % Translate the red car image
    tcar= imtranslate(ex_redcar, [CameraT(i+1)-(i+1), 0],OutputView="same");
    tbackground = imtranslate(ex_background,[CameraT(i+1),0],OutputView="same");
    
    % Replace zero pixels with the corresponding background pixels
    tcar(tcar == 0) = tbackground(tcar == 0);
    
    % Accumulate the translated image into the blurred image
    blured_imageT = blured_imageT + tcar;
end


% Average the accumulated image to create the blur effect
blured_imageT = blured_imageT/52; % Divide by the number of translations

% Display the final blurred image
imshow(blured_imageT);
%%
figure
tiledlayout(1,2)
nexttile
imshow(blured_image);
title("blured 1")

nexttile
imshow(blured_imageT);
title("blured 2")
%%
x = zeros(1,52);
x(1) = 0.1;
for i = 2:52
x(i) = i;
end
psf = 1./sqrt(x/13);
psf = psf/sum(psf)
%%
psf_ex = zeros(25,52);
for i =1:25
    psf_ex(i,:) = psf*20;

end
imshow(psf_ex)

%%

first_row = [psf'; zeros(n-1,1)];
first_col = [1/52; zeros(n-1,1)];
A1_t = toeplitz(first_col,first_row);
A1 = transpose(A1_t);
size(A1_t)
imshow(A1*52)
%%
deblured1 = zeros(m,n,3);
for c =1:3
  blured_row=blured_imageT(:,:,c);
  size(blured_row)
  
  sol = blured_row*pinv(A1_t);
  
  
  deblured1(:,:,c) = sol ;
end
imshow(deblured1/1.2)
%%
size(blured_row )
size(A1_t)


%%
plot(CameraT)


%%

tcar1 = imtranslate(ex_redcar,[1, 0],OutputView="same");
size(tcar1)