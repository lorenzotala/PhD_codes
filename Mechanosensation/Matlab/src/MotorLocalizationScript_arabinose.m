%% Initialization
clear all; close all;
clc;
tic
data_root_path='C:/Users/lorenzo/Desktop/src/data_fimX';
% save_path='C:/Users/lorenzo/Desktop/src/figures with fimX/WithCorrection/New Graph/';
% data_root_path='C:/Users/tala/Desktop/backstal/Download_code/src/data';

% mNeonGreen_fimX dataset files
fimX_liq_files={'/DataSet_mNG_fimX_fliC-_liq_BR=1.mat','/DataSet_mNG_fimX_fliC-_liq_BR=2.mat','/DataSet_mNG_fimX_fliC-_liq_BR=3.mat'};
fimX_sol_files={'/DataSet_mNG_fimX_fliC-_sol_BR=1.mat','/DataSet_mNG_fimX_fliC-_sol_BR=2.mat','/DataSet_mNG_fimX_fliC-_sol_BR=3.mat'};
fimX_pilH_liq_files={'/DataSet_mNG_fimX_pilH-fliC-_liq_BR=1.mat', '/DataSet_mNG_fimX_pilH-fliC-_liq_BR=2.mat', '/DataSet_mNG_fimX_pilH-fliC-_liq_BR=3.mat'};
fimX_pilG_liq_files={'/DataSet_mNG_fimX_pilG-fliC-_liq_BR=1.mat','/DataSet_mNG_fimX_pilG-fliC-_liq_BR=2.mat','/DataSet_mNG_fimX_pilG-fliC-_liq_BR=3.mat'};
fimX_cpdA_liq_files={'/DataSet_mNG_fimX_cpdA-fliC-_liq_BR=1.mat', '/DataSet_mNG_fimX_cpdA-fliC-_liq_BR=2.mat', '/DataSet_mNG_fimX_cpdA-fliC-_liq_BR=3.mat'};
fimX_pilGcpdA_liq_files={'/DataSet_mNG_fimX_pilG-cpdA-fliC-_liq_BR=1.mat', '/DataSet_mNG_fimX_pilG-cpdA-fliC-_liq_BR=2.mat', '/DataSet_mNG_fimX_pilG-cpdA-fliC-_liq_BR=3.mat'};
fimX_pilHcyaB_liq_files={'/DataSet_mNG_fimX_pilH-cyaB-_liq_BR=1.mat', '/DataSet_mNG_fimX_pilH-cyaB-_liq_BR=2.mat', '/DataSet_mNG_fimX_pilH-cyaB-_liq_BR=3.mat'};

% pilB_mNeonGreen dataset files
pilB_liq_files={'/DataSet_pilB_mNG_liq_BR=1.mat', '/DataSet_pilB_mNG_liq_BR=2.mat', '/DataSet_pilB_mNG_liq_BR=3.mat'};
pilB_sol_files={'/DataSet_pilB_mNG_3hsol_BR=1.mat', '/DataSet_pilB_mNG_3hsol_BR=2.mat', '/DataSet_pilB_mNG_3hsol_BR=3.mat'};
pilB_pilH_liq_files={'/DataSet_pilB_mNG_pilH-_liq_BR=1.mat', '/DataSet_pilB_mNG_pilH-_liq_BR=2.mat', '/DataSet_pilB_mNG_pilH-_liq_BR=3.mat'};
pilB_pilG_liq_files={'/DataSet_pilB_mNG_pilG-_liq_BR=1.mat','/DataSet_pilB_mNG_pilG-_liq_BR=2.mat','/DataSet_pilB_mNG_pilG-_liq_BR=3.mat'};
pilB_cpdA_liq_files={'/DataSet_pilB_mNG_cpdA-_liq_BR=1.mat', '/DataSet_pilB_mNG_cpdA-_liq_BR=2.mat', '/DataSet_pilB_mNG_cpdA-_liq_BR=3.mat'};
pilB_pilGcpdA_liq_files={'/DataSet_pilB_mNG_pilG-cpdA-fliC-_liq_BR=1.mat', '/DataSet_pilB_mNG_pilG-cpdA-fliC-_liq_BR=2.mat', '/DataSet_pilB_mNG_pilG-cpdA-fliC-_liq_BR=3.mat'};
pilB_pilHcyaB_liq_files={'/DataSet_pilB_mNG_pilH-cyaB-_liq_BR=1.mat', '/DataSet_pilB_mNG_pilH-cyaB-_liq_BR=2.mat', '/DataSet_pilB_mNG_pilH-cyaB-_liq_BR=3.mat'};

% Inducible pilB_mNG with arabinose
pilB_0_0ara_files={'/DataSet_pilB-_pilB_mNG_0ara_BR=1.mat'};
pilB_0_01ara_files={'/DataSet_pilB-_pilB_mNG_0-01ara_BR=1.mat'};
pilB_0_03ara_files={'/DataSet_pilB-_pilB_mNG_0-03ara_BR=1.mat'};
pilB_0_1ara_files={'/DataSet_pilB-_pilB_mNG_0-1ara_BR=1.mat'};

% mNeonGreen_pilT dataset files
pilT_liq_files={'/DataSet_mNG_pilT_liq_BR=1.mat', '/DataSet_mNG_pilT_liq_BR=2.mat', '/DataSet_mNG_pilT_liq_BR=3.mat'};
pilT_sol_files={'/DataSet_mNG_pilT_3hsol_BR=1.mat', '/DataSet_mNG_pilT_3hsol_BR=2.mat', '/DataSet_mNG_pilT_3hsol_BR=3.mat'};
pilT_pilH_liq_files={'/DataSet_mNG_pilT_pilH-_liq_BR=1.mat', '/DataSet_mNG_pilT_pilH-_liq_BR=2.mat', '/DataSet_mNG_pilT_pilH-_liq_BR=3.mat'};
pilT_pilG_liq_files={'/DataSet_mNG_pilT_pilG-_liq_BR=1.mat', '/DataSet_mNG_pilT_pilG-_liq_BR=2.mat', '/DataSet_mNG_pilT_pilG-_liq_BR=3.mat'};
pilT_cpdA_liq_files={'/DataSet_mNG_pilT_cpdA-_liq_BR=1.mat', '/DataSet_mNG_pilT_cpdA-_liq_BR=2.mat', '/DataSet_mNG_pilT_cpdA-_liq_BR=3.mat'};

% mNeonGreen_pilU dataset files
pilU_liq_files={'/DataSet_mNG_pilU_liq_BR=1.mat', '/DataSet_mNG_pilU_liq_BR=2.mat', '/DataSet_mNG_pilU_liq_BR=3.mat'};
pilU_sol_files={'/DataSet_mNG_pilU_3hsol_BR=1.mat', '/DataSet_mNG_pilU_3hsol_BR=2.mat', '/DataSet_mNG_pilU_3hsol_BR=3.mat'};
pilU_pilH_liq_files={'/DataSet_mNG_pilU_pilH-_liq_BR=1.mat', '/DataSet_mNG_pilU_pilH-_liq_BR=2.mat', '/DataSet_mNG_pilU_pilH-_liq_BR=3.mat'};
pilU_pilG_liq_files={'/DataSet_mNG_pilU_pilG-_liq_BR=1.mat', '/DataSet_mNG_pilU_pilG-_liq_BR=2.mat', '/DataSet_mNG_pilU_pilG-_liq_BR=3.mat'};
pilU_cpdA_liq_files={'/DataSet_mNG_pilU_cpdA-_liq_BR=1.mat', '/DataSet_mNG_pilU_cpdA-_liq_BR=2.mat', '/DataSet_mNG_pilU_cpdA-_liq_BR=3.mat'};

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
CellLengthLiq=5; %in �m;
CellLengthSol=5; %in �m;

fields=cell(Biological_reps, 1);
for i=1:Biological_reps
    name=strcat('BR',num2str(i));
    fields(i)= {name};
end

for y=1:Biological_reps
    %FimX
    [MeanFimXliq(y,:), StdFimXliq(y,:), NFimXliq(y), ProfileFimXliq.(char(fields(y))), FluoMeansFimXliq.(char(fields(y))), CellWidthFimXliq.(char(fields(y))), CellLengthFimXliq.(char(fields(y))), CellIDFimXliq.(char(fields(y)))]=getMeanProfile(strcat(data_root_path, fimX_liq_files{y}), k, NbUpSamples, fluo_FieldNames, CellLengthLiq);
    temp=trapz(MeanFimXliq(y,:));
    MeanFimXliq(y,:)=MeanFimXliq(y,:)/temp;
    [MeanFimXsol(y,:), StdFimXsol(y,:), NFimXsol(y), ProfileFimXsol.(char(fields(y))), FluoMeansFimXsol.(char(fields(y))), CellWidthFimXsol.(char(fields(y))), CellLengthFimXsol.(char(fields(y))), CellIDFimXsol.(char(fields(y)))]=getMeanProfile(strcat(data_root_path, fimX_sol_files{y}), k, NbUpSamples, fluo_FieldNames, CellLengthSol);
    temp=trapz(MeanFimXsol(y,:));
    MeanFimXsol(y,:)=MeanFimXsol(y,:)/temp;
    [MeanFimXpilHliq(y,:), StdFimXpilHliq(y,:), NFimXpilHliq(y), ProfileFimXpilHliq.(char(fields(y))), FluoMeansFimXpilHliq.(char(fields(y))), CellWidthFimXpilHliq.(char(fields(y))), CellLengthFimXpilHliq.(char(fields(y))), CellIDFimXpilHliq.(char(fields(y)))]=getMeanProfile(strcat(data_root_path, fimX_pilH_liq_files{y}), k, NbUpSamples, fluo_FieldNames, CellLengthLiq);
    temp=trapz(MeanFimXpilHliq(y,:));
    MeanFimXpilHliq(y,:)=MeanFimXpilHliq(y,:)/temp;
    [MeanFimXpilGliq(y,:), StdFimXpilGliq(y,:), NFimXpilGliq(y), ProfileFimXpilGliq.(char(fields(y))), FluoMeansFimXpilGliq.(char(fields(y))), CellWidthFimXpilGliq.(char(fields(y))), CellLengthFimXpilGliq.(char(fields(y))), CellIDFimXpilGliq.(char(fields(y)))]=getMeanProfile(strcat(data_root_path, fimX_pilG_liq_files{y}), k, NbUpSamples, fluo_FieldNames, CellLengthLiq);
    temp=trapz(MeanFimXpilGliq(y,:));
    MeanFimXpilGliq(y,:)=MeanFimXpilGliq(y,:)/temp;
    [MeanFimXcpdAliq(y,:), StdFimXcpdAliq(y,:), NFimXcpdAliq(y), ProfileFimXcpdAliq.(char(fields(y))), FluoMeansFimXcpdAliq.(char(fields(y))), CellWidthFimXcpdAliq.(char(fields(y))), CellLengthFimXcpdAliq.(char(fields(y))), CellIDFimXcpdAliq.(char(fields(y)))]=getMeanProfile(strcat(data_root_path, fimX_cpdA_liq_files{y}), k, NbUpSamples, fluo_FieldNames, CellLengthLiq);
    temp=trapz(MeanFimXcpdAliq(y,:));
    MeanFimXcpdAliq(y,:)=MeanFimXcpdAliq(y,:)/temp;
    [MeanFimXpilGcpdAliq(y,:), StdFimXpilGcpdAliq(y,:), NFimXpilGcpdAliq(y), ProfileFimXpilGcpdAliq.(char(fields(y))), FluoMeansFimXpilGcpdAliq.(char(fields(y))), CellWidthFimXpilGcpdAliq.(char(fields(y))), CellLengthFimXpilGcpdAliq.(char(fields(y))), CellIDFimXpilGcpdAliq.(char(fields(y)))]=getMeanProfile(strcat(data_root_path, fimX_pilGcpdA_liq_files{y}), k, NbUpSamples, fluo_FieldNames, CellLengthLiq);
    temp=trapz(MeanFimXpilGcpdAliq(y,:));
    MeanFimXpilGcpdAliq(y,:)=MeanFimXpilGcpdAliq(y,:)/temp;
    [MeanFimXpilHcyaBliq(y,:), StdFimXpilHcyaBliq(y,:), NFimXpilHcyaBliq(y), ProfileFimXpilHcyaBliq.(char(fields(y))), FluoMeansFimXpilHcyaBliq.(char(fields(y))), CellWidthFimXpilHcyaBliq.(char(fields(y))), CellLengthFimXpilHcyaBliq.(char(fields(y))), CellIDFimXpilHcyaBliq.(char(fields(y)))]=getMeanProfile(strcat(data_root_path, fimX_pilHcyaB_liq_files{y}), k, NbUpSamples, fluo_FieldNames, CellLengthLiq);
    temp=trapz(MeanFimXpilHcyaBliq(y,:));
    MeanFimXpilHcyaBliq(y,:)=MeanFimXpilHcyaBliq(y,:)/temp;
    
    %PilB
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
    [MeanPilBcpdAliq(y,:), StdPilBcpdAliq(y,:), NpilBcpdAliq(y), ProfilePilBcpdAliq.(char(fields(y))), FluoMeansPilBcpdAliq.(char(fields(y))), CellWidthPilBcpdAliq.(char(fields(y))), CellLengthPilBcpdAliq.(char(fields(y))), CellIDPilBcpdAliq.(char(fields(y)))]=getMeanProfile(strcat(data_root_path, pilB_cpdA_liq_files{y}), k, NbUpSamples, fluo_FieldNames, CellLengthLiq);
    temp=trapz(MeanPilBcpdAliq(y,:));
    MeanPilBcpdAliq(y,:)=MeanPilBcpdAliq(y,:)/temp;
    [MeanPilBpilGcpdAliq(y,:), StdPilBpilGcpdAliq(y,:), NpilBpilGcpdAliq(y), ProfilePilBpilGcpdAliq.(char(fields(y))), FluoMeansPilBpilGcpdAliq.(char(fields(y))), CellWidthPilBpilGcpdAliq.(char(fields(y))), CellLengthPilBpilGcpdAliq.(char(fields(y))), CellIDPilBpilGcpdAliq.(char(fields(y)))]=getMeanProfile(strcat(data_root_path, pilB_pilGcpdA_liq_files{y}), k, NbUpSamples, fluo_FieldNames, CellLengthLiq);
    temp=trapz(MeanPilBpilGcpdAliq(y,:));
    MeanPilBpilGcpdAliq(y,:)=MeanPilBpilGcpdAliq(y,:)/temp;
    [MeanPilBpilHcyaBliq(y,:), StdPilBpilHcyaBliq(y,:), NPilBpilHcyaBliq(y), ProfilePilBpilHcyaBliq.(char(fields(y))), FluoMeansPilBpilHcyaBliq.(char(fields(y))), CellWidthPilBpilHcyaBliq.(char(fields(y))), CellLengthPilBpilHcyaBliq.(char(fields(y))), CellIDPilBpilHcyaBliq.(char(fields(y)))]=getMeanProfile(strcat(data_root_path, pilB_pilHcyaB_liq_files{y}), k, NbUpSamples, fluo_FieldNames, CellLengthLiq);
    temp=trapz(MeanPilBpilHcyaBliq(y,:));
    MeanPilBpilHcyaBliq(y,:)=MeanPilBpilHcyaBliq(y,:)/temp;
    
    %PilU
    [MeanPilUliq(y,:), StdPilUliq(y,:), NpilUliq(y), ProfilePilUliq.(char(fields(y))), FluoMeansPilUliq.(char(fields(y))), CellWidthPilUliq.(char(fields(y))), CellLengthPilUliq.(char(fields(y))), CellIDPilUliq.(char(fields(y)))]=getMeanProfile(strcat(data_root_path, pilU_liq_files{y}), k, NbUpSamples, fluo_FieldNames, CellLengthLiq);
    temp=trapz(MeanPilUliq(y,:));
    MeanPilUliq(y,:)=MeanPilUliq(y,:)/temp;
    [MeanPilUsol(y,:), StdPilUsol(y,:), NpilUsol(y), ProfilePilUsol.(char(fields(y))), FluoMeansPilUsol.(char(fields(y))), CellWidthPilUsol.(char(fields(y))), CellLengthPilUsol.(char(fields(y))), CellIDPilUsol.(char(fields(y)))]=getMeanProfile(strcat(data_root_path, pilU_sol_files{y}), k, NbUpSamples, fluo_FieldNames, CellLengthSol);
    temp=trapz(MeanPilUsol(y,:));
    MeanPilUsol(y,:)=MeanPilUsol(y,:)/temp;
    [MeanPilUpilHliq(y,:), StdPilUpilHliq(y,:), NpilUpilHliq(y), ProfilePilUpilHliq.(char(fields(y))), FluoMeansPilUpilHliq.(char(fields(y))), CellWidthPilUpilHliq.(char(fields(y))), CellLengthPilUpilHliq.(char(fields(y))), CellIDPilUpilHliq.(char(fields(y)))]=getMeanProfile(strcat(data_root_path, pilU_pilH_liq_files{y}), k, NbUpSamples, fluo_FieldNames, CellLengthLiq);
    temp=trapz(MeanPilUpilHliq(y,:));
    MeanPilUpilHliq(y,:)=MeanPilUpilHliq(y,:)/temp;
    [MeanPilUpilGliq(y,:), StdPilUpilGliq(y,:), NpilUpilGliq(y), ProfilePilUpilGliq.(char(fields(y))), FluoMeansPilUpilGliq.(char(fields(y))), CellWidthPilUpilGliq.(char(fields(y))), CellLengthPilUpilGliq.(char(fields(y))), CellIDPilUpilGliq.(char(fields(y)))]=getMeanProfile(strcat(data_root_path, pilU_pilG_liq_files{y}), k, NbUpSamples, fluo_FieldNames, CellLengthLiq);
    temp=trapz(MeanPilUpilGliq(y,:));
    MeanPilUpilGliq(y,:)=MeanPilUpilGliq(y,:)/temp;  
    [MeanPilUcpdAliq(y,:), StdPilUcpdAliq(y,:), NpilUcpdAliq(y), ProfilePilUcpdAliq.(char(fields(y))), FluoMeansPilUcpdAliq.(char(fields(y))), CellWidthPilUcpdAliq.(char(fields(y))), CellLengthPilUcpdAliq.(char(fields(y))), CellIDPilUcpdAliq.(char(fields(y)))]=getMeanProfile(strcat(data_root_path, pilU_cpdA_liq_files{y}), k, NbUpSamples, fluo_FieldNames, CellLengthLiq);
    temp=trapz(MeanPilUcpdAliq(y,:));
    MeanPilUcpdAliq(y,:)=MeanPilUcpdAliq(y,:)/temp;
    
    %PilT
    [MeanPilTliq(y,:), StdPilTliq(y,:), NpilTliq(y), ProfilePilTliq.(char(fields(y))), FluoMeansPilTliq.(char(fields(y))), CellWidthPilTliq.(char(fields(y))), CellLengthPilTliq.(char(fields(y))), CellIDPilTliq.(char(fields(y)))]=getMeanProfile(strcat(data_root_path, pilT_liq_files{y}), k, NbUpSamples, fluo_FieldNames, CellLengthLiq);
    temp=trapz(MeanPilTliq(y,:));
    MeanPilTliq(y,:)=MeanPilTliq(y,:)/temp;
    [MeanPilTsol(y,:), StdPilTsol(y,:), NpilTsol(y), ProfilePilTsol.(char(fields(y))), FluoMeansPilTsol.(char(fields(y))), CellWidthPilTsol.(char(fields(y))), CellLengthPilTsol.(char(fields(y))), CellIDPilTsol.(char(fields(y)))]=getMeanProfile(strcat(data_root_path, pilT_sol_files{y}), k, NbUpSamples, fluo_FieldNames, CellLengthSol);
    temp=trapz(MeanPilTsol(y,:));
    MeanPilTsol(y,:)=MeanPilTsol(y,:)/temp;
    [MeanPilTpilHliq(y,:), StdPilTpilHliq(y,:), NpilTpilHliq(y), ProfilePilTpilHliq.(char(fields(y))), FluoMeansPilTpilHliq.(char(fields(y))), CellWidthPilTpilHliq.(char(fields(y))), CellLengthPilTpilHliq.(char(fields(y))), CellIDPilTpilHliq.(char(fields(y)))]=getMeanProfile(strcat(data_root_path, pilT_pilH_liq_files{y}), k, NbUpSamples, fluo_FieldNames, CellLengthLiq);
    temp=trapz(MeanPilTpilHliq(y,:));
    MeanPilTpilHliq(y,:)=MeanPilTpilHliq(y,:)/temp;
    [MeanPilTpilGliq(y,:), StdPilTpilGliq(y,:), NpilTpilGliq(y), ProfilePilTpilGliq.(char(fields(y))), FluoMeansPilTpilGliq.(char(fields(y))), CellWidthPilTpilGliq.(char(fields(y))), CellLengthPilTpilGliq.(char(fields(y))), CellIDPilTpilGliq.(char(fields(y)))]=getMeanProfile(strcat(data_root_path, pilT_pilG_liq_files{y}), k, NbUpSamples, fluo_FieldNames, CellLengthLiq);
    temp=trapz(MeanPilTpilGliq(y,:));
    MeanPilTpilGliq(y,:)=MeanPilTpilGliq(y,:)/temp;        
    [MeanPilTcpdAliq(y,:), StdPilTcpdAliq(y,:), NpilTcpdAliq(y), ProfilePilTcpdAliq.(char(fields(y))), FluoMeansPilTcpdAliq.(char(fields(y))), CellWidthPilTcpdAliq.(char(fields(y))), CellLengthPilTcpdAliq.(char(fields(y))), CellIDPilTcpdAliq.(char(fields(y)))]=getMeanProfile(strcat(data_root_path, pilT_cpdA_liq_files{y}), k, NbUpSamples, fluo_FieldNames, CellLengthLiq);
    temp=trapz(MeanPilTcpdAliq(y,:));
    MeanPilTcpdAliq(y,:)=MeanPilTcpdAliq(y,:)/temp;
    
    %PilH
    [MeanPilHliq(y,:), StdPilHliq(y,:), NpilHliq(y), ProfilePilHliq.(char(fields(y))), FluoMeansPilHliq.(char(fields(y))), CellWidthPilHliq.(char(fields(y))), CellLengthPilHliq.(char(fields(y))), CellIDPilHliq.(char(fields(y)))]=getMeanProfile(strcat(data_root_path, pilH_liq_files{y}), k, NbUpSamples, fluo_FieldNames, CellLengthLiq);
    temp=trapz(MeanPilHliq(y,:));
    MeanPilHliq(y,:)=MeanPilHliq(y,:)/temp;
    [MeanPilHsol(y,:), StdPilHsol(y,:), NpilHsol(y), ProfilePilHsol.(char(fields(y))), FluoMeansPilHsol.(char(fields(y))), CellWidthPilHsol.(char(fields(y))), CellLengthPilHsol.(char(fields(y))), CellIDPilHsol.(char(fields(y)))]=getMeanProfile(strcat(data_root_path, pilH_sol_files{y}), k, NbUpSamples, fluo_FieldNames, CellLengthLiq);
    temp=trapz(MeanPilHsol(y,:));
    MeanPilHsol(y,:)=MeanPilHsol(y,:)/temp;
    
    %PilG
    [MeanPilGliq(y,:), StdPilGliq(y,:), NpilGliq(y), ProfilePilGliq.(char(fields(y))), FluoMeansPilGliq.(char(fields(y))), CellWidthPilGliq.(char(fields(y))), CellLengthPilGliq.(char(fields(y))), CellIDPilGliq.(char(fields(y)))]=getMeanProfile(strcat(data_root_path, pilG_liq_files{y}), k, NbUpSamples, fluo_FieldNames, CellLengthLiq);
    temp=trapz(MeanPilGliq(y,:));
    MeanPilGliq(y,:)=MeanPilGliq(y,:)/temp;
    [MeanPilGsol(y,:), StdPilGsol(y,:), NpilGsol(y), ProfilePilGsol.(char(fields(y))), FluoMeansPilGsol.(char(fields(y))), CellWidthPilGsol.(char(fields(y))), CellLengthPilGsol.(char(fields(y))), CellIDPilGsol.(char(fields(y)))]=getMeanProfile(strcat(data_root_path, pilG_sol_files{y}), k, NbUpSamples, fluo_FieldNames, CellLengthLiq);
    temp=trapz(MeanPilGsol(y,:));
    MeanPilGsol(y,:)=MeanPilGsol(y,:)/temp;
end

%% Compute profiles for Inducible PilB_mNG
for y=1:1
    [MeanpilB_0_0ara(y,:), StdpilB_0_0ara(y,:), NpilB_0_0ara(y), ProfilePilB_0_0ara.(char(fields(y))), FluoMeansPilB_0_0ara.(char(fields(y))), CellWidthPilB_0_0ara.(char(fields(y))), CellLengthPilB_0_0ara.(char(fields(y))), CellIDPilB_0_0ara.(char(fields(y)))]=getMeanProfile(strcat(data_root_path, pilB_0_0ara_files{y}), k, NbUpSamples, fluo_FieldNames, CellLengthSol);
    temp=trapz(MeanpilB_0_0ara(y,:));
    MeanpilB_0_0ara(y,:)=MeanpilB_0_0ara(y,:)/temp;
    [MeanpilB_0_01ara(y,:), StdpilB_0_01ara(y,:), NpilB_0_01ara(y), ProfilePilB_0_01ara.(char(fields(y))), FluoMeansPilB_0_01ara.(char(fields(y))), CellWidthPilB_0_01ara.(char(fields(y))), CellLengthPilB_0_01ara.(char(fields(y))), CellIDPilB_0_01ara.(char(fields(y)))]=getMeanProfile(strcat(data_root_path, pilB_0_01ara_files{y}), k, NbUpSamples, fluo_FieldNames, CellLengthSol);
    temp=trapz(MeanpilB_0_01ara(y,:));
    MeanpilB_0_01ara(y,:)=MeanpilB_0_01ara(y,:)/temp;
    [MeanpilB_0_03ara(y,:), StdpilB_0_03ara(y,:), NpilB_0_03ara(y), ProfilePilB_0_03ara.(char(fields(y))), FluoMeansPilB_0_03ara.(char(fields(y))), CellWidthPilB_0_03ara.(char(fields(y))), CellLengthPilB_0_03ara.(char(fields(y))), CellIDPilB_0_03ara.(char(fields(y)))]=getMeanProfile(strcat(data_root_path, pilB_0_03ara_files{y}), k, NbUpSamples, fluo_FieldNames, CellLengthSol);
    temp=trapz(MeanpilB_0_03ara(y,:));
    MeanpilB_0_03ara(y,:)=MeanpilB_0_03ara(y,:)/temp;
    [MeanpilB_0_1ara(y,:), StdpilB_0_1ara(y,:), NpilB_0_1ara(y), ProfilePilB_0_1ara.(char(fields(y))), FluoMeansPilB_0_1ara.(char(fields(y))), CellWidthPilB_0_1ara.(char(fields(y))), CellLengthPilB_0_1ara.(char(fields(y))), CellIDPilB_0_1ara.(char(fields(y)))]=getMeanProfile(strcat(data_root_path, pilB_0_1ara_files{y}), k, NbUpSamples, fluo_FieldNames, CellLengthSol);
    temp=trapz(MeanpilB_0_1ara(y,:));
    MeanpilB_0_1ara(y,:)=MeanpilB_0_1ara(y,:)/temp;
end

%% Compute polar ratios
BootN=300;
% PilU
[RatPilUliq, BootRatPilUliq, MeanRatPilUliq, stdRatPilUliq, PolarisationPilUliq, MeanPolarisationPilUliq]=polarRatios2(ProfilePilUliq, CellWidthPilUliq, CellLengthPilUliq, k, BootN);
[RatPilUsol, BootRatPilUsol, MeanRatPilUsol, stdRatPilUsol, PolarisationPilUsol, MeanPolarisationPilUsol]=polarRatios2(ProfilePilUsol, CellWidthPilUsol, CellLengthPilUsol, k, BootN);
[RatPilUpilHliq, BootRatPilUpilHliq, MeanRatPilUpilHliq, stdRatPilUpilHliq, PolarisationPilUpilHliq, MeanPolarisationPilUpilHliq]=polarRatios2(ProfilePilUpilHliq, CellWidthPilUpilHliq, CellLengthPilUpilHliq, k, BootN);
[RatPilUpilGliq, BootRatPilUpilGliq, MeanRatPilUpilGliq, stdRatPilUpilGliq, PolarisationPilUpilGliq, MeanPolarisationPilUpilGliq]=polarRatios2(ProfilePilUpilGliq,  CellWidthPilUpilGliq, CellLengthPilUpilGliq, k, BootN);
[RatPilUcpdAliq, BootRatPilUcpdAliq, MeanRatPilUcpdAliq, stdRatPilUcpdAliq, PolarisationPilUcpdAliq, MeanPolarisationPilUcpdAliq]=polarRatios2(ProfilePilUcpdAliq,  CellWidthPilUcpdAliq, CellLengthPilUcpdAliq, k, BootN);

% PilT
[RatPilTliq, BootRatPilTliq, MeanRatPilTliq, stdRatPilTliq, PolarisationPilTliq, MeanPolarisationPilTliq]=polarRatios2(ProfilePilTliq, CellWidthPilTliq, CellLengthPilTliq, k, BootN);
[RatPilTsol, BootRatPilTsol, MeanRatPilTsol, stdRatPilTsol, PolarisationPilTsol, MeanPolarisationPilTsol]=polarRatios2(ProfilePilTsol, CellWidthPilTsol, CellLengthPilTsol, k, BootN);
[RatPilTpilHliq, BootRatPilTpilHliq, MeanRatPilTpilHliq, stdRatPilTpilHliq, PolarisationPilTpilHliq, MeanPolarisationPilTpilHliq]=polarRatios2(ProfilePilTpilHliq, CellWidthPilTpilHliq, CellLengthPilTpilHliq, k, BootN);
[RatPilTpilGliq, BootRatPilTpilGliq, MeanRatPilTpilGliq, stdRatPilTpilGliq, PolarisationPilTpilGliq, MeanPolarisationPilTpilGliq]=polarRatios2(ProfilePilTpilGliq, CellWidthPilTpilGliq, CellLengthPilTpilGliq, k, BootN);
[RatPilTcpdAliq, BootRatPilTcpdAliq, MeanRatPilTcpdAliq, stdRatPilTcpdAliq, PolarisationPilTcpdAliq, MeanPolarisationPilTcpdAliq]=polarRatios2(ProfilePilTcpdAliq, CellWidthPilTcpdAliq, CellLengthPilTcpdAliq, k, BootN);

% PilB
[RatPilBliq, BootRatPilBliq, MeanRatPilBliq, stdRatPilBliq, PolarisationPilBliq, MeanPolarisationPilBliq]=polarRatios2(ProfilePilBliq, CellWidthPilBliq, CellLengthPilBliq, k, BootN);
[RatPilBsol, BootRatPilBsol, MeanRatPilBsol, stdRatPilBsol, PolarisationPilBsol, MeanPolarisationPilBsol]=polarRatios2(ProfilePilBsol, CellWidthPilBsol, CellLengthPilBsol, k, BootN);
[RatPilBpilHliq, BootRatPilBpilHliq, MeanRatPilBpilHliq, stdRatPilBpilHliq, PolarisationPilBpilHliq, MeanPolarisationPilBpilHliq]=polarRatios2(ProfilePilBpilHliq, CellWidthPilBpilHliq, CellLengthPilBpilHliq, k, BootN);
[RatPilBpilGliq, BootRatPilBpilGliq, MeanRatPilBpilGliq, stdRatPilBpilGliq, PolarisationPilBpilGliq, MeanPolarisationPilBpilGliq]=polarRatios2(ProfilePilBpilGliq,  CellWidthPilBpilGliq, CellLengthPilBpilGliq, k, BootN);
[RatPilBcpdAliq, BootRatPilBcpdAliq, MeanRatPilBcpdAliq, stdRatPilBcpdAliq, PolarisationPilBcpdAliq, MeanPolarisationPilBcpdAliq]=polarRatios2(ProfilePilBcpdAliq,  CellWidthPilBcpdAliq, CellLengthPilBcpdAliq, k, BootN);
[RatPilBpilGcpdAliq, BootRatPilBpilGcpdAliq, MeanRatPilBpilGcpdAliq, stdRatPilBpilGcpdAliq, PolarisationPilBpilGcpdAliq, MeanPolarisationPilBpilGcpdAliq]=polarRatios2(ProfilePilBpilGcpdAliq,  CellWidthPilBpilGcpdAliq, CellLengthPilBpilGcpdAliq, k, BootN);
[RatPilBpilHcyaBliq, BootRatPilBpilHcyaBliq, MeanRatPilBpilHcyaBliq, stdRatPilBpilHcyaBliq, PolarisationPilBpilHcyaBliq, MeanPolarisationPilBpilHcyaBliq]=polarRatios2(ProfilePilBpilHcyaBliq,  CellWidthPilBpilHcyaBliq, CellLengthPilBpilHcyaBliq, k, BootN);

% FimX
[RatFimXliq, BootRatFimXliq, MeanRatFimXliq, stdRatFimXliq, PolarisationFimXliq, MeanPolarisationFimXliq]=polarRatios2(ProfileFimXliq, CellWidthFimXliq, CellLengthFimXliq, k, BootN);
[RatFimXsol, BootRatFimXsol, MeanRatFimXsol, stdRatFimXsol, PolarisationFimXsol, MeanPolarisationFimXsol]=polarRatios2(ProfileFimXsol, CellWidthFimXsol, CellLengthFimXsol, k, BootN);
[RatFimXpilHliq, BootRatFimXpilHliq, MeanRatFimXpilHliq, stdRatFimXpilHliq, PolarisationFimXpilHliq, MeanPolarisationFimXpilHliq]=polarRatios2(ProfileFimXpilHliq, CellWidthFimXpilHliq, CellLengthFimXpilHliq, k, BootN);
[RatFimXpilGliq, BootRatFimXpilGliq, MeanRatFimXpilGliq, stdRatFimXpilGliq, PolarisationFimXpilGliq, MeanPolarisationFimXpilGliq]=polarRatios2(ProfileFimXpilGliq,  CellWidthFimXpilGliq, CellLengthFimXpilGliq, k, BootN);
[RatFimXcpdAliq, BootRatFimXcpdAliq, MeanRatFimXcpdAliq, stdRatFimXcpdAliq, PolarisationFimXcpdAliq, MeanPolarisationFimXcpdAliq]=polarRatios2(ProfileFimXcpdAliq,  CellWidthFimXcpdAliq, CellLengthFimXcpdAliq, k, BootN);
[RatFimXpilGcpdAliq, BootRatFimXpilGcpdAliq, MeanRatFimXpilGcpdAliq, stdRatFimXpilGcpdAliq, PolarisationFimXpilGcpdAliq, MeanPolarisationFimXpilGcpdAliq]=polarRatios2(ProfileFimXpilGcpdAliq,  CellWidthFimXpilGcpdAliq, CellLengthFimXpilGcpdAliq, k, BootN);
[RatFimXpilHcyaBliq, BootRatFimXpilHcyaBliq, MeanRatFimXpilHcyaBliq, stdRatFimXpilHcyaBliq, PolarisationFimXpilHcyaBliq, MeanPolarisationFimXpilHcyaBliq]=polarRatios2(ProfileFimXpilHcyaBliq,  CellWidthFimXpilHcyaBliq, CellLengthFimXpilHcyaBliq, k, BootN);

% Response Regulators
[RatPilHliq, BootRatPilHliq, MeanRatPilHliq, stdRatPilHliq, PolarisationPilHliq, MeanPolarisationPilHliq]=polarRatios2(ProfilePilHliq, CellWidthPilHliq, CellLengthPilHliq, k, BootN);
[RatPilGliq, BootRatPilGliq, MeanRatPilGliq, stdRatPilGliq, PolarisationPilGliq, MeanPolarisationPilGliq]=polarRatios2(ProfilePilGliq,  CellWidthPilGliq, CellLengthPilGliq, k, BootN);
[RatPilHsol, BootRatPilHsol, MeanRatPilHsol, stdRatPilHsol, PolarisationPilHsol, MeanPolarisationPilHsol]=polarRatios2(ProfilePilHsol, CellWidthPilHsol, CellLengthPilHsol, k, BootN);
[RatPilGsol, BootRatPilGsol, MeanRatPilGsol, stdRatPilGsol, PolarisationPilGsol, MeanPolarisationPilGsol]=polarRatios2(ProfilePilGsol,  CellWidthPilGsol, CellLengthPilGsol, k, BootN);

% Inducible PilB_mNG
[RatPilB_0_0ara, BootPilB_0_0ara, MeanRatPilB_0_0ara, stdRatPilB_0_0ara, PolarisationPilB_0_0ara, MeanPolarisationPilB_0_0ara]=polarRatios2(ProfilePilB_0_0ara, CellWidthPilB_0_0ara, CellLengthPilB_0_0ara, k, BootN);
[RatPilB_0_01ara, BootPilB_0_01ara, MeanRatPilB_0_01ara, stdRatPilB_0_01ara, PolarisationPilB_0_01ara, MeanPolarisationPilB_0_01ara]=polarRatios2(ProfilePilB_0_01ara, CellWidthPilB_0_01ara, CellLengthPilB_0_01ara, k, BootN);
[RatPilB_0_03ara, BootPilB_0_03ara, MeanRatPilB_0_03ara, stdRatPilB_0_03ara, PolarisationPilB_0_03ara, MeanPolarisationPilB_0_03ara]=polarRatios2(ProfilePilB_0_03ara, CellWidthPilB_0_03ara, CellLengthPilB_0_03ara, k, BootN);
[RatPilB_0_1ara, BootPilB_0_1ara, MeanRatPilB_0_1ara, stdRatPilB_0_1ara, PolarisationPilB_0_1ara, MeanPolarisationPilB_0_1ara]=polarRatios2(ProfilePilB_0_1ara, CellWidthPilB_0_1ara, CellLengthPilB_0_1ara, k, BootN);

save('WorkSpace_Final.mat');
%% Plot profiles
% clc; close all;
% load('WorkSpace_Final.mat');
save_path='final_figures/';

% PilB_mNG main figure
y_limit=max(max((MeanPilBpilHliq)+0.1*max(MeanPilBpilHliq),[],2));
alpha=0.4;
linewidth=2;
dim=1;
Legend = {'WT liquid', 'in pilH-', 'in pilG-'};
Title = 'PilB localization profiles';
Colors_main = [170 170 170; 255 0 0; 31 226 255];
Y_limit=[0, y_limit];
plotProfiles(Title, Legend, alpha, linewidth, dim, Colors_main, false, Y_limit, k, MeanPilBliq, MeanPilBpilHliq, MeanPilBpilGliq);
saveas(gcf, strcat(save_path,Title));
saveas(gcf, strcat(save_path,Title), 'epsc');

% PilB_mNG SI figure
Legend = {'WT liquid', 'WT solid', 'in cpdA-', 'in pilG-cpdA-', 'in pilH-cyaB-'};
Title = 'PilB localization profiles SI';
Colors_SI = [170 170 170; 20 20 20; 0 190 170; 235 0 139; 135 10 239];
plotProfiles(Title, Legend, alpha, linewidth, dim, Colors_SI, false, Y_limit, k, MeanPilBliq, MeanPilBsol, MeanPilBcpdAliq, MeanPilBpilGcpdAliq, MeanPilBpilHcyaBliq);
saveas(gcf, strcat(save_path,Title));
saveas(gcf, strcat(save_path,Title), 'epsc');

% mNG_FimX main figure
Title = 'FimX localization profiles';
plotProfiles(Title, Legend, alpha, linewidth, dim, Colors_main, false, Y_limit, k, MeanFimXliq, MeanFimXpilHliq, MeanFimXpilGliq);
saveas(gcf, strcat(save_path,Title));
saveas(gcf, strcat(save_path,Title), 'epsc');

% mNG_fimX SI figure
Title = 'FimX localization profiles SI';
plotProfiles(Title, Legend, alpha, linewidth, dim, Colors_SI, false, Y_limit, k, MeanFimXliq, MeanFimXsol, MeanFimXcpdAliq, MeanFimXpilGcpdAliq, MeanFimXpilHcyaBliq);
saveas(gcf, strcat(save_path,Title));
saveas(gcf, strcat(save_path,Title), 'epsc');

% pilT SI figure
Title = 'PilT localization profiles SI';
Legend = {'WT liquid', 'WT solid', 'in pilG-', 'in pilH-', 'in cpdA-'};
plotProfiles(Title, Legend, alpha, linewidth, dim, Colors_SI, false, Y_limit, k, MeanPilTliq, MeanPilTsol, MeanPilTpilGliq, MeanPilTpilHliq, MeanPilTcpdAliq);
saveas(gcf, strcat(save_path,Title));
saveas(gcf, strcat(save_path,Title), 'epsc');

% pilU SI figure
Title = 'PilU localization profiles SI';
Legend = {'WT liquid', 'WT solid', 'in pilG-', 'in pilH-', 'in cpdA-'};
plotProfiles(Title, Legend, alpha, linewidth, dim, Colors_SI, false, Y_limit, k, MeanPilUliq, MeanPilUsol, MeanPilUpilGliq, MeanPilUpilHliq, MeanPilUcpdAliq);
saveas(gcf, strcat(save_path,Title));
saveas(gcf, strcat(save_path,Title), 'epsc');

% Response Regulators
Legend = {'pilH sol', 'pilG sol'};
Title = 'Response Regulators';
Colors_main = [15 67 20; 229 20 50];
Y_limit=[0, 0.015];
plotProfiles(Title, Legend, alpha, linewidth, dim, Colors_main, false, Y_limit, k, MeanPilHsol, MeanPilGsol)
saveas(gcf, strcat(save_path,Title), 'fig');
saveas(gcf, strcat(save_path,Title), 'epsc');

% Inducible PilB
Legend = {'0% arabinose', '0.03% arabinose', '0.1% arabinose'};
Title = 'Arabinose inducible pilB_mNG';
Colors_main = [200 200 200; 150 150 150; 100 100 100; 50 50 50];
Y_limit=[0, 0.015];
plotProfiles(Title, Legend, alpha, linewidth, dim, Colors_main, false, Y_limit, k, MeanpilB_0_0ara, MeanpilB_0_03ara, MeanpilB_0_1ara)
saveas(gcf, strcat(save_path,Title), 'fig');
saveas(gcf, strcat(save_path,Title), 'epsc');

% Plot polar ratios

% Response Regulators
DataMarkerSize=8;
Legends_RR={'pilH liq', 'pilH sol', 'pilG liq', 'pilG sol'};
Title='Response Regulators polar localization index Main figure';
YLable='polar localization index';
Ylimit=[0, 1];
Colors_RR = [120 170 60; 15 67 20; 209 103 209; 229 20 50];
plotPolarityMeans(Title, YLable, Ylimit, DataMarkerSize, Legends_RR, Colors_RR, MeanRatPilHliq, MeanRatPilHsol, MeanRatPilGliq, MeanRatPilGsol)
saveas(gcf, strcat(save_path,Title), 'fig');
saveas(gcf, strcat(save_path,Title), 'epsc');

% PilB
DataMarkerSize=8;
Title = 'PilB polar localization index Main figure';
Colors_main = [170 170 170; 255 0 0; 31 226 255];
Legends_main = {'WT liquid', 'in pilH-', 'in pilG-'};
plotPolarityMeans(Title, YLable, Ylimit, DataMarkerSize, Legends_main, Colors_main, MeanRatPilBliq, MeanRatPilBpilHliq, MeanRatPilBpilGliq)
saveas(gcf, strcat(save_path,Title), 'fig');
saveas(gcf, strcat(save_path,Title), 'epsc');

Title = 'PilB polar localization index SI figure';
Colors_SI = [170 170 170; 20 20 20; 0 190 170; 235 0 139; 135 10 239];
Legends_SI = {'WT liquid', 'WT solid', 'in cpdA-', 'in pilG-cpdA-', 'in pilH-cyaB-'};
plotPolarityMeans(Title, YLable, Ylimit, DataMarkerSize, Legends_SI, Colors_SI, MeanRatPilBliq, MeanRatPilBsol, MeanRatPilBcpdAliq, MeanRatPilBpilGcpdAliq , MeanRatPilBpilHcyaBliq)
saveas(gcf, strcat(save_path,Title), 'fig');
saveas(gcf, strcat(save_path,Title), 'epsc');

% FimX
Title = 'FimX polar localization index Main figure';
plotPolarityMeans(Title, YLable, Ylimit, DataMarkerSize, Legends_main, Colors_main, MeanRatFimXliq, MeanRatFimXpilHliq, MeanRatFimXpilGliq)
saveas(gcf, strcat(save_path,Title), 'fig');
saveas(gcf, strcat(save_path,Title), 'epsc');

Title = 'FimX polar localization index SI figure';
plotPolarityMeans(Title, YLable, Ylimit, DataMarkerSize, Legends_SI, Colors_SI, MeanRatFimXliq, MeanRatFimXsol, MeanRatFimXcpdAliq, MeanRatFimXpilGcpdAliq, MeanRatFimXpilHcyaBliq)
saveas(gcf, strcat(save_path,Title), 'fig');
saveas(gcf, strcat(save_path,Title), 'epsc');

%PilB arabinose induced
Title = 'pilB polar localization index arabinosed induced SI';
Colors_induced = [200 200 200; 150 150 150; 100 100 100; 50 50 50];
Legends_induced = {'0% arabinose', '0.01% arabinose', '0.03% arabinose', '0.1% arabinose'};
plotPolarityMeans(Title, YLable, Ylimit, DataMarkerSize, Legends_induced, Colors_induced, MeanRatPilB_0_0ara, MeanRatPilB_0_01ara, MeanRatPilB_0_03ara, MeanRatPilB_0_1ara)
saveas(gcf, strcat(save_path,Title), 'fig');
saveas(gcf, strcat(save_path,Title), 'epsc');

%PilT
Title = 'pilT polar localization index SI';
Legends_RetMot = {'WT liquid', 'WT solid', 'in pilG-', 'in pilH-', 'in cpdA-'};
plotPolarityMeans(Title, YLable, Ylimit, DataMarkerSize, Legends_RetMot, Colors_SI, MeanRatPilTliq, MeanRatPilTsol, MeanRatPilTpilGliq, MeanRatPilTpilHliq, MeanRatPilTcpdAliq)
saveas(gcf, strcat(save_path,Title), 'fig');
saveas(gcf, strcat(save_path,Title), 'epsc');

%PilU
Title = 'pilU polar localization index SI';
plotPolarityMeans(Title, YLable, Ylimit, DataMarkerSize, Legends_RetMot, Colors_SI, MeanRatPilUliq, MeanRatPilUsol, MeanRatPilUpilGliq, MeanRatPilUpilHliq, MeanRatPilUcpdAliq)
saveas(gcf, strcat(save_path,Title), 'fig');
saveas(gcf, strcat(save_path,Title), 'epsc');

% Plot polarisation

% Response Regulators
DataMarkerSize=8;
Title='Response Regulators polarization index Main figure';
YLable='polarization index';
Ylimit=[0.5, 1];
plotPolarityMeans(Title, YLable, Ylimit, DataMarkerSize, Legends_RR, Colors_RR, MeanPolarisationPilHliq, MeanPolarisationPilHsol, MeanPolarisationPilGliq, MeanPolarisationPilGsol)
saveas(gcf, strcat(save_path,Title), 'fig');
saveas(gcf, strcat(save_path,Title), 'epsc');

% PilB
DataMarkerSize=10;
Title = 'PilB polarization index SI figure';
Colors_full_SI = [170 170 170; 20 20 20; 255 0 0; 31 226 255; 0 190 170; 235 0 139; 135 10 239];
Legends_full_SI = {'WT liquid', 'WT solid', 'in pilH-', 'in pilG-', 'in cpdA-', 'in pilG-cpdA-', 'in pilH-cyaB-'};
plotPolarityMeans(Title, YLable, Ylimit, DataMarkerSize, Legends_full_SI, Colors_full_SI, MeanPolarisationPilBliq, MeanPolarisationPilBsol, MeanPolarisationPilBpilHliq, MeanPolarisationPilBpilGliq, MeanPolarisationPilBcpdAliq, MeanPolarisationPilBpilGcpdAliq, MeanPolarisationPilBpilHcyaBliq);
saveas(gcf, strcat(save_path,Title), 'fig');
saveas(gcf, strcat(save_path,Title), 'epsc');

% FimX
Title = 'FimX polarization index Main figure';
plotPolarityMeans(Title, YLable, Ylimit, DataMarkerSize, Legends_full_SI, Colors_full_SI, MeanPolarisationFimXliq, MeanPolarisationFimXsol, MeanPolarisationFimXpilHliq, MeanPolarisationFimXpilGliq, MeanPolarisationFimXcpdAliq, MeanPolarisationFimXpilGcpdAliq, MeanPolarisationFimXpilHcyaBliq);
saveas(gcf, strcat(save_path,Title), 'fig');
saveas(gcf, strcat(save_path,Title), 'epsc');

%PilB arabinose induced
Title = 'pilB polarization index arabinosed induced SI';
YLabel = 'polarization index';
Colors_induced = [200 200 200; 150 150 150; 100 100 100; 50 50 50];
plotPolarityMeans(Title, YLable, Ylimit, DataMarkerSize, Legends_induced, Colors_induced, MeanPolarisationPilB_0_0ara, MeanPolarisationPilB_0_01ara, MeanPolarisationPilB_0_03ara, MeanPolarisationPilB_0_1ara)
saveas(gcf, strcat(save_path,Title), 'fig');
saveas(gcf, strcat(save_path,Title), 'epsc');

%PilT
Title = 'pilT polarization index SI';
Legends_RetMot = {'WT liquid', 'WT solid', 'in pilG-', 'in pilH-', 'in cpdA-'};
plotPolarityMeans(Title, YLable, Ylimit, DataMarkerSize, Legends_RetMot, Colors_SI, MeanPolarisationPilTliq, MeanPolarisationPilTsol, MeanPolarisationPilTpilGliq, MeanPolarisationPilTpilHliq, MeanPolarisationPilTcpdAliq)
saveas(gcf, strcat(save_path,Title), 'fig');
saveas(gcf, strcat(save_path,Title), 'epsc');

%PilU
Title = 'pilU polarization index SI';
plotPolarityMeans(Title, YLable, Ylimit, DataMarkerSize, Legends_RetMot, Colors_SI, MeanPolarisationPilUliq, MeanPolarisationPilUsol, MeanPolarisationPilUpilGliq, MeanPolarisationPilUpilHliq, MeanPolarisationPilUcpdAliq)
saveas(gcf, strcat(save_path,Title), 'fig');
saveas(gcf, strcat(save_path,Title), 'epsc');
%%
toc