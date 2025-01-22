function [Rxx, Ryy, Rxy] = new_rcaBase_accumulateCovariances(sumXX, sumYY, sumXY, nPointsInXX, nPointsInYY, nPointsInXY)
    % Initialize covariance matrices
    Rxx = zeros(size(sumXX));
    Ryy = zeros(size(sumYY));
    Rxy = zeros(size(sumXY));

    % Accumulate covariances across selected conditions/subjects
    switch ndims(sumXX)
        case 2  % channels x channels
            Rxx = sumXX ./ nPointsInXX;
            Ryy = sumYY ./ nPointsInYY;
            Rxy = sumXY ./ nPointsInXY;
        case 3 % cond x channels x channels OR subjects x channels x channels
            Rxx = squeeze(sum(sumXX, 1)) ./ squeeze(sum(nPointsInXX, 1));
            Ryy = squeeze(sum(sumYY, 1)) ./ squeeze(sum(nPointsInYY, 1));
            Rxy = squeeze(sum(sumXY, 1)) ./ squeeze(sum(nPointsInXY, 1));
        case 4  % cond x subj x channels x channels
            [condNum, subjNum, ~, ~] = size(sumXX);

            if subjNum > 1 && condNum > 1
                Rxx = squeeze(sum(squeeze(sum(sumXX, 2)), 1)) ./ squeeze(sum(squeeze(sum(nPointsInXX, 2)), 1));
                Ryy = squeeze(sum(squeeze(sum(sumYY, 2)), 1)) ./ squeeze(sum(squeeze(sum(nPointsInYY, 2)), 1));
                Rxy = squeeze(sum(squeeze(sum(sumXY, 2)), 1)) ./ squeeze(sum(squeeze(sum(nPointsInXY, 2)), 1));
            elseif condNum == 1
                Rxx = squeeze(sum(sumXX, 2)) ./ squeeze(sum(nPointsInXX, 2));
                Ryy = squeeze(sum(sumYY, 2)) ./ squeeze(sum(nPointsInYY, 2));
                Rxy = squeeze(sum(sumXY, 2)) ./ squeeze(sum(nPointsInXY, 2));
            elseif subjNum == 1
                Rxx = squeeze(sum(squeeze(sumXX), 1)) ./ squeeze(sum(squeeze(nPointsInXX), 1));
                Ryy = squeeze(sum(squeeze(sumYY), 1)) ./ squeeze(sum(squeeze(nPointsInYY), 1));
                Rxy = squeeze(sum(squeeze(sumXY), 1)) ./ squeeze(sum(squeeze(nPointsInXY), 1));
            else
                error('Something went wrong');
            end
    end
end
