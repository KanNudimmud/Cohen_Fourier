%% Rhythmicity in brain waves

%%
% Load the data
load EEGrestingState.mat

n = length(eegdata);
timevec = (0:n-1)/srate;

% Compute amplitude spectrum
dataX    = fft(eegdata)/n;
ampspect = 2*abs(dataX);
hz       = linspace(0,srate/2,floor(n/2)+1);

figure(2), clf

% Plot time domain signal
subplot(211)
plot(timevec,eegdata,'k')
xlabel('Time (sec.)'), ylabel('Amplitude (\muV)')
title('Time domain signal')

% Plot frequency domain signal
subplot(212)
plot(hz,smooth(ampspect(1:length(hz)),30),'k','linew',2)
%plot(hz,ampspect(1:length(hz)),'k','linew',2)
set(gca,'xlim',[0 70],'ylim',[0 .6])
xlabel('Frequency (Hz)'), ylabel('Amplitude (\muV)')
title('Frequency domain')

%% end