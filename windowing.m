%% Windowing and Welch's method

%%
% Create signal
srate = 1000;
npnts = 2000; % actually, this times 2!
time  = (0:npnts*2-1)/srate;
freq  = 10; % Hz

% Create signal
signal = [sin(2*pi*freq*time(1:npnts)) sin(2*pi*freq*time(1:npnts) + pi)];

% Compute its amplitude spectrum
hz = linspace(0,srate/2,floor(length(time)/2)+1);
ampspect = abs(fft(signal)/length(time));
ampspect(2:length(hz)-1) = 2*ampspect(2:length(hz)-1);

figure(4), clf
% Plot the time-domain signal
subplot(311)
plot(time,signal)
xlabel('Time (s)'), ylabel('Amplitude')
title('Time domain')

% Plot the frequency domain signal
subplot(312)
stem(hz,ampspect(1:length(hz)),'ks-','linew',2)
set(gca,'xlim',[0 freq*2])
xlabel('Frequency (Hz)'), ylabel('Amplitude')
title('Frequency domain (FFT)')

%% Welch's method
% Parameters
winlen = 1000; % window length in points (not ms!)
nbins = floor(length(time)/winlen);

% Vector of frequencies for the small windows
hzL = linspace(0,srate/2,floor(winlen/2)+1);

% Initialize time-frequency matrix
welchspect = zeros(1,length(hzL));

% Hann taper
hwin = .5*(1-cos(2*pi*(1:winlen) / (winlen-1)));

% Loop over time windows
for ti=1:nbins
    % Extract part of the signal
    tidx    = (ti-1)*winlen+1:ti*winlen;
    tmpdata = signal(tidx);
    
    % FFT of these data (does the taper help?)
    x = fft(hwin.*tmpdata)/winlen;
    
    % Put in matrix
    welchspect = welchspect + 2*abs(x(1:length(hzL)));
end

% Divide by nbins to complete average
welchspect = welchspect/nbins;

subplot(313)
stem(hzL,welchspect,'ks-','linew',2)
set(gca,'xlim',[0 freq*2])
xlabel('Frequency (Hz)'), ylabel('Amplitude')
title('Frequency domain (Welch''s method)')

%% end