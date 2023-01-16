
%Training and validation using ResNet
DatasetPath='C:\Windows\System32\dataecg1500';

%Reading Images from Image database folder
images=imageDatastore(DatasetPath,'IncludeSubFolders',true,'LabelSource','foldernames');

%Distributing Images in the set ofTraining and Testing
numTrainFiles= 940; 
[TrainImages, TestImages]=splitEachLabel(images, numTrainFiles,'randomize');

net= resnet50; %importing pretrained Resnet (Requires support package)
lgraph = layerGraph(net);
layersTransfer=net.Layers(1:end-3); %Preserving all layers except last three

numClasses = 5; %Numberof output classes: N,SEV,VEB,FB,UNKNOWN

%New Learnable Layer
newLearnableLayer = fullyConnectedLayer(numClasses, ...
        'Name','new_fc', ...
        'WeightLearnRateFactor',10, ...
        'BiasLearnRateFactor',10);
% Replacing the last layers with new layers
lgraph = replaceLayer(lgraph,'fc1000',newLearnableLayer);
newsoftmaxLayer = softmaxLayer('Name','new_softmax');
lgraph = replaceLayer(lgraph,'fc1000_softmax',newsoftmaxLayer);
newClassLayer = classificationLayer('Name','new_classoutput');
lgraph = replaceLayer(lgraph,'ClassificationLayer_fc1000',newClassLayer);
% Training Options, we choose a small mini-batch size due to limited images 
options = trainingOptions('sgdm',...
        'MaxEpochs',8,'MiniBatchSize',8,...
        'Shuffle','every-epoch', ...
        'InitialLearnRate',1e-4, ...
        'ValidationData', TestImages, 'ValidationFrequency',10,...
        'Verbose',false, ...
        'Plots','training-progress');
    
% Training
netTransfer = trainNetwork(TrainImages,lgraph,options);
%weight nd attribution will be in netTransfer : my newnetwork

%Classification Images 
YPred= classify(netTransfer,TestImages);
YValidation=TestImages.Labels; %vector
accuracy=sum(YPred ==YValidation)/numel(YValidation);

%Ploting Confusion Matrix
plotconfusion(YValidation,YPred)