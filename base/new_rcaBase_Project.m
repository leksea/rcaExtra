function Y = new_rcaBase_Project(data, W)
    % Y = RCAPROJECT(DATA, W)
    %
    % data: 3-D array of epoched data (samples x channels x trials)
    % W: matrix of RCA projection vectors (channels x component)
    %
    % Y: RCA projected data (samples x components x trials)
    %
    % This function efficiently computes the RCA projected data while
    % handling missing data (NaNs) in the input.
    %
    % (c) Jacek P. Dmochowski, 2014

    if ~iscell(data)
        [nSamples, nElectrodes, nTrials] = size(data);
        nComp = size(W, 2);

        % Initialize output Y
        Y = zeros(nSamples, nComp, nTrials);

        % Compute Y component by component
        for comp = 1:nComp
            W_comp = W(:, comp)';

            % Reshape W_comp to perform element-wise multiplication
            W_comp = reshape(W_comp, [1, nElectrodes]);

            % Perform element-wise multiplication and sum along the electrode dimension
            Y(:, comp, :) = sum(bsxfun(@times, data, W_comp), 2);
        end

        % Handle NaNs in data
        nan_idx = all(isnan(data), 2);
        Y(repmat(nan_idx, [1, nComp, 1])) = NaN;
    else
        [nCond, nSubjects] = size(data);
        nComp = size(W, 2);
        Y = cell(nCond, nSubjects);

        for c = 1:nCond
            for s = 1:nSubjects
                data3D = data{c, s};
                [nSamples, nElectrodes, nTrials] = size(data3D);
                nComp = size(W, 2);

                % Initialize output Y for this condition and subject
                Y{c, s} = zeros(nSamples, nComp, nTrials);

                % Compute Y component by component
                for comp = 1:nComp
                    W_comp = W(:, comp)';

                    % Reshape W_comp to perform element-wise multiplication
                    W_comp = reshape(W_comp, [1, nElectrodes]);

                    % Perform element-wise multiplication and sum along the electrode dimension
                    Y{c, s}(:, comp, :) = sum(bsxfun(@times, data3D, W_comp), 2);
                end

                % Handle NaNs in data
                nan_idx = all(isnan(data3D), 2);
                Y{c, s}(repmat(nan_idx, [1, nComp, 1])) = NaN;
            end
        end
    end
end
