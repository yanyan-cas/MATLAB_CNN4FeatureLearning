function output = poolingCalculation(frame) %, template, threshold

[m, n] = size(frame);
Z = frame;
temp = zeros(m, n);
for i = 2 : m-1
    for j = 2 : n-1
        % get the neighbor cells' states
        neighbor = [ Z(i-1, j-1),  Z(i-1, j),   Z(i-1, j+1);...
                        Z(i, j-1),     Z(i, j),      Z(i, j+1); ...
                        Z(i+1, j-1), Z(i+1, j) ,  Z(i+1, j+1)];
        temp(i, j) = max(max(neighbor));
    end
end
output = temp(2:m-1, 2:n-1);
end