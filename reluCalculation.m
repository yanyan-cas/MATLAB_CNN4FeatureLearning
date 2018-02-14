function output = reluCalculation(frame) %, template, threshold

% [m, n] = size(frame);
% mapping.ymin = -1;
% mapping.ymax = 1;
% [Z, ~] = mapminmax(frame, mapping);
% temp = zeros(m, n);
% for i = 2 : m-1
%     for j = 2 : n-1
%         % get the neighbor cells' states
%         neighbor = [ Z(i-1, j-1),  Z(i-1, j),   Z(i-1, j+1);...
%                         Z(i, j-1),     Z(i, j),      Z(i, j+1); ...
%                         Z(i+1, j-1), Z(i+1, j) ,  Z(i+1, j+1)];
%         temp(i, j) = sum(sum(neighbor .* template)) + threshold;
%     end
% end
% output = mapminmax(temp(2:m-1, 2:n-1), 0, 1);


output = (frame).*(frame >0);

end