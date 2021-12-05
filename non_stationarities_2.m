%% Solutions for non-stationary time series

%% Create signal (chirp) used in the following examples
% Simulation details and create chirp
fs     = 1000; % sampling rate
time   = 0:1/fs:5;
npnts  = length(time);
f      = [10 30]; % frequencies in Hz
ff     = linspace(f(1),mean(f),npnts);
signal = sin(2*pi.*ff.*time);

figure(9), clf
% Plot signal
subplot(211)
plot(time,signal,'k','linew',2)
xlabel('Time (s)'), ylabel('Amplitude')
title('Time domain signal')

% Compute power spectrum
sigpow = 2*abs(fft(signal)/npnts).^2;
hz     = linspace(0,fs/2,floor(npnts/2)+1);

% Plot
subplot(212)
plot(hz,sigpow(1:length(hz)),'k','linew',2)
xlabel('Frequency (Hz)'), ylabel('Power')
set(gca,'xlim',[0 80])

%% Short-time FFT
winlen   = 500; % window length
stepsize = 25;  % step size for STFFT
numsteps = floor( (npnts-winlen)/stepsize );

hz = linspace(0,fs/2,floor(winlen/2)+1);

% Initialize time-frequency matrix
tf = zeros(length(hz),numsteps);

% Hann taper
hwin = .5*(1-cos(2*pi*(1:winlen) / (winlen-1)));

% Loop over time windows
for ti=1:numsteps
    
    % Extract part of the signal
    tidx    = (ti-1)*stepsize+1:(ti-1)*stepsize+winlen;
    tapdata = signal(tidx);
    
    % FFT of these data
    x = fft(hwin.*tapdata)/winlen;
    
    % Put in matrix
    tf(:,ti) = 2*abs(x(1:length(hz)));
end

figure(10), clf
subplot(211)
contourf(time( (0:numsteps-1)*stepsize+1 ),hz,tf,40,'linecolor','none')
set(gca,'ylim',[0 50],'xlim',[0 5],'clim',[0 .5])
xlabel('Time (s)'), ylabel('Frequency (Hz)')
title('Time-frequency power via short-time FFT')
colorbar

%% Morlet wavelet convolution
% Frequencies used in analysis
nfrex = 30;
frex  = linspace(2,50,nfrex);
wtime = -2:1/fs:2;
gausS = linspace(5,35,nfrex);

% Convolution parameters
nConv = length(wtime) + npnts - 1;
halfw = floor(length(wtime)/2);

% Initialize time-frequency output matrix
tf = zeros(nfrex,npnts);

% FFT of signal
signalX = fft(signal,nConv);

% Loop over wavelet frequencies
for fi=1:nfrex
    % Create the wavelet
    s   = ( gausS(fi)/(2*pi*frex(fi)) )^2;
    cmw = exp(1i*2*pi*frex(fi)*wtime) .* exp( (-wtime.^2)/s );
    
    % Compute its Fourier spectrum and normalize
    cmwX = fft(cmw,nConv);
    cmwX = cmwX./max(cmwX); % scale to 1
  
    % Convolution result is inverse FFT of pointwise multiplication
    convres  = ifft( signalX .* cmwX );
    tf(fi,:) = 2*abs(convres(halfw+1:end-halfw));
end

subplot(212)
contourf(time,frex,tf,40,'linecolor','none')
set(gca,'ylim',[0 50],'xlim',[0 5],'clim',[0 1])
xlabel('Time (s)'), ylabel('Frequency (Hz)')
title('Time-frequency power via complex Morlet wavelet convolution')
colorbar

%% end.