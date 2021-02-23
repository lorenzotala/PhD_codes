% here I analyze Lorenzo data:
% only Pil_B_mNG_ on SOLIDE

clear all
close all

% addpath('X:\Lorenzo_WS\LorenzoData_assymetry_data');
addpath('C:\Users\tala\Desktop\backstal\Download_code\src\data');
limit_ratio=0.69;
%% insert needed data
name={'DataSet_pilB_mNG_liq_BR=';'DataSet_pilB_mNG_3hsol_BR=';'DataSet_pilB_mNG_pilH-_liq_BR=';...
'DataSet_pilB_mNG_cpdA-_liq_BR=';'DataSet_pilB_mNG_pilG-_liq_BR=';'DataSet_pilB_mNG_cyaB-_liq_BR=';...
'DataSet_pilB_mNG_pilG-cpdA-fliC-_liq_BR='; 'DataSet_mNG_pilH_liq_BR='; 'DataSet_mNG_pilH_sol_BR=';...
'DataSet_mNG_pilG_liq_BR='; 'DataSet_mNG_pilG_sol_BR='};

Data=cell(size(name,1),3);
figure
for m=1:1:size(name,1)
    
for i=1:1:3
    nom=strcat(name{m},num2str(i),'.mat')
    Data_tmp{i,1}=nom;
    [Data_tmp{i,2}]=get_data(nom);
    
    for l=1:1:size(Data_tmp{i,2},1)
    Data_tmp{i,2}(l,3)=min(Data_tmp{i,2}(l,1:2))/max(Data_tmp{i,2}(l,1:2));
    Data_tmp{i,2}(l,4)=Data_tmp{i,2}(l,3)<limit_ratio; %1 if YES asymmetric
    end
    
    Data_tmp{i,3}=sum(Data_tmp{i,2}(:,4))/size(Data_tmp{i,2},1)*100;
end
Data{m}=Data_tmp;
end
%% GRAPH
close all;
colors=[[0 0.5 0.7]; [0 0.5 0.8]; [1 0.5 0.2]; [0.9 0.4 0.6]; [0 1 0]; [0.3 0.6 0.6]; [0 1 0]; [0.5 1 1]; [1 0.5 1]; [1 1 0.5]; [0.3 0.6 0.6]; [0 1 0]; [0.5 1 1]; [1 0.5 1]; [1 1 0.5]];
for m=1:1:size(Data,1)
    for i=1:1:3
        hold on
        plot(m,Data{m,1}{i,3},'ok','MarkerFaceColor',colors(m,:),'MarkerSize', 8);
    end
    hold on
    plot([m-0.25 m+0.25], [mean([Data{m,1}{:,3}]) mean([Data{m,1}{:,3}])], 'k','Linewidth',2);
    plot([m m], [mean([Data{m,1}{:,3}])-std([Data{m,1}{:,3}]) mean([Data{m,1}{:,3}])+std([Data{m,1}{:,3}])], 'k','Linewidth',2);
end
set(gca, 'XTickLabel',{'liquid';'solid';'in pilH- liquid';'in cpdA liquid';'in pilG liq';'in cyaB liq';'in pilG-cpdA-fliC-';'pilH liq'; 'pilH sol'; 'pilG liq'; 'pilG sol'}, 'Fontsize',15)
ylabel('Asymmetric cell [%]')
% title('All cells');
axis([0 m+1 0 100])
xticks([1:1:m])
xtickangle(45);

%%
pathCell = regexp(path, pathsep, 'split');
if ispc  % Windows is not case-sensitive
  onPath = any(strcmpi(Folder, pathCell));
else
  onPath = any(strcmp(Folder, pathCell));
end