function [ cenn] = cennInitial( cenn)
%rand('state',0)

for j = 1:cenn.n-1
  for i = 1 : cenn.equ

    if strcmp(cenn.layers{j}.type, 'CeNN')
            cenn.convTemplate{j}{i} = 2 * rand(3, 3) - 1;
    end
    
  end
end

end
