%% Amplitude spectrum vs. power spectrum

%%
% Simulation parameters
srate = 1000;
time  = 0:1/srate:.85;
npnts = length(time);

% Generate signal
signal = 2.5*sin(2*pi*10*time);

% Fourier transform
fourTime = (0:npnts-1)/npnts;
signalX  = zeros(size(signal));
for fi=1:npnts
    csw = exp( -1i*2*pi*(fi-1)*fourTime );
    signalX(fi) = sum( signal.*csw );
end

% Frequencies vector
hz = linspace(0,srate/2,floor(length(time)/2)+1);

% Extract correctly-normalized amplitude
signalAmp = abs(signalX(1:length(hz))/npnts);
signalAmp(2:end) = 2*signalAmp(2:end);

% Power
signalPow = signalAmp.^2;

figure(8), clf

% Plot time-domain signal
subplot(311)
plot(time,signal,'k','linew',2)
xlabel('Time (ms)')
ylabel('Amplitude')
title('Time domain')

% Plot frequency domain spectra
subplot(312)
plot(hz,signalAmp,'ks-','linew',2,'markerfacecolor','w','markersize',10)
hold on
plot(hz,signalPow,'rs-','linew',2,'markerfacecolor','w','markersize',10)

set(gca,'xlim',[0 20])
legend({'Amplitude';'Power'})
xlabel('Frequency (Hz)')
ylabel('Amplitude or power')
title('Frequency domain')

% Plot dB power
subplot(313)
plot(hz,10*log10(signalPow),'ks-','linew',2,'markerfacecolor','w','markersize',10)
set(gca,'xlim',[0 20])
xlabel('Frequency (Hz)')
ylabel('Decibel power')

%% end.