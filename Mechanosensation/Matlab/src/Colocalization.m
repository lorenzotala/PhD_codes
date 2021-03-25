clear all; close all; clc;
Path = "C:\Users\lorenzo\Desktop\git\PhD_codes\Mechanosensation\Matlab\src\DataColocalization\";
k=linspace(-1,1,200);
Cell_Length=10;
[ Mean_FimX, Std_FimX, N_FimX, Profiles_FimX, FluoMean_FimX, CellWidth_FimX, CellLength_FimX, CellID_FimX, Flip_signal_FimX] = getMeanProfile2( strcat(Path,"DataSet_1006_2h37_mNG_FimX_mScI_PilG.mat"), 200, "mNG_Fimx", Cell_Length );
[ Mean_PilG, Std_PilG, N_PilG, Profiles_PilG, FluoMean_PilG, CellWidth_PilG, CellLength_PilG, CellID_PilG, Flip_signal_PilG] = getMeanProfile2( strcat(Path,"DataSet_1006_2h37_mNG_FimX_mScI_PilG.mat"), 200, "mScI_PilG", Cell_Length );
plot(k, Mean_FimX);
hold on;
plot(k, Mean_PilG);
hold off;
col=['b', 'r'];
figure
for i=1:size(Profiles_FimX,1)
    subplot(8,9,i);
    plot(k, Profiles_FimX(i,:),'Color',col(1));
    hold on;
    plot(k, Profiles_PilG(i,:),'Color',col(2));
end

f = msgbox('Altogether our data shows that FimX colocalizes with PilG and that Chp mediates Mechanotaxis', 'Results');