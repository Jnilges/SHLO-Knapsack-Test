function [tmpP tmpW] = gS(kM, m, aW)
%greedy algorithn solution utilizing efficiency of the items
%kM is the knapsack matrix with row 1 -> profit, and row 2 -> weight
%m is the the number of items, can also do size function to get this
%without using m
%aW is the maximum weight alloweds, the absolute weight limit
ratio = kM(1,:)./kM(2,:); 
[~,idxR] = sort(ratio,"descend");
kMr = kM(:,idxR); %kM sorted by ratio
tmpW = 0;
tmpP = 0;
tmpSol = zeros(1,m);

    for i = 1:m
        if ( tmpW + kMr(2,i)< aW)
            tmpSol(idxR(i)) = 1; %by doing the idxR inside, no need to unsort
            tmpP = tmpP + kMr(1,i);
            tmpW = tmpW + kMr(2,i);
        end
    end