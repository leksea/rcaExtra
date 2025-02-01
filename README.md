Readme for rcaExra Repository
```
**Folder Structure**
├── LICENSE
├── README.md
├── base
│   ├── new_rcaBase_Plot.m
│   ├── new_rcaBase_Project.m
│   ├── new_rcaBase_ProjectData.m
│   ├── new_rcaBase_Run.m
│   ├── new_rcaBase_Train.m
│   ├── new_rcaBase_accumulateCovariances.m
│   ├── new_rcaBase_computeCovariances.m
│   ├── preComputeRcaCovariancesLoop.m
│   ├── rcaProject.m
│   ├── rcaRun.m
│   └── rcaTrain.m
├── common
│   ├── getRawData.m
│   ├── projectDatasets.m
│   ├── rcaBase_Project.m
│   ├── rcaExtra_adjustRCSigns.m
│   ├── rcaExtra_adjustRCWeights.m
│   ├── rcaExtra_compareRCASettings_freq.m
│   ├── rcaExtra_computeAverages.m
│   ├── rcaExtra_displayError.m
│   ├── rcaExtra_genStructureTemplate.m
│   ├── rcaExtra_getDataLoadingSettings.m
│   ├── rcaExtra_getRCARunSettings.m
│   ├── rcaExtra_getStatsSettings.m
│   ├── rcaExtra_mergeDatasetConditions.m
│   ├── rcaExtra_prepareDataArrayForStats.m
│   ├── rcaExtra_prepareDataForStats.m
│   ├── rcaExtra_projectDataSubset.m
│   ├── rcaExtra_runAnalysis.m
│   ├── rcaExtra_selectConditionsSubset.m
│   └── rcaExtra_setupDestDir.m
├── examples
│   ├── loadExperimentInfo_AttnDispTD.m
│   ├── loadExperimentInfo_Exports_6Hz.m
│   ├── loadExperimentInfo_LochyRep.m
│   ├── loadExperimentInfo_Lochy_Oddball.m
│   ├── main_Lochy_Oddball_analysis_freq.m
│   ├── main_Lochy_Oddball_analysis_time.m
│   ├── main_Standard_Oddball_analysis_freq.m
│   ├── main_Standard_Oddball_analysis_time.m
│   └── rcaExtra_sensorSpaceAnalysis.m
├── frequency
│   ├── angleStats_jcn_complex.m
│   ├── averageBinsPerTrials.m
│   ├── averageBinsTrials.m
│   ├── averageFrequencyData.m
│   ├── averageProject.m
│   ├── averageSensor_freq.m
│   ├── averageSubjectFrequencyData.m
│   ├── averageSubjects.m
│   ├── calculatewRSSQ.m
│   ├── computeAmpPhase.m
│   ├── computeErrorProj.m
│   ├── computeErrorSubj.m
│   ├── eigFourierCoefs.m
│   ├── errorEllipse.m
│   ├── exportFrequencyData.m
│   ├── exportFrequencyData_beta.m
│   ├── extractAmpPhase.m
│   ├── extractDataSubset.m
│   ├── fitErrorEllipse.m
│   ├── fitErrorEllipse_3D.m
│   ├── getRealImag.m
│   ├── getRealImag_byBin.m
│   ├── new_runRCA_frequency.m
│   ├── pctNaNSamples.m
│   ├── projectProjData.m
│   ├── projectSubjData.m
│   ├── projectSubjectAmplitudes.m
│   ├── rcaExtra_analyzeFrequencyDataset.m
│   ├── rcaExtra_averageRSSQData.m
│   ├── rcaExtra_calcRSSQStats.m
│   ├── rcaExtra_computeLatencies.m
│   ├── rcaExtra_computeLatenciesWithSignificance.m
│   ├── rcaExtra_computeRSS.m
│   ├── rcaExtra_computeSubjectLatencies.m
│   ├── rcaExtra_createSensorSpaceStruct.m
│   ├── rcaExtra_getXDivaTextHeaderTable.m
│   ├── rcaExtra_normalizeByErr_post.m
│   ├── rcaExtra_projectFrequencyData.m
│   ├── rcaExtra_reshapeBinsToTrials.m
│   ├── rcaExtra_returnSignificantResult_frequency.m
│   ├── rcaExtra_testRSSQFactors.m
│   ├── rcaRunLite.m
│   ├── reBinSession.m
│   ├── readFrequencyDataTXT.m
│   ├── readRawEEG_freq.m
│   ├── readRawEEG_freq_MFD.m
│   ├── removeNaNTrials.m
│   ├── reshapeTrialToBinForRCA.m
│   ├── runRCA_frequency.m
│   └── unwrapPhases.m
├── plotting
│   ├── EGInetFaces.m
│   ├── EGInetFaces256.m
│   ├── EGInetFaces32.m
│   ├── _plotIndividualSubjectFrequency.m
│   ├── _rcaExtra_plotSinCos_freq.m
│   ├── colorbrewer.mat
│   ├── customErrPlot.m
│   ├── defaultFlatNet.mat
│   ├── expandAMatrixTo128Channels.m
│   ├── jmaColors.m
│   ├── plotOnEgi.m
│   ├── plotSummary_AmplitudeBars.m
│   ├── plotSummary_TopoMaps.m
│   ├── plotSummary_Waveforms.m
│   ├── plot_addStatsBar_freq.m
│   ├── plot_addStatsBar_time.m
│   ├── plotdGen.m
│   ├── rcaExtra_addPlotOptionsToData.m
│   ├── rcaExtra_barplot_freq.m
│   ├── rcaExtra_compareTopoMaps.m
│   ├── rcaExtra_initPlottingContainer.m
│   ├── rcaExtra_latplot_freq.m
│   ├── rcaExtra_loliplot_freq.m
│   ├── rcaExtra_noiseplot_freq.m
│   ├── rcaExtra_plotAmplitudeWithStats.m
│   ├── rcaExtra_plotAmplitudes.m
│   ├── rcaExtra_plotLatencies.m
│   ├── rcaExtra_plotLogAmplitudes.m
│   ├── rcaExtra_plotLollipops.m
│   ├── rcaExtra_plotLollipopsSubj.m
│   ├── rcaExtra_plotPolarAmp.m
│   ├── rcaExtra_plotRCSummary.m
│   ├── rcaExtra_plotResults.m
│   ├── rcaExtra_plotSubjsAmplitudes.m
│   ├── rcaExtra_plotWaveforms.m
│   ├── rcaExtra_plotrssqFactors.m
│   ├── rcaExtra_sincos_freq.m
│   ├── rcaExtra_splitPlotDataByCondition.m
│   ├── setAxisAtTheOrigin.m
│   ├── setAxisAtTheOrigin_cell.m
│   ├── shadedErrorBar.m
│   ├── subplots2figures.m
│   └── tight_subplot.m
├── stats
│   ├── CritT.m
│   ├── _computeStatsFreq.m
│   ├── _computeStatsFreqBetween.m
│   ├── _getBetweenConditionsStats.m
│   ├── _getBetweenPopulationStats.m
│   ├── fdrCorrection.m
│   ├── jcn_error_estimate.m
│   ├── mbox.m
│   ├── rcaExtra_HTSquared_d.m
│   ├── rcaExtra_HTSquared_i.m
│   ├── rcaExtra_runStatsAnalysis.m
│   ├── rcaExtra_testSignificance.m
│   ├── rcaExtra_ttestPermute.m
│   ├── reshapeDataForStats.m
│   ├── tTest_between.m
│   ├── tcirc.m
│   ├── ttest_between_pvalueOnly_time.m
│   ├── ttest_paired.m
│   ├── ttest_permute_between.m
│   └── ttest_unpaired.m
├── test
│   ├── testWeightFlipping.m
│   └── test_plot_SignificantAmplitudes.m
├── time
│   ├── _rcaProjectData.m
│   ├── _reshapeRawData.m
│   ├── averageSensor_time.m
│   ├── baselineDataTime.m
│   ├── fft_epoch.m
│   ├── ifft_epoch.m
│   ├── rcaExtra_compareRCASettings_time.m
│   ├── rcaExtra_filter4DData.m
│   ├── rcaExtra_filterData.m
│   ├── readAXXEEG.m
│   ├── readRawData.m
│   ├── readRawEEG_time.m
│   ├── resampleData.m
│   ├── reshapeEpochsToTrial.m
│   ├── reshapeTrialToEpochs.m
│   └── runRCA_time.m
└── toolbox
    ├── ParseArgs.m
    ├── allcomb.m
    ├── dir2.m
    ├── interleave.m
    ├── list_folder.m
    ├── my_repelem.m
    ├── num2bits.m
    ├── polyparci.m
    ├── weightedcov.m
    └── wmean
        ├── license.txt
        └── wmean.m
```
**Directory Overview**
* base -- contains scripts copied from [rcaBase](https://github.com/svndl/rcaBase), as well as refactored (currently not in use) scripts. The scripts are not in sync with the rcaBase repo. 
* common -- higher-level wrapper scripts around domain-specific analysis.
* examples -- examples of the analysis use (sans data). The pipeline is designed to work with xDiva-specific data exports in time and frequency domains.
* frequency -- frequency-specific analysis scripts, data loading, slicing, processing.
* time -- time-specific analysis scripts, data loading, slicing, processing.
* plotting -- a collection of various plotting templates for time and frequency-domain data. Most of the scripts require post-processed data, i.e.averages and errors (std or sem).
* stats -- statistics used in the pipeline.
* test -- tests used in the pipeline.
* toolbox -- misc scripts (sourced from Matlab's package) used in the pipeline.

**Publication Links** 

[Cognitive penetrability of scene representations based on horizontal image disparities](https://pubmed.ncbi.nlm.nih.gov/36284130/)

[Preferential Loss of Contrast Decrement Responses in Human Glaucoma](https://pubmed.ncbi.nlm.nih.gov/36264656/)

[Dynamics of Contrast Decrement and Increment Responses in Human Visual Cortex](https://pubmed.ncbi.nlm.nih.gov/32953246/)


