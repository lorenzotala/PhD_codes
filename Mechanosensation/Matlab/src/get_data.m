function [data_ordored]=get_data(nom)
% here I order take ALL the data from each Biological Replicate which
% contains 5/6 frames each.
load(nom,'frames');

nbr_frames=size(frames,1);
j=0;
for f=1:1:nbr_frames
    data_brut=frames(f).cells.Stats; 
    for nbr=1:1:size(data_brut,1)
        j=j+1;
       axis_intensity=data_brut(nbr).MedialAxisIntensity_mNeonGreen;
       l=length(axis_intensity);
       nbr_to_consider=floor(0.15*l);
       mean1=mean(axis_intensity(1,1:1+nbr_to_consider));
       mean2=mean(axis_intensity(1,l-nbr_to_consider:l));
       
       data_ordored(j,1)=mean1;
       data_ordored(j,2)=mean2;
    end
    
end
end
