% how to create cwt Image database from ECG signals
load('ECGData.mat');
data= ECGData.Data;
labels = ECGData.labels;
% taking first 30 recordings
ARR= data(1:30,:);
CHF= data(97:126,:);
NSR= data(127:156,:);
signallength= 500;
%Defining filters for CWT with amor wavelet and 12 filters per octave
fb= cwtfilterbank('SignalLength', signallength,'Wavelet','amor','VoicesPerOctave',12);
%Making Folders
%Main Folders
mkdir('dataecg227');
%sub Folders
mkdir('dataecg227\arr');
mkdir('dataecg227\chf');
mkdir('dataecg227\nsr');

ecgtype={'ARR', 'CHF', 'NSR'};
%Function to convert ECG to Image
ecg2cwtscg(ARR,fb,ecgtype{1});
ecg2cwtscg(CHF,fb,ecgtype{2});
ecg2cwtscg(NSR,fb,ecgtype{3});

