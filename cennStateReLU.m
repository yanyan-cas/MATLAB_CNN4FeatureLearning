function output = cennStateReLU(input)

%     [m, n, num] = size(input);
%     F = zeros(m+2, n+2, num);
%     F(2:m+1, 2:n+1, :) = input;
%     output = zeros(m, n, num);
%     
%     templateB = [0 0 0; 0 1 0; 0 0 0];
%     thresholdOne = -1;
%     thresholdTwo = 1;
%     
% for i = 1 : num
%     frame = F(:,:,i);
%      temp = reluCalculation(frame, templateB, thresholdOne);
%      output(:,:,i) = reluCalculation(temp, templateB, thresholdTwo);
% end

output = (input).*(input >0);

end