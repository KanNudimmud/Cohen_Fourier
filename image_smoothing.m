%% Image smoothing and sharpening

%% With picture
% Load image
lenna = imread('Lenna.png');
imgL  = double(mean(lenna,3));

figure(5), clf, colormap gray

% Plot original image
subplot(221)
imagesc(imgL)
axis off, axis square
title('Original image')

% Power spectrum
imgX  = fftshift(fft2(imgL));
powr2 = log(abs(imgX));

subplot(234)
imagesc(powr2)
set(gca,'clim',[0 15])
axis off, axis square
title('Amplitude spectrum')

% Filter kernel is a Gaussian
width  = .1;   % width of gaussian (normalized Z units)
[x,y]  = ndgrid(zscore(1:size(imgL,1)),zscore(1:size(imgL,2)));

% Add 1- at beginning of the next line to invert the filter
gaus2d = 1-exp(-(x.^2 + y.^2) ./ (2*width^2)); 

subplot(235)
imagesc(gaus2d)
axis off, axis square
title('Gaussian (2D gain function)')

subplot(236)
imagesc( log(abs(imgX.*gaus2d)) )
axis off, axis square
set(gca,'clim',[0 15])
title('Modulated spectrum')

subplot(222)
imgrecon = real(ifft2( fftshift(imgX.*gaus2d)));

imagesc( imgrecon )
axis off, axis square
title('Low-pass filtered image')

%% end.