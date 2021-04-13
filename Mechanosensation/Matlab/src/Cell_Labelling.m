%% Initialization
close all; clear all; clc;
Data_dir='DataColocalization/DataSet_1006_2h37_mNG_FimX_mScI_PilG.mat';
newStr = split(Data_dir,'/');
Name=split(newStr(2),'.');
save_dir=strcat('DataColocalization/',Name(1));
mkdir(char(save_dir));
DataSet=load(Data_dir);
contrast_bounds=[0.0003 0.005];
fontSize=10;

PixSize=str2double(DataSet.params.Scaling.String);
Cell_Length=10;  % µm
%% Get Total number of cells that match the constraints: Not deleted and smaller than a cell length
NbFrames=max(size(DataSet.frames));
LenInPix= Cell_Length/PixSize;
NbCells=zeros(NbFrames,1); NbCellsKept=zeros(NbFrames,1); totCells=0; totKeptCells=0;
for i=1:NbFrames
    NbCells(i)=max(size(DataSet.frames(i).cells.Stats));
    n=zeros(NbCells(i),1);
    for j=1:NbCells(i)
        if ((~DataSet.frames(i).cells.Stats(j).CellDeleted) &&(DataSet.frames(i).cells.Stats(j).CellLength)< LenInPix)
            n(j)=0;
        else
            n(j)=1;
        end
    end
    NbCellsKept(i)=length(find(n==0));
    totCells=totCells+NbCells(i);
    totKeptCells=totKeptCells+NbCellsKept(i);

end 

%% Labelling
k=1;
Tot_CellID=[];
Frames=[];
for h=1:NbFrames
    path_Fimx=DataSet.frames(h).mNG_Fimx;
    I_Fimx = imread(path_Fimx);
    J_Fimx = imadjust(I_Fimx,contrast_bounds);
    I2_Fimx = adapthisteq(J_Fimx);
    path_PilG=DataSet.frames(h).mScI_PilG;
    I_PilG = imread(path_PilG);
    J_PilG = imadjust(I_PilG,contrast_bounds);
    I2_PilG = adapthisteq(J_PilG);
    path_PC=DataSet.frames(h).PhaseContrast;
    I_PC = imread(path_PC);
    J_PC = imadjust(I_PC);
    I2_PC =J_PC;
    CellID=zeros(NbCellsKept(h), 1);
    l=1;
    for i=1:NbCells(h)
        if((~DataSet.frames(h).cells.Stats(i).CellDeleted) && (DataSet.frames(h).cells.Stats(i).CellLength)< LenInPix)
            CellID(l)=DataSet.frames(h).cells.Stats(i).('CellID');
            l=l+1;
        end
    end
    disp(strcat('Labeling of: ',num2str(length(CellID)), ' cells in frame ', num2str(h)));
    Tot_CellID=[Tot_CellID;CellID];
    temp=ones(length(CellID),1)*h;
    Frames=[Frames;temp];
    
    set(gcf, 'units','normalized','outerposition',[0 1 0.9 0.5]);
    for Cell=transpose(CellID)
        disp(strcat('Cell - ', num2str(Cell)));
        Centroid=DataSet.frames(h).cells.Stats(Cell).Centroid;
        CellLength=DataSet.frames(h).cells.Stats(Cell).CellLength;
        CellWidth=DataSet.frames(h).cells.Stats(Cell).CellWidth;
        CellOutline=DataSet.frames.cells.Stats(h).CellOutlineCoordinates;
        MedialAxis=DataSet.frames.cells.Stats(h).CellMedialAxisCoordinates;
        IntensityProfile_Fimx=DataSet.frames(h).cells.Stats(Cell).MedialAxisIntensity_mNG_Fimx;
        IntensityProfile_PilG=DataSet.frames(h).cells.Stats(Cell).MedialAxisIntensity_mScI_PilG;
        x1=round(Centroid(1)-CellLength);
        y1=round(Centroid(2)-CellLength);
        x2=round(Centroid(1)+CellLength);
        y2=round(Centroid(2)+CellLength);
        croppedImage_Fimx = I2_Fimx(y1:y2,x1:x2);
        croppedImage_PilG = I2_PilG(y1:y2,x1:x2);
        croppedImage_PC = I2_PC(y1:y2,x1:x2);
        mNG_Fimx_corr=[x1+1, y1-2];
        mNG_PilG_corr=[x1-1, y1-1];
        fig=figure(1);
        
        subplot(2,3,2);
        imshow(croppedImage_Fimx);
        axis on;
        title(strcat('Frame ',num2str(h) ,' - Cell  ',num2str(Cell), 'FimX'), 'FontSize', fontSize);
        hold on;
        plot(CellOutline(:,2)-mNG_Fimx_corr(1),CellOutline(:,1)-mNG_Fimx_corr(2), 'Color', [0.9, 0.7, 0.2], 'LineWidth', 0.5);
        plot(MedialAxis(1,2)-mNG_Fimx_corr(1),MedialAxis(1,1)-mNG_Fimx_corr(2), 'og', 'MarkerSize', CellWidth*0.5, 'MarkerFace','g');
        subplot(2,3,3);
        imshow(croppedImage_PilG);
        axis on;
        hold on;
        plot(CellOutline(:,2)-mNG_PilG_corr(1),CellOutline(:,1)-mNG_PilG_corr(2), '-r', 'LineWidth', 0.5);
        plot(MedialAxis(1,2)-mNG_PilG_corr(1),MedialAxis(1,1)-mNG_PilG_corr(2), 'og', 'MarkerSize', CellWidth*0.5, 'MarkerFace','g');
        title(strcat('Frame ',num2str(h) ,' - Cell  ',num2str(Cell), 'PilG'), 'FontSize', fontSize);
        subplot(2,3,1);
        imshow(croppedImage_PC);
        axis on;
        title(strcat('Frame ',num2str(h) ,' - Cell  ',num2str(Cell), 'Fluorescence'), 'FontSize', fontSize);
        subplot(2,3,5);
        plot(IntensityProfile_Fimx, 'Color', [0.9, 0.7, 0.2]);
        hold on;
        plot(IntensityProfile_Fimx(1),'og', 'MarkerSize', CellWidth*0.5, 'MarkerFace','g');
        truesize(fig,[400 400])
        subplot(2,3,6);
        plot(IntensityProfile_PilG, '-r');
        hold on;
        plot(IntensityProfile_PilG(1),'og', 'MarkerSize', CellWidth*0.5, 'MarkerFace','g');
        truesize(fig,[400 400])
        
        [x,y]=ginput(2);
        
        %Fimx computation
        Start_Profile_mNG_Fimx=[MedialAxis(1,2)-mNG_Fimx_corr(1),MedialAxis(1,1)-mNG_Fimx_corr(2)];
        End_Profile_mNG_Fimx=[MedialAxis(length(MedialAxis),2)-mNG_Fimx_corr(1),MedialAxis(length(MedialAxis),1)-mNG_Fimx_corr(2)];
        Start_dist_mNG_Fimx=norm(Start_Profile_mNG_Fimx-[x(1),y(1)]);
        End_dist_mNG_Fimx=norm(End_Profile_mNG_Fimx-[x(1),y(1)]);
        Bpole_Fimx=0;
        if End_dist_mNG_Fimx < Start_dist_mNG_Fimx
            Bpole_Fimx=1;
        end

        %PilG computation
        Start_Profile_mNG_PilG=[MedialAxis(1,2)-mNG_PilG_corr(1),MedialAxis(1,1)-mNG_PilG_corr(2)];
        End_Profile_mNG_PilG=[MedialAxis(length(MedialAxis),2)-mNG_PilG_corr(1),MedialAxis(length(MedialAxis),1)-mNG_PilG_corr(2)];
        Start_dist_mNG_PilG=norm(Start_Profile_mNG_PilG-[x(2),y(2)])
        End_dist_mNG_PilG=norm(End_Profile_mNG_PilG-[x(2),y(2)])
        Bpole_PilG=0;
        if End_dist_mNG_PilG < Start_dist_mNG_PilG
            Bpole_PilG=1;
        end

        %Colocalization
        Colocalization = 0;
        if not(xor(Bpole_Fimx,Bpole_PilG))
            Colocalization = 1;
        end
       
        subplot(2,3,2);
        hold on;
        plot(x(1),y(1), 'oy', 'MarkerSize', CellWidth*2);
        subplot(2,3,3);
        hold on;
        plot(x(2),y(2), 'or', 'MarkerSize', CellWidth*2);
        
        Results=['do not colocalize', 'colocalize'];
        prompt = {strcat('FimX and PilG',' ', Results(Colocalization+1))};
        dlgtitle = 'Input';
        dims = [1 50];
        answer(k) = Colocalization;
        
        imwrite(croppedImage_Fimx,char(strcat(save_dir, '/FimX_Frame',num2str(h) ,'_Cell',num2str(Cell),'.png')),'png')
        imwrite(croppedImage_PilG,char(strcat(save_dir, '/PilG_Frame',num2str(h) ,'_Cell',num2str(Cell),'.png')),'png')
        k=k+1;
        hold off;
    end
    
    csvwrite(char(strcat(save_dir,'/','Frame ',num2str(h) ,'CellID.csv')),CellID);
end
answer=transpose(answer);
csvwrite(char(strcat(save_dir,'/',Name(1),'_Colocalization.csv')),answer);
%%

combined_data=[Frames,Tot_CellID,answer];
cHeader = {'Frame' 'CellID' 'Label'}; %dummy header
commaHeader = [cHeader;repmat({','},1,numel(cHeader))]; %insert commaas
commaHeader = commaHeader(:)';
textHeader = cell2mat(commaHeader); %cHeader in text with commas
%write header to file
fid = fopen(strcat(save_dir,'/',Name(1),'_FrameIDLabels.csv'),'w'); 
fprintf(fid,'%s\n',textHeader);
fclose(fid);
%write data to end of file
dlmwrite(char(strcat(save_dir,'/',Name(1),'_FrameIDLabels.csv')),combined_data,'-append');
