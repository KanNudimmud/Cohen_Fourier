%% Interpreting phase values

%% Same amplitude, Different phase
% Simulation parameters
srate = 1000;
time  = 0:1/srate:1;
npnts = length(time);

% Generate signal
signal1 = 2.5*sin(2*pi*10*time +   0  ); % different phase values
signal2 = 2.5*sin(2*pi*10*time + pi/2 ); 

% Fourier transform
fourTime = (0:npnts-1)/npnts;
signal1X = zeros(size(signal1));
signal2X = zeros(size(signal2));

for fi=1:npnts
    csw = exp( -1i*2*pi*(fi-1)*fourTime );
    signal1X(fi) = sum( signal1.*csw );
    signal2X(fi) = sum( signal2.*csw );
end

% Frequencies vector
hz = linspace(0,srate/2,floor(length(time)/2)+1);

% Extract correctly-normalized amplitude
signal1Amp = abs(signal1X(1:length(hz))/npnts);
signal1Amp(2:end) = 2*signal1Amp(2:end);

signal2Amp = abs(signal2X(1:length(hz))/npnts);
signal2Amp(2:end) = 2*signal2Amp(2:end);

% Extract phases
signal1phase = angle(signal1X(1:length(hz)));
signal2phase = angle(signal2X(1:length(hz)));

figure(5), clf

% Plot time-domain signals
subplot(321), plot(time,signal1,'k')
title('Signal 1, time domain')
xlabel('Time (s)'), ylabel('Amplitude')

subplot(322), plot(time,signal2,'k')
title('Signal 2, time domain')
xlabel('Time (s)'), ylabel('Amplitude')

subplot(323), stem(hz,signal1Amp,'k')
title('Frequency domain')
xlabel('Frequency (Hz)'), ylabel('Amplitude')
set(gca,'xlim',[0 20],'ylim',[0 2.8])

subplot(324), stem(hz,signal2Amp,'k')
title('Frequency domain')
xlabel('Frequency (Hz)'), ylabel('Amplitude')
set(gca,'xlim',[0 20],'ylim',[0 2.8])

subplot(325), stem(hz,signal1phase,'k')
xlabel('Frequency (Hz)'), ylabel('Phase (rad.)')
set(gca,'xlim',[0 20])

subplot(326), stem(hz,signal2phase,'k')
xlabel('Frequency (Hz)'), ylabel('Phase (rad.)')
set(gca,'xlim',[0 20])

%% end.