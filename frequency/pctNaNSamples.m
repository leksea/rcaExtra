function out = pctNaNSamples(sourceData3D)

    vectorizedData = sourceData3D(:);
    if (numel(vectorizedData) == 0)
        out = -1;
    else
        out = 100*sum(isnan(vectorizedData))/numel(vectorizedData);
    end
end