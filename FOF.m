%==========================================================================
% Formant Synthesis using FOF methods. This is designed to take an impulse
% train at 120 Hz and generate 5 formats that are mixed together to 
% create various vocal formants.
%==========================================================================

% Nice audio sample rate
Fs = 44100;

%==============================================
% Impulse Train Creation
%==============================================
input = zeros(1,Fs);
F_imp = 120;
input(1:int32(Fs/F_imp):Fs) = 1;

%==============================================
% Formant synthesis with five parallel FOF's
%==============================================

% Center Frequencies of the FOF Synthesizer output
Fc_a = [600 1040 2250 2450 2750];
Fc_e = [400 1620 2400 2800 3100];
Fc_i = [220 1720 2600 3050 3340];
Fc_o = [400 750 2400 2600 2900];
Fc_u = [350 600 2400 2675 2950];

% Max Amplitudes of the FOF Synthesizer output
A_a = [0 -7 -9 -9 -20];
A_e = [0 -12 -9 -12 -18];
A_i = [0 -30 -16 -22 -28];
A_o = [0 -11 -21 -20 -40];
A_u = [0 -20 -32 -28 -36];

% Bandwidth of the FOF 
BW_a = [60 70 110 120 130];
BW_e = [40 80 100 120 120];
BW_i = [60 90 100 120 120];
BW_o = [40 80 100 120 120];
BW_u = [40 80 100 120 120];

%==============================================
% Formant synthesis with three parallel FOF's
%==============================================

% Center Frequencies of the FOF Synthesizer output
Fc_beat = [270 2300 3000];
Fc_bit = [400 2000 2550];
Fc_bet = [530 1850 2500];
Fc_bat = [660 1700 2400];
Fc_part = [730 1100 2450];
Fc_pot = [570 850 2400];
Fc_boot = [440 1000 2250];
Fc_book = [300 850 2250];
Fc_but = [640 1200 2400];
Fc_pert = [490 1350 1700];

% Max Amplitudes of the FOF Synthesizer output
A_3 = [0 -4 -7];

% Bandwidth of the FOF 
BW_3 = [60 70 110];

%==============================================
% System Constants
%==============================================

% k_1 values (where the attack transitions to decay)
k_1 = [.002*Fs .0015*Fs .0015*Fs .003*Fs .001*Fs];
k_1_3 = [.002*Fs .0015*Fs .0015*Fs];

% Beta Values
beta = [pi/k_1(1), pi/k_1(2), pi/k_1(3), pi/k_1(4), pi/k_1(5)];

%==============================================
% Synthesize each vowel from formants
%==============================================
out_a = vowel(Fc_a, A_a, BW_a, k_1, beta, Fs, input, 0, '"A" Formant');
out_e = vowel(Fc_e, A_e, BW_e, k_1, beta, Fs, input, 0, '"E" Formant');
out_i = vowel(Fc_i, A_i, BW_i, k_1, beta, Fs, input, 0, '"I" Formant');
out_o = vowel(Fc_o, A_o, BW_o, k_1, beta, Fs, input, 0, '"O" Formant');
out_u = vowel(Fc_u, A_u, BW_u, k_1, beta, Fs, input, 0, '"U" Formant');

out_beat = vowel(Fc_beat, A_3, BW_3, k_1_3, beta(1:3), Fs, input, 1, 'bEAt Formant');
out_bit = vowel(Fc_bit, A_3, BW_3, k_1_3, beta(1:3), Fs, input, 1, 'bIt Formant');
out_bet = vowel(Fc_bet, A_3, BW_3, k_1_3, beta(1:3), Fs, input, 1, 'bEt Formant');
out_bat = vowel(Fc_bat, A_3, BW_3, k_1_3, beta(1:3), Fs, input, 1, 'bAt Formant');
out_part = vowel(Fc_part, A_3, BW_3, k_1_3, beta(1:3), Fs, input, 1, 'pARt Formant');
out_pot = vowel(Fc_pot, A_3, BW_3, k_1_3, beta(1:3), Fs, input, 1, 'pOt Formant');
out_boot = vowel(Fc_boot, A_3, BW_3, k_1_3, beta(1:3), Fs, input, 1, 'bOOt Formant');
out_book = vowel(Fc_book, A_3, BW_3, k_1_3, beta(1:3), Fs, input, 1, 'bOOk Formant');
out_but = vowel(Fc_but, A_3, BW_3, k_1_3, beta(1:3), Fs, input, 1, 'bUt Formant');
out_pert = vowel(Fc_pert, A_3, BW_3, k_1_3, beta(1:3), Fs, input, 1, 'pERt Formant');

%==============================================
% Let's make a nice visual of each formant
% and the impulse train for comparison.
% 
% Disabled by default, as similar images
% are created in the FOF function
% Left in as it makes an image of all
% 5 FOFlet singals on one graph.
%==============================================
%figure
window = 512;
noverlap = 256;
nfft = 4096;
rot_x = 7;
rot_y = 63;
plot_points = 2000;

% subplot(6,2,1)
% plot(input(1:plot_points))
% ylim([-0.2 1.2]);
% subplot(6,2,2)
% %spectrogram(input, window, noverlap, nfft, Fs)
% pwelch(input, window, noverlap, nfft, Fs);
% ax = gca;
% xlim(ax, [0,5])
% ylim(ax, [-80 -30]);
% title('Impulse Train Input')
% 
% subplot(6,2,3)
% spectrogram(out_a, window, noverlap, nfft, Fs)
% view(rot_x,rot_y)
% ax = gca;
% xlim(ax, [0,5])
% %plot(out_a(1:plot_points))
% 
% subplot(6,2,5)
% spectrogram(out_e, window, noverlap, nfft, Fs)
% view(rot_x,rot_y)
% ax = gca;
% xlim(ax, [0,5])
% %plot(out_e(1:plot_points))
% 
% subplot(6,2,7)
% spectrogram(out_i, window, noverlap, nfft, Fs)
% view(rot_x,rot_y)
% ax = gca;
% xlim(ax, [0,5])
% %plot(out_i(1:plot_points))
% 
% subplot(6,2,9)
% spectrogram(out_o, window, noverlap, nfft, Fs)
% view(rot_x,rot_y)
% ax = gca;
% xlim(ax, [0,5])
% %plot(out_o(1:plot_points))
% 
% subplot(6,2,11)
% spectrogram(out_u, window, noverlap, nfft, Fs)
% view(rot_x,rot_y)
% ax = gca;
% xlim(ax, [0,5])
% %plot(out_u(1:plot_points))
% 
% subplot(6,2,4)
% 
% pwelch(out_a, window, noverlap, nfft, Fs);
% ax = gca;
% xlim(ax, [0,5])
% ylim(ax, [-80 -30]);
% xline(Fc_a(1)/1000, 'r')
% xline(Fc_a(2)/1000, 'r')
% xline(Fc_a(3)/1000, 'r')
% xline(Fc_a(4)/1000, 'r')
% xline(Fc_a(5)/1000, 'r')
% title('"A" Formants')
% 
% 
% subplot(6,2,6)
% %spectrogram(out_e, window, noverlap, nfft, Fs)
% pwelch(out_e, window, noverlap, nfft, Fs);
% ax = gca;
% xlim(ax, [0,5])
% ylim(ax, [-80 -30]);
% xline(Fc_e(1)/1000, 'r')
% xline(Fc_e(2)/1000, 'r')
% xline(Fc_e(3)/1000, 'r')
% xline(Fc_e(4)/1000, 'r')
% xline(Fc_e(5)/1000, 'r')
% title('"E" Formants')
% 
% subplot(6,2,8)
% %spectrogram(out_i, window, noverlap, nfft, Fs)
% pwelch(out_i, window, noverlap, nfft, Fs);
% ax = gca;
% xlim(ax, [0,5])
% ylim(ax, [-80 -30]);
% xline(Fc_i(1)/1000, 'r')
% xline(Fc_i(2)/1000, 'r')
% xline(Fc_i(3)/1000, 'r')
% xline(Fc_i(4)/1000, 'r')
% xline(Fc_i(5)/1000, 'r')
% title('"I" Formants')
% 
% subplot(6,2,10)
% %spectrogram(out_o, window, noverlap, nfft, Fs)
% pwelch(out_o, window, noverlap, nfft, Fs);
% ax = gca;
% xlim(ax, [0,5])
% ylim(ax, [-80 -30]);
% xline(Fc_o(1)/1000, 'r')
% xline(Fc_o(2)/1000, 'r')
% xline(Fc_o(3)/1000, 'r')
% xline(Fc_o(4)/1000, 'r')
% xline(Fc_o(5)/1000, 'r')
% title('"O" Formants')
% 
% subplot(6,2,12)
% %spectrogram(out_u, window, noverlap, nfft, Fs)
% pwelch(out_u, window, noverlap, nfft, Fs);
% ax = gca;
% xlim(ax, [0,5])
% ylim(ax, [-80 -30]);
% xline(Fc_u(1)/1000, 'r')
% xline(Fc_u(2)/1000, 'r')
% xline(Fc_u(3)/1000, 'r')
% xline(Fc_u(4)/1000, 'r')
% xline(Fc_u(5)/1000, 'r')
% title('"U" Formants')
% colormap('jet')

%==============================================
% Write all files to disk for qualitative
% analysis (listen to them).
%==============================================
audiowrite('_a.wav', out_a, Fs)
audiowrite('_e.wav', out_e, Fs)
audiowrite('_i.wav', out_i, Fs)
audiowrite('_o.wav', out_o, Fs)
audiowrite('_u.wav', out_u, Fs)

audiowrite('_beat.wav', out_beat, Fs)
audiowrite('_bit.wav', out_bit, Fs)
audiowrite('_bet.wav', out_bet, Fs)
audiowrite('_bat.wav', out_bat, Fs)
audiowrite('_part.wav', out_part, Fs)
audiowrite('_pot.wav', out_pot, Fs)
audiowrite('_boot.wav', out_boot, Fs)
audiowrite('_book.wav', out_book, Fs)
audiowrite('_but.wav', out_but, Fs)
audiowrite('_pert.wav', out_pert, Fs)


%==============================================
% Frequency domain representation of formants
% synthesized with incrimenting atta/decay
% transition demarcation.
%==============================================
% figure
% out_single_1 = vowel(2500, 0, 80, .005*Fs, pi/(.01*Fs), Fs, input, 0, '');
% out_single_2 = vowel(2500, 0, 80, .001*Fs, pi/(.001*Fs), Fs, input, 0, '');
% out_single_3 = vowel(2500, 0, 80, .0005*Fs, pi/(.0001*Fs), Fs, input, 0, '');
% out_single_4 = vowel(2500, 0, 80, .0001*Fs, pi/(.00001*Fs), Fs, input, 0, '');
% [pxx1,f] = pwelch(out_single_1, window, noverlap, nfft, Fs);
% [pxx2,f] = pwelch(out_single_2, window, noverlap, nfft, Fs);
% [pxx3,f] = pwelch(out_single_3, window, noverlap, nfft, Fs);
% [pxx4,f] = pwelch(out_single_4, window, noverlap, nfft, Fs);
% 
% plot(f, pow2db(pxx1))
% hold on
% plot(f, pow2db(pxx2), 'r')
% plot(f, pow2db(pxx3), 'g')
% plot(f, pow2db(pxx4), 'c')
% xlim([0,5000])
% legend('5 msec', '1 msec', '.5 msec', '.1 msec')
