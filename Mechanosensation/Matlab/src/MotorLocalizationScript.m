%% Initialization
clear all; close all;
clc;
tic
data_root_path='C:/Users/Iscia/Desktop/src/data_fimX';
save_path='C:/Users/Iscia/Desktop/src/figures with fimX/WithCorrection/';
% data_root_path='C:/Users/tala/Desktop/backstal/Download_code/src/data';

% mNeonGreen_fimX dataset files
fimX_liq_files={'/DataSet_mNG_fimX_fliC-_liq_BR=1.mat','/DataSet_mNG_fimX_fliC-_liq_BR=2.mat','/DataSet_mNG_fimX_fliC-_liq_BR=3.mat'};
fimX_sol_files={'/DataSet_mNG_fimX_fliC-_sol_BR=1.mat','/DataSet_mNG_fimX_fliC-_sol_BR=2.mat','/DataSet_mNG_fimX_fliC-_sol_BR=3.mat'};
fimX_pilH_liq_files={'/DataSet_mNG_fimX_pilH-fliC-_liq_BR=1.mat', '/DataSet_mNG_fimX_pilH-fliC-_liq_BR=2.mat', '/DataSet_mNG_fimX_pilH-fliC-_liq_BR=3.mat'};
fimX_pilG_liq_files={'/DataSet_mNG_fimX_pilG-fliC-_liq_BR=1.mat','/DataSet_mNG_fimX_pilG-fliC-_liq_BR=2.mat','/DataSet_mNG_fimX_pilG-fliC-_liq_BR=3.mat'};
fimX_cpdA_liq_files={'/DataSet_mNG_fimX_cpdA-fliC-_liq_BR=1.mat', '/DataSet_mNG_fimX_cpdA-fliC-_liq_BR=2.mat', '/DataSet_mNG_fimX_cpdA-fliC-_liq_BR=3.mat'};
fimX_pilGcpdA_liq_files={'/DataSet_mNG_fimX_pilG-cpdA-fliC-_liq_BR=1.mat', '/DataSet_mNG_fimX_pilG-cpdA-fliC-_liq_BR=2.mat', '/DataSet_mNG_fimX_pilG-cpdA-fliC-_liq_BR=3.mat'}; %Copied Biological replicates
% fimX_pilH_sol_files={'/DataSet_mNG_fimX_pilH-fliC-_sol_BR=1.mat', '/DataSet_mNG_fimX_pilH-fliC-_sol_BR=2.mat', '/DataSet_mNG_fimX_pilH-fliC-_sol_BR=3.mat'};
% fimX_pilG_sol_files={'/DataSet_mNG_fimX_pilG-fliC-_sol_BR=1.mat','/DataSet_mNG_fimX_pilG-fliC-_sol_BR=1.mat','/DataSet_mNG_fimX_pilG-fliC-_sol_BR=1.mat'}; %Copied Biological replicates
% fimX_cpdA_sol_files={'/DataSet_mNG_fimX_cpdA-fliC-_sol_BR=1.mat', '/DataSet_mNG_fimX_cpdA-fliC-_sol_BR=2.mat', '/DataSet_mNG_fimX_cpdA-fliC-_sol_BR=2.mat'}; %Copied Biological replicates
% fimX_pilGcpdA_sol_files={'/DataSet_mNG_fimX_pilG-cpdA-fliC-_sol_BR=1.mat', '/DataSet_mNG_fimX_pilG-cpdA-fliC-_sol_BR=2.mat', '/DataSet_mNG_fimX_pilG-cpdA-fliC-_sol_BR=2.mat'}; %Copied Biological replicates


% pilB_mNeonGreen dataset files
pilB_liq_files={'/DataSet_pilB_mNG_liq_BR=1.mat', '/DataSet_pilB_mNG_liq_BR=2.mat', '/DataSet_pilB_mNG_liq_BR=3.mat'};
pilB_sol_files={'/DataSet_pilB_mNG_3hsol_BR=1.mat', '/DataSet_pilB_mNG_3hsol_BR=2.mat', '/DataSet_pilB_mNG_3hsol_BR=3.mat'};
pilB_pilH_liq_files={'/DataSet_pilB_mNG_pilH-_liq_BR=1.mat', '/DataSet_pilB_mNG_pilH-_liq_BR=2.mat', '/DataSet_pilB_mNG_pilH-_liq_BR=3.mat'};
% pilB_pilH_sol_files={'/DataSet_pilB_mNG_pilH-fliC-_sol_BR=1.mat', '/DataSet_pilB_mNG_pilH-fliC-_sol_BR=2.mat', '/DataSet_pilB_mNG_pilH-fliC-_sol_BR=3.mat'};
pilB_pilG_liq_files={'/DataSet_pilB_mNG_pilG-_liq_BR=1.mat','/DataSet_pilB_mNG_pilG-_liq_BR=2.mat','/DataSet_pilB_mNG_pilG-_liq_BR=3.mat'};
% pilB_pilG_sol_files={'/DataSet_pilB_mNG_pilG-fliC-_sol_BR=1.mat','/DataSet_pilB_mNG_pilG-fliC-_sol_BR=1.mat','/DataSet_pilB_mNG_pilG-fliC-_sol_BR=1.mat'}; %Copied Biological replicates
% pilB_cyaB_liq_files={'/DataSet_pilB_mNG_cyaB-_liq_BR=1.mat', '/DataSet_pilB_mNG_cyaB-_liq_BR=2.mat', '/DataSet_pilB_mNG_cyaB-_liq_BR=3.mat'};
% pilB_cyaB_sol_files={'/DataSet_pilB_mNG_cyaB-_sol_BR=1.mat', '/DataSet_pilB_mNG_cyaB-_sol_BR=2.mat', '/DataSet_pilB_mNG_cyaB-_sol_BR=3.mat'};
pilB_cpdA_liq_files={'/DataSet_pilB_mNG_cpdA-_liq_BR=1.mat', '/DataSet_pilB_mNG_cpdA-_liq_BR=2.mat', '/DataSet_pilB_mNG_cpdA-_liq_BR=3.mat'};
pilB_cpdA_sol_files={'/DataSet_pilB_mNG_cpdA-_sol_BR=1.mat', '/DataSet_pilB_mNG_cpdA-_sol_BR=2.mat', '/DataSet_pilB_mNG_cpdA-_sol_BR=3.mat'};
pilB_pilGcpdA_liq_files={'/DataSet_pilB_mNG_pilG-cpdA-fliC-_liq_BR=1.mat', '/DataSet_pilB_mNG_pilG-cpdA-fliC-_liq_BR=2.mat', '/DataSet_pilB_mNG_pilG-cpdA-fliC-_liq_BR=3.mat'};
% pilB_pilGcpdA_sol_files={'/DataSet_pilB_mNG_pilG-cpdA-fliC-_sol_BR=1.mat', '/DataSet_pilB_mNG_pilG-cpdA-fliC-_sol_BR=2.mat', '/DataSet_pilB_mNG_pilG-cpdA-fliC-_sol_BR=2.mat'}; %Copied Biological replicates
% pilB_0_0ara_files={'/DataSet_pilB-_pilB_mNG_0ara_BR=1.mat'};
% pilB_0_01ara_files={'/DataSet_pilB-_pilB_mNG_0-01ara_BR=1.mat'};
% pilB_0_03ara_files={'/DataSet_pilB-_pilB_mNG_0-03ara_BR=1.mat'};
% pilB_0_1ara_files={'/DataSet_pilB-_pilB_mNG_0-1ara_BR=1.mat'};

% mNeonGreen_pilT dataset files
% pilT_liq_files={'/DataSet_mNG_pilT_liq_BR=1.mat', '/DataSet_mNG_pilT_liq_BR=2.mat', '/DataSet_mNG_pilT_liq_BR=3.mat'};
% pilT_pilH_liq_files={'/DataSet_mNG_pilT_pilH-_liq_BR=1.mat', '/DataSet_mNG_pilT_pilH-_liq_BR=2.mat', '/DataSet_mNG_pilT_pilH-_liq_BR=3.mat'};
% pilT_pilG_liq_files={'/DataSet_mNG_pilT_pilG-_liq_BR=1.mat', '/DataSet_mNG_pilT_pilG-_liq_BR=2.mat', '/DataSet_mNG_pilT_pilG-_liq_BR=3.mat'};
% pilT_pilH_sol_files={'/DataSet_mNG_pilT_pilH-_sol_BR=1.mat', '/DataSet_mNG_pilT_pilH-_sol_BR=2.mat', '/DataSet_mNG_pilT_pilH-_sol_BR=3.mat'};
% pilT_pilG_sol_files={'/DataSet_mNG_pilT_pilG-_sol_BR=1.mat', '/DataSet_mNG_pilT_pilG-_sol_BR=2.mat', '/DataSet_mNG_pilT_pilG-_sol_BR=3.mat'};
% pilT_sol_files={'/DataSet_mNG_pilT_3hsol_BR=1.mat', '/DataSet_mNG_pilT_3hsol_BR=2.mat', '/DataSet_mNG_pilT_3hsol_BR=3.mat'};
% pilT_cyaB_liq_files={'/DataSet_mNG_pilT_cyaB-_liq_BR=1.mat', '/DataSet_mNG_pilT_cyaB-_liq_BR=2.mat', '/DataSet_mNG_pilT_cyaB-_liq_BR=3.mat'};
% pilT_cyaB_sol_files={'/DataSet_mNG_pilT_cyaB-_sol_BR=1.mat', '/DataSet_mNG_pilT_cyaB-_sol_BR=2.mat', '/DataSet_mNG_pilT_cyaB-_sol_BR=3.mat'};
% pilT_cpdA_liq_files={'/DataSet_mNG_pilT_cpdA-_liq_BR=1.mat', '/DataSet_mNG_pilT_cpdA-_liq_BR=2.mat', '/DataSet_mNG_pilT_cpdA-_liq_BR=3.mat'};
% pilT_cpdA_sol_files={'/DataSet_mNG_pilT_cpdA-_sol_BR=1.mat', '/DataSet_mNG_pilT_cpdA-_sol_BR=2.mat', '/DataSet_mNG_pilT_cpdA-_sol_BR=3.mat'};

% mNeonGreen_pilH dataset files
pilH_liq_files={'/DataSet_mNG_pilH_liq_BR=1.mat', '/DataSet_mNG_pilH_liq_BR=2.mat', '/DataSet_mNG_pilH_liq_BR=3.mat'};
pilH_sol_files={'/DataSet_mNG_pilH_sol_BR=1.mat', '/DataSet_mNG_pilH_sol_BR=2.mat', '/DataSet_mNG_pilH_sol_BR=3.mat'};

% mNeonGreen_pilH dataset files
pilG_liq_files={'/DataSet_mNG_pilG_liq_BR=1.mat', '/DataSet_mNG_pilG_liq_BR=2.mat', '/DataSet_mNG_pilG_liq_BR=3.mat'};
pilG_sol_files={'/DataSet_mNG_pilG_sol_BR=1.mat', '/DataSet_mNG_pilG_sol_BR=2.mat', '/DataSet_mNG_pilG_sol_BR=3.mat'};

% Field name of fluorescence profile data in the BacStalk Struct Dataset
fluo_FieldNames='MedialAxisIntensity_mNeonGreen';

%% Compute profile stats
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
%     [MeanFimXpilHsol(y,:), StdFimXpilHsol(y,:), NFimXpilHsol(y), ProfileFimXpilHsol.(char(fields(y))), FluoMeansFimXpilHsol.(char(fields(y))), CellWidthFimXpilHsol.(char(fields(y))), CellLengthFimXpilHsol.(char(fields(y))), CellIDFimXpilHsol.(char(fields(y)))]=getMeanProfile(strcat(data_root_path, fimX_pilH_sol_files{y}), k, NbUpSamples, fluo_FieldNames, CellLengthSol);
%     temp=trapz(MeanFimXpilHsol(y,:));
%     MeanFimXpilHsol(y,:)=MeanFimXpilHsol(y,:)/temp; 
    [MeanFimXpilGliq(y,:), StdFimXpilGliq(y,:), NFimXpilGliq(y), ProfileFimXpilGliq.(char(fields(y))), FluoMeansFimXpilGliq.(char(fields(y))), CellWidthFimXpilGliq.(char(fields(y))), CellLengthFimXpilGliq.(char(fields(y))), CellIDFimXpilGliq.(char(fields(y)))]=getMeanProfile(strcat(data_root_path, fimX_pilG_liq_files{y}), k, NbUpSamples, fluo_FieldNames, CellLengthLiq);
    temp=trapz(MeanFimXpilGliq(y,:));
    MeanFimXpilGliq(y,:)=MeanFimXpilGliq(y,:)/temp;
%     [MeanFimXpilGsol(y,:), StdFimXpilGsol(y,:), NFimXpilGsol(y), ProfileFimXpilGsol.(char(fields(y))), FluoMeansFimXpilGsol.(char(fields(y))), CellWidthFimXpilGsol.(char(fields(y))), CellLengthFimXpilGsol.(char(fields(y))), CellIDFimXpilGsol.(char(fields(y)))]=getMeanProfile(strcat(data_root_path, fimX_pilG_sol_files{y}), k, NbUpSamples, fluo_FieldNames, CellLengthSol);
%     temp=trapz(MeanFimXpilGsol(y,:));
%     MeanFimXpilGsol(y,:)=MeanFimXpilGsol(y,:)/temp;
    [MeanFimXcpdAliq(y,:), StdFimXcpdAliq(y,:), NFimXcpdAliq(y), ProfileFimXcpdAliq.(char(fields(y))), FluoMeansFimXcpdAliq.(char(fields(y))), CellWidthFimXcpdAliq.(char(fields(y))), CellLengthFimXcpdAliq.(char(fields(y))), CellIDFimXcpdAliq.(char(fields(y)))]=getMeanProfile(strcat(data_root_path, fimX_cpdA_liq_files{y}), k, NbUpSamples, fluo_FieldNames, CellLengthLiq);
    temp=trapz(MeanFimXcpdAliq(y,:));
    MeanFimXcpdAliq(y,:)=MeanFimXcpdAliq(y,:)/temp;
%     [MeanFimXcpdAsol(y,:), StdFimXcpdAsol(y,:), NFimXcpdAsol(y), ProfileFimXcpdAsol.(char(fields(y))), FluoMeansFimXcpdAsol.(char(fields(y))), CellWidthFimXcpdAsol.(char(fields(y))), CellLengthFimXcpdAsol.(char(fields(y))), CellIDFimXcpdAsol.(char(fields(y)))]=getMeanProfile(strcat(data_root_path, fimX_cpdA_sol_files{y}), k, NbUpSamples, fluo_FieldNames, CellLengthSol);
%     temp=trapz(MeanFimXcpdAsol(y,:));
%     MeanFimXcpdAsol(y,:)=MeanFimXcpdAsol(y,:)/temp;
    [MeanFimXpilGcpdAliq(y,:), StdFimXpilGcpdAliq(y,:), NFimXpilGcpdAliq(y), ProfileFimXpilGcpdAliq.(char(fields(y))), FluoMeansFimXpilGcpdAliq.(char(fields(y))), CellWidthFimXpilGcpdAliq.(char(fields(y))), CellLengthFimXpilGcpdAliq.(char(fields(y))), CellIDFimXpilGcpdAliq.(char(fields(y)))]=getMeanProfile(strcat(data_root_path, fimX_pilGcpdA_liq_files{y}), k, NbUpSamples, fluo_FieldNames, CellLengthLiq);
    temp=trapz(MeanFimXpilGcpdAliq(y,:));
    MeanFimXpilGcpdAliq(y,:)=MeanFimXpilGcpdAliq(y,:)/temp;
%     [MeanFimXpilGcpdAsol(y,:), StdFimXpilGcpdAsol(y,:), NFimXpilGcpdAsol(y), ProfileFimXpilGcpdAsol.(char(fields(y))), FluoMeansFimXpilGcpdAsol.(char(fields(y))), CellWidthFimXpilGcpdAsol.(char(fields(y))), CellLengthFimXpilGcpdAsol.(char(fields(y))), CellIDFimXpilGcpdAsol.(char(fields(y)))]=getMeanProfile(strcat(data_root_path, fimX_pilGcpdA_sol_files{y}), k, NbUpSamples, fluo_FieldNames, CellLengthSol);
%     temp=trapz(MeanFimXpilGcpdAsol(y,:));
%     MeanFimXpilGcpdAsol(y,:)=MeanFimXpilGcpdAsol(y,:)/temp;
    
    [MeanPilBliq(y,:), StdPilBliq(y,:), NpilBliq(y), ProfilePilBliq.(char(fields(y))), FluoMeansPilBliq.(char(fields(y))), CellWidthPilBliq.(char(fields(y))), CellLengthPilBliq.(char(fields(y))), CellIDPilBliq.(char(fields(y)))]=getMeanProfile(strcat(data_root_path, pilB_liq_files{y}), k, NbUpSamples, fluo_FieldNames, CellLengthLiq);
    temp=trapz(MeanPilBliq(y,:));
    MeanPilBliq(y,:)=MeanPilBliq(y,:)/temp;
    [MeanPilBsol(y,:), StdPilBsol(y,:), NpilBsol(y), ProfilePilBsol.(char(fields(y))), FluoMeansPilBsol.(char(fields(y))), CellWidthPilBsol.(char(fields(y))), CellLengthPilBsol.(char(fields(y))), CellIDPilBsol.(char(fields(y)))]=getMeanProfile(strcat(data_root_path, pilB_sol_files{y}), k, NbUpSamples, fluo_FieldNames, CellLengthSol);
    temp=trapz(MeanPilBsol(y,:));
    MeanPilBsol(y,:)=MeanPilBsol(y,:)/temp;
    [MeanPilBpilHliq(y,:), StdPilBpilHliq(y,:), NpilBpilHliq(y), ProfilePilBpilHliq.(char(fields(y))), FluoMeansPilBpilHliq.(char(fields(y))), CellWidthPilBpilHliq.(char(fields(y))), CellLengthPilBpilHliq.(char(fields(y))), CellIDPilBpilHliq.(char(fields(y)))]=getMeanProfile(strcat(data_root_path, pilB_pilH_liq_files{y}), k, NbUpSamples, fluo_FieldNames, CellLengthLiq);
    temp=trapz(MeanPilBpilHliq(y,:));
    MeanPilBpilHliq(y,:)=MeanPilBpilHliq(y,:)/temp;  
    [MeanPilBpilGliq(y,:), StdPilBpilGliq(y,:), NpilBpilGliq(y), ProfilePilBpilGliq.(char(fields(y))), FluoMeansPilBpilGliq.(char(fields(y))), CellWidthPilBpilGliq.(char(fields(y))), CellLengthPilBpilGliq.(char(fields(y))), CellIDPilBpilGliq.(char(fields(y)))]=getMeanProfile(strcat(data_root_path, pilB_pilG_liq_files{y}), k, NbUpSamples, fluo_FieldNames, CellLengthLiq);
    temp=trapz(MeanPilBpilGliq(y,:));
    MeanPilBpilGliq(y,:)=MeanPilBpilGliq(y,:)/temp;    
%     [MeanPilBcyaBliq(y,:), StdPilBcyaBliq(y,:), NpilBcyaBliq(y), ProfilePilBcyaBliq.(char(fields(y))), FluoMeansPilBcyaBliq.(char(fields(y))), CellWidthPilBcyaBliq.(char(fields(y))), CellLengthPilBcyaBliq.(char(fields(y))), CellIDPilBcyaBliq.(char(fields(y)))]=getMeanProfile(strcat(data_root_path, pilB_cyaB_liq_files{y}), k, NbUpSamples, fluo_FieldNames, CellLengthLiq);
%     temp=trapz(MeanPilBcyaBliq(y,:));
%     MeanPilBcyaBliq(y,:)=MeanPilBcyaBliq(y,:)/temp;    
    [MeanPilBcpdAliq(y,:), StdPilBcpdAliq(y,:), NpilBcpdAliq(y), ProfilePilBcpdAliq.(char(fields(y))), FluoMeansPilBcpdAliq.(char(fields(y))), CellWidthPilBcpdAliq.(char(fields(y))), CellLengthPilBcpdAliq.(char(fields(y))), CellIDPilBcpdAliq.(char(fields(y)))]=getMeanProfile(strcat(data_root_path, pilB_cpdA_liq_files{y}), k, NbUpSamples, fluo_FieldNames, CellLengthLiq);
    temp=trapz(MeanPilBcpdAliq(y,:));
    MeanPilBcpdAliq(y,:)=MeanPilBcpdAliq(y,:)/temp;
    [MeanPilBpilGcpdAliq(y,:), StdPilBpilGcpdAliq(y,:), NpilBpilGcpdAliq(y), ProfilePilBpilGcpdAliq.(char(fields(y))), FluoMeansPilBpilGcpdAliq.(char(fields(y))), CellWidthPilBpilGcpdAliq.(char(fields(y))), CellLengthPilBpilGcpdAliq.(char(fields(y))), CellIDPilBpilGcpdAliq.(char(fields(y)))]=getMeanProfile(strcat(data_root_path, pilB_pilGcpdA_liq_files{y}), k, NbUpSamples, fluo_FieldNames, CellLengthLiq);
    temp=trapz(MeanPilBpilGcpdAliq(y,:));
    MeanPilBpilGcpdAliq(y,:)=MeanPilBpilGcpdAliq(y,:)/temp;
    [MeanPilBcpdAsol(y,:), StdPilBcpdAsol(y,:), NpilBcpdAsol(y), ProfilePilBcpdAsol.(char(fields(y))), FluoMeansPilBcpdAsol.(char(fields(y))), CellWidthPilBcpdAsol.(char(fields(y))), CellLengthPilBcpdAsol.(char(fields(y))), CellIDPilBcpdAsol.(char(fields(y)))]=getMeanProfile(strcat(data_root_path, pilB_cpdA_sol_files{y}), k, NbUpSamples, fluo_FieldNames, CellLengthLiq);
    temp=trapz(MeanPilBcpdAsol(y,:));
    MeanPilBcpdAsol(y,:)=MeanPilBcpdAsol(y,:)/temp;
    
    [MeanPilHliq(y,:), StdPilHliq(y,:), NpilHliq(y), ProfilePilHliq.(char(fields(y))), FluoMeansPilHliq.(char(fields(y))), CellWidthPilHliq.(char(fields(y))), CellLengthPilHliq.(char(fields(y))), CellIDPilHliq.(char(fields(y)))]=getMeanProfile(strcat(data_root_path, pilH_liq_files{y}), k, NbUpSamples, fluo_FieldNames, CellLengthLiq);
    temp=trapz(MeanPilHliq(y,:));
    MeanPilHliq(y,:)=MeanPilHliq(y,:)/temp;
    [MeanPilHsol(y,:), StdPilHsol(y,:), NpilHsol(y), ProfilePilHsol.(char(fields(y))), FluoMeansPilHsol.(char(fields(y))), CellWidthPilHsol.(char(fields(y))), CellLengthPilHsol.(char(fields(y))), CellIDPilHsol.(char(fields(y)))]=getMeanProfile(strcat(data_root_path, pilH_sol_files{y}), k, NbUpSamples, fluo_FieldNames, CellLengthLiq);
    temp=trapz(MeanPilHsol(y,:));
    MeanPilHsol(y,:)=MeanPilHsol(y,:)/temp;
    
    [MeanPilGliq(y,:), StdPilGliq(y,:), NpilGliq(y), ProfilePilGliq.(char(fields(y))), FluoMeansPilGliq.(char(fields(y))), CellWidthPilGliq.(char(fields(y))), CellLengthPilGliq.(char(fields(y))), CellIDPilGliq.(char(fields(y)))]=getMeanProfile(strcat(data_root_path, pilG_liq_files{y}), k, NbUpSamples, fluo_FieldNames, CellLengthLiq);
    temp=trapz(MeanPilGliq(y,:));
    MeanPilGliq(y,:)=MeanPilGliq(y,:)/temp;
    [MeanPilGsol(y,:), StdPilGsol(y,:), NpilGsol(y), ProfilePilGsol.(char(fields(y))), FluoMeansPilGsol.(char(fields(y))), CellWidthPilGsol.(char(fields(y))), CellLengthPilGsol.(char(fields(y))), CellIDPilGsol.(char(fields(y)))]=getMeanProfile(strcat(data_root_path, pilG_sol_files{y}), k, NbUpSamples, fluo_FieldNames, CellLengthLiq);
    temp=trapz(MeanPilGsol(y,:));
    MeanPilGsol(y,:)=MeanPilGsol(y,:)/temp;
end

%% Compute polar ratios
BootN=300;
% PilB
[RatPilBliq, BootRatPilBliq, MeanRatPilBliq, stdRatPilBliq, PolarisationPilBliq, MeanPolarisationPilBliq]=polarRatios2(ProfilePilBliq, CellWidthPilBliq, CellLengthPilBliq, k, BootN);
[RatPilBsol, BootRatPilBsol, MeanRatPilBsol, stdRatPilBsol, PolarisationPilBsol, MeanPolarisationPilBsol]=polarRatios2(ProfilePilBsol, CellWidthPilBsol, CellLengthPilBsol, k, BootN);
[RatPilBpilHliq, BootRatPilBpilHliq, MeanRatPilBpilHliq, stdRatPilBpilHliq, PolarisationPilBpilHliq, MeanPolarisationPilBpilHliq]=polarRatios2(ProfilePilBpilHliq, CellWidthPilBpilHliq, CellLengthPilBpilHliq, k, BootN);
[RatPilBpilGliq, BootRatPilBpilGliq, MeanRatPilBpilGliq, stdRatPilBpilGliq, PolarisationPilBpilGliq, MeanPolarisationPilBpilGliq]=polarRatios2(ProfilePilBpilGliq,  CellWidthPilBpilGliq, CellLengthPilBpilGliq, k, BootN);
[RatPilBcpdAliq, BootRatPilBcpdAliq, MeanRatPilBcpdAliq, stdRatPilBcpdAliq, PolarisationPilBcpdAliq, MeanPolarisationPilBcpdAliq]=polarRatios2(ProfilePilBcpdAliq,  CellWidthPilBcpdAliq, CellLengthPilBcpdAliq, k, BootN);
[RatPilBcpdAsol, BootRatPilBcpdAsol, MeanRatPilBcpdAsol, stdRatPilBcpdAsol, PolarisationPilBcpdAsol, MeanPolarisationPilBcpdAsol]=polarRatios2(ProfilePilBcpdAsol,  CellWidthPilBcpdAsol, CellLengthPilBcpdAsol, k, BootN);
[RatPilBpilGcpdAliq, BootRatPilBpilGcpdAliq, MeanRatPilBpilGcpdAliq, stdRatPilBpilGcpdAliq, PolarisationPilBpilGcpdAliq, MeanPolarisationPilBpilGcpdAliq]=polarRatios2(ProfilePilBpilGcpdAliq,  CellWidthPilBpilGcpdAliq, CellLengthPilBpilGcpdAliq, k, BootN);
%[RatPilBcyaBliq, BootRatPilBcyaBliq, MeanRatPilBcyaBliq, stdRatPilBcyaBliq]=polarRatios2(ProfilePilBcyaBliq,  CellWidthPilBcyaBliq, CellLengthPilBcyaBliq, k, BootN);

% FimX
[RatFimXliq, BootRatFimXliq, MeanRatFimXliq, stdRatFimXliq, PolarisationFimXliq, MeanPolarisationFimXliq]=polarRatios2(ProfileFimXliq, CellWidthFimXliq, CellLengthFimXliq, k, BootN);
[RatFimXsol, BootRatFimXsol, MeanRatFimXsol, stdRatFimXsol, PolarisationFimXsol, MeanPolarisationFimXsol]=polarRatios2(ProfileFimXsol, CellWidthFimXsol, CellLengthFimXsol, k, BootN);
[RatFimXpilHliq, BootRatFimXpilHliq, MeanRatFimXpilHliq, stdRatFimXpilHliq, PolarisationFimXpilHliq, MeanPolarisationFimXpilHliq]=polarRatios2(ProfileFimXpilHliq, CellWidthFimXpilHliq, CellLengthFimXpilHliq, k, BootN);
[RatFimXpilGliq, BootRatFimXpilGliq, MeanRatFimXpilGliq, stdRatFimXpilGliq, PolarisationFimXpilGliq, MeanPolarisationFimXpilGliq]=polarRatios2(ProfileFimXpilGliq,  CellWidthFimXpilGliq, CellLengthFimXpilGliq, k, BootN);
[RatFimXcpdAliq, BootRatFimXcpdAliq, MeanRatFimXcpdAliq, stdRatFimXcpdAliq, PolarisationFimXcpdAliq, MeanPolarisationFimXcpdAliq]=polarRatios2(ProfileFimXcpdAliq,  CellWidthFimXcpdAliq, CellLengthFimXcpdAliq, k, BootN);
[RatFimXpilGcpdAliq, BootRatFimXpilGcpdAliq, MeanRatFimXpilGcpdAliq, stdRatFimXpilGcpdAliq, PolarisationFimXpilGcpdAliq, MeanPolarisationFimXpilGcpdAliq]=polarRatios2(ProfileFimXpilGcpdAliq,  CellWidthFimXpilGcpdAliq, CellLengthFimXpilGcpdAliq, k, BootN);

% Response Regulators
[RatPilHliq, BootRatPilHliq, MeanRatPilHliq, stdRatPilHliq, PolarisationPilHliq, MeanPolarisationPilHliq]=polarRatios2(ProfilePilHliq, CellWidthPilHliq, CellLengthPilHliq, k, BootN);
[RatPilGliq, BootRatPilGliq, MeanRatPilGliq, stdRatPilGliq, PolarisationPilGliq, MeanPolarisationPilGliq]=polarRatios2(ProfilePilGliq,  CellWidthPilGliq, CellLengthPilGliq, k, BootN);
[RatPilHsol, BootRatPilHsol, MeanRatPilHsol, stdRatPilHsol, PolarisationPilHsol, MeanPolarisationPilHsol]=polarRatios2(ProfilePilHsol, CellWidthPilHsol, CellLengthPilHsol, k, BootN);
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
Legend = {'pilH sol', 'pilH liq', 'pilG liq', 'pilG sol'};
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
Y_limit=[0,0.4];
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
Colors_high = [15 67 20; 229 20 50; 120 170 60; 209 103 209];
Lengend = {'solid','in pilH liq','in cpdA liq','in pilg-cpdA-flic- liq'};
plotPolarity(Title, XLabel, Binsize, Binwidth, Colors_high, Lengend, X_limit, Y_limit, RatPilBsol, RatPilBpilHliq, RatPilBcpdAliq, RatPilBpilGcpdAliq)
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
Y_limit=[0,0.4];
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
Colors_high = [15 67 20; 229 20 50; 120 170 60; 209 103 209];
Lengend = {'solid','in pilH liq','in cpdA liq','in pilg-cpdA-flic- liq'};
plotPolarity(Title, XLabel, Binsize, Binwidth, Colors_high, Lengend, X_limit, Y_limit, PolarisationPilBsol, PolarisationPilBpilHliq, PolarisationPilBcpdAliq, PolarisationPilBpilGcpdAliq)
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
Colors = [15 67 20; 15 67 20; 229 20 50; 120 170 60; 100 150 40; 209 103 209; 20 255 50];
plotPolarityMeans(Title, YLable, Ylimit, DataMarkerSize, Legends, Colors, MeanPolarisationFimXliq, MeanPolarisationFimXsol, MeanPolarisationFimXpilHliq, MeanPolarisationFimXcpdAliq, MeanPolarisationFimXpilGcpdAliq, MeanPolarisationFimXpilGliq)
saveas(gcf, strcat(save_path,Title), 'fig');
saveas(gcf, strcat(save_path,Title), 'svg');
%%
toc