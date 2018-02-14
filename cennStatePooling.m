function output = cennStatePooling(input)

    [m, n, num] = size(input);
    F = zeros(m+2, n+2, num);
    F(2:m+1, 2:n+1, :) = input;
    output = zeros(m, n, num);
    

for i = 1 : num
    frame = F(:,:,i);
     output(:,:,i) = poolingCalculation(frame);
end

end