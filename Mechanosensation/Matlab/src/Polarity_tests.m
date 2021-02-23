tic
close all; clear all; clc

load('WorkSpace_CellStats.mat');
save_path='C:/Users/Iscia/Desktop/src/figures with fimX/WithoutCorrection/';
%% Compute polar ratios
BootN=300;
% PilB
disp('PilB liq');
[RatPilBliq, BootRatPilBliq, MeanRatPilBliq, stdRatPilBliq, PolarisationPilBliq, MeanPolarisationPilBliq]=polarRatios2(ProfilePilBliq, CellWidthPilBliq, CellLengthPilBliq, k, BootN);
disp('PilB sol');
[RatPilBsol, BootRatPilBsol, MeanRatPilBsol, stdRatPilBsol, PolarisationPilBsol, MeanPolarisationPilBsol]=polarRatios2(ProfilePilBsol, CellWidthPilBsol, CellLengthPilBsol, k, BootN);
disp('PilB pilH liq');
[RatPilBpilHliq, BootRatPilBpilHliq, MeanRatPilBpilHliq, stdRatPilBpilHliq, PolarisationPilBpilHliq, MeanPolarisationPilBpilHliq]=polarRatios2(ProfilePilBpilHliq, CellWidthPilBpilHliq, CellLengthPilBpilHliq, k, BootN);
disp('PilB pilG liq');
[RatPilBpilGliq, BootRatPilBpilGliq, MeanRatPilBpilGliq, stdRatPilBpilGliq, PolarisationPilBpilGliq, MeanPolarisationPilBpilGliq]=polarRatios2(ProfilePilBpilGliq,  CellWidthPilBpilGliq, CellLengthPilBpilGliq, k, BootN);
disp('PilB cpdA liq');
[RatPilBcpdAliq, BootRatPilBcpdAliq, MeanRatPilBcpdAliq, stdRatPilBcpdAliq, PolarisationPilBcpdAliq, MeanPolarisationPilBcpdAliq]=polarRatios2(ProfilePilBcpdAliq,  CellWidthPilBcpdAliq, CellLengthPilBcpdAliq, k, BootN);
disp('PilB cpdA sol');
[RatPilBcpdAsol, BootRatPilBcpdAsol, MeanRatPilBcpdAsol, stdRatPilBcpdAsol, PolarisationPilBcpdAsol, MeanPolarisationPilBcpdAsol]=polarRatios2(ProfilePilBcpdAsol,  CellWidthPilBcpdAsol, CellLengthPilBcpdAsol, k, BootN);
disp('PilB pilGcpdA liq');
[RatPilBpilGcpdAliq, BootRatPilBpilGcpdAliq, MeanRatPilBpilGcpdAliq, stdRatPilBpilGcpdAliq, PolarisationPilBpilGcpdAliq, MeanPolarisationPilBpilGcpdAliq]=polarRatios2(ProfilePilBpilGcpdAliq,  CellWidthPilBpilGcpdAliq, CellLengthPilBpilGcpdAliq, k, BootN);
%[RatPilBcyaBliq, BootRatPilBcyaBliq, MeanRatPilBcyaBliq, stdRatPilBcyaBliq]=polarRatios2(ProfilePilBcyaBliq,  CellWidthPilBcyaBliq, CellLengthPilBcyaBliq, k, BootN);

% FimX
disp('FimX liq');
[RatFimXliq, BootRatFimXliq, MeanRatFimXliq, stdRatFimXliq, PolarisationFimXliq, MeanPolarisationFimXliq]=polarRatios2(ProfileFimXliq, CellWidthFimXliq, CellLengthFimXliq, k, BootN);
disp('FimX sol');
[RatFimXsol, BootRatFimXsol, MeanRatFimXsol, stdRatFimXsol, PolarisationFimXsol, MeanPolarisationFimXsol]=polarRatios2(ProfileFimXsol, CellWidthFimXsol, CellLengthFimXsol, k, BootN);
disp('FimX pilH liq');
[RatFimXpilHliq, BootRatFimXpilHliq, MeanRatFimXpilHliq, stdRatFimXpilHliq, PolarisationFimXpilHliq, MeanPolarisationFimXpilHliq]=polarRatios2(ProfileFimXpilHliq, CellWidthFimXpilHliq, CellLengthFimXpilHliq, k, BootN);
disp('FimX pilG liq');
[RatFimXpilGliq, BootRatFimXpilGliq, MeanRatFimXpilGliq, stdRatFimXpilGliq, PolarisationFimXpilGliq, MeanPolarisationFimXpilGliq]=polarRatios2(ProfileFimXpilGliq,  CellWidthFimXpilGliq, CellLengthFimXpilGliq, k, BootN);
disp('FimX cpdA liq');
[RatFimXcpdAliq, BootRatFimXcpdAliq, MeanRatFimXcpdAliq, stdRatFimXcpdAliq, PolarisationFimXcpdAliq, MeanPolarisationFimXcpdAliq]=polarRatios2(ProfileFimXcpdAliq,  CellWidthFimXcpdAliq, CellLengthFimXcpdAliq, k, BootN);
disp('FimX pilGcpdA liq');
[RatFimXpilGcpdAliq, BootRatFimXpilGcpdAliq, MeanRatFimXpilGcpdAliq, stdRatFimXpilGcpdAliq, PolarisationFimXpilGcpdAliq, MeanPolarisationFimXpilGcpdAliq]=polarRatios2(ProfileFimXpilGcpdAliq,  CellWidthFimXpilGcpdAliq, CellLengthFimXpilGcpdAliq, k, BootN);

% Response Regulators
disp('PilH liq');
[RatPilHliq, BootRatPilHliq, MeanRatPilHliq, stdRatPilHliq, PolarisationPilHliq, MeanPolarisationPilHliq]=polarRatios2(ProfilePilHliq, CellWidthPilHliq, CellLengthPilHliq, k, BootN);
disp('PilH sol');
[RatPilGliq, BootRatPilGliq, MeanRatPilGliq, stdRatPilGliq, PolarisationPilGliq, MeanPolarisationPilGliq]=polarRatios2(ProfilePilGliq,  CellWidthPilGliq, CellLengthPilGliq, k, BootN);
disp('PilG liq');
[RatPilHsol, BootRatPilHsol, MeanRatPilHsol, stdRatPilHsol, PolarisationPilHsol, MeanPolarisationPilHsol]=polarRatios2(ProfilePilHsol, CellWidthPilHsol, CellLengthPilHsol, k, BootN);
disp('PilG sol');
[RatPilGsol, BootRatPilGsol, MeanRatPilGsol, stdRatPilGsol, PolarisationPilGsol, MeanPolarisationPilGsol]=polarRatios2(ProfilePilGsol,  CellWidthPilGsol, CellLengthPilGsol, k, BootN);

%% Plot profiles

% PilB_mNG
y_limit=max(max((MeanPilBpilHliq)+0.1*max(MeanPilBpilHliq),[],2));
alpha=0.4;
linewidth=2;
dim=1;
Legend = {'WT sol', 'in pilH liq', 'in cpdA liq', 'in pilG cpdA liq'};
Title = 'PilB in high cAMP';
Colors_high = [15 67 20; 229 20 50; 120 170 60; 209 103 209];
Y_limit=[0, y_limit];
plotProfiles(Title, Legend, alpha, linewidth, dim, Colors_high, false, Y_limit, k, MeanPilBsol, MeanPilBpilHliq, MeanPilBcpdAliq, MeanPilBpilGcpdAliq)
saveas(gcf, strcat(save_path,Title), 'fig');
saveas(gcf, strcat(save_path,Title), 'epsc');

Legend = {'WT liq', 'in pilG liq'};
Title = 'PilB in low cAMP';
Colors_low = [15 67 70; 20 255 50];
Y_limit=[0, y_limit];
plotProfiles(Title, Legend, alpha, linewidth, dim, Colors_low, false, Y_limit, k, MeanPilBliq, MeanPilBpilGliq)
saveas(gcf, strcat(save_path,Title), 'fig');
saveas(gcf, strcat(save_path,Title), 'epsc');

% FimX
Legend = {'WT sol', 'in pilH liq', 'in cpdA liq', 'in pilG cpdA liq'};
Title = 'FimX in high cAMP';
Colors_high = [15 67 20; 229 20 50; 120 170 60; 209 103 209];
Y_limit=[0, y_limit];
plotProfiles(Title, Legend, alpha, linewidth, 1, Colors_high, false, Y_limit, k, MeanFimXsol, MeanFimXpilHliq, MeanFimXcpdAliq, MeanFimXpilGcpdAliq)
saveas(gcf, strcat(save_path,Title), 'fig');
saveas(gcf, strcat(save_path,Title), 'epsc');

Legend = {'WT liq', 'in pilG liq'};
Title = 'FimX in low cAMP';
Colors_low = [15 67 70; 20 255 50];
Y_limit=[0, y_limit];
plotProfiles(Title, Legend, alpha, linewidth, 1, Colors_low, false, Y_limit, k, MeanFimXliq, MeanFimXpilGliq)
saveas(gcf, strcat(save_path,Title), 'fig');
saveas(gcf, strcat(save_path,Title), 'epsc');

% Response Regulators
Legend = {'pilH liq', 'pilH sol', 'pilG liq', 'pilG sol'};
Title = 'Response Regulators';
Colors_high = [15 67 20; 229 20 50; 120 170 60; 209 103 209];
Y_limit=[0, y_limit];
plotProfiles(Title, Legend, alpha, linewidth, dim, Colors_high, false, Y_limit, k, MeanPilHliq, MeanPilHsol, MeanPilGliq, MeanPilGsol)
saveas(gcf, strcat(save_path,Title), 'fig');
saveas(gcf, strcat(save_path,Title), 'epsc');

%% Plot polar ratios

% Response Regulators
Title = 'Response Regulators polar ratios';
XLabel = 'polar ratio';
Binsize = 20;
Binwidth = 0.02;
Colors_high = [15 67 20; 229 20 50; 120 170 60; 209 103 209];
Lengend = {'pilH liq', 'pilH sol', 'pilG liq', 'pilG sol'};
Y_limit=[0,0.3];
X_limit=[0,1];
plotPolarity(Title, XLabel, Binsize, Binwidth, Colors_high, Lengend, X_limit, Y_limit, RatPilHliq, RatPilHsol, RatPilGliq, RatPilGsol)
saveas(gcf, strcat(save_path,Title), 'fig');
saveas(gcf, strcat(save_path,Title), 'svg');


DataMarkerSize=8;
Legends={'pilH liq', 'pilH sol', 'pilG liq', 'pilG sol'};
Title='Response Regulators polarity';
YLable='polar ratio';
Ylimit=[0, 1];
Colors = [15 67 20; 229 20 50; 120 170 60; 209 103 209];
plotPolarityMeans(Title, YLable, Ylimit, DataMarkerSize, Legends, Colors, MeanRatPilHliq, MeanRatPilHsol, MeanRatPilGliq, MeanRatPilGsol)
saveas(gcf, strcat(save_path,Title), 'fig');
saveas(gcf, strcat(save_path,Title), 'svg');

% PilB
Title = 'PilB polarity in high cAMP';
XLabel = 'polar ratio';
Colors_high = [15 67 20; 229 20 50; 120 170 60; 100 150 40; 209 103 209];
Lengend = {'solid','in pilH liq','in cpdA liq','in cpdA sol','in pilg-cpdA-flic- liq'};
plotPolarity(Title, XLabel, Binsize, Binwidth, Colors_high, Lengend, X_limit, Y_limit, RatPilBsol, RatPilBpilHliq, RatPilBcpdAliq, RatPilBcpdAsol, RatPilBpilGcpdAliq)
saveas(gcf, strcat(save_path,Title), 'fig');
saveas(gcf, strcat(save_path,Title), 'svg');

Title = 'PilB polarity in low cAMP';
XLabel = 'polar ratio';
Colors_low = [15 67 70; 20 255 50];
Lengend = {'WT liq','in pilG liq'};
plotPolarity(Title, XLabel, Binsize, Binwidth, Colors_low, Lengend, X_limit, Y_limit, RatPilBliq, RatPilBpilGliq)
saveas(gcf, strcat(save_path,Title), 'fig');
saveas(gcf, strcat(save_path,Title), 'svg');

DataMarkerSize=8;
Legends={'liq','sol','in pilH liq', 'in cpdA liq', 'in cpdA sol', 'in pilG-cpdA-fliC- liq', 'in pilG liq'};
Title='PilB polarity';
YLable='polar ratio';
Colors = [15 67 20; 15 67 20; 229 20 50; 120 170 60; 100 150 40; 209 103 209; 20 255 50];
plotPolarityMeans(Title, YLable, Ylimit, DataMarkerSize, Legends, Colors, MeanRatPilBliq, MeanRatPilBsol, MeanRatPilBpilHliq, MeanRatPilBcpdAliq, MeanRatPilBcpdAsol, MeanRatPilBpilGcpdAliq, MeanRatPilBpilGliq)
saveas(gcf, strcat(save_path,Title), 'fig');
saveas(gcf, strcat(save_path,Title), 'svg');

% FimX
Title = 'FimX polarity in high cAMP';
XLabel = 'polar ratio';
Colors_high = [15 67 20; 229 20 50; 120 170 60; 209 103 209];
Lengend = {'solid','in pilH liq','in cpdA liq','in pilg-cpdA-flic- liq'};
plotPolarity(Title, XLabel, Binsize, Binwidth, Colors_high, Lengend, X_limit, Y_limit, RatFimXsol, RatFimXpilHliq, RatFimXcpdAliq, RatFimXpilGcpdAliq)
saveas(gcf, strcat(save_path,Title), 'fig');
saveas(gcf, strcat(save_path,Title), 'svg');

Title = 'FimX polarity in low cAMP';
XLabel = 'polar ratio';
Colors_low = [15 67 70; 20 255 50];
Lengend = {'WT liq','in pilG liq'};
plotPolarity(Title, XLabel, Binsize, Binwidth, Colors_low, Lengend, X_limit, Y_limit, RatFimXliq, RatFimXpilGliq)
saveas(gcf, strcat(save_path,Title), 'fig');
saveas(gcf, strcat(save_path,Title), 'svg');

DataMarkerSize=8;
Legends={'liq','sol','in pilH liq', 'in cpdA liq', 'in pilG-cpdA-fliC- liq', 'in pilG liq'};
Title='FimX polarity';
YLable='polar ratio';
Colors = [15 67 20; 15 67 20; 229 20 50; 120 170 60; 209 103 209; 20 255 50];
plotPolarityMeans(Title, YLable, Ylimit, DataMarkerSize, Legends, Colors, MeanRatFimXliq, MeanRatFimXsol, MeanRatFimXpilHliq, MeanRatFimXcpdAliq, MeanRatFimXpilGcpdAliq, MeanRatFimXpilGliq)
saveas(gcf, strcat(save_path,Title), 'fig');
saveas(gcf, strcat(save_path,Title), 'svg');

%% Plot polarisation

% Response Regulators
Title = 'Response Regulators polarisation index';
XLabel = 'polarisation index';
Binsize = 20;
Binwidth = 0.01;
Colors_high = [15 67 20; 229 20 50; 120 170 60; 209 103 209];
Lengend = {'pilH liq', 'pilH sol', 'pilG liq', 'pilG sol'};
Y_limit=[0,0.11];
X_limit=[0.5,1];
plotPolarity(Title, XLabel, Binsize, Binwidth, Colors_high, Lengend, X_limit, Y_limit, PolarisationPilHliq, PolarisationPilHsol, PolarisationPilGliq, PolarisationPilGsol)
saveas(gcf, strcat(save_path,Title), 'fig');
saveas(gcf, strcat(save_path,Title), 'svg');

DataMarkerSize=8;
Legends={'pilH liq', 'pilH sol', 'pilG liq', 'pilG sol'};
Title='Response Regulators polarisation';
YLable='polarisation index';
Ylimit=[0.5, 1];
Colors = [15 67 20; 229 20 50; 120 170 60; 209 103 209];
plotPolarityMeans(Title, YLable, Ylimit, DataMarkerSize, Legends, Colors, MeanPolarisationPilHliq, MeanPolarisationPilHsol, MeanPolarisationPilGliq, MeanPolarisationPilGsol)
saveas(gcf, strcat(save_path,Title), 'fig');
saveas(gcf, strcat(save_path,Title), 'svg');

% PilB
Title = 'PilB polarisation in high cAMP';
Colors_high = [15 67 20; 229 20 50; 120 170 60; 100 150 40; 209 103 209];
Lengend = {'solid','in pilH liq','in cpdA liq','in cpdA sol','in pilg-cpdA-flic- liq'};
plotPolarity(Title, XLabel, Binsize, Binwidth, Colors_high, Lengend, X_limit, Y_limit, PolarisationPilBsol, PolarisationPilBpilHliq, PolarisationPilBcpdAliq, PolarisationPilBcpdAsol, PolarisationPilBpilGcpdAliq)
saveas(gcf, strcat(save_path,Title), 'fig');
saveas(gcf, strcat(save_path,Title), 'svg');

Title = 'PilB polarisation in low cAMP';
Colors_low = [15 67 70; 20 255 50];
Lengend = {'WT liq','in pilG liq'};
plotPolarity(Title, XLabel, Binsize, Binwidth, Colors_low, Lengend, X_limit, Y_limit, PolarisationPilBliq, PolarisationPilBpilGliq)
saveas(gcf, strcat(save_path,Title), 'fig');
saveas(gcf, strcat(save_path,Title), 'svg');

DataMarkerSize=8;
Legends={'liq','sol','in pilH liq', 'in cpdA liq', 'in cpdA sol', 'in pilG-cpdA-fliC- liq', 'in pilG liq'};
Title='PilB polarisation';
YLable='polarisation index';
Colors = [15 67 20; 15 67 20; 229 20 50; 120 170 60; 100 150 40; 209 103 209; 20 255 50];
plotPolarityMeans(Title, YLable, Ylimit, DataMarkerSize, Legends, Colors, MeanPolarisationPilBliq, MeanPolarisationPilBsol, MeanPolarisationPilBpilHliq, MeanPolarisationPilBcpdAliq, MeanPolarisationPilBcpdAsol, MeanPolarisationPilBpilGcpdAliq, MeanPolarisationPilBpilGliq)
saveas(gcf, strcat(save_path,Title), 'fig');
saveas(gcf, strcat(save_path,Title), 'svg');

% FimX
Title = 'FimX polarisation in high cAMP';
Colors_high = [15 67 20; 229 20 50; 120 170 60; 209 103 209];
Lengend = {'solid','in pilH liq','in cpdA liq','in pilg-cpdA-flic- liq'};
plotPolarity(Title, XLabel, Binsize, Binwidth, Colors_high, Lengend, X_limit, Y_limit, PolarisationFimXsol, PolarisationFimXpilHliq, PolarisationFimXcpdAliq, PolarisationFimXpilGcpdAliq)
saveas(gcf, strcat(save_path,Title), 'fig');
saveas(gcf, strcat(save_path,Title), 'svg');

Title = 'FimX polarisation in low cAMP';
Colors_low = [15 67 70; 20 255 50];
Lengend = {'WT liq','in pilG liq'};
plotPolarity(Title, XLabel, Binsize, Binwidth, Colors_low, Lengend, X_limit, Y_limit, PolarisationFimXliq, PolarisationFimXpilGliq)
saveas(gcf, strcat(save_path,Title), 'fig');
saveas(gcf, strcat(save_path,Title), 'svg');

DataMarkerSize=8;
Legends={'liq','sol','in pilH liq', 'in cpdA liq', 'in pilG-cpdA-fliC- liq', 'in pilG liq'};
Title='FimX polarisation';
YLable='polarisation index';
Colors = [15 67 20; 15 67 20; 229 20 50; 120 170 60; 209 103 209; 20 255 50];
plotPolarityMeans(Title, YLable, Ylimit, DataMarkerSize, Legends, Colors, MeanPolarisationFimXliq, MeanPolarisationFimXsol, MeanPolarisationFimXpilHliq, MeanPolarisationFimXcpdAliq, MeanPolarisationFimXpilGcpdAliq, MeanPolarisationFimXpilGliq)
saveas(gcf, strcat(save_path,Title), 'fig');
saveas(gcf, strcat(save_path,Title), 'svg');
%%
toc