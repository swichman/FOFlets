function [out] = plot_fof(FOF, Fs, Fc, placement, strTitle, fig)
%PLOT_FOF Summary of this function goes here
%   Detailed explanation goes here
window = 512;
noverlap = 256;
nfft = 4096;
rot_x = 0;
rot_y = 90;

figure(fig)

subplot(2,5,placement)
pwelch(FOF, window, noverlap, nfft, Fs);
ax = gca;
xlim(ax, [0,5])
ylim(ax, [-90 -20]);
xline(Fc(1)/1000, 'r')
xline(Fc(2)/1000, 'r')
xline(Fc(3)/1000, 'r')
title(compose('%s PSD Estimate', strTitle));

subplot(2,5,placement+5)
spectrogram(FOF, window, noverlap, nfft, Fs)
view(rot_x,rot_y)
ax = gca;
xlim(ax, [0,5])
title(compose('%s Spectrogram', strTitle));
colormap('jet')

out = 0;
end

