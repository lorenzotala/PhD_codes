close all; clear all; clc;
load('workspace_no_sol.mat');
BootN=300;

[RatPilUliq, BootRatPilUliq, MeanRatPilUliq, stdRatPilUliq]=polarRatios2(ProfilePilUliq, CellWidthPilUliq, CellLengthPilUliq, k, BootN);
[RatPilBliq, BootRatPilBliq, MeanRatPilBliq, stdRatPilBliq]=polarRatios2(ProfilePilBliq, CellWidthPilBliq, CellLengthPilBliq, k, BootN);
[RatPilBsol, BootRatPilBsol, MeanRatPilBsol, stdRatPilBsol]=polarRatios2(ProfilePilBsol, CellWidthPilBsol, CellLengthPilBsol, k, BootN);
[RatPilBpilHliq, BootRatPilBpilHliq, MeanRatPilBpilHliq, stdRatPilBpilHliq]=polarRatios2(ProfilePilBpilHliq, CellWidthPilBpilHliq, CellLengthPilBpilHliq, k, BootN);
[RatPilBpilGliq, BootRatPilBpilGliq, MeanRatPilBpilGliq, stdRatPilBpilGliq]=polarRatios2(ProfilePilBpilGliq,  CellWidthPilBpilGliq, CellLengthPilBpilGliq, k, BootN);
[RatPilBcpdAliq, BootRatPilBcpdAliq, MeanRatPilBcpdAliq, stdRatPilBcpdAliq]=polarRatios2(ProfilePilBcpdAliq,  CellWidthPilBcpdAliq, CellLengthPilBcpdAliq, k, BootN);
[RatPilBpilGcpdAliq, BootRatPilBpilGcpdAliq, MeanRatPilBpilGcpdAliq, stdRatPilBpilGcpdAliq]=polarRatios2(ProfilePilBpilGcpdAliq,  CellWidthPilBpilGcpdAliq, CellLengthPilBpilGcpdAliq, k, BootN);
[RatPilBcyaBliq, BootRatPilBcyaBliq, MeanRatPilBcyaBliq, stdRatPilBcyaBliq]=polarRatios2(ProfilePilBcyaBliq,  CellWidthPilBcyaBliq, CellLengthPilBcyaBliq, k, BootN);

DataMarker=8;
MedianMarkSize=10;
figure();
LegendsHighcAMP={'solid', 'in pilH liquid', 'in cpdA liquid'};
plot([1 1 1], MeanRatPilBsol,'ob',  [2 2 2], MeanRatPilBpilHliq, 'or', [3 3 3], MeanRatPilBcpdAliq,'om', 'MarkerSize', DataMarker)
hold on;
plot([1, 2, 3],[mean(MeanRatPilBsol), mean(MeanRatPilBpilHliq), mean(MeanRatPilBcpdAliq)], 'ok', 'MarkerSize', MedianMarkSize)
ICPilB_high=[[mean(MeanRatPilBsol)-std(MeanRatPilBsol); mean(MeanRatPilBpilHliq)-std(MeanRatPilBpilHliq); mean(MeanRatPilBcpdAliq)-std(MeanRatPilBcpdAliq)] [mean(MeanRatPilBsol)+std(MeanRatPilBsol); mean(MeanRatPilBpilHliq)+std(MeanRatPilBpilHliq); mean(MeanRatPilBcpdAliq)+std(MeanRatPilBcpdAliq)]];
for i=1:3
    plot([i i],ICPilB_high(i,:), 'k', 'LineWidth',2);
end

xlim([0,4]);
ylim([0,1]);
xticks(1:4);
xticklabels(LegendsHighcAMP);
%xtickangle(45);
title('PilB in high cAMP');
ylabel('PolarRatio');

figure();
LegendsLowcAMP={'liquid','in pilG liq', 'in cyaB liq'};
plot([1 1 1],MeanRatPilBliq,'ob', [2 2 2], MeanRatPilBpilGliq,'og', [3 3 3], MeanRatPilBcyaBliq,'oc', 'MarkerSize', DataMarker)
hold on;
plot([1, 2, 3],[mean(MeanRatPilBliq), mean(MeanRatPilBpilGliq), mean(MeanRatPilBcyaBliq)], 'ok', 'MarkerSize', MedianMarkSize)
ICPilB_low=[[mean(MeanRatPilBliq)-std(MeanRatPilBliq); mean(MeanRatPilBpilGliq)-std(MeanRatPilBpilGliq); mean(MeanRatPilBcyaBliq)-std(MeanRatPilBcyaBliq)] [mean(MeanRatPilBliq)+std(MeanRatPilBliq); mean(MeanRatPilBpilGliq)+std(MeanRatPilBpilGliq); mean(MeanRatPilBcyaBliq)+std(MeanRatPilBcyaBliq)]];
for i=1:3
    plot([i i],ICPilB_low(i,:), 'k', 'LineWidth',2);
end
xlim([0,4]);
ylim([0,1]);
xticks(1:4);
xticklabels(LegendsLowcAMP);
%xtickangle(45);
title('PilB in low cAMP');
ylabel('PolarRatio');
%%
close all;
figure();
binsize=30;
%histogram([RatPilBliq.BR3,RatPilBliq.BR2,RatPilBliq.BR1],binsize,'Normalization','probability')
hold on;
histogram([RatPilBsol.BR3,RatPilBsol.BR2,RatPilBsol.BR1],binsize,'Normalization','probability', 'FaceColor', [30 136 229]/256 )
hold on;
histogram([RatPilBpilHliq.BR3,RatPilBpilHliq.BR2,RatPilBpilHliq.BR1],binsize,'Normalization','probability', 'FaceColor', [216 27 96]/256)
hold on;
histogram([RatPilBcpdAliq.BR3,RatPilBcpdAliq.BR2,RatPilBcpdAliq.BR1],binsize, 'Normalization','probability', 'FaceColor', [255 193 7]/256 )
hold on;
histogram([RatPilBpilGcpdAliq.BR3,RatPilBpilGcpdAliq.BR2,RatPilBpilGcpdAliq.BR1],binsize, 'Normalization','probability', 'FaceColor', [255 193 102]/256 )
legend('solid','in pilH liq','in cpdA liq','in pilg-cpdA-flic- liq','Location','best');
xlim([0,1]);
xlabel('polar ratio');
ylabel('probability');
title('PilB polarity');
ylim([0,0.15]);

figure;
binsize=30;
histogram([RatPilBliq.BR3,RatPilBliq.BR2,RatPilBliq.BR1],binsize,'Normalization','probability', 'FaceColor', [30 136 229]/256)
hold on;
%histogram([RatPilBsol.BR3,RatPilBsol.BR2,RatPilBsol.BR1],binsize,'Normalization','probability', 'FaceColor', [30 136 229]/256 )
hold on;
histogram([RatPilBpilGliq.BR3,RatPilBpilGliq.BR2,RatPilBpilGliq.BR1],binsize,'Normalization','probability', 'FaceColor', [26 255 26]/256)
hold on;
histogram([RatPilBcyaBliq.BR3,RatPilBcyaBliq.BR2,RatPilBcyaBliq.BR1],binsize, 'Normalization','probability', 'FaceColor', [153 123 239]/256 )
legend('liquid','in pilG liq','in cyaB liq','Location','best');
xlim([0,1]);
xlabel('polar ratio');
ylabel('probability');
title('PilB polarity');
ylim([0,0.15]);



%% Mean polar ratios liquid vs solid
figure;
DataMarker=8;
MedianMarkSize=10;
subplot(2,3,1);
LegendsLowcAMP={'liquid', 'solid', 'in pilG liquid', 'in pilG solid', 'in cyaB liquid', 'in cyaB solid'};
plot([1 1 1],MeanRatPilUliq,'ob', [2 2 2], MeanRatPilUsol,'*b', [3 3 3], MeanRatPilUpilGliq, 'og',[4 4 4], MeanRatPilUpilGsol, '*g',[5 5 5], MeanRatPilUcyaBliq,'oc',[6 6 6], MeanRatPilUcyaBsol,'*c', 'MarkerSize', DataMarker)
hold on;
plot([1, 2, 3, 4, 5, 6],[mean(MeanRatPilUliq), mean(MeanRatPilUsol), mean(MeanRatPilUpilGliq), mean(MeanRatPilUpilGsol), mean(MeanRatPilUcyaBliq), mean(MeanRatPilUcyaBsol)], 'ok', 'MarkerSize', MedianMarkSize)
ICPilU=[mean(stdRatPilUliq); mean(stdRatPilUsol); mean(stdRatPilUpilGliq); mean(stdRatPilUpilGsol); mean(stdRatPilUcyaBliq); mean(stdRatPilUcyaBsol)];
for i=1:6
    plot([i i],ICPilU(i,:), 'k', 'LineWidth',1);
end
xlim([0,7]);
ylim([0,4.5]);
xticks(1:6);
xticklabels(LegendsLowcAMP);
xtickangle(45);
title('PilU in low cAMP');
ylabel('PolarRatio');

subplot(2,3,4);
LegendsHighcAMP={'liquid', 'solid', 'in pilH liquid', 'in pilH solid', 'in cpdA liquid', 'in cpdA solid'};
plot([1 1 1],MeanRatPilUliq,'ob', [2 2 2], MeanRatPilUsol,'*b', [3 3 3], MeanRatPilUpilHliq, 'or', [4 4 4], MeanRatPilUpilHsol, '*r',[5 5 5], MeanRatPilUcpdAliq,'om',[6 6 6], MeanRatPilUcpdAsol,'*m', 'MarkerSize', DataMarker)
hold on;
plot([1, 2, 3, 4, 5, 6],[mean(MeanRatPilUliq), mean(MeanRatPilUsol), mean(MeanRatPilUpilHliq), mean(MeanRatPilUpilHsol), mean(MeanRatPilUcpdAliq), mean(MeanRatPilUcpdAsol)], 'ok', 'MarkerSize', MedianMarkSize)
ICPilU=[mean(stdRatPilUliq); mean(stdRatPilUsol); mean(stdRatPilUpilHliq); mean(stdRatPilUpilHsol); mean(stdRatPilUcpdAliq); mean(stdRatPilUcpdAsol)];
for i=1:6
    plot([i i],ICPilU(i,:), 'k', 'LineWidth',1);
end
xlim([0,7]);
ylim([0,4.5]);
xticks(1:6);
xticklabels(LegendsHighcAMP);
xtickangle(45);
title('PilU in high cAMP');
ylabel('PolarRatio');

subplot(2,3,2);

plot([1 1 1],MeanRatPilBliq,'ob', [2 2 2], MeanRatPilBsol,'*b', [3 3 3], MeanRatPilBpilGliq, 'og', [4 4 4], MeanRatPilBpilGsol, '*g',[5 5 5], MeanRatPilBcyaBliq,'oc',[6 6 6], MeanRatPilBcyaBsol,'*c', 'MarkerSize', DataMarker)
hold on;
plot([1, 2, 3, 4, 5, 6],[mean(MeanRatPilBliq), mean(MeanRatPilBsol), mean(MeanRatPilBpilGliq), mean(MeanRatPilBpilGsol), mean(MeanRatPilBcyaBliq), mean(MeanRatPilBcyaBsol)], 'ok', 'MarkerSize', MedianMarkSize)
xlim([0,7]);
ylim([0,4.5]);
xticks(1:6);
xticklabels(LegendsLowcAMP);
xtickangle(45);
title('PilB in low cAMP');
ylabel('PolarRatio');

subplot(2,3,5);

plot([1 1 1],MeanRatPilBliq,'ob', [2 2 2], MeanRatPilBsol,'*b', [3 3 3], MeanRatPilBpilHliq, 'or', [4 4 4], MeanRatPilBpilHsol, '*r',[5 5 5], MeanRatPilBcpdAliq,'om',[6 6 6], MeanRatPilBcpdAsol,'*m', 'MarkerSize', DataMarker)
hold on;
plot([1, 2, 3, 4, 5, 6],[mean(MeanRatPilBliq), mean(MeanRatPilBsol), mean(MeanRatPilBpilHliq), mean(MeanRatPilBpilHsol), mean(MeanRatPilBcpdAliq), mean(MeanRatPilBcpdAsol)], 'ok', 'MarkerSize', MedianMarkSize)
xlim([0,7]);
ylim([0,4.5]);
xticks(1:6);
xticklabels(LegendsHighcAMP);
xtickangle(45);
title('PilB in high cAMP');
ylabel('PolarRatio');

subplot(2,3,3);

plot([1 1 1],MeanRatPilTliq,'ob', [2 2 2], MeanRatPilTsol,'*b', [3 3 3], MeanRatPilTpilGliq, 'og', [4 4 4], MeanRatPilTpilGsol, '*g',[5 5 5], MeanRatPilTcyaBliq,'oc',[6 6 6], MeanRatPilTcyaBsol,'*c', 'MarkerSize', DataMarker)
hold on;
plot([1, 2, 3, 4, 5, 6],[mean(MeanRatPilTliq), mean(MeanRatPilTsol), mean(MeanRatPilTpilGliq), mean(MeanRatPilTpilGsol), mean(MeanRatPilTcyaBliq), mean(MeanRatPilTcyaBsol)], 'ok', 'MarkerSize', MedianMarkSize)
xlim([0,7]);
ylim([0,4.5]);
xticks(1:6);
xticklabels(LegendsLowcAMP);
xtickangle(45);
title('PilT in low cAMP');
ylabel('PolarRatio');

subplot(2,3,6);
% LegendsHighcAMP={'liquid', 'solid', 'in pilH solid', 'in cpdA solid'};
plot([1 1 1],MeanRatPilTliq,'ob', [2 2 2], MeanRatPilTsol,'*b', [3 3 3], MeanRatPilTpilHliq, 'or', [4 4 4], MeanRatPilTpilHsol, '*r', [5 5 5], MeanRatPilTcpdAliq, 'om', [6 6 6], MeanRatPilTcpdAsol, '*m', 'MarkerSize', DataMarker)
hold on;
plot([1, 2, 3, 4, 5, 6],[mean(MeanRatPilTliq), mean(MeanRatPilTsol), mean(MeanRatPilTpilHliq), mean(MeanRatPilTpilHsol), mean(MeanRatPilTcpdAliq), mean(MeanRatPilTcpdAsol)], 'ok', 'MarkerSize', MedianMarkSize)
xlim([0,7]);
ylim([0,4.5]);
xticks(1:6);
xticklabels(LegendsHighcAMP);
xtickangle(45);
title('PilT in high cAMP');
ylabel('PolarRatio');

% figure;
% LegendsHighcAMP={'liquid', 'solid', '0%', '0.01%', '0.03%', '0.1%'};
% plot([1 1 1],MeanRatPilBliq,'ob', [2 2 2], MeanRatPilBsol,'*b', [3 3 3], MeanRatpilB_0_0ara, 'or', [4 4 4], MeanRatpilB_0_01ara, '*r',[5 5 5], MeanRatpilB_0_03ara,'om',[6 6 6], MeanRatpilB_0_1ara,'*m', 'MarkerSize', DataMarker)
% hold on;
% plot([1, 2, 3, 4, 5, 6],[mean(MeanRatPilBliq), mean(MeanRatPilBsol), mean(MeanRatpilB_0_0ara), mean(MeanRatpilB_0_01ara), mean(MeanRatpilB_0_03ara), mean(MeanRatpilB_0_1ara)], 'ok', 'MarkerSize', MedianMarkSize)
% xlim([0,7]);
% ylim([0,4.5]);
% xticks(1:6);
% xticklabels(LegendsHighcAMP);
% xtickangle(45);
% title('PilB arabinose induced');
% ylabel('PolarRatio');

%%
% x1=FluoMeansPilUcyaBsol.(char(fields(y)));
% y1=transpose(RatPilUcyaBsol.(char(fields(y))));
% P = polyfit(x1,y1,1);
% yfit = P(1)*x+P(2);
% hold on;
% plot(x,yfit,'k-.');
