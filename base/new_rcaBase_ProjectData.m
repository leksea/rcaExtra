function dataOut = new_rcaBase_ProjectData(data, W)
    if iscell(data)
        [nCond, nSubjects] = size(data);
        dataOut = cell(nCond, nSubjects);
        for subj = 1:nSubjects
            for cond = 1:nCond
                thisVolume = data{cond, subj};
                dataOut{cond, subj} = new_rcaBase_Project(thisVolume, W);
            end
        end
    else
        dataOut = new_rcaBase_Project(data, W);
    end
end
