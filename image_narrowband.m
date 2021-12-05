%% Image narrowband filtering

%% Example with two sine wave gradients
% Specify vector of sine phases
sinephas = [ 0 pi/4 ];

% Cector of sine frequencies
sinefreq = [.1 .05];  % arbitrary units

% Sine wave initializations
lims  = [-91 91];
[x,y] = ndgrid(lims(1):lims(2),lims(1):lims(2));

% Compute 2D sine gradients
xp = x*cos(sinephas(1)) + y*sin(sinephas(1));
img1 = sin( 2*pi*sinefreq(1)*xp );

xp = x*cos(sinephas(2)) + y*sin(sinephas(2));
img2 = sin( 2*pi*sinefreq(2)*xp );

% Combine images
img = img1+img2;

figure(6), clf

% Show original two gradients
subplot(321)
imagesc(img1), axis off, axis square
title('One image')

subplot(322)
imagesc(img2), axis off, axis square
title('Second image')

% Show sum
subplot(323)
imagesc(img), axis off, axis square
title('Summed image')

% FFT
imgX    = fft2(img);
imgXamp = abs(imgX);

% Show amplitude spectrum
subplot(324)
imagesc(fftshift(imgXamp))
set(gca,'clim',[0 500])
axis off, axis square
title('Amplitude spectrum')

% Show sum down columns
subplot(325)
stem(sum(imgXamp),'ks'), axis square
title('Column sum of power spectra')

% Replace 1st column with last
imgX(:,1) = imgX(:,end);

% Reconstructed image
imgrecon  = real(ifft2(imgX));

subplot(326)
imagesc(imgrecon), axis square, axis off
title('Filtered image')

%% end.