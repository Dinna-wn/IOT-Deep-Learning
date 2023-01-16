
%Training and validation using AlexNet
DatasetPath='C:\Windows\System32\dataecg227';
%DatasetPath1='C:\Windows\System32\dataecg1\test';

%Reading Images from Image database folder
images=imageDatastore(DatasetPath,'IncludeSubFolders',true,'LabelSource','foldernames');
%testimages=imageDatastore(DatasetPath1,'IncludeSubFolders',true,'LabelSource','foldernames');

%Distributing Images in the set ofTraining and Testing
numTrainFiles= 250; % from each folder total =730 training images and 150 test images
[TrainImages, TestImages]=splitEachLabel(images, numTrainFiles,'randomize');

net= alexnet; %importing pretrainedAlexnet (Requires support package)
layersTransfer=net.Layers(1:end-3); %Preserving all layers except last three

numClasses = 3; %Numberof output classes: ARR,CHF,NSR

%Defining layers of Alexnet   % layersTransfer : layers we preserved
layers=[layersTransfer        
fullyConnectedLayer(numClasses,'WeightLearnRateFactor',20,'BiasLearnRateFactor',20)
softmaxLayer
classificationLayer];

%Training Options % sgdm: gradient decent % shuffling the data in every epoch
options= trainingOptions('sgdm','MiniBatchSize',20,'MaxEpochs',8, ...
    'InitialLearnRate',1e-4, 'Shuffle', 'Every-Epoch', ...
'ValidationData', TestImages, 'ValidationFrequency',10,...
'Verbose', false,'Plots', 'training-progress');
%Trainig he AlexNet
netTransfer= trainNetwork(TrainImages, layers,options); %training strt with this command% layers:all layers
save netTransfer;

%weight nd attribution will be in netTransfer : my newnetwork
%Classification Images 
YPred= classify(netTransfer,TestImages);
YValidation=TestImages.Labels; %vector
accuracy=sum(YPred ==YValidation)/numel(YValidation);

%Ploting Confusion Matrix
plotconfusion(YValidation,YPred)