%% Narrowband temporal filtering

%%
% Load the data
load braindata.mat
n = length(timevec);

% Plot time-domain signal
figure(4), clf
subplot(311)
plot(timevec,braindata,'k','linew',2)
set(gca,'xlim',[-.5 1.5])
xlabel('Time (sec.)'), ylabel('Voltage (\muV)')
title('Time domain')

% Compute power spectrum
dataX    = fft(braindata);
ampspect = (2*abs(dataX/n)).^2;
hz       = linspace(0,srate,n); % out to srate as trick for the filter

% Plot power spectrum
subplot(312)
plot(hz,ampspect(1:length(hz)),'k','linew',2)
set(gca,'xlim',[0 100],'ylim',[0 500])
xlabel('Frequency (Hz)'), ylabel('Voltage (\muV)')
title('Frequency domain')

% Specify which frequencies to filter
peakFiltFreqs = [2 47]; % Hz

c = 'kr'; % line colors
leglab = cell(size(peakFiltFreqs)); % legend entries

% Loop over frequencies
for fi=1:length(peakFiltFreqs)
    % Construct the filter
    x  = hz-peakFiltFreqs(fi); % shifted frequencies
    fx = exp(-(x/4).^2);       % gaussian
    
    % Apply the filter to the data
    filtdat = 2*real( ifft( dataX.*fx ));
    
    % Show the results
    subplot(313), hold on
    plot(timevec,filtdat,c(fi),'linew',2)
    set(gca,'xlim',[-.5 1.5])
    xlabel('Time (sec.)'), ylabel('Voltage (\muV)')
    title('Time domain')
    
    % Label for legend
    leglab{fi} = [ num2str(peakFiltFreqs(fi)) ' Hz' ];
end

% Add legend
legend(leglab)

%% end.