function [sumXX, sumYY, sumXY, nPointsInXX, nPointsInYY, nPointsInXY] = new_rcaBase_computeCovariances(dataIn)
    % Initialize variables
    [nSubjs, nConds] = size(dataIn);
    [nDataSamples, nElectrodes, ~] = size(dataIn{1, 1});
    
    % Preallocate arrays
    preAllocated_4DMat = zeros(nConds, nSubjs, nElectrodes, nElectrodes);
    sumXX = preAllocated_4DMat;
    sumYY = preAllocated_4DMat;
    sumXY = preAllocated_4DMat;
    nPointsInXX = preAllocated_4DMat;
    nPointsInYY = preAllocated_4DMat;
    nPointsInXY = preAllocated_4DMat;
    
    % for parpool
    preAllocated_2DMat = zeros(nElectrodes, nElectrodes);
    sXX = preAllocated_2DMat;
    sYY = preAllocated_2DMat;
    sXY = preAllocated_2DMat;
    nXX = preAllocated_2DMat;
    nYY = preAllocated_2DMat;
    nXY = preAllocated_2DMat;
    
    parpoolOpen = false;
    % Loop over subjects and conditions
    for c = 1:nConds
        for s = 1:nSubjs
            fprintf('Computing covariances for subject %d/%d and condition %d/%d... \n', s, nSubjs, c, nConds);
            thisVolume = dataIn{s, c};

            if nDataSamples < nElectrodes
                warning('Number of samples is less than the number of electrodes'); 
            end
        
            nTrials = size(thisVolume, 3);
            pindx = combnk(1:nTrials, 2);
            pindx = cat(1, pindx, pindx(:, [2 1])); % Lucas' trick to ensure that Rxx=Ryy
            nPairs = size(pindx, 1);
            
            % offset by mean local to this subject-condition

            thisVolume_permuted = permute(thisVolume, [2 1 3]); % electrode x sample x trials
            thisMu = nanmean(thisVolume_permuted(:, :), 2);
            thisVolume2D = thisVolume_permuted(:, :) - repmat(thisMu, [1 nDataSamples*nTrials]);
            thisVolume_mc = reshape(thisVolume2D, [nElectrodes nDataSamples nTrials]);
                      
            p1 = pindx(:, 1);
            p2 = pindx(:, 2);    
            try
                if(c*s == 1)
                    parpool;
                    parpoolOpen = true;
                end            
                parfor p = 1:nPairs
                    M1 = squeeze(thisVolume_mc(:, :, p1(p)));
                    M2 = squeeze(thisVolume_mc(:, :, p2(p)));
                
                    nXX = nXX + double(~isnan(M1))*double(~isnan(M1))';
                    nYY = nYY + double(~isnan(M2))*double(~isnan(M2))';
                    nXY = nXY + double(~isnan(M1))*double(~isnan(M2))';
                
                    M1(isnan(M1)) = 0;
                    M2(isnan(M2)) = 0;
                
                    sXX = sXX + M1*M1';
                    sYY = sYY + M2*M2';
                    sXY = sXY + M1*M2';
                end
                nPointsInXX(c, s, :, :) = nXX;
                nPointsInYY(c, s, :, :) = nYY;
                nPointsInXY(c, s, :, :) = nXY;
                sumXX(c, s, :, :) = sXX;
                sumYY(c, s, :, :) = sYY;
                sumXY(c, s, :, :) = sXY;
                
                if 	(parpoolOpen) && (c*s == nConds*nSubjs)
                    delete(gcp('nocreate'));
                end
                
            catch err
                rcaExtra_displayError(err);
                % delete parpool
                if 	parpoolOpen
                    delete(gcp('nocreate'));
                end
                % continue with vectors
                M1 = squeeze(thisVolume_mc(:, :, p1));
                M2 = squeeze(thisVolume_mc(:, :, p2));
                
                M1 = M1(:, :);
                M2 = M2(:, :);
                
                nXX = nXX + double(~isnan(M1))*(double(~isnan(M1)))';
                nYY = nYY + double(~isnan(M2))*(double(~isnan(M2)))';
                nXY = nXY + double(~isnan(M1))*(double(~isnan(M2)))';
                
                M1(isnan(M1)) = 0;
                M2(isnan(M2)) = 0;
                
                sXX = sXX + M1*(M1)';
                sYY = sYY + M2*(M2)';
                sXY = sXY + M1*(M2)';   
                nPointsInXX(c, s, :, :) = nXX;
                nPointsInYY(c, s, :, :) = nYY;
                nPointsInXY(c, s, :, :) = nXY;
                sumXX(c, s, :, :) = sXX;
                sumYY(c, s, :, :) = sYY;
                sumXY(c, s, :, :) = sXY;                
            end
        end
    end
    % Squeeze the results to remove singleton dimensions
    sumXX = squeeze(sumXX);
    sumYY = squeeze(sumYY);
    sumXY = squeeze(sumXY);
    nPointsInXX = squeeze(nPointsInXX);
    nPointsInYY = squeeze(nPointsInYY);
    nPointsInXY = squeeze(nPointsInXY);
end
