clc;
clear;

baseFolder = 'dataset';
emotionFolders = {'happy','sad','angry','neutral'};

features = [];
labels = {};

for i = 1:length(emotionFolders)
    
    folderPath = fullfile(baseFolder, emotionFolders{i});
    
    if ~isfolder(folderPath)
        disp(['Folder not found: ', folderPath])
        continue
    end
    
    % Read BOTH wav and mp3 files
    wavFiles = dir(fullfile(folderPath, '*.wav'));
    mp3Files = dir(fullfile(folderPath, '*.mp3'));
    
    files = [wavFiles; mp3Files];
    
    if isempty(files)
        disp(['No audio files in: ', folderPath])
        continue
    end
    
    for j = 1:length(files)
        
        filePath = fullfile(folderPath, files(j).name);
        [audio, fs] = audioread(filePath);
        
        audio = audio(:,1);   % make mono
        
        coeffs = mfcc(audio, fs);
        featureVector = mean(coeffs);
        
        features = [features; featureVector];
        labels{end+1} = emotionFolders{i};
        
    end
end

labels = categorical(labels);

save emotion_dataset.mat features labels

disp('Dataset Created Successfully')