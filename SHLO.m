function [bestSolution, idx] = SHLO(knapMatrix,absoluteWeight,Gmax,popsize)
disp = 5000; % change this to change how often it dispays the current iteration , (will show current iteration every disp iterations)
rlProb = 0.5;
[a m] = size(knapMatrix); % don't currently use a
p_r = 5.0 / m;               
p_i = 0.85 + 2.0 / m;  

%% Initial population 
    popus = inipop(popsize,m);    
    
%% Evaluate fitness function and initial the IKD and SKD
    Fits = eF(knapMatrix,popus, absoluteWeight);                         % Fitness function evaulation 
    IKDfits = Fits;                                         % the best individual fitness    
    IKD = popus;           
    
%% Initial the SKD
    [arrange,position] = sort(IKDfits,1);               
    SKDfit = IKDfits(position(1,1),1);                    
    SKD = IKD(position(1,1),:);                           % the best individual (binary)
    
%% Generation Starts
    for t = 1:Gmax
        for i = 1:popsize
            for j = 1:m
             prob = rand;
                if  prob < p_r && prob > 0                     	%random learning
                    if rand < rlProb
                        popus(i,j) = 1;
                    else
                        popus(i,j) = 0;
                    end
                elseif prob >= p_r && prob < p_i                %individual learning
                    popus(i,j) = IKD(i,j);
                elseif prob >= p_i  && prob < 1               	%social learning
                    popus(i,j) = SKD(1,j);   
                end
            end
        end
%% Evaluate fitness function
        Fits = eF(knapMatrix,popus, absoluteWeight);            %Fitness function evaulation 
%% Evaluate IKD
        for i = 1:popsize
            if Fits(i) > IKDfits(i) %FLIPPED
                IKDfits(i) = Fits(i);
                IKD(i,:) = popus(i,:);
            end
        end
%% Evaluate SKD
        [arrange,postion] = sort(IKDfits,1);  
        if arrange(1,1) > SKDfit   	% when the best fitness of this generation is better than global best fitness, then update 
            SKDfit = arrange(1,1);
            SKD = IKD(postion(1,1),:);
            idx = t;
        end
        if (mod(t,disp))==0
        fprintf('the %d round\n',t);
        end
        
    end
    %fprintf('the best SHLO profit value for \n %d items \n %d max weight \n %d individuals \n %d max iterations is:', m,absoluteWeight,popsize,Gmax);
    %display(SKDfit);
    fprintf('best solution: %d \n', SKDfit)
    bestSolution = SKDfit;
end