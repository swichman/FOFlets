function [out] = vowel(Fc, A, BW, k_1, beta, Fs, impulse, graph, graphtitle)
%VOWEL Summary of this function goes here
%   Detailed explanation goes here
FOF = zeros(1,Fs);
if graph == 1
    h = figure('Position',[0 0 800 1300]);
end

for i = 1:length(Fc)
    tmp = FOFlet(Fs, BW(i), k_1(i), beta(i), Fc(i), A(i), impulse);
    if graph == 1
        subplot(length(Fc)+2,1,i)
        plot(tmp(1:368))
        xline(k_1(i), 'r')
        ylim([min(tmp(1:368)) + min(tmp(1:368))*.1, max(tmp(1:368)) + max(tmp(1:368))*.1])
        xlim([1, 368])
        k1_value = strcat(', k_1 transition at ', compose(' %0.f',k_1(i)));
        FOFlet_num = strcat(graphtitle, compose(' %d', i));
        titleText = strcat(FOFlet_num, k1_value);
        title(titleText)
    end
    FOF = FOF + tmp(1:Fs);
end

% Normalize the output to avoid clipping
FOF = FOF/max(abs(FOF));

if graph == 1
    window = 512;
    noverlap = 256;
    nfft = 4096;
    rot_x = 7;
    rot_y = 63;

    subplot(length(Fc)+2,1,length(Fc)+1)
    pwelch(FOF, window, noverlap, nfft, Fs);
    ax = gca;
    xlim(ax, [0,5])
    ylim(ax, [-90 -20]);
    xline(Fc(1)/1000, 'r')
    xline(Fc(2)/1000, 'r')
    xline(Fc(3)/1000, 'r')
    if length(Fc) > 3
        xline(Fc(4)/1000, 'r')
        xline(Fc(5)/1000, 'r')
    end
    title(strcat(graphtitle, ' PSD Estimate'));

%     subplot(length(Fc)+2,1,length(Fc)+2)
%     spectrogram(FOF, window, noverlap, nfft, Fs)
%     view(rot_x,rot_y)
%     ax = gca;
%     xlim(ax, [0,5])
%     colormap('jet')
     
    saveas_name = strcat(erase(graphtitle, '"'),'.png');
    saveas(h, saveas_name);
end
   
out = FOF;
end