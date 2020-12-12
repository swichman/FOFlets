function [output] = FOFlet(Fs,bw,k_1,beta,f_c, A, in_train)
%FOFLET Summary of this function goes here
%   Detailed explanation goes here
Ts = 1/Fs;
fof = zeros(1,Fs);    %only 1 second of audio output
%f_c = f_c/120;

j = 1;
while j < Fs
    for k = 1:k_1
        fof(j) = .5*(1 - cos(beta*(k-1)))*exp(-bw*pi*Ts*(k-1))*sin(2*pi*f_c*(k-1)*Ts);
        j = j + 1;
    end
    
    for k = k_1:Fs/120
        fof(j) = exp(-bw*pi*Ts*k)*sin(2*pi*f_c*k*Ts);
        j = j + 1;
    end    
end
% figure
% plot(conv(in_train,fof(1:2000)))

output = conv(in_train,db2mag(A)*fof);
%output = conv(in_train,fof);

