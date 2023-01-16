filename=  'D:\Memoire\Code\matlab Projects\netTransfermatlab\heartsignal6';
loadfile = load(filename);
table = struct2cell(loadfile);
data_matrix = cell2mat(table);
B = transpose(data_matrix);
signallength= 500;
fb= cwtfilterbank('SignalLength', signallength,'Wavelet','amor','VoicesPerOctave',12);
mkdir('dataecg1500\test');
nos=1; %number of signals
nol=500; % signal length
colormap= jet(128);

folderpath=strcat('C:\Windows\System32\dataecg1500\test\');
findx=0;

for i=1:1
    indx = 0;
        for k=1:nos
            %ecgdata = ecgdata.';
            %B = flipud(ecgdata);
             ecgsign=B(i,indx+1:indx+nol);
             %ecgsignal= double(ecgsign);
            cfs=abs(fb.wt(ecgsign));
            im= ind2rgb(im2uint8(rescale(cfs)), colormap);
            filenameindex= findx;
            imwrite(imresize(im,[227 227]),fullfile(folderpath,sprintf('%d.jpg', filenameindex)));

            indx= indx+nol;
        end
            findx= findx+nos;
end        

