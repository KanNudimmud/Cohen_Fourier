%% Normalized time vector

%%
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
subplot(311)
plot(time,signal,'k','linew',2)
xlabel('Time (s)'), ylabel('Amplitude')
title('Time domain')

% Plot amplitude
subplot(312)
stem(hz,ampls(1:length(hz)),'ks-','linew',3,'markersize',15,'markerfacecolor','w')

% Make plot look a bit nicer
set(gca,'xlim',[0 10],'ylim',[-.01 3])
xlabel('Frequency (Hz)'), ylabel('Amplitude (a.u.)')
title('Amplitude spectrum')

% Plot angles
subplot(313)
stem(hz,angle(fCoefs(1:length(hz))),'ks-','linew',3,'markersize',15,'markerfacecolor','w')

% Make plot look a bit nicer
set(gca,'xlim',[0 10],'ylim',[-1 1]*pi)
xlabel('Frequency (Hz)'), ylabel('Phase (rad.)')
title('Phase spectrum')

% Finally, plot reconstructed time series on top of original time series
reconTS = real(ifft( fCoefs ))*pnts;
subplot(311), hold on
plot(time(1:3:end),reconTS(1:3:end),'r.')
legend({'Original';'Reconstructed'})

% Inspect the two time series. they should be identical!
zoom on 

%% end.