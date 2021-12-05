%% Rhythmicity in walking (gait)

%%
% Load the data
load gait.mat

figure(1), clf

% Plot the gait speed for Parkinson's patient and control
subplot(311)
plot(park(:,1),park(:,2),'k.-','linew',2)
hold on
plot(cont(:,1),cont(:,2),'r.-','linew',2)
xlabel('Time (sec.)'), ylabel('Stride time (s)')
legend({'Parkinson''s patient';'Control'})

% Define sampling rate
srate  = 1000;

% Create time series of steps
parkts = zeros(round(park(end,1)*1000),1);
parkts(round(park(2:end,1)*1000)) = 1;

% Time vector and number of time points
parktx = (0:length(parkts)-1)/srate;
parkn  = length(parktx);

% Repeat for control data
contts = zeros(round(cont(end,1)*1000),1);
contts(round(cont(2:end,1)*1000)) = 1;
conttx = (0:length(contts)-1)/srate;
contn  = length(conttx);

% Plot the time course of steps
subplot(312)
stem(parktx,parkts,'ks')
xlabel('Time (sec.)'), ylabel('Step')
set(gca,'ylim',[-.1 1.1])

% Compute power for both datasets
parkPow = 2*abs(fft(parkts)/parkn);
contPow = 2*abs(fft(contts)/contn);

% Compute separate frequencies vector for each subject
parkHz = linspace(0,srate/2,floor(parkn/2)+1);
contHz = linspace(0,srate/2,floor(contn/2)+1);

% Show power spectra
subplot(313)
plot(parkHz(2:end),parkPow(2:length(parkHz)),'k')
hold on
plot(contHz(2:end),contPow(2:length(contHz)),'r')
set(gca,'xlim',[0 7])
xlabel('Frequency (Hz)'), ylabel('Amplitude')
title('Frequency domain')
legend({'Parkinson''s patient';'Control'})

% SOURCES:
%  Data downloaded from https://physionet.org/physiobank/database/gaitdb/
%   Parkinson's patient data is pd1-si.txt
%   Young control data is y1-23.si.txt

%% end