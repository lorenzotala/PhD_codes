%% Initialization
clear all; close all;
clc;
tic

data_root_path='C:/Users/tala/Desktop/backstal/Download_code/src/data';
% mNeonGreen_pilU dataset files
pilU_liq_files={'/DataSet_mNG_pilU_liq_BR=1.mat', '/DataSet_mNG_pilU_liq_BR=2.mat', '/DataSet_mNG_pilU_liq_BR=3.mat'};
pilU_sol_files={'/DataSet_mNG_pilU_3hsol_BR=1.mat', '/DataSet_mNG_pilU_3hsol_BR=2.mat', '/DataSet_mNG_pilU_3hsol_BR=3.mat'};
pilU_pilH_liq_files={'/DataSet_mNG_pilU_pilH-_liq_BR=1.mat', '/DataSet_mNG_pilU_pilH-_liq_BR=2.mat', '/DataSet_mNG_pilU_pilH-_liq_BR=3.mat'};
pilU_pilG_liq_files={'/DataSet_mNG_pilU_pilG-_liq_BR=1.mat', '/DataSet_mNG_pilU_pilG-_liq_BR=2.mat', '/DataSet_mNG_pilU_pilG-_liq_BR=3.mat'};
pilU_pilH_sol_files={'/DataSet_mNG_pilU_pilH-_sol_BR=1.mat', '/DataSet_mNG_pilU_pilH-_sol_BR=2.mat', '/DataSet_mNG_pilU_pilH-_sol_BR=3.mat'};
pilU_pilG_sol_files={'/DataSet_mNG_pilU_pilG-_sol_BR=1.mat', '/DataSet_mNG_pilU_pilG-_sol_BR=2.mat', '/DataSet_mNG_pilU_pilG-_sol_BR=3.mat'};
pilU_cyaB_liq_files={'/DataSet_mNG_pilU_cyaB-_liq_BR=1.mat', '/DataSet_mNG_pilU_cyaB-_liq_BR=2.mat', '/DataSet_mNG_pilU_cyaB-_liq_BR=3.mat'};
pilU_cyaB_sol_files={'/DataSet_mNG_pilU_cyaB-_sol_BR=1.mat', '/DataSet_mNG_pilU_cyaB-_sol_BR=2.mat', '/DataSet_mNG_pilU_cyaB-_sol_BR=3.mat'};
pilU_cpdA_liq_files={'/DataSet_mNG_pilU_cpdA-_liq_BR=1.mat', '/DataSet_mNG_pilU_cpdA-_liq_BR=2.mat', '/DataSet_mNG_pilU_cpdA-_liq_BR=3.mat'};
pilU_cpdA_sol_files={'/DataSet_mNG_pilU_cpdA-_sol_BR=1.mat', '/DataSet_mNG_pilU_cpdA-_sol_BR=2.mat', '/DataSet_mNG_pilU_cpdA-_sol_BR=3.mat'};

% pilB_mNeonGreen dataset files
pilB_liq_files={'/DataSet_pilB_mNG_liq_BR=1.mat', '/DataSet_pilB_mNG_liq_BR=2.mat', '/DataSet_pilB_mNG_liq_BR=3.mat'};
pilB_sol_files={'/DataSet_pilB_mNG_3hsol_BR=1.mat', '/DataSet_pilB_mNG_3hsol_BR=2.mat', '/DataSet_pilB_mNG_3hsol_BR=3.mat'};
pilB_pilH_liq_files={'/DataSet_pilB_mNG_pilH-_liq_BR=1.mat', '/DataSet_pilB_mNG_pilH-_liq_BR=2.mat', '/DataSet_pilB_mNG_pilH-_liq_BR=3.mat'};
pilB_pilH_sol_files={'/DataSet_pilB_mNG_pilH-_sol_BR=1.mat', '/DataSet_pilB_mNG_pilH-_sol_BR=2.mat', '/DataSet_pilB_mNG_pilH-_sol_BR=3.mat'};
pilB_pilG_liq_files={'/DataSet_pilB_mNG_pilG-_liq_BR=1.mat', '/DataSet_pilB_mNG_pilG-_liq_BR=2.mat', '/DataSet_pilB_mNG_pilG-_liq_BR=3.mat'};
pilB_pilG_sol_files={'/DataSet_pilB_mNG_pilG-_sol_BR=1.mat', '/DataSet_pilB_mNG_pilG-_sol_BR=2.mat', '/DataSet_pilB_mNG_pilG-_sol_BR=3.mat'};
pilB_cyaB_liq_files={'/DataSet_pilB_mNG_cyaB-_liq_BR=1.mat', '/DataSet_pilB_mNG_cyaB-_liq_BR=2.mat', '/DataSet_pilB_mNG_cyaB-_liq_BR=3.mat'};
pilB_cyaB_sol_files={'/DataSet_pilB_mNG_cyaB-_sol_BR=1.mat', '/DataSet_pilB_mNG_cyaB-_sol_BR=2.mat', '/DataSet_pilB_mNG_cyaB-_sol_BR=3.mat'};
pilB_cpdA_liq_files={'/DataSet_pilB_mNG_cpdA-_liq_BR=1.mat', '/DataSet_pilB_mNG_cpdA-_liq_BR=2.mat', '/DataSet_pilB_mNG_cpdA-_liq_BR=3.mat'};
pilB_cpdA_sol_files={'/DataSet_pilB_mNG_cpdA-_sol_BR=1.mat', '/DataSet_pilB_mNG_cpdA-_sol_BR=2.mat', '/DataSet_pilB_mNG_cpdA-_sol_BR=3.mat'};
pilB_pilGcpdA_liq_files={'/DataSet_pilB_mNG_pilG-cpdA-fliC-_liq_BR=1.mat', '/DataSet_pilB_mNG_pilG-cpdA-fliC-_liq_BR=2.mat', '/DataSet_pilB_mNG_pilG-cpdA-fliC-_liq_BR=3.mat'};
pilB_pilGcpdA_sol_files={'/DataSet_pilB_mNG_pilG-cpdA-fliC-_sol_BR=1.mat', '/DataSet_pilB_mNG_pilG-cpdA-fliC-_sol_BR=2.mat', '/DataSet_pilB_mNG_pilG-cpdA-fliC-_sol_BR=3.mat'};
pilB_0_0ara_files={'/DataSet_pilB-_pilB_mNG_0ara_BR=1.mat'};
pilB_0_01ara_files={'/DataSet_pilB-_pilB_mNG_0-01ara_BR=1.mat'};
pilB_0_03ara_files={'/DataSet_pilB-_pilB_mNG_0-03ara_BR=1.mat'};
pilB_0_1ara_files={'/DataSet_pilB-_pilB_mNG_0-1ara_BR=1.mat'};

% mNeonGreen_pilT dataset files
pilT_liq_files={'/DataSet_mNG_pilT_liq_BR=1.mat', '/DataSet_mNG_pilT_liq_BR=2.mat', '/DataSet_mNG_pilT_liq_BR=3.mat'};
pilT_pilH_liq_files={'/DataSet_mNG_pilT_pilH-_liq_BR=1.mat', '/DataSet_mNG_pilT_pilH-_liq_BR=2.mat', '/DataSet_mNG_pilT_pilH-_liq_BR=3.mat'};
pilT_pilG_liq_files={'/DataSet_mNG_pilT_pilG-_liq_BR=1.mat', '/DataSet_mNG_pilT_pilG-_liq_BR=2.mat', '/DataSet_mNG_pilT_pilG-_liq_BR=3.mat'};
pilT_pilH_sol_files={'/DataSet_mNG_pilT_pilH-_sol_BR=1.mat', '/DataSet_mNG_pilT_pilH-_sol_BR=2.mat', '/DataSet_mNG_pilT_pilH-_sol_BR=3.mat'};
pilT_pilG_sol_files={'/DataSet_mNG_pilT_pilG-_sol_BR=1.mat', '/DataSet_mNG_pilT_pilG-_sol_BR=2.mat', '/DataSet_mNG_pilT_pilG-_sol_BR=3.mat'};
pilT_sol_files={'/DataSet_mNG_pilT_3hsol_BR=1.mat', '/DataSet_mNG_pilT_3hsol_BR=2.mat', '/DataSet_mNG_pilT_3hsol_BR=3.mat'};
pilT_cyaB_liq_files={'/DataSet_mNG_pilT_cyaB-_liq_BR=1.mat', '/DataSet_mNG_pilT_cyaB-_liq_BR=2.mat', '/DataSet_mNG_pilT_cyaB-_liq_BR=3.mat'};
pilT_cyaB_sol_files={'/DataSet_mNG_pilT_cyaB-_sol_BR=1.mat', '/DataSet_mNG_pilT_cyaB-_sol_BR=2.mat', '/DataSet_mNG_pilT_cyaB-_sol_BR=3.mat'};
pilT_cpdA_liq_files={'/DataSet_mNG_pilT_cpdA-_liq_BR=1.mat', '/DataSet_mNG_pilT_cpdA-_liq_BR=2.mat', '/DataSet_mNG_pilT_cpdA-_liq_BR=3.mat'};
pilT_cpdA_sol_files={'/DataSet_mNG_pilT_cpdA-_sol_BR=1.mat', '/DataSet_mNG_pilT_cpdA-_sol_BR=2.mat', '/DataSet_mNG_pilT_cpdA-_sol_BR=3.mat'};

% mNeonGreen_pilH dataset files
pilH_liq_files={'/DataSet_mNG_pilH_liq_BR=1.mat', '/DataSet_mNG_pilH_liq_BR=2.mat', '/DataSet_mNG_pilH_liq_BR=3.mat'};
pilH_sol_files={'/DataSet_mNG_pilH_sol_BR=1.mat', '/DataSet_mNG_pilH_sol_BR=2.mat', '/DataSet_mNG_pilH_sol_BR=3.mat'};

% mNeonGreen_pilH dataset files
pilG_liq_files={'/DataSet_mNG_pilG_liq_BR=1.mat', '/DataSet_mNG_pilG_liq_BR=2.mat', '/DataSet_mNG_pilG_liq_BR=3.mat'};
pilG_sol_files={'/DataSet_mNG_pilG_sol_BR=1.mat', '/DataSet_mNG_pilG_sol_BR=2.mat', '/DataSet_mNG_pilG_sol_BR=3.mat'};

% Field name of fluorescence profile data in the BacStalk Struct Dataset
fluo_FieldNames='MedialAxisIntensity_mNeonGreen';

%% Stats
NbUpSamples=200; %Up sample the intensity profile to get similar length vectors to compare.
Biological_reps=3;
k=linspace(0,1,NbUpSamples); %k is a ordered vector from 1 to 200
CellLengthLiq=4.5; %in µm;
CellLengthSol=4.5; %in µm;

fields=cell(Biological_reps, 1);
for i=1:Biological_reps
    name=strcat('BR',num2str(i));
    fields(i)= {name};
end

for y=1:Biological_reps
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
    [MeanPilUcyaBliq(y,:), StdPilUcyaBliq(y,:), NpilUcyaBliq(y), ProfilePilUcyaBliq.(char(fields(y))), FluoMeansPilUcyaBliq.(char(fields(y))), CellWidthPilUcyaBliq.(char(fields(y))), CellLengthPilUcyaBliq.(char(fields(y))), CellIDPilUcyaBliq.(char(fields(y)))]=getMeanProfile(strcat(data_root_path, pilU_cyaB_liq_files{y}), k, NbUpSamples, fluo_FieldNames, CellLengthLiq);
    temp=trapz(MeanPilUcyaBliq(y,:));
    MeanPilUcyaBliq(y,:)=MeanPilUcyaBliq(y,:)/temp;
        
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
    [MeanPilBcyaBliq(y,:), StdPilBcyaBliq(y,:), NpilBcyaBliq(y), ProfilePilBcyaBliq.(char(fields(y))), FluoMeansPilBcyaBliq.(char(fields(y))), CellWidthPilBcyaBliq.(char(fields(y))), CellLengthPilBcyaBliq.(char(fields(y))), CellIDPilBcyaBliq.(char(fields(y)))]=getMeanProfile(strcat(data_root_path, pilB_cyaB_liq_files{y}), k, NbUpSamples, fluo_FieldNames, CellLengthLiq);
    temp=trapz(MeanPilBcyaBliq(y,:));
    MeanPilBcyaBliq(y,:)=MeanPilBcyaBliq(y,:)/temp;    
    [MeanPilBcpdAliq(y,:), StdPilBcpdAliq(y,:), NpilBcpdAliq(y), ProfilePilBcpdAliq.(char(fields(y))), FluoMeansPilBcpdAliq.(char(fields(y))), CellWidthPilBcpdAliq.(char(fields(y))), CellLengthPilBcpdAliq.(char(fields(y))), CellIDPilBcpdAliq.(char(fields(y)))]=getMeanProfile(strcat(data_root_path, pilB_cpdA_liq_files{y}), k, NbUpSamples, fluo_FieldNames, CellLengthLiq);
    temp=trapz(MeanPilBcpdAliq(y,:));
    MeanPilBcpdAliq(y,:)=MeanPilBcpdAliq(y,:)/temp;
    [MeanPilBpilGcpdAliq(y,:), StdPilBpilGcpdAliq(y,:), NpilBpilGcpdAliq(y), ProfilePilBpilGcpdAliq.(char(fields(y))), FluoMeansPilBpilGcpdAliq.(char(fields(y))), CellWidthPilBpilGcpdAliq.(char(fields(y))), CellLengthPilBpilGcpdAliq.(char(fields(y))), CellIDPilBpilGcpdAliq.(char(fields(y)))]=getMeanProfile(strcat(data_root_path, pilB_pilGcpdA_liq_files{y}), k, NbUpSamples, fluo_FieldNames, CellLengthLiq);
    temp=trapz(MeanPilBpilGcpdAliq(y,:));
    MeanPilBpilGcpdAliq(y,:)=MeanPilBpilGcpdAliq(y,:)/temp;
    [MeanPilBpilGcpdAsol(y,:), StdPilBpilGcpdAsol(y,:), NpilBpilGcpdAsol(y), ProfilePilBpilGcpdAsol.(char(fields(y))), FluoMeansPilBpilGcpdAsol.(char(fields(y))), CellWidthPilBpilGcpdAsol.(char(fields(y))), CellLengthPilBpilGcpdAsol.(char(fields(y))), CellIDPilBpilGcpdAsol.(char(fields(y)))]=getMeanProfile(strcat(data_root_path, pilB_pilGcpdA_sol_files{y}), k, NbUpSamples, fluo_FieldNames, CellLengthLiq);
    temp=trapz(MeanPilBpilGcpdAsol(y,:));
    MeanPilBpilGcpdAsol(y,:)=MeanPilBpilGcpdAsol(y,:)/temp;
    
%     [MeanpilB_0_0ara(y,:), StdpilB_0_0ara(y,:), NpilB_0_0ara(y)]=getMeanProfile(pilB_0_0ara_files{y}, k, NbUpSamples, fluo_FieldNames, CellLengthSol);
%     temp=trapz(MeanpilB_0_0ara(y,:));
%     MeanpilB_0_0ara(y,:)=MeanpilB_0_0ara(y,:)/temp;
%     [MeanpilB_0_01ara(y,:), StdpilB_0_01ara(y,:), NpilB_0_01ara(y)]=getMeanProfile(pilB_0_01ara_files{y}, k, NbUpSamples, fluo_FieldNames, CellLengthSol);
%     temp=trapz(MeanpilB_0_01ara(y,:));
%     MeanpilB_0_01ara(y,:)=MeanpilB_0_01ara(y,:)/temp;
%     [MeanpilB_0_03ara(y,:), StdpilB_0_03ara(y,:), NpilB_0_03ara(y)]=getMeanProfile(pilB_0_03ara_files{y}, k, NbUpSamples, fluo_FieldNames, CellLengthSol);
%     temp=trapz(MeanpilB_0_03ara(y,:));
%     MeanpilB_0_03ara(y,:)=MeanpilB_0_03ara(y,:)/temp;
%     [MeanpilB_0_1ara(y,:), StdpilB_0_1ara(y,:), NpilB_0_1ara(y)]=getMeanProfile(pilB_0_1ara_files{y}, k, NbUpSamples, fluo_FieldNames, CellLengthSol);
%     temp=trapz(MeanpilB_0_1ara(y,:));
%     MeanpilB_0_1ara(y,:)=MeanpilB_0_1ara(y,:)/temp;
    
    
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
    [MeanPilTcyaBliq(y,:), StdPilTcyaBliq(y,:), NpilTcyaBliq(y), ProfilePilTcyaBliq.(char(fields(y))), FluoMeansPilTcyaBliq.(char(fields(y))), CellWidthPilTcyaBliq.(char(fields(y))), CellLengthPilTcyaBliq.(char(fields(y))), CellIDPilTcyaBliq.(char(fields(y)))]=getMeanProfile(strcat(data_root_path, pilT_cyaB_liq_files{y}), k, NbUpSamples, fluo_FieldNames, CellLengthLiq);
    temp=trapz(MeanPilTcyaBliq(y,:));
    MeanPilTcyaBliq(y,:)=MeanPilTcyaBliq(y,:)/temp;        
    [MeanPilTcpdAliq(y,:), StdPilTcpdAliq(y,:), NpilTcpdAliq(y), ProfilePilTcpdAliq.(char(fields(y))), FluoMeansPilTcpdAliq.(char(fields(y))), CellWidthPilTcpdAliq.(char(fields(y))), CellLengthPilTcpdAliq.(char(fields(y))), CellIDPilTcpdAliq.(char(fields(y)))]=getMeanProfile(strcat(data_root_path, pilT_cpdA_liq_files{y}), k, NbUpSamples, fluo_FieldNames, CellLengthLiq);
    temp=trapz(MeanPilTcpdAliq(y,:));
    MeanPilTcpdAliq(y,:)=MeanPilTcpdAliq(y,:)/temp;
    
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
%% Plotting

%load('workspace_no_sol.mat');
figure();
linewidth=2;
col=[0.5 0.5 0.5];
if(Biological_reps==1)
    subplot(1,3,1);
    y_limit=max(MeanPilBpilHliq)+0.1*max(MeanPilBpilHliq);
    hold on;
    plot(k, MeanPilUliq, 'b--','LineWidth',linewidth);
    plot(k, MeanPilUsol, 'b','LineWidth',linewidth);
    plot(k, MeanPilUpilHliq, 'r--','LineWidth',linewidth-1);
   
    plot(k, MeanPilUpilGliq, 'g--','LineWidth',linewidth);
    
    plot(k, MeanPilUcpdAliq, 'm--','LineWidth',linewidth-1);
    
    plot(k, MeanPilUcyaBliq, 'c--','LineWidth',linewidth);
    
    legend('liquid', 'solid', 'in pilH liquid', 'in pilG liquid', 'in cpdA liquid', 'in cyaB liquid', 'Location', 'Best');
%     legend('liquid', 'solid', 'in pilH liquid', 'in pilH solid', 'in pilG liquid', 'in pilG solid', 'Location', 'Best');
    % shadePlot(k, MeanPilUliq, StdPilUliq, 'r');
    % shadePlot(k, MeanPilUsol, StdPilUsol, 'b');
    % stdshade(MeanPilUliq, 0.2, 'b', k)
    % stdshade(MeanPilUsol, 0.2, 'r', k)
    ylim([0 y_limit]);
    title('pilU');

    subplot(1,3,2);
    hold on;
    plot(k, MeanPilBliq, 'b--','LineWidth',linewidth);
    plot(k, MeanPilBsol, 'b','LineWidth',linewidth);
    plot(k, MeanPilBpilHliq, 'r--','LineWidth',linewidth-1);

    plot(k, MeanPilBpilGliq, 'g--','LineWidth',linewidth);

    plot(k, MeanPilBcpdAliq, 'm--','LineWidth',linewidth-1);
    plot(k, MeanPilBpilGcpdAliq, 'm:','LineWidth',linewidth-1);

    plot(k, MeanPilBcyaBliq, 'c--','LineWidth',linewidth);

    legend('liquid', 'solid', 'in pilH liquid','in pilG liquid', 'in cpdA liquid', 'in pilG-cpdA-fliC- liquid', 'in cyaB liquid', 'Location', 'Best');
%     legend('liquid', 'solid', 'in pilH liquid', 'in pilH solid', 'in pilG liquid', 'in pilG solid', 'Location', 'Best');
    % shadePlot(k, MeanPilBliq, StdPilBliq, 'r');
    % shadePlot(k, MeanPilBsol, StdPilBsol, 'b');
    % stdshade(MeanPilBliq, 0.2, 'b', k)
    % stdshade(MeanPilBsol, 0.2, 'r', k)
    ylim([0 y_limit]);
    title('pilB');

    subplot(1,3,3);
    hold on;
    plot(k, MeanPilTliq, 'b--','LineWidth',linewidth);
    plot(k, MeanPilTsol, 'b','LineWidth',linewidth);
    plot(k, MeanPilTpilHliq, 'r--','LineWidth',linewidth-1);

    plot(k, MeanPilTpilGliq, 'g--','LineWidth',linewidth);

    plot(k, MeanPilTcpdAliq, 'm--','LineWidth',linewidth);

    plot(k, MeanPilTcyaBliq, 'c--','LineWidth',linewidth);

    legend('liquid', 'solid', 'in pilH liquid', 'in pilG liquid', 'in cpdA liquid', 'in cyaB liquid', 'Location', 'Best');
%     legend('liquid', 'solid', 'in pilH liquid', 'in pilH solid', 'in pilG liquid', 'in pilG solid', 'Location', 'Best');
    % shadePlot(k, MeanPilTliq, StdPilTliq, 'r');
    % shadePlot(k, MeanPilTsol, StdPilTsol, 'b');
    %stdshade(MeanPilTliq, 0.2, 'b', k)
    %stdshade(MeanPilTsol, 0.2, 'r', k)
    ylim([0 y_limit]);
    title('pilT');
    
    figure;
    hold on;
    plot(k, MeanPilBliq, 'b--','LineWidth',linewidth);
    plot(k, MeanPilBsol, 'b','LineWidth',linewidth);
    plot(k, MeanpilB_0_0ara, 'r--','LineWidth',linewidth-1);
    plot(k, MeanpilB_0_01ara, 'r','LineWidth',linewidth-1);
    plot(k, MeanpilB_0_03ara, 'g--','LineWidth',linewidth);
    plot(k, MeanpilB_0_1ara, 'g','LineWidth',linewidth);
    legend('liquid', 'solid', '0%', '0.01%', '0.03%', '0.1%', 'Location', 'Best');
    ylim([0 y_limit]);
    title('pilB arabinose');
else 
    subplot(1,3,1);
    y_limit=max(mean(MeanPilBpilHliq))+max(std(MeanPilBpilHliq));
    hold on;
    plot(k, mean(MeanPilUliq), 'b--','LineWidth',linewidth);
    plot(k, mean(MeanPilUsol), 'b','LineWidth',linewidth);
    plot(k, mean(MeanPilUpilHliq), 'r--','LineWidth',linewidth-1);

    plot(k, mean(MeanPilUpilGliq), 'g--','LineWidth',linewidth);

    plot(k, mean(MeanPilUcpdAliq), 'm--','LineWidth',linewidth-1);

    plot(k, mean(MeanPilUcyaBliq), 'c--','LineWidth',linewidth);

    legend('liquid', 'solid', 'in pilH liquid', 'in pilG liquid', 'in cpdA liquid', 'in cyaB liquid', 'Location', 'Best');
%     legend('liquid', 'solid', 'in pilH liquid', 'in pilH solid', 'in pilG liquid', 'in pilG solid', 'Location', 'Best');
    % shadePlot(k, MeanPilUliq, StdPilUliq, 'r');
    % shadePlot(k, MeanPilUsol, StdPilUsol, 'b');
    % stdshade(MeanPilUliq, 0.2, 'b', k)
    % stdshade(MeanPilUsol, 0.2, 'r', k)
    ylim([0 y_limit]);
    title('pilU');

    subplot(1,3,2);
    hold on;
    plot(k, mean(MeanPilBliq), 'b--','LineWidth',linewidth);
    plot(k, mean(MeanPilBsol), 'b','LineWidth',linewidth);
    plot(k, mean(MeanPilBpilHliq), 'r--','LineWidth',linewidth-1);

    plot(k, mean(MeanPilBpilGliq), 'g--','LineWidth',linewidth);

    plot(k, mean(MeanPilBcpdAliq), 'm--','LineWidth',linewidth-1);
    plot(k, mean(MeanPilBpilGcpdAliq), 'm:','LineWidth',linewidth);

    plot(k, mean(MeanPilBcyaBliq), 'c--','LineWidth',linewidth);

    legend('liquid', 'solid', 'in pilH liquid', 'in pilG liquid', 'in cpdA liquid', 'in pilG-cpdA-fliC- liquid', 'in cyaB liquid', 'Location', 'Best');
    ylim([0 y_limit]);
    title('pilB');

    subplot(1,3,3);
    hold on;
    plot(k, mean(MeanPilTliq), 'b--','LineWidth',linewidth);
    plot(k, mean(MeanPilTsol), 'b','LineWidth',linewidth);
    plot(k, mean(MeanPilTpilHliq), 'r--','LineWidth',linewidth-1);

    plot(k, mean(MeanPilTpilGliq), 'g--','LineWidth',linewidth);

    plot(k, mean(MeanPilTcpdAliq), 'm--','LineWidth',linewidth);

    plot(k, mean(MeanPilTcyaBliq), 'c--','LineWidth',linewidth);

   legend('liquid', 'solid', 'in pilH liquid', 'in pilG liquid', 'in cpdA liquid', 'in cyaB liquid', 'Location', 'Best');
    ylim([0 y_limit]);
    title('pilT');
    
    figure
    hold on;
    plot(k, mean(MeanPilHliq), 'b--','LineWidth',linewidth);
    plot(k, mean(MeanPilHsol), 'b','LineWidth',linewidth);
    plot(k, mean(MeanPilGliq), 'r--','LineWidth',linewidth-1);
    plot(k, mean(MeanPilGsol), 'r','LineWidth',linewidth);

   legend('pilH liquid', 'pilH solid', 'pilG liquid', 'pilG solid', 'Location', 'Best');
    ylim([0 y_limit]);
    title('Response Regulators');
end

%% T-tests
[HpilB,PpilB,CIpilB] = ttest2(mean(transpose(MeanPilBliq)), mean(transpose(MeanPilBsol)));
disp(['liquid vs solid t-test of PilB: p-value of ', num2str(PpilB), ', CI = [', num2str(CIpilB(1)), ', ', num2str(CIpilB(2)), '], N liq = ', num2str(sum(NpilBliq)), ', N sol = ', num2str(sum(NpilBsol))]);
[HpilT,PpilT,CIpilT] = ttest2(mean(transpose(MeanPilTliq)), mean(transpose(MeanPilTsol)));
disp(['liquid vs solid t-test of PilT: p-value of ', num2str(PpilT), ', CI = [', num2str(CIpilT(1)), ', ', num2str(CIpilT(2)), '], N liq = ', num2str(sum(NpilTliq)), ', N sol = ', num2str(sum(NpilTsol))]);
[HpilU,PpilU,CIpilU] = ttest2(mean(transpose(MeanPilUliq)), mean(transpose(MeanPilUsol)));
disp(['liquid vs solid t-test of PilU: p-value of ', num2str(PpilU), ', CI = [', num2str(CIpilU(1)), ', ', num2str(CIpilU(2)), '], N liq = ', num2str(sum(NpilUliq)), ', N sol = ', num2str(sum(NpilUsol))]);

%% 

figure(40);
alpha=0.4;

k2 = [k, fliplr(k)];
hold on;
plot(k, mean(MeanPilBsol), 'b','LineWidth',linewidth);
plot(k, mean(MeanPilBpilHliq), 'r','LineWidth',linewidth);
plot(k, mean(MeanPilBcpdAliq), 'm','LineWidth',linewidth);
plot(k, mean(MeanPilBpilGcpdAliq), 'g','LineWidth',linewidth);

top = mean(MeanPilBsol)+ std(MeanPilBsol);
bottom = mean(MeanPilBsol)- std(MeanPilBsol);
% inBetween = [top, fliplr(bottom)];
% fill(k2, inBetween, [0.5 0.5 1],'FaceAlpha',alpha, 'EdgeColor', 'none');
plot(k, top, 'b--', k, bottom, 'b--','LineWidth',linewidth-1);

top = mean(MeanPilBpilHliq)+ std(MeanPilBpilHliq);
bottom = mean(MeanPilBpilHliq)- std(MeanPilBpilHliq);
% inBetween = [top, fliplr(bottom)];
% fill(k2, inBetween, [1 0.5 0.5],'FaceAlpha',alpha, 'EdgeColor', 'none');
plot(k, top, 'r:', k, bottom, 'r:','LineWidth',linewidth-1);

top = mean(MeanPilBcpdAliq)+ std(MeanPilBcpdAliq);
bottom = mean(MeanPilBcpdAliq)- std(MeanPilBcpdAliq);
% inBetween = [top, fliplr(bottom)];
% fill(k2, inBetween, [1 0.5 1],'FaceAlpha',alpha, 'EdgeColor', 'none');
plot(k, top, 'm:', k, bottom, 'm--','LineWidth',linewidth-1);

top = mean(MeanPilBpilGcpdAliq)+ std(MeanPilBpilGcpdAliq);
bottom = mean(MeanPilBpilGcpdAliq)- std(MeanPilBpilGcpdAliq);
% inBetween = [top, fliplr(bottom)];
% fill(k2, inBetween, [1 0.5 1],'FaceAlpha',alpha, 'EdgeColor', 'none');
plot(k, top, 'g:', k, bottom, 'g--','LineWidth',linewidth-1);

legend('solid', 'in pilH liquid', 'in cpdA liquid', 'in pilG-cpdA-fliC- liquid', 'Location', 'Best');
ylim([0 y_limit]);
title('pilB high cAMP');

figure(41);
hold on;
plot(k, mean(MeanPilBliq), 'b','LineWidth',linewidth);
plot(k, mean(MeanPilBpilGliq), 'g','LineWidth',linewidth);
plot(k, mean(MeanPilBcyaBliq), 'c','LineWidth',linewidth);

top = mean(MeanPilBliq)+ std(MeanPilBliq);
bottom = mean(MeanPilBliq)- std(MeanPilBliq);
% inBetween = [top, fliplr(bottom)];
% fill(k2, inBetween, [0.5 0.5 1],'FaceAlpha',alpha, 'EdgeColor', 'none');
plot(k, top, 'b--', k, bottom, 'b--','LineWidth',linewidth-1);

top = mean(MeanPilBpilGliq)+ std(MeanPilBpilGliq);
bottom = mean(MeanPilBpilGliq)- std(MeanPilBpilGliq);
% inBetween = [top, fliplr(bottom)];
% fill(k2, inBetween, [0.5 1 0.5],'FaceAlpha',alpha, 'EdgeColor', 'none');
plot(k, top, 'g:', k, bottom, 'g:','LineWidth',linewidth-1);

top = mean(MeanPilBcyaBliq)+ std(MeanPilBcyaBliq);
bottom = mean(MeanPilBcyaBliq)- std(MeanPilBcyaBliq);
% inBetween = [top, fliplr(bottom)];
% fill(k2, inBetween, [0.5 1 1],'FaceAlpha',alpha, 'EdgeColor', 'none');
plot(k, top, 'c:', k, bottom, 'c:','LineWidth',linewidth-1);

legend('liquid', 'in pilG liquid', 'in cyaB liquid', 'Location', 'Best');
ylim([0 y_limit]);
title('pilB low cAMP');

figure(42);
hold on;
plot(k, mean(MeanPilHliq), 'b','LineWidth',linewidth);
plot(k, mean(MeanPilHsol), 'c','LineWidth',linewidth);
plot(k, mean(MeanPilGliq), 'r','LineWidth',linewidth);
plot(k, mean(MeanPilGsol), 'm','LineWidth',linewidth);

top = mean(MeanPilHliq)+ std(MeanPilHliq);
bottom = mean(MeanPilHliq)- std(MeanPilHliq);
% inBetween = [top, fliplr(bottom)];
% fill(k2, inBetween, [0.5 0.5 1],'FaceAlpha',alpha, 'EdgeColor', 'none');
plot(k, top, 'b--', k, bottom, 'b--','LineWidth',linewidth-1);

top = mean(MeanPilHsol)+ std(MeanPilHsol);
bottom = mean(MeanPilHsol)- std(MeanPilHsol);
% inBetween = [top, fliplr(bottom)];
% fill(k2, inBetween, [0.5 1 0.5],'FaceAlpha',alpha, 'EdgeColor', 'none');
plot(k, top, 'c:', k, bottom, 'c:','LineWidth',linewidth-1);

top = mean(MeanPilGliq)+ std(MeanPilGliq);
bottom = mean(MeanPilGliq)- std(MeanPilGliq);
% inBetween = [top, fliplr(bottom)];
% fill(k2, inBetween, [0.5 1 1],'FaceAlpha',alpha, 'EdgeColor', 'none');
plot(k, top, 'r:', k, bottom, 'r:','LineWidth',linewidth-1);

top = mean(MeanPilGsol)+ std(MeanPilGsol);
bottom = mean(MeanPilGsol)- std(MeanPilGsol);
% inBetween = [top, fliplr(bottom)];
% fill(k2, inBetween, [0.5 1 1],'FaceAlpha',alpha, 'EdgeColor', 'none');
plot(k, top, 'm:', k, bottom, 'm:','LineWidth',linewidth-1);

legend('pilH liquid', 'pilH solid', 'pilG liquid', 'pilG solid', 'Location', 'Best');
ylim([0 y_limit]);
title('Response Regulators');

%% polar ratios

BootN=300;

[RatPilUliq, BootRatPilUliq, MeanRatPilUliq, stdRatPilUliq]=polarRatios2(ProfilePilUliq, CellWidthPilUliq, CellLengthPilUliq, k, BootN);
[RatPilBliq, BootRatPilBliq, MeanRatPilBliq, stdRatPilBliq]=polarRatios2(ProfilePilBliq, CellWidthPilBliq, CellLengthPilBliq, k, BootN);
[RatPilBsol, BootRatPilBsol, MeanRatPilBsol, stdRatPilBsol]=polarRatios2(ProfilePilBsol, CellWidthPilBsol, CellLengthPilBsol, k, BootN);
[RatPilBpilHliq, BootRatPilBpilHliq, MeanRatPilBpilHliq, stdRatPilBpilHliq]=polarRatios2(ProfilePilBpilHliq, CellWidthPilBpilHliq, CellLengthPilBpilHliq, k, BootN);
[RatPilBpilGliq, BootRatPilBpilGliq, MeanRatPilBpilGliq, stdRatPilBpilGliq]=polarRatios2(ProfilePilBpilGliq,  CellWidthPilBpilGliq, CellLengthPilBpilGliq, k, BootN);
[RatPilBcpdAliq, BootRatPilBcpdAliq, MeanRatPilBcpdAliq, stdRatPilBcpdAliq]=polarRatios2(ProfilePilBcpdAliq,  CellWidthPilBcpdAliq, CellLengthPilBcpdAliq, k, BootN);
[RatPilBpilGcpdAliq, BootRatPilBpilGcpdAliq, MeanRatPilBpilGcpdAliq, stdRatPilBpilGcpdAliq]=polarRatios2(ProfilePilBpilGcpdAliq,  CellWidthPilBpilGcpdAliq, CellLengthPilBpilGcpdAliq, k, BootN);
[RatPilBcyaBliq, BootRatPilBcyaBliq, MeanRatPilBcyaBliq, stdRatPilBcyaBliq]=polarRatios2(ProfilePilBcyaBliq,  CellWidthPilBcyaBliq, CellLengthPilBcyaBliq, k, BootN);

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
histogram([RatPilBpilGcpdAliq.BR3,RatPilBpilGcpdAliq.BR2,RatPilBpilGcpdAliq.BR1],binsize, 'Normalization','probability', 'FaceColor', [255 193 102]/256 )
legend('liquid','in pilG liq','in cyaB liq','in pilg-cpdA-flic- liq','Location','best');
xlim([0,1]);
xlabel('polar ratio');
ylabel('probability');
title('PilB polarity');
ylim([0,0.15]);

DataMarker=8;
MedianMarkSize=10;
figure();
LegendsHighcAMP={'solid', 'in pilH liquid', 'in cpdA liquid', 'in pilG-cpdA-fliC- liquid'};
plot([1 1 1], MeanRatPilBsol,'ob',  [2 2 2], MeanRatPilBpilHliq, 'or', [3 3 3], MeanRatPilBcpdAliq,'om', [4 4 4], MeanRatPilBpilGcpdAliq,'og', 'MarkerSize', DataMarker)
hold on;
plot([1, 2, 3, 4],[mean(MeanRatPilBsol), mean(MeanRatPilBpilHliq), mean(MeanRatPilBcpdAliq), mean(MeanRatPilBpilGcpdAliq)], 'ok', 'MarkerSize', MedianMarkSize)
ICPilB_high=[[mean(MeanRatPilBsol)-std(MeanRatPilBsol); mean(MeanRatPilBpilHliq)-std(MeanRatPilBpilHliq); mean(MeanRatPilBcpdAliq)-std(MeanRatPilBcpdAliq); mean(MeanRatPilBpilGcpdAliq)-std(MeanRatPilBpilGcpdAliq)] [mean(MeanRatPilBsol)+std(MeanRatPilBsol); mean(MeanRatPilBpilHliq)+std(MeanRatPilBpilHliq); mean(MeanRatPilBcpdAliq)+std(MeanRatPilBcpdAliq); mean(MeanRatPilBpilGcpdAliq)+std(MeanRatPilBpilGcpdAliq)]];
for i=1:4
    plot([i i],ICPilB_high(i,:), 'k', 'LineWidth',2);
end

xlim([0,5]);
ylim([0,1]);
xticks(1:5);
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
[RatPilHliq, BootRatPilHliq, MeanRatPilHliq, stdRatPilHliq]=polarRatios2(ProfilePilHliq, CellWidthPilHliq, CellLengthPilHliq, k, BootN);
[RatPilGliq, BootRatPilGliq, MeanRatPilGliq, stdRatPilGliq]=polarRatios2(ProfilePilGliq,  CellWidthPilGliq, CellLengthPilGliq, k, BootN);
[RatPilHsol, BootRatPilHsol, MeanRatPilHsol, stdRatPilHsol]=polarRatios2(ProfilePilHsol, CellWidthPilHsol, CellLengthPilHsol, k, BootN);
[RatPilGsol, BootRatPilGsol, MeanRatPilGsol, stdRatPilGsol]=polarRatios2(ProfilePilGsol,  CellWidthPilGsol, CellLengthPilGsol, k, BootN);

figure;
binsize=30;
histogram([RatPilHliq.BR3,RatPilHliq.BR2,RatPilHliq.BR1],binsize,'Normalization','probability', 'FaceColor', [15 67 115]/256)
hold on;
histogram([RatPilHsol.BR3,RatPilHsol.BR2,RatPilHsol.BR1],binsize,'Normalization','probability', 'FaceColor', [30 136 229]/256 )
hold on;
histogram([RatPilGliq.BR3,RatPilGliq.BR2,RatPilGliq.BR1],binsize,'Normalization','probability', 'FaceColor', [26 255 26]/256)
hold on;
histogram([RatPilGsol.BR3,RatPilGsol.BR2,RatPilGsol.BR1],binsize, 'Normalization','probability', 'FaceColor', [239 123 239]/256 )

legend('pilH liquid','pilH solid','pilG liquid','pilG solid','Location','best');
xlim([0,1]);
xlabel('polar ratio');
ylabel('probability');
title('Response regulators');
ylim([0,0.15]);

DataMarker=8;
MedianMarkSize=10;
figure();
LegendsHighcAMP={'pilH liquid','pilH solid','pilG liquid','pilG solid'};
plot([1 1 1], MeanRatPilHliq,'ob',  [2 2 2], MeanRatPilHsol, 'or', [3 3 3], MeanRatPilGliq,'om', [4 4 4], MeanRatPilGsol,'og', 'MarkerSize', DataMarker)
hold on;
plot([1, 2, 3, 4],[mean(MeanRatPilHliq), mean(MeanRatPilHsol), mean(MeanRatPilGliq), mean(MeanRatPilGsol)], 'ok', 'MarkerSize', MedianMarkSize)
ICPilB_high=[[mean(MeanRatPilHliq)-std(MeanRatPilHliq); mean(MeanRatPilHsol)-std(MeanRatPilHsol); mean(MeanRatPilGliq)-std(MeanRatPilGliq); mean(MeanRatPilGsol)-std(MeanRatPilGsol)] [mean(MeanRatPilHliq)+std(MeanRatPilHliq); mean(MeanRatPilHsol)+std(MeanRatPilHsol); mean(MeanRatPilGliq)+std(MeanRatPilGliq); mean(MeanRatPilGsol)+std(MeanRatPilGsol)]];
for i=1:4
    plot([i i],ICPilB_high(i,:), 'k', 'LineWidth',2);
end

xlim([0,5]);
ylim([0,1]);
xticks(1:5);
xticklabels(LegendsHighcAMP);
%xtickangle(45);
title('Response regulators');
ylabel('PolarRatio');

toc