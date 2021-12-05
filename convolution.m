%% Convolution theorem

%%
m = 50; % length of signal
n = 11; % length of kernel

signal = zeros(m,1);
signal(round(m*.4):round(m*.6)) = 1;

kernel = zeros(n,1);
kernel(round(n*.25):round(n*.8)) = linspace(1,0,ceil(n*.55));

figure(3), clf

% Plot signal
subplot(311)
plot(signal,'ks-','linew',2,'markerfacecolor','w')
title('Signal')

% Plot kernel
subplot(312)
plot(kernel,'ks-','linew',2,'markerfacecolor','w')
set(gca,'xlim',[0 m])
title('Kernel')

% Setup convolution parameters
nConv = m+n-1;
halfk = floor(n/2);

% Convolution as point-wise multiplication of spectra and inverse
mx = fft(signal,nConv);
nx = fft(kernel,nConv);
% here's the convolution:
convres = ifft( mx.*nx );
% chop off the 'wings' of convolution
convres = convres(halfk+1:end-halfk);

% Plot the result of convolution
subplot(313)
plot(convres,'rs-','linew',2,'markerfacecolor','w')
title('Result of convolution')

% For comparison, plot against the MATLAB convolution function
hold on
plot(conv(signal,kernel,'same'),'g','linew',2)

%% end