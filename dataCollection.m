%~~~~~~~~% My Variables
clear;
clc;
format long;
startTime = datetime('now')

imaxP = 100; % want 50-100
iminP = 50;
imaxW = 20; % want 5-15
iminW = 5;

%~~~~~~~~~% HLO Variablesclear;
runtimes = 30;           %Number of runs
bit = 1;               %Bits numbers
%m = bit * Dim;          %Individual lenth
Xmax = 1;             %Vaiable range
Xmin = 0;            %Vaiable range            
 % ~~~~~~~~~~% Replication Parameters
items = [100;200;400;600;800;1000;1200;1500];
maxWeights = [1000;2400;4000;6000;8000;10000;14000;16000];
individuals = [100;100;100;100;100;200;200;200];
maxEvals = [10000;10000;10000;10000;10000;40000;40000;40000];
colSize = size(items,1);
dataMatrix = [items,maxWeights,individuals,maxEvals,zeros(colSize,9)]; %9 for mean, sd, max, min, avg best iteration index, min best iteration index, max best iteration index, sum weights, sum profits
%dataMatrix will be colSize by 13 matrix, first 4 cols are inputs, last 9 observed
for a = 1:colSize
    Dim = dataMatrix(a,1);              % Dimension
    maxW = dataMatrix(a,2);             % Max weight
    popsize = dataMatrix(a,3);          % Population size  
    Gmax = dataMatrix(a,4);             % Max number of generations - stopping criteria
    tmp = zeros(runtimes,2);            % use this to record the end solution of each run, and the iteration the best solution occured

    rng(1);
    kM = zeros(2,Dim); % use 3 to store the profit, weight, and profit to weight ratio
    kM(1,:) = randi([iminP,imaxP], 1, Dim); %First row is profit
    kM(2,:) = randi([iminW,imaxW], 1, Dim); %second row is weight
    dataMatrix(a,12) = sum(kM(1,:)); %sum all the profits
    dataMatrix(a,13) = sum(kM(2,:)); %sum all the weights
    for b = 1:runtimes
        fprintf('run number %d of %d, of dim set %d \n',b,runtimes,Dim);
        rng('shuffle');
        [tmp(b,1), tmp(b,2)]= SHLO(kM,maxW,Gmax,popsize);
    end

    dataMatrix(a,5) = mean(tmp(:,1));
    dataMatrix(a,6) = std(tmp(:,1));

    dataMatrix(a,7) = min(tmp(:,1));
    dataMatrix(a,8) = max(tmp(:,1));
    dataMatrix(a,9) = mean(tmp(:,2));
    dataMatrix(a,10) = min(tmp(:,2));
    dataMatrix(a,11) = max(tmp(:,2));
end
labels = {'Dim', 'MaxWeight' ,'PopSize', 'MaxIters' ,'SolAvg', 'SolStd', 'SolMin' ,'SolMax', 'SolIdxMean' ,'SolIdxMin', 'SolIdxMax', 'SumProfit', 'SumWeight'};
kk = array2table(dataMatrix);
kk.Properties.VariableNames(1:13) = labels;
kk
writetable(kk,'SHLO_data.csv')
endTime = datetime('now');

startTime
endTime
