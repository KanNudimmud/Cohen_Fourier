%% Aliasing

%%
% Simulation parameters
srate  = 1000;
time   = 0:1/srate:1;
npnts  = length(time);
signal = sin(2*pi*5*time);

% Measurement parameters
msrate = 6; % hz
mtime  = 0:1/msrate:1;
midx   = dsearchn(time',mtime');

% Plot the time-domain signals
figure(2), clf
subplot(221)
plot(time,signal,'k','linew',3)
hold on
plot(time(midx),signal(midx),'mo','linew',2,'markerfacecolor','w','markersize',10)
set(gca,'ylim',[-1.1 1.1])
xlabel('time (s)'), ylabel('Amplitude')
title('Time domain')
legend({'"Analog"';'Sampled points'})

% Plot the power spectrum of the "analog" signal
subplot(222)
sigX = 2*abs(fft(signal,npnts)/npnts);
hz   = linspace(0,srate/2,floor(npnts/2)+1);
stem(hz,sigX(1:length(hz)),'k','linew',2,'markerfacecolor','k')
set(gca,'xlim',[0 20])
xlabel('Frequency (Hz)'), ylabel('amplitude')
title('Frequency domain of "analog" signal')

% Plot only the measured signal
subplot(223)
plot(time(midx),signal(midx),'m','linew',2,'markerfacecolor','w','markersize',10)
set(gca,'ylim',[-1.1 1.1])
title('Measured signal')
xlabel('Time (s)'), ylabel('amplitude')

% Amplitude spectrum
subplot(224)
sigX = 2*abs(fft(signal(midx),npnts)/length(midx));
hz   = linspace(0,msrate/2,floor(npnts/2)+1);
plot(hz,sigX(1:length(hz)),'k','linew',2,'markerfacecolor','k')
set(gca,'xlim',[0 20])
xlabel('Frequency (Hz)'), ylabel('amplitude')
title('Frequency domain of "analog" signal')

%% Related: getting close to the Nyquist
% Subsample a high-sampling rate sine wave (pretend it's a continuous wave)
srate = 1000;
t = 0:1/srate:1;
f = 10; % frequency of the sine wave Hz
d = sin(2*pi*f*t);

% "Measurement" sampling rates
srates = [15 22 50 200]; % in Hz

figure(2), clf
for si=1:4
    subplot(2,2,si)
    
    % Plot 'continuous' sine wave
    plot(t,d), hold on
    
    % Plot sampled sine wave
    samples = round(1:1000/srates(si):length(t));
    plot(t(samples),d(samples),'ro-','linew',2)
    
    title([ 'Sampled at ' num2str(srates(si)/f) ' times' ])
    set(gca,'ylim',[-1.1 1.1],'xtick',0:.25:1)
end

%% end.