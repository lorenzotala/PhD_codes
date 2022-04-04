clear all; clc; close all;

PhageIntensityvaluessliding = importfile("Phage_Intensity_values.csv");

STD = std(PhageIntensityvaluessliding.Mean)
Mean = mean(PhageIntensityvaluessliding.Mean)

raw_signal_freq=100;
acq_freq=50;
w1=2*pi*raw_signal_freq;
time = 3; %s
%(110:150) plot(PhageIntensityvaluessliding.Slice*(1/acq_freq),PhageIntensityvaluessliding.Mean-(mean(PhageIntensityvaluessliding.Mean)), 'ro');
figure(1)
histogram(PhageIntensityvaluessliding.Mean,'BinMethod','fd');
%plot(PhageIntensityvaluessliding.Slice*(1/acq_freq),PhageIntensityvaluessliding.Mean-Mean, 'r');
hold on;
X=linspace(2.2,time,10000);
Y=0.002*sin(w1*X);
%plot(X,Y,"b");

figure
plot(PhageIntensityvaluessliding.Mean)
[avg_o, var_o, skew_o, med_o]=moving_mean(PhageIntensityvaluessliding.Mean,25);
hold on;
plot(avg_o, 'LineWidth',2);
hold on;
%plot(skew_o, 'LineWidth',2);
yyaxis right
plot(var_o, 'LineWidth',2);
hold on;


figure
plot(PhageIntensityvaluessliding.Mean-avg_o);

[avg_o1, var_o1, skew_o1, med_o1]=moving_mean(PhageIntensityvaluessliding.Mean-avg_o,25);

hold on;
plot(avg_o1, 'LineWidth',2);
hold on;
%plot(skew_o1, 'LineWidth',2);
yyaxis right
plot(var_o1, 'LineWidth',2);
hold on;

figure
histogram(PhageIntensityvaluessliding.Mean-avg_o,'BinMethod','fd');

function [out_avg, out_var, out_skew, out_med] = moving_mean(in, half_window_size)
    in_L = length(in);
    out_avg = zeros(in_L,1);
    out_med = zeros(in_L,1);
    out_var = zeros(in_L,1);
    out_skew = zeros(in_L,1);
    Boundary_left = flip(in(1+1:1+half_window_size));
    Boundary_right = flip(in(in_L-half_window_size:in_L-1));
    
    in_padded = [Boundary_left; in; Boundary_right];
    
    for i=1:in_L
        c=half_window_size+i;
        out_avg(i)=mean(in_padded(c-half_window_size:c+half_window_size));
        out_var(i)=std(in_padded(c-half_window_size:c+half_window_size));
        out_med(i)=median(in_padded(c-half_window_size:c+half_window_size));
        out_skew(i)=3*(out_avg(i)-out_med(i))/sqrt(out_var(i));
    end
end



% if raz-le-bol
%     go home
% 
% else if ballek
%         go home too
%     end
% end
% 
% even if HR :
%     Go all the way HOME
%     
% Only care about yourself
% 
% Sleeping is the most important thing in the world 
% 
% It changes the way yoiu apprehend things 
% 
% Dont ever underestimate the power of sleeping 
% 
% If you yant to become friends with phages :
%     GO HOME
 