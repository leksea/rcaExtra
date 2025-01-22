function plotSettings = new_rcaBase_Plot(dataOut, W, A, Rxx, Ryy, Rxy, dGen, Kout, plotStyle)
    plotSettings = struct();

        h = figure;
        
        
        if strcmp(plotStyle,'matchMaxSignsToRc1')
            symmetricColorbars = true;
            alignPolarityToRc1 = true;
        else % use original plotting conventions
            symmetricColorbars = false;
            alignPolarityToRc1 = false;
        end
        
        if symmetricColorbars
            % for a consistent colorbar across RCs:
            colorbarLimits = [min(A(:)),max(A(:))];
            newExtreme = max(abs(colorbarLimits));
            colorbarLimits = [-newExtreme,newExtreme];
        else
            colorbarLimits = [];
        end
        if alignPolarityToRc1
            extremeVals = [min(A); max(A)];
            for rc = 1:nComp
                [~,f(rc)]=max(abs(extremeVals(:,rc)));
            end
            s = ones(1,nComp);
            if f(1)==1 % largest extreme value of RC1 is negative
                s(1) = -1; % flip the sign of RC1 so its largest extreme value is positive (yellow in parula)
                f(1) = 2;
            end
            for rc = 2:nComp
                if f(rc)~=f(1) % if the poles containing the maximum corr coef are different
                    s(rc) = -1; % we will flip the sign of that RC's time course & thus its corr coef values (in A) too
                end
            end
        else
            s = ones(1,nComp);
        end
        
        plotSettings.signFlips = s;
        plotSettings.colorbarLimits = colorbarLimits;
        
        try
            for c=1:nComp
                subplot(3,nComp,c);
                if ~isempty(which('mrC.plotOnEgi')) % check for mrC version of plotOnEgi
                    mrC.plotOnEgi(s(c).*A(:,c),colorbarLimits);
                else
                    plotOnEgi(s(c).*A(:,c),colorbarLimits);
                end
                title(['RC' num2str(c)]);
                axis off;
            end
        catch
            fprintf('call to plotOnEgi() failed. Plotting electrode values in a 1D style instead.\n');
            for c=1:nComp, subplot(3,nComp,c); plot(A(:,c),'*k-'); end
            title(['RC' num2str(c)]);
        end
        
        try
            for c=1:nComp
                subplot(3,nComp,c+nComp);
                shadedErrorBar([],s(c).*muData(:,c),semData(:,c),'k');
                title(['RC' num2str(c) ' time course']);
                axis tight;
            end
        catch
            fprintf('unable to plot rc means and sems. \n');
        end
        
        try
            [~,eigs]=eig(Rxx+Ryy);
            eigs=sort(diag(eigs),'ascend');
            subplot(325); hold on
            plot(eigs,'*k:');
            nEigs=length(eigs);
            plot(nEigs-Kout,eigs(nEigs-Kout),'*g');
            title('Within-trial covariance spectrum');
        catch
            fprintf('unable to plot within-trial covariance spectrum. \n');
        end
        
        subplot(326); plot(dGen,'*k:'); title('Across-trial covariance spectrum');
        
    end
end
