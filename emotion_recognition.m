%% 
%Real Time Speech Emotion Recognititon Using Signal Processing Techniques
clc;
clear;
close all;

%% Load Dataset
load emotion_dataset.mat

%% Train KNN Modhiel
model = fitcknn(features, labels, 'NumNeighbors', 5);

%% Record Live Voice
fs = 16000;      % Sampling frequency
duration = 4;    
% Recording duration (seconds)

recObj = audiorecorder(fs,16,1);

disp('Start speaking...')
recordblocking(recObj, duration);
disp('Recording finished.')

audio = getaudiodata(recObj);

%% Plot Recorded Signal
t = (0:length(audio)-1)/fs;
figure;
plot(t, audio);
title('Live Recorded Speech');
xlabel('Time (s)');
ylabel('Amplitude');

%% Extract MFCC
coeffs = mfcc(audio, fs);
testFeature = mean(coeffs);

%% Predict Emotion
predictedEmotion = predict(model, testFeature);

disp(['Detected Emotion: ', char(predictedEmotion)]);