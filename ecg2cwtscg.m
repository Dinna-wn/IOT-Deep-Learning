%Function ecg2cwtscg()
function ecg2cwtscg(ecgdata, cwtfb,ecgtype)
nos=10; %number of signals
nol=500; % signal length
colormap= jet(128);
if ecgtype=='ARR'
    folderpath=strcat('C:\Windows\System32\dataecg227\arr\');
    findx=0;
    for i=1:30
        index=0;
        for k=1:nos
            ecgsignal=ecgdata(i,indx+1:indx+nol);
            cfs=abs(cwtf.wt(ecgsignal));
            im= ind2rgb(im2unit8(rescale(cfs)), colormap);
            filenameindex= findx+k;
            filename= stract(folderpath,sprintf('%d.jpg', filenameindex));
            imwrite(imresize(im,[227 227]), filename);
            indx= indx+nol;
        end
       findx= findx+nos;
    end
elseif ecgtype=='CHF'    
    folderpath=strcat('C:\Windows\System32\dataecg227\chf\');
    findx=0;
    for i=1:30
        index=0;
        for k=1:nos
            ecgsignal=ecgdata(i,indx+1:indx+nol);
            cfs=abs(cwtf.wt(ecgsignal));
            im= ind2rgb(im2unit8(rescale(cfs)), colormap);
            filenameindex= findx+k;
            filename= stract(folderpath,sprintf('%d.jpg', filenameindex));
            imwrite(imresize(im,[227 227]), filename);
            indx= indx+nol;
        end
       findx= findx+nos;
    end
elseif ecgtype=='NSR'    
    folderpath=strcat('C:\Windows\System32\dataecg227\nsr\');
    findx=0;
    for i=1:30
        index=0;
        for k=1:nos
            ecgsignal=ecgdata(i,indx+1:indx+nol);
            cfs=abs(cwtf.wt(ecgsignal));
            im= ind2rgb(im2unit8(rescale(cfs)), colormap);
            filenameindex= findx+k;
            filename= stract(folderpath,sprintf('%d.jpg', filenameindex));
            imwrite(imresize(im,[227 227]), filename);
            indx= indx+nol;
        end
       findx= findx+nos;
    end
end