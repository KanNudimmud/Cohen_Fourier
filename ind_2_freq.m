%% Shortcut: converting indices to frequencies

%% Case 1: ODD number of data points, N is correct
% Create the signal
srate = 1000;
time  = (0:srate)/srate;
npnts = length(time);

% Notice: A simple 15-Hz sine wave!
signal = sin(15*2*pi*time);

% Amplitude spectrum
signalX = 2*abs(fft(signal)) / length(signal);

% Frequencies vector
hz1 = linspace(0,srate,npnts+1);
hz2 = linspace(0,srate,npnts);

% Plot it
figure(1), clf, hold on
stem(hz1(1:npnts),signalX,'bs-','linew',3,'markersize',12)
stem(hz2,signalX,'ro-','linew',3,'markersize',12)
axis([14.9 15.1 .99 1.01])
title([ num2str(length(time)) ' points' ])
xlabel('Frequency (Hz)'), ylabel('Amplitude')
legend({'N+1';'N'})

%% Case 2: EVEN number of data points, N+1 is correct
% Create the signal
srate = 1000;
time  = (0:srate-1)/srate;
npnts = length(time);

% Notice: A simple 15-Hz sine wave!
signal = sin(15*2*pi*time);

% Amplitude spectrum
signalX = 2*abs(fft(signal)) / length(signal);

% Frequencies vector
hz1 = linspace(0,srate,npnts+1);
hz2 = linspace(0,srate,npnts);

% Plot it
figure(2), clf, hold on
stem(hz1(1:npnts),signalX,'bs-','linew',3,'markersize',12)
stem(hz2,signalX,'ro-','linew',3,'markersize',12)
axis([14.9 15.1 .99 1.01])
title([ num2str(length(time)) ' points' ])
xlabel('Frequency (Hz)'), ylabel('Amplitude')
legend({'N+1';'N'})

%% Case 3: longer signal
% Create the signal
srate = 1000;
time  = (0:5*srate-1)/srate;
npnts = length(time);

% Notice: A simple 15-Hz sine wave!
signal = sin(15*2*pi*time);

% Amplitude spectrum
signalX = 2*abs(fft(signal)) / length(signal);

% Frequencies vector
hz1 = linspace(0,srate,npnts+1);
hz2 = linspace(0,srate,npnts);

% Plot it
figure(3), clf, hold on
stem(hz1(1:npnts),signalX,'bs-','linew',3,'markersize',12)
stem(hz2,signalX,'ro-','linew',3,'markersize',12)
axis([14.99 15.01 .99 1.01])
title([ num2str(length(time)) ' points' ])
xlabel('Frequency (Hz)'), ylabel('Amplitude')
legend({'N+1';'N'})

%% Shortcut
x = randn(10000,1)
srate = 512;
plot(linspace(0,srate,length(x)),abs(fft(x)))
set(gca,'xlim',[0 150])

%% end.