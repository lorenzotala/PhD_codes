Title = 'Response Regulators';
XLabel = 'polar ratio';
Binsize = 20;
Binwidth = 0.01;
Colors = [15 67 20; 229 20 50; 120 170 60; 209 103 209; 209 103 209; 15 67 20; 229 20 50; 120 170 60; 209 103 209; 209 103 209; 15 67 20; 229 20 50; 120 170 60; 209 103 209; 209 103 209];
Legend = {'pilH liq', 'pilH sol', 'pilG liq', 'pilG sol'};
Y_limit=[0,0.13];
X_limit=[-1,1];
plotPolarity(Title, XLabel, Binsize, Binwidth, Colors, Legend, X_limit, Y_limit, RatPilHliq, RatPilHsol, RatPilGliq, RatPilGsol)

Legend = {'WT sol', 'in pilH liq', 'in cpdA liq', 'in pilG cpdA liq'};
Title = 'FimX in high cAMP';
Y_limit=[0, 0.025];
plotProfiles(Title, Legend, 0.4, 2, 1, Colors, true, Y_limit, k, MeanFimXliq, MeanFimXpilHliq, MeanFimXcpdAliq, MeanFimXpilGcpdAliq)

DataMarkerSize=8;
Legends={'solid', 'in pilH liquid', 'in cpdA liquid', 'in pilG-cpdA-fliC- liquid'};
Title='PilB polarity in high cAMP';
YLable='PolarRatio';
Y_limit=[-1, 1];
plotPolarityMeans(Title, YLable, Y_limit, DataMarkerSize, Legends, Colors, MeanRatPilBsol, MeanRatPilBpilHliq, MeanRatPilBcpdAliq, MeanRatPilBpilGcpdAliq)

DataMarkerSize=8;
Legends={'solid', 'in pilH liq', 'in cpdA liq', 'in cpdA sol', 'in pilG-cpdA-fliC- liq'};
Title='PilB polarisation in high cAMP';
YLable='polarisation index';
Y_limit=[0.5, 1];
plotPolarityMeans(Title, YLable, Y_limit, DataMarkerSize, Legends, Colors, MeanPolarisationPilBsol, MeanPolarisationPilBpilHliq, MeanPolarisationPilBcpdAliq, MeanPolarisationPilBcpdAsol, MeanPolarisationPilBpilGcpdAliq)
save_path='C:/Users/Iscia/Desktop/src/figures with fimX/WithCorrection/';
DataMarkerSize=8;
Legends={'liq','sol','in pilH liq', 'in cpdA liq', 'in cpdA sol', 'in pilG-cpdA-fliC- liq', 'in pilG liq'};
Title='PilB polarisation in low cAMP';
YLable='polarisation index';
Y_limit=[0.5, 1];
plotPolarityMeans(Title, YLable, Y_limit, DataMarkerSize, Legends, Colors, MeanPolarisationPilBliq, MeanPolarisationPilBsol, MeanPolarisationPilBpilHliq, MeanPolarisationPilBcpdAliq, MeanPolarisationPilBcpdAsol, MeanPolarisationPilBpilGcpdAliq, MeanPolarisationPilBpilGliq)
saveas(gcf, strcat(save_path,Title), 'fig');
saveas(gcf, strcat(save_path,Title), 'svg');
saveas(gcf, strcat(save_path,Title), 'epsc');