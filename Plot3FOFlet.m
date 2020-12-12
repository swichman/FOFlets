this = figure('Position',[0 0 1980 500]);

window = 512;
noverlap = 256;
nfft = 4096;
rot_x = 0;
rot_y = 90;

plot_fof(out_beat,Fs,Fc_beat,1,'b-EA-t',this)
plot_fof(out_bit,Fs,Fc_bit,2,'b-I-t',this)
plot_fof(out_bet,Fs,Fc_bet,3,'b-E-t',this)
plot_fof(out_bat,Fs,Fc_bat,4,'b-A-t',this)
plot_fof(out_part,Fs,Fc_part,5,'p-AR-t',this)

saveas(this, 'top_5_3-FOFlets.png');

plot_fof(out_pot,Fs,Fc_pot,1,'p-O-t',this)
plot_fof(out_boot,Fs,Fc_boot,2,'b-OO-t',this)
plot_fof(out_book,Fs,Fc_book,3,'b-OO-k',this)
plot_fof(out_but,Fs,Fc_but,4,'b-u-t',this)
plot_fof(out_pert,Fs,Fc_pert,5,'p-ER-t',this)

saveas(this, 'bottom_5_3-FOFlets.png');
