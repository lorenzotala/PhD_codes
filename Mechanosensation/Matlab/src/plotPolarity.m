function [] = plotPolarity(Title, XLabel, Binsize, Binwidth, Colors, Legend,X_limit,Y_limit, varargin)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
figure
for i=9:nargin
    hold on;
    histogram([varargin{i-8}.BR3,varargin{i-8}.BR2,varargin{i-8}.BR1],Binsize,'Normalization','probability', 'FaceColor', Colors(i-8,:)/256, 'BinWidth', Binwidth)
end

legend(Legend,'Location','best');
xlim(X_limit);
xlabel(XLabel);
ylabel('probability');
title(Title);
ylim(Y_limit);
end

