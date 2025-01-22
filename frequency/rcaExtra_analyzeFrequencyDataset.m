function rcaExtra_analyzeFrequencyDataset(varargin)
% point to RLS directory 

    [curr_path, ~, ~] = fileparts(mfilename('fullpath'));
    if(isempty(varargin))
        pathToFolder = uigetdir(curr_path, 'Select MAT data source results directory');
    else
        pathToFolder = varargin{1};
    end
    
    sourceData = pathToFolder;

    %% list subjects
    
    list_subj = list_folder(fullfile(sourceData, '*RLS.mat'));

    subjs = {list_subj(:).name};
    nsubj = numel(subjs);
    
    datasetBinLabels_12 = {};
    datasetFrequencyLabels_12 = {}; 
    datasetNaNs_12 = {};

    datasetBinLabels_8 = {};
    datasetFrequencyLabels_8 = {}; 
    datasetNaNs_8 = {};
    
    if (nsubj > 0)
        for s = 1:nsubj
            try
                display(['Loading  ' subjs{s}]);
                load(fullfile(sourceData, subjs{s}));
                % add info into datsert table
                if numel(info.binLabels') == 12
                    subj_12b{s} = subjs{s};
                    datasetBinLabels_12(s, :) = info.binLabels';
                    datasetFrequencyLabels_12(s, :) = info.freqLabels';
                    datasetNaNs_12(s, :) = cellfun(@(x) pctNaNSamples(x), signalData', 'uni', false);
                elseif numel(info.binLabels') == 8 
                    subj_8b{s} = subjs{s};
                    datasetBinLabels_8(s, :) = info.binLabels';
                    datasetFrequencyLabels_8(s, :) = info.freqLabels';
                    datasetNaNs_8(s, :) = cellfun(@(x) pctNaNSamples(x), signalData', 'uni', false);
                end
            catch err
                rcaExtra_displayError(err)
                display(['Warning, could not load data from: ' subjs{s}]);
            end
        end
    end
    
    
    datasetFrequencyLabels12b = cellfun(@(x) x', datasetFrequencyLabels_12, 'uni', false);
    tableFileName_12b=  fullfile(sourceData, 'DatasetInfo_12b.xlsx');
    % break into conditions and compile tables
    nConditions = size(datasetBinLabels_12, 2);
    for nc = 1:nConditions
        tb = table(subj_12b', datasetBinLabels_12(:, nc), datasetFrequencyLabels12b(:, nc), ...
            datasetNaNs_12(:, nc), ...
            'VariableNames', {'ID', 'Bins', 'Frequencies', 'PercentNaNs'});
        writetable(tb, tableFileName_12b, 'sheet', nc);
    end
    
    datasetFrequencyLabels8b = cellfun(@(x) x', datasetFrequencyLabels_8, 'uni', false);
    tableFileName_8b=  fullfile(sourceData, 'DatasetInfo_8b.xlsx');
    % break into conditions and compile tables
    nConditions = size(datasetBinLabels_8, 2);
    for nc = 1:nConditions
        tb = table(subj_8b', datasetBinLabels_8(:, nc), datasetFrequencyLabels8b(:, nc), ...
            datasetNaNs_8(:, nc), ...
            'VariableNames', {'ID', 'Bins', 'Frequencies', 'PercentNaNs'});
        writetable(tb, tableFileName_8b, 'sheet', nc);
    end
    
end
