function main_Standard_Oddball_analysis_freq
    
    experimentName = 'LochyRep';
    
    % load up expriment info specified in loadExperimentInfo_experimentName
    % matlab file
    
    try
        analysisStruct = feval(['loadExperimentInfo_' experimentName]);
    catch err
        % in case unable to load the designated file, load default file
        % (not implemented atm)
        rcaExtra_displayError(err);
        disp('Unable to load specific expriment settings, loading default');
        analysisStruct = loadExperimentInfo_Default;
    end
    
    
    % read raw data    
    
    analysisStruct.domain = 'freq';
    loadSettings = rcaExtra_getDataLoadingSettings(analysisStruct);
    loadSettings.subjTag = 'nl*';
    loadSettings.experiment = 'LochyRep';
    loadSettings.useBins = 1:10;
    loadSettings.useFrequencies = {'1F1', '2F1', '3F1', '4F1'};
    [subjList, EEGData, CN1, CN2, info] = getRawData(loadSettings);   
                              
    % rc settings
    rcSettings = rcaExtra_getRCARunSettings(analysisStruct);
    rcSettings.subjList = subjList;
    rcSettings.binsToUse = 1:10; 
    rcSettings.freqsUsed = 2;
    rcSettings.freqsToUse = {'1F1', '2F1', '3F1', '4F1'};
    rcSettings.nComp = 4;
    rcResult = cell(1, 3);
    
    %colorScheme_gray = 0.65*ones(1, 3);
    colorScheme_black = 0.15*ones(1, 3);

    plotSettings.groupLabel = 'Lochy Rep';
    plotSettings.colorMode = 'groupsconditions';
    plotSettings.colorOrder = 1;
    plotSettings.colorSceme = [];
    plotSettings.Markers = 'o';
    plotSettings.colorScheme = cat(1, colorScheme_black, colorScheme_black);
    close all;
    for nc = 1:3
        % copy RC template settings for each condition and modify if needed
        
        rcaSettings_cnd = rcSettings;
        rcaSettings_cnd.condsToUse = nc;
                
        rcaSettings_cnd.label = strcat('Condition', num2str(nc)) ;
        rcaSettings_cnd.useCnds = nc;
        rcResult{nc} = rcaExtra_runAnalysis(rcaSettings_cnd, EEGData, CN1, CN2);
        
        plotSettings.conditionLabels = [];
        plotSettings.groupLabel = strcat('Lochy Rep Condition ', num2str(nc));        
        plotSettings.RCsToPlot = 3;
        rcaExtra_plotCompareConditions_freq(plotSettings, rcResult{nc});       
    end  
end