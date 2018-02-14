function [accuracy] = predictLabels(Z2, tsLabel, W, labelSize)
    
%predict
WW = W * Z2;
[~, C] = max(WW);

numClass = labelSize;

%%comput accuracy
acc = zeros(numClass, 1);
for jj = 1 : numClass
    c = jj;
    idx = find(tsLabel == c);
    predLabel = C(idx);
    gndLabel = tsLabel(idx)';
    acc(jj) = length(find(predLabel == gndLabel'));
end

accuracy = sum(acc);

end