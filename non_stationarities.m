%% Effects of non-stationarities on power spectra

%% Amplitude non-stationarity

srate = 1000;
t = 0:1/srate:10;
n = length(t);
f = 3; % frequency in Hz

% Sine wave with time-increasing amplitude
ampl1 = linspace(1,10,n);

% Uncomment this line for an AM-radio-like signal
% ampl1 = abs(interp1(linspace(t(1),t(end),10),10*rand(1,10),t,'spline'));

ampl2 = mean(ampl1);

signal1 = ampl1 .* sin(2*pi*f*t);
signal2 = ampl2 .* sin(2*pi*f*t);

% Obtain Fourier coefficients and Hz vector
signal1X = fft(signal1)/n;
signal2X = fft(signal2)/n;
hz = linspace(0,srate/2,floor(n/2)+1);

figure(3), clf
subplot(211)
plot(t,signal2,'r','linew',2), hold on
plot(t,signal1,'b','linew',2)
xlabel('Time (sec.)'), ylabel('Amplitude')
title('Time domain signal')

subplot(212)
stem(hz,2*abs(signal2X(1:length(hz))),'ro-','linew',2,'markerface','r')
hold on
stem(hz,2*abs(signal1X(1:length(hz))),'bs-','linew',2,'markerface','k')

title('Frequency domain')
xlabel('Frequency (Hz)'), ylabel('Amplitude')
set(gca,'xlim',[1 7])
legend({'Stationary';'Non-stationary'})

%% Frequency non-stationarity
% Create signals (sine wave and linear chirp)
f  = [2 10];
ff = linspace(f(1),mean(f),n);
signal1 = sin(2*pi.*ff.*t);
signal2 = sin(2*pi.*mean(ff).*t);

% Fourier spectra
signal1X = fft(signal1)/n;
signal2X = fft(signal2)/n;
hz = linspace(0,srate/2,floor(n/2));

figure(4), clf
% Plot the signals in the time domain
subplot(211)
plot(t,signal1,'b'), hold on
plot(t,signal2,'r')
xlabel('Time (sec.)'), ylabel('Amplitude')
set(gca,'ylim',[-1.1 1.1])

% Amplitude spectra
subplot(212)
stem(hz,2*abs(signal1X(1:length(hz))),'.-','linew',2), hold on
stem(hz,2*abs(signal2X(1:length(hz))),'r.-','linew',2)
xlabel('Frequency (Hz)'), ylabel('Amplitude')
set(gca,'xlim',[0 20])

%% Sharp transitions
a = [10 2 5 8];
f = [3 1 6 12];

timechunks = round(linspace(1,n,length(a)+1));

signal = 0;
for i=1:length(a)
    signal = cat(2,signal,a(i)* sin(2*pi*f(i)*t(timechunks(i):timechunks(i+1)-1) ));
end

signalX = fft(signal)/n;
hz = linspace(0,srate/2,floor(n/2)+1);

figure(5), clf
subplot(211)
plot(t,signal,'k')
xlabel('Time (s)'), ylabel('Amplitude')

subplot(212)
stem(hz,2*abs(signalX(1:length(hz))),'ks-','markerface','b')
xlabel('Frequency (Hz)'), ylabel('Amplitude')
set(gca,'xlim',[0 20])

%% Phase reversal
srate = 1000;
ttime = 0:1/srate:1-1/srate; % temp time, for creating half the signal
time  = 0:1/srate:2-1/srate; % signal's time vector
n = length(time);

signal = [ sin(2*pi*10*ttime) -sin(2*pi*10*ttime) ];

figure(7), clf
subplot(211)
plot(time,signal,'k','linew',2)
xlabel('Time (sec.)'), ylabel('Amplitude')
title('Time domain')

subplot(212)
signalAmp = (2*abs( fft(signal)/n )).^2;
hz = linspace(0,srate/2,floor(n/2)+1);
plot(hz,signalAmp(1:length(hz)),'ks-','linew',2,'markerfacecolor','w')
set(gca,'xlim',[0 20])
xlabel('Frequency (Hz)'), ylabel('Power')
title('Frequency domain')

%% Ddges and edge artifacts
x = (linspace(0,1,n)>.5)+0; % +0 converts from boolean to number
t = 0:n-1;

% Uncommenting this line shows that nonstationarities 
% do not prevent stationary signals from being easily observed
% x = x + .08*sin(2*pi*6*time);

% Plot
figure(6), clf
subplot(211)
plot(t,x,'k','linew',2)
set(gca,'ylim',[-.1 1.1])
xlabel('Time (s.)'), ylabel('Amplitude (a.u.)')

subplot(212)
xX = fft(x)/n;
stem(hz,2*abs(xX(1:length(hz))),'ks-')
set(gca,'xlim',[0 20],'ylim',[0 .1])
xlabel('Frequency (Hz)'), ylabel('Amplitude (a.u.)')

%% Spike in the frequency domain
% Frequency spectrum with a spike
fspect = zeros(300,1);
fspect(10) = 1;

% Time-domain signal via iFFT
td_sig = real(ifft(fspect)) * length(fspect);

figure(8), clf
% Plot amplitude spectrum
subplot(211)
stem(fspect,'ks-','linew',2)
xlabel('Frequency (indices)')
ylabel('Amplitude')
title('Frequency domain')

% Plot time domain signal
subplot(212)
plot(td_sig,'k','linew',2)
xlabel('Time (indices)')
ylabel('Amplitude')
title('Time domain')

%% end.