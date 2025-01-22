function subplots2figures
    hAx = findobj('type', 'axes');
    for iAx = 1:length(hAx)
        fNew = figure;
        hNew = copyobj(hAx(iAx), fNew);
        % Change the axes position so it fills whole figure
        set(hNew, 'pos', [0.23162 0.2233 0.72058 0.63107])
    end
end