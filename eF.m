function eval = evalFunction(knapMatrix,candidate,maxW)
[row col] = size(candidate);

for i=1:row
    candW = sum(candidate(i,:) .* knapMatrix(2,:));
    candP = sum(candidate(i,:) .*knapMatrix(1,:));
    if (candW > maxW)
        candP = 0 ; %make the profit 0 to make it an uncompetitive solution
    end
    eval(i) = candP;
end
end