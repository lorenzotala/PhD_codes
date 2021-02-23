%% Initialization
clear all; close all;
clc;
tic
data_root_path='C:/Users/Iscia/Desktop/src/Analysis_Marco';
% data_root_path='C:/Users/tala/Desktop/backstal/Download_code/src/data';
save_path='C:/Users/Iscia/Desktop/src/Analysis_Marco/figures/';

% mNeonGreen_fimX dataset files
fimX_liq_files={'/DataSet_mNG_fimX_fliC-_liq_BR=1.mat','/DataSet_mNG_fimX_fliC-_liq_BR=1.mat','/DataSet_mNG_fimX_fliC-_liq_BR=1.mat'};
fimX_sol_files={'/DataSet_mNG_fimX_fliC-_sol_BR=1.mat','/DataSet_mNG_fimX_fliC-_sol_BR=1.mat','/DataSet_mNG_fimX_fliC-_sol_BR=1.mat'};
fimX_pilH_liq_files={'/DataSet_mNG_fimX_pilH-fliC-_liq_BR=1.mat', '/DataSet_mNG_fimX_pilH-fliC-_liq_BR=2.mat', '/DataSet_mNG_fimX_pilH-fliC-_liq_BR=3.mat'};
fimX_cpdA_liq_files={'/DataSet_mNG_fimX_cpdA-fliC-_liq_BR=1.mat', '/DataSet_mNG_fimX_cpdA-fliC-_liq_BR=2.mat', '/DataSet_mNG_fimX_cpdA-fliC-_liq_BR=2.mat'};
fimX_cpdA_sol_files={'/DataSet_mNG_fimX_cpdA-fliC-_sol_BR=1.mat', '/DataSet_mNG_fimX_cpdA-fliC-_sol_BR=2.mat', '/DataSet_mNG_fimX_cpdA-fliC-_sol_BR=2.mat'}; %Copied Biological replicates
fimX_pilGcpdA_liq_files={'/DataSet_mNG_fimX_pilG-cpdA-fliC-_liq_BR=1.mat', '/DataSet_mNG_fimX_pilG-cpdA-fliC-_liq_BR=2.mat', '/DataSet_mNG_fimX_pilG-cpdA-fliC-_liq_BR=2.mat'}; %Copied Biological replicates
fimX_pilGcpdA_sol_files={'/DataSet_mNG_fimX_pilG-cpdA-fliC-_sol_BR=1.mat', '/DataSet_mNG_fimX_pilG-cpdA-fliC-_sol_BR=2.mat', '/DataSet_mNG_fimX_pilG-cpdA-fliC-_sol_BR=2.mat'}; %Copied Biological replicates


% pilB_mNeonGreen dataset files
pilB_liq_files={'/DataSet_pilB_mNG_fliC-_liq_BR=1.mat', '/DataSet_pilB_mNG_fliC-_liq_BR=2.mat', '/DataSet_pilB_mNG_fliC-_liq_BR=3.mat'};
pilB_sol_files={'/DataSet_pilB_mNG_fliC-_sol_BR=1.mat', '/DataSet_pilB_mNG_fliC-_sol_BR=2.mat', '/DataSet_pilB_mNG_fliC-_sol_BR=3.mat'};
pilB_pilH_liq_files={'/DataSet_pilB_mNG_pilH-fliC-_liq_BR=1.mat', '/DataSet_pilB_mNG_pilH-fliC-_liq_BR=2.mat', '/DataSet_pilB_mNG_pilH-fliC-_liq_BR=3.mat'};
pilB_cpdA_liq_files={'/DataSet_pilB_mNG_cpdA-fliC-_liq_BR=1.mat', '/DataSet_pilB_mNG_cpdA-fliC-_liq_BR=2.mat', '/DataSet_pilB_mNG_cpdA-fliC-_liq_BR=2.mat'};
pilB_cpdA_sol_files={'/DataSet_pilB_mNG_cpdA-fliC-_sol_BR=1.mat', '/DataSet_pilB_mNG_cpdA-fliC-_sol_BR=2.mat', '/DataSet_pilB_mNG_cpdA-fliC-_sol_BR=2.mat'};
pilB_pilGcpdA_liq_files={'/DataSet_pilB_mNG_pilG-cpdA-fliC-_liq_BR=1.mat', '/DataSet_pilB_mNG_pilG-cpdA-fliC-_liq_BR=2.mat', '/DataSet_pilB_mNG_pilG-cpdA-fliC-_liq_BR=2.mat'};
pilB_pilGcpdA_sol_files={'/DataSet_pilB_mNG_pilG-cpdA-fliC-_sol_BR=1.mat', '/DataSet_pilB_mNG_pilG-cpdA-fliC-_sol_BR=2.mat', '/DataSet_pilB_mNG_pilG-cpdA-fliC-_sol_BR=2.mat'}; %Copied Biological replicates

% Field name of fluorescence profile data in the BacStalk Struct Dataset
fluo_FieldNames='MedialAxisIntensity_mNeonGreen';

%% Stats
NbUpSamples=200; %Up sample the intensity profile to get similar length vectors to compare.
Biological_reps=3;
k=linspace(0,1,NbUpSamples); %k is a ordered vector from 1 to 200
CellLengthLiq=5; %in µm;
CellLengthSol=5; %in µm;

fields=cell(Biological_reps, 1);
for i=1:Biological_reps
    name=strcat('BR',num2str(i));
    fields(i)= {name};
end

for y=1:Biological_reps
    [MeanFimXliq(y,:), StdFimXliq(y,:), NFimXliq(y), ProfileFimXliq.(char(fields(y))), FluoMeansFimXliq.(char(fields(y))), CellWidthFimXliq.(char(fields(y))), CellLengthFimXliq.(char(fields(y))), CellIDFimXliq.(char(fields(y)))]=getMeanProfile(strcat(data_root_path, fimX_liq_files{y}), k, NbUpSamples, fluo_FieldNames, CellLengthLiq);
    temp=trapz(MeanFimXliq(y,:));
    MeanFimXliq(y,:)=MeanFimXliq(y,:)/temp;
    [MeanFimXsol(y,:), StdFimXsol(y,:), NFimXsol(y), ProfileFimXsol.(char(fields(y))), FluoMeansFimXsol.(char(fields(y))), CellWidthFimXsol.(char(fields(y))), CellLengthFimXsol.(char(fields(y))), CellIDFimXsol.(char(fields(y)))]=getMeanProfile(strcat(data_root_path, fimX_sol_files{y}), k, NbUpSamples, fluo_FieldNames, CellLengthSol);
    temp=trapz(MeanFimXsol(y,:));
    MeanFimXsol(y,:)=MeanFimXsol(y,:)/temp;
    [MeanFimXpilHliq(y,:), StdFimXpilHliq(y,:), NFimXpilHliq(y), ProfileFimXpilHliq.(char(fields(y))), FluoMeansFimXpilHliq.(char(fields(y))), CellWidthFimXpilHliq.(char(fields(y))), CellLengthFimXpilHliq.(char(fields(y))), CellIDFimXpilHliq.(char(fields(y)))]=getMeanProfile(strcat(data_root_path, fimX_pilH_liq_files{y}), k, NbUpSamples, fluo_FieldNames, CellLengthLiq);
    temp=trapz(MeanFimXpilHliq(y,:));
    MeanFimXpilHliq(y,:)=MeanFimXpilHliq(y,:)/temp;
    [MeanFimXcpdAliq(y,:), StdFimXcpdAliq(y,:), NFimXcpdAliq(y), ProfileFimXcpdAliq.(char(fields(y))), FluoMeansFimXcpdAliq.(char(fields(y))), CellWidthFimXcpdAliq.(char(fields(y))), CellLengthFimXcpdAliq.(char(fields(y))), CellIDFimXcpdAliq.(char(fields(y)))]=getMeanProfile(strcat(data_root_path, fimX_cpdA_liq_files{y}), k, NbUpSamples, fluo_FieldNames, CellLengthLiq);
    temp=trapz(MeanFimXcpdAliq(y,:));
    MeanFimXcpdAliq(y,:)=MeanFimXcpdAliq(y,:)/temp;
    [MeanFimXcpdAsol(y,:), StdFimXcpdAsol(y,:), NFimXcpdAsol(y), ProfileFimXcpdAsol.(char(fields(y))), FluoMeansFimXcpdAsol.(char(fields(y))), CellWidthFimXcpdAsol.(char(fields(y))), CellLengthFimXcpdAsol.(char(fields(y))), CellIDFimXcpdAsol.(char(fields(y)))]=getMeanProfile(strcat(data_root_path, fimX_cpdA_sol_files{y}), k, NbUpSamples, fluo_FieldNames, CellLengthSol);
    temp=trapz(MeanFimXcpdAsol(y,:));
    MeanFimXcpdAsol(y,:)=MeanFimXcpdAsol(y,:)/temp;
    [MeanFimXpilGcpdAliq(y,:), StdFimXpilGcpdAliq(y,:), NFimXpilGcpdAliq(y), ProfileFimXpilGcpdAliq.(char(fields(y))), FluoMeansFimXpilGcpdAliq.(char(fields(y))), CellWidthFimXpilGcpdAliq.(char(fields(y))), CellLengthFimXpilGcpdAliq.(char(fields(y))), CellIDFimXpilGcpdAliq.(char(fields(y)))]=getMeanProfile(strcat(data_root_path, fimX_pilGcpdA_liq_files{y}), k, NbUpSamples, fluo_FieldNames, CellLengthLiq);
    temp=trapz(MeanFimXpilGcpdAliq(y,:));
    MeanFimXpilGcpdAliq(y,:)=MeanFimXpilGcpdAliq(y,:)/temp;
    [MeanFimXpilGcpdAsol(y,:), StdFimXpilGcpdAsol(y,:), NFimXpilGcpdAsol(y), ProfileFimXpilGcpdAsol.(char(fields(y))), FluoMeansFimXpilGcpdAsol.(char(fields(y))), CellWidthFimXpilGcpdAsol.(char(fields(y))), CellLengthFimXpilGcpdAsol.(char(fields(y))), CellIDFimXpilGcpdAsol.(char(fields(y)))]=getMeanProfile(strcat(data_root_path, fimX_pilGcpdA_sol_files{y}), k, NbUpSamples, fluo_FieldNames, CellLengthSol);
    temp=trapz(MeanFimXpilGcpdAsol(y,:));
    MeanFimXpilGcpdAsol(y,:)=MeanFimXpilGcpdAsol(y,:)/temp;
    
    [MeanPilBliq(y,:), StdPilBliq(y,:), NpilBliq(y), ProfilePilBliq.(char(fields(y))), FluoMeansPilBliq.(char(fields(y))), CellWidthPilBliq.(char(fields(y))), CellLengthPilBliq.(char(fields(y))), CellIDPilBliq.(char(fields(y)))]=getMeanProfile(strcat(data_root_path, pilB_liq_files{y}), k, NbUpSamples, fluo_FieldNames, CellLengthLiq);
    temp=trapz(MeanPilBliq(y,:));
    MeanPilBliq(y,:)=MeanPilBliq(y,:)/temp;
    [MeanPilBsol(y,:), StdPilBsol(y,:), NpilBsol(y), ProfilePilBsol.(char(fields(y))), FluoMeansPilBsol.(char(fields(y))), CellWidthPilBsol.(char(fields(y))), CellLengthPilBsol.(char(fields(y))), CellIDPilBsol.(char(fields(y)))]=getMeanProfile(strcat(data_root_path, pilB_sol_files{y}), k, NbUpSamples, fluo_FieldNames, CellLengthSol);
    temp=trapz(MeanPilBsol(y,:));
    MeanPilBsol(y,:)=MeanPilBsol(y,:)/temp;
    [MeanPilBpilHliq(y,:), StdPilBpilHliq(y,:), NpilBpilHliq(y), ProfilePilBpilHliq.(char(fields(y))), FluoMeansPilBpilHliq.(char(fields(y))), CellWidthPilBpilHliq.(char(fields(y))), CellLengthPilBpilHliq.(char(fields(y))), CellIDPilBpilHliq.(char(fields(y)))]=getMeanProfile(strcat(data_root_path, pilB_pilH_liq_files{y}), k, NbUpSamples, fluo_FieldNames, CellLengthLiq);
    temp=trapz(MeanPilBpilHliq(y,:));
    MeanPilBpilHliq(y,:)=MeanPilBpilHliq(y,:)/temp;  
    [MeanPilBcpdAliq(y,:), StdPilBcpdAliq(y,:), NpilBcpdAliq(y), ProfilePilBcpdAliq.(char(fields(y))), FluoMeansPilBcpdAliq.(char(fields(y))), CellWidthPilBcpdAliq.(char(fields(y))), CellLengthPilBcpdAliq.(char(fields(y))), CellIDPilBcpdAliq.(char(fields(y)))]=getMeanProfile(strcat(data_root_path, pilB_cpdA_liq_files{y}), k, NbUpSamples, fluo_FieldNames, CellLengthLiq);
    temp=trapz(MeanPilBcpdAliq(y,:));
    MeanPilBcpdAliq(y,:)=MeanPilBcpdAliq(y,:)/temp;
    [MeanPilBcpdAsol(y,:), StdPilBcpdAsol(y,:), NpilBcpdAsol(y), ProfilePilBcpdAsol.(char(fields(y))), FluoMeansPilBcpdAsol.(char(fields(y))), CellWidthPilBcpdAsol.(char(fields(y))), CellLengthPilBcpdAsol.(char(fields(y))), CellIDPilBcpdAsol.(char(fields(y)))]=getMeanProfile(strcat(data_root_path, pilB_cpdA_sol_files{y}), k, NbUpSamples, fluo_FieldNames, CellLengthLiq);
    temp=trapz(MeanPilBcpdAsol(y,:));
    MeanPilBcpdAsol(y,:)=MeanPilBcpdAsol(y,:)/temp;
    [MeanPilBpilGcpdAliq(y,:), StdPilBpilGcpdAliq(y,:), NpilBpilGcpdAliq(y), ProfilePilBpilGcpdAliq.(char(fields(y))), FluoMeansPilBpilGcpdAliq.(char(fields(y))), CellWidthPilBpilGcpdAliq.(char(fields(y))), CellLengthPilBpilGcpdAliq.(char(fields(y))), CellIDPilBpilGcpdAliq.(char(fields(y)))]=getMeanProfile(strcat(data_root_path, pilB_pilGcpdA_liq_files{y}), k, NbUpSamples, fluo_FieldNames, CellLengthLiq);
    temp=trapz(MeanPilBpilGcpdAliq(y,:));
    MeanPilBpilGcpdAliq(y,:)=MeanPilBpilGcpdAliq(y,:)/temp;
    [MeanPilBpilGcpdAsol(y,:), StdPilBpilGcpdAsol(y,:), NpilBpilGcpdAsol(y), ProfilePilBpilGcpdAsol.(char(fields(y))), FluoMeansPilBpilGcpdAsol.(char(fields(y))), CellWidthPilBpilGcpdAsol.(char(fields(y))), CellLengthPilBpilGcpdAsol.(char(fields(y))), CellIDPilBpilGcpdAsol.(char(fields(y)))]=getMeanProfile(strcat(data_root_path, pilB_pilGcpdA_sol_files{y}), k, NbUpSamples, fluo_FieldNames, CellLengthLiq);
    temp=trapz(MeanPilBpilGcpdAsol(y,:));
    MeanPilBpilGcpdAsol(y,:)=MeanPilBpilGcpdAsol(y,:)/temp;
end

%% Compute polar ratios
BootN=300;
% PilB
[RatPilBliq, BootRatPilBliq, MeanRatPilBliq, stdRatPilBliq, PolarisationPilBliq, MeanPolarisationPilBliq]=polarRatios2(ProfilePilBliq, CellWidthPilBliq, CellLengthPilBliq, k, BootN);
[RatPilBsol, BootRatPilBsol, MeanRatPilBsol, stdRatPilBsol, PolarisationPilBsol, MeanPolarisationPilBsol]=polarRatios2(ProfilePilBsol, CellWidthPilBsol, CellLengthPilBsol, k, BootN);
[RatPilBpilHliq, BootRatPilBpilHliq, MeanRatPilBpilHliq, stdRatPilBpilHliq, PolarisationPilBpilHliq, MeanPolarisationPilBpilHliq]=polarRatios2(ProfilePilBpilHliq, CellWidthPilBpilHliq, CellLengthPilBpilHliq, k, BootN);
[RatPilBcpdAliq, BootRatPilBcpdAliq, MeanRatPilBcpdAliq, stdRatPilBcpdAliq, PolarisationPilBcpdAliq, MeanPolarisationPilBcpdAliq]=polarRatios2(ProfilePilBcpdAliq,  CellWidthPilBcpdAliq, CellLengthPilBcpdAliq, k, BootN);
[RatPilBcpdAsol, BootRatPilBcpdAsol, MeanRatPilBcpdAsol, stdRatPilBcpdAsol, PolarisationPilBcpdAsol, MeanPolarisationPilBcpdAsol]=polarRatios2(ProfilePilBcpdAsol,  CellWidthPilBcpdAsol, CellLengthPilBcpdAsol, k, BootN);
[RatPilBpilGcpdAliq, BootRatPilBpilGcpdAliq, MeanRatPilBpilGcpdAliq, stdRatPilBpilGcpdAliq, PolarisationPilBpilGcpdAliq, MeanPolarisationPilBpilGcpdAliq]=polarRatios2(ProfilePilBpilGcpdAliq,  CellWidthPilBpilGcpdAliq, CellLengthPilBpilGcpdAliq, k, BootN);
[RatPilBpilGcpdAsol, BootRatPilBpilGcpdAsol, MeanRatPilBpilGcpdAsol, stdRatPilBpilGcpdAsol, PolarisationPilBpilGcpdAsol, MeanPolarisationPilBpilGcpdAsol]=polarRatios2(ProfilePilBpilGcpdAsol,  CellWidthPilBpilGcpdAsol, CellLengthPilBpilGcpdAsol, k, BootN);

% FimX
[RatFimXliq, BootRatFimXliq, MeanRatFimXliq, stdRatFimXliq, PolarisationFimXliq, MeanPolarisationFimXliq]=polarRatios2(ProfileFimXliq, CellWidthFimXliq, CellLengthFimXliq, k, BootN);
[RatFimXsol, BootRatFimXsol, MeanRatFimXsol, stdRatFimXsol, PolarisationFimXsol, MeanPolarisationFimXsol]=polarRatios2(ProfileFimXsol, CellWidthFimXsol, CellLengthFimXsol, k, BootN);
[RatFimXpilHliq, BootRatFimXpilHliq, MeanRatFimXpilHliq, stdRatFimXpilHliq, PolarisationFimXpilHliq, MeanPolarisationFimXpilHliq]=polarRatios2(ProfileFimXpilHliq, CellWidthFimXpilHliq, CellLengthFimXpilHliq, k, BootN);
[RatFimXcpdAliq, BootRatFimXcpdAliq, MeanRatFimXcpdAliq, stdRatFimXcpdAliq, PolarisationFimXcpdAliq, MeanPolarisationFimXcpdAliq]=polarRatios2(ProfileFimXcpdAliq,  CellWidthFimXcpdAliq, CellLengthFimXcpdAliq, k, BootN);
[RatFimXcpdAsol, BootRatFimXcpdAsol, MeanRatFimXcpdAsol, stdRatFimXcpdAsol, PolarisationFimXcpdAsol, MeanPolarisationFimXcpdAsol]=polarRatios2(ProfileFimXcpdAsol,  CellWidthFimXcpdAsol, CellLengthFimXcpdAsol, k, BootN);
[RatFimXpilGcpdAliq, BootRatFimXpilGcpdAliq, MeanRatFimXpilGcpdAliq, stdRatFimXpilGcpdAliq, PolarisationFimXpilGcpdAliq, MeanPolarisationFimXpilGcpdAliq]=polarRatios2(ProfileFimXpilGcpdAliq,  CellWidthFimXpilGcpdAliq, CellLengthFimXpilGcpdAliq, k, BootN);
[RatFimXpilGcpdAsol, BootRatFimXpilGcpdAsol, MeanRatFimXpilGcpdAsol, stdRatFimXpilGcpdAsol, PolarisationFimXpilGcpdAsol, MeanPolarisationFimXpilGcpdAsol]=polarRatios2(ProfileFimXpilGcpdAsol,  CellWidthFimXpilGcpdAsol, CellLengthFimXpilGcpdAsol, k, BootN);

%% Plot profiles

% PilB_mNG
y_limit=max(max((MeanPilBpilHliq)+0.1*max(MeanPilBpilHliq),[],2));
alpha=0.4;
linewidth=2;
dim=1;
Legend = {'liq', 'sol', 'in pilH liq', 'in cpdA liq', 'in cpdA sol', 'in pilG cpdA liq', 'in pilG cpdA liq'};
Title = 'PilB in high cAMP';
Colors_high = [100 100 100; 20 20 20; 229 20 50; 120 170 60; 70 120 100; 209 103 209; 159 53 20];
Y_limit=[0, y_limit];
plotProfiles(Title, Legend, alpha, linewidth, dim, Colors_high, false, Y_limit, k, MeanPilBliq, MeanPilBsol, MeanPilBpilHliq, MeanPilBcpdAliq, MeanPilBcpdAsol, MeanPilBpilGcpdAliq, MeanPilBpilGcpdAsol)
saveas(gcf, strcat(save_path,Title), 'fig');
saveas(gcf, strcat(save_path,Title), 'epsc');


% FimX
Title = 'FimX in high cAMP';
plotProfiles(Title, Legend, alpha, linewidth, 1, Colors_high, false, Y_limit, k, MeanFimXliq, MeanFimXsol, MeanFimXpilHliq, MeanFimXcpdAliq, MeanFimXcpdAsol, MeanFimXpilGcpdAliq, MeanFimXpilGcpdAsol)
saveas(gcf, strcat(save_path,Title), 'fig');
saveas(gcf, strcat(save_path,Title), 'epsc');

%% Plot polar ratios

% General parameters
XLabel = 'polar ratio';
Binsize = 20;
Binwidth = 0.02;
Legend = {'liq', 'sol', 'in pilH liq', 'in cpdA liq', 'in cpdA sol', 'in pilG cpdA liq', 'in pilG cpdA liq'};
Y_limit=[0,0.4];
X_limit=[0,1];
Ylimit=[0, 1];

%PilB
Title = 'PilB polarity cpdA';
Legend = {'liq', 'sol', 'in pilH liq', 'in cpdA liq', 'in cpdA sol'};
Colors = Colors_high(1:5,:);
plotPolarity(Title, XLabel, Binsize, Binwidth, Colors, Legend, X_limit, Y_limit, RatPilBliq, RatPilBsol, RatPilBpilHliq, RatPilBcpdAliq, RatPilBcpdAsol)
saveas(gcf, strcat(save_path,Title), 'fig');
saveas(gcf, strcat(save_path,Title), 'svg');

Title = 'PilB polarity pilG cpdA';
Legend = {'liq', 'sol', 'in pilG cpdA liq', 'in pilG cpdA liq'};
Colors = Colors_high([1 2 6 7],:);
plotPolarity(Title, XLabel, Binsize, Binwidth, Colors, Legend, X_limit, Y_limit, RatPilBliq, RatPilBsol, RatPilBpilGcpdAliq, RatPilBpilGcpdAsol)
saveas(gcf, strcat(save_path,Title), 'fig');
saveas(gcf, strcat(save_path,Title), 'svg');

DataMarkerSize=8;
Legend = {'liq', 'sol', 'in pilH liq', 'in cpdA liq', 'in cpdA sol', 'in pilG cpdA liq', 'in pilG cpdA liq'};
Title='PilB polarity';
YLable='polar ratio';
plotPolarityMeans(Title, YLable, Ylimit, DataMarkerSize, Legend, Colors_high, MeanRatPilBliq, MeanRatPilBsol, MeanRatPilBpilHliq, MeanRatPilBcpdAliq, MeanRatPilBcpdAsol, MeanRatPilBpilGcpdAliq, MeanRatPilBpilGcpdAsol)
saveas(gcf, strcat(save_path,Title), 'fig');
saveas(gcf, strcat(save_path,Title), 'svg');

%FimX
Title = 'FimX polarity cpdA';
Legend = {'liq', 'sol', 'in pilH liq', 'in cpdA liq', 'in cpdA sol'};
Colors = Colors_high(1:5,:);
plotPolarity(Title, XLabel, Binsize, Binwidth, Colors, Legend, X_limit, Y_limit, RatFimXliq, RatFimXsol, RatFimXpilHliq, RatFimXcpdAliq, RatFimXcpdAsol)
saveas(gcf, strcat(save_path,Title), 'fig');
saveas(gcf, strcat(save_path,Title), 'svg');

Title = 'FimX polarity pilG cpdA';
Legend = {'liq', 'sol', 'in pilG cpdA liq', 'in pilG cpdA liq'};
Colors = Colors_high([1 2 6 7],:);
plotPolarity(Title, XLabel, Binsize, Binwidth, Colors, Legend, X_limit, Y_limit, RatFimXliq, RatFimXsol, RatFimXpilGcpdAliq, RatFimXpilGcpdAsol)
saveas(gcf, strcat(save_path,Title), 'fig');
saveas(gcf, strcat(save_path,Title), 'svg');

DataMarkerSize=8;
Legend = {'liq', 'sol', 'in pilH liq', 'in cpdA liq', 'in cpdA sol', 'in pilG cpdA liq', 'in pilG cpdA liq'};
Title='FimX polarity';
YLable='polar ratio';
plotPolarityMeans(Title, YLable, Ylimit, DataMarkerSize, Legend, Colors_high, MeanRatFimXliq, MeanRatFimXsol, MeanRatFimXpilHliq, MeanRatFimXcpdAliq, MeanRatFimXcpdAsol, MeanRatFimXpilGcpdAliq, MeanRatFimXpilGcpdAsol)
saveas(gcf, strcat(save_path,Title), 'fig');
saveas(gcf, strcat(save_path,Title), 'svg');

%% Plot polarisation index

% General parameters
XLabel = 'polarisation index';
Binsize = 20;
Binwidth = 0.01;
Legend = {'liq', 'sol', 'in pilH liq', 'in cpdA liq', 'in cpdA sol', 'in pilG cpdA liq', 'in pilG cpdA liq'};
Y_limit=[0,0.4];
X_limit=[0.5,1];
Ylimit=[0.5,1];

%PilB
Title = 'PilB polarisation cpdA';
Legend = {'liq', 'sol', 'in pilH liq', 'in cpdA liq', 'in cpdA sol'};
Colors = Colors_high(1:5,:);
plotPolarity(Title, XLabel, Binsize, Binwidth, Colors, Legend, X_limit, Y_limit, PolarisationPilBliq, PolarisationPilBsol, PolarisationPilBpilHliq, PolarisationPilBcpdAliq, PolarisationPilBcpdAsol)
saveas(gcf, strcat(save_path,Title), 'fig');
saveas(gcf, strcat(save_path,Title), 'svg');

Title = 'PilB polarisation pilG cpdA';
Legend = {'liq', 'sol', 'in pilG cpdA liq', 'in pilG cpdA liq'};
Colors = Colors_high([1 2 6 7],:);
plotPolarity(Title, XLabel, Binsize, Binwidth, Colors, Legend, X_limit, Y_limit, PolarisationPilBliq, PolarisationPilBsol, PolarisationPilBpilGcpdAliq, PolarisationPilBpilGcpdAsol)
saveas(gcf, strcat(save_path,Title), 'fig');
saveas(gcf, strcat(save_path,Title), 'svg');

DataMarkerSize=8;
Legend = {'liq', 'sol', 'in pilH liq', 'in cpdA liq', 'in cpdA sol', 'in pilG cpdA liq', 'in pilG cpdA liq'};
Title='PilB polarisation';
YLable='polar ratio';
plotPolarityMeans(Title, YLable, Ylimit, DataMarkerSize, Legend, Colors_high, MeanPolarisationPilBliq, MeanPolarisationPilBsol, MeanPolarisationPilBpilHliq, MeanPolarisationPilBcpdAliq, MeanPolarisationPilBcpdAsol, MeanPolarisationPilBpilGcpdAliq, MeanPolarisationPilBpilGcpdAsol)
saveas(gcf, strcat(save_path,Title), 'fig');
saveas(gcf, strcat(save_path,Title), 'svg');

%FimX
Title = 'FimX polarisation cpdA';
Legend = {'liq', 'sol', 'in pilH liq', 'in cpdA liq', 'in cpdA sol'};
Colors = Colors_high(1:5,:);
plotPolarity(Title, XLabel, Binsize, Binwidth, Colors, Legend, X_limit, Y_limit, PolarisationFimXliq, PolarisationFimXsol, PolarisationFimXpilHliq, PolarisationFimXcpdAliq, PolarisationFimXcpdAsol)
saveas(gcf, strcat(save_path,Title), 'fig');
saveas(gcf, strcat(save_path,Title), 'svg');

Title = 'FimX polarisation pilG cpdA';
Legend = {'liq', 'sol', 'in pilG cpdA liq', 'in pilG cpdA liq'};
Colors = Colors_high([1 2 6 7],:);
plotPolarity(Title, XLabel, Binsize, Binwidth, Colors, Legend, X_limit, Y_limit, PolarisationFimXliq, PolarisationFimXsol, PolarisationFimXpilGcpdAliq, PolarisationFimXpilGcpdAsol)
saveas(gcf, strcat(save_path,Title), 'fig');
saveas(gcf, strcat(save_path,Title), 'svg');

DataMarkerSize=8;
Legend = {'liq', 'sol', 'in pilH liq', 'in cpdA liq', 'in cpdA sol', 'in pilG cpdA liq', 'in pilG cpdA liq'};
Title='FimX polarisation';
YLable='polar ratio';
plotPolarityMeans(Title, YLable, Ylimit, DataMarkerSize, Legend, Colors_high, MeanPolarisationFimXliq, MeanPolarisationFimXsol, MeanPolarisationFimXpilHliq, MeanPolarisationFimXcpdAliq, MeanPolarisationFimXcpdAsol, MeanPolarisationFimXpilGcpdAliq, MeanPolarisationFimXpilGcpdAsol)
saveas(gcf, strcat(save_path,Title), 'fig');
saveas(gcf, strcat(save_path,Title), 'svg');

toc