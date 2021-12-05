%% The discrete Fourier transform

%% The DTFT in loop-form

% Create the signal
srate  = 1000; % hz
time   = 0:1/srate:2; % time vector in seconds
pnts   = length(time); % number of time points
signal = 2.5 * sin( 2*pi*4*time ) ...
       + 1.5 * sin( 2*pi*6.5*time );

% Prepare the Fourier transform
fourTime = (0:pnts-1)/pnts;
fCoefs   = zeros(size(signal));

for fi=1:pnts
    % Create complex sine wave
    csw = exp( -1i*2*pi*(fi-1)*fourTime );
    
    % Compute dot product between sine wave and signal
    fCoefs(fi) = sum( signal.*csw ) / pnts;
    % these are called the Fourier coefficients
end

% Extract amplitudes
ampls = 2*abs(fCoefs);

% Compute frequencies vector
hz = linspace(0,srate/2,floor(pnts/2)+1);

figure(1), clf
subplot(211)
plot(time,signal,'k','linew',2)
xlabel('Time (s)'), ylabel('Amplitude')
title('Time domain')

subplot(212)
plot(hz,ampls(1:length(hz)),'ks-','linew',3,'markersize',15,'markerfacecolor','w')

% Make plot look a bit nicer
set(gca,'xlim',[0 10],'ylim',[-.01 3])
xlabel('Frequency (Hz)'), ylabel('Amplitude (a.u.)')
title('Frequency domain')

% Now plot MATLAB's fft output on top
fCoefsF = fft(signal)/pnts;
amplsF  = 2*abs(fCoefsF);
hold on
% plot(hz,amplsF(1:length(hz)),'ro','markerfacecolor','r')

%% Plot two Fourier coefficients

coefs2plot = dsearchn(hz',[4 4.5]');

% Extract magnitude and angle
mag = abs(fCoefs(coefs2plot));
phs = angle(fCoefs(coefs2plot));

figure(2), clf
plot( real(fCoefs(coefs2plot)) , imag(fCoefs(coefs2plot)) ,'o','linew',2,'markersize',10,'markerfacecolor','r');

% Make plot look nicer
axislims = max(mag)*1.1;
set(gca,'xlim',[-1 1]*axislims,'ylim',[-1 1]*axislims)
grid on, hold on, axis square
plot(get(gca,'xlim'),[0 0],'k','linew',2)
plot([0 0],get(gca,'ylim'),'k','linew',2)
xlabel('Real axis')
ylabel('Imaginary axis')
title('Complex plane')

%% end