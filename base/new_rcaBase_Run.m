function [dataOut, W, A, Rxx, Ryy, Rxy, dGen, plotSettings] = new_rcaBase_Run(data, nReg, nComp, plotStyle, show)
    % Check and set default values for optional arguments
    if nargin < 5 || isempty(show), show = false; end
    if nargin < 4 || isempty(plotStyle), plotStyle = 'matchMaxSignsToRc1'; end
    if nargin < 3 || isempty(nComp), nComp = 3; end
    if nargin < 2 || isempty(nReg), nReg = []; end
    if nargin < 1 || isempty(data), error('At least one argument is required'); end

    % Compute un-normalized covariances and keep track of the number of non-NaN data points
    tic
    [sumXX, sumYY, sumXY, nPointsInXX, nPointsInYY, nPointsInXY] = new_rcaBase_computeCovariances(data);
    toc
    tic
    [sumXX_1, sumYY_1, sumXY_1, nPointsInXX_1, nPointsInYY_1, nPointsInXY_1] = preComputeRcaCovariancesLoop(data);
    toc
    % Accumulate covariances across selected conditions/subjects
    fprintf('Accumulating covariance across selected conditions/subjects... \n');
    [Rxx, Ryy, Rxy] = new_rcaBase_accumulateCovariances(sumXX, sumYY, sumXY, nPointsInXX, nPointsInYY, nPointsInXY);

    % Train RCA spatial filters
    [W, A, ~, dGen, Kout] = new_rcaBase_Train(Rxx, Ryy, Rxy, nReg, nComp);

    % Project data into RCA space
    dataOut = new_rcaBase_Project(data, W);

    % Plot results if 'show' is true
    if show
        plotSettings = new_rcaBase_Plot(A, Rxx, Ryy, dGen, Kout, plotStyle);
    else
        plotSettings = [];
    end
end
