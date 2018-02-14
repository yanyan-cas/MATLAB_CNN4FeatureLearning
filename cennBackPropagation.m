function cenn = cennBackPropagation(cenn, x, y)

    n = cenn.n;
    equ = cenn.equ;
    m = size(x, 3);
    
    outputSize = size(cenn.U{n}{1});
    temp = outputSize(1) * outputSize(2);
    fea = zeros(temp*equ, m);
    for j = 1: equ
        fea(temp*(j-1)+1:temp*j,:)=reshape(cenn.U{n}{j}, temp,m);
    end
    
    fea=[ones(1,m);fea];
    %W  =  argmin E, which could minimize the error function.
    cenn.W=(y*fea')/(fea*fea'+diag([1 cenn.lambda*ones(1,temp*equ)]));

    cenn.error = sum(sum((y-cenn.W*fea).*(y - cenn.W*fea)))/m;
           
    dU = - cenn.W' * (y - cenn.W * fea) / m;
    dU = dU(2 : end, :);
    ddU = cell(equ, 1);
    
    for j = 1 : equ
        ddU{j} = reshape(dU(temp*(j-1)+1:temp*j,:), outputSize(1), outputSize(2), outputSize(3));
    end
    
    
    %% numerical derivative
for i = (n-1) : -1 : 1
        ddUlast = cell(equ, 1);
    for j = 1 : equ
           if i >1 && strcmp(cenn.layers{i}.type, 'softmax')
                   inputsize = size(cenn.U{i}{j});
                   
                   if strcmp(cenn.layers{i}.function, 'max')
                       ex1 = expand(ddU{j},[pde.layers{i}.scale,pde.layers{i}.scale,1]);
                       ex2 = expand(pde.U{i+1}{j},[pde.layers{i}.scale,pde.layers{i}.scale,1]);         
                       ddUlast{j} =ex1(1:inputsize(1),1:inputsize(2),:).*(ex2(1:inputsize(1),1:inputsize(2),:)==pde.U{i}{j});
                   else
                      ex1 = expand(ddU{j},[pde.layers{i}.scale,pde.layers{i}.scale,1])/(pde.layers{i}.scale.^2);
                      ddUlast{j} =ex1(1:inputsize(1),1:inputsize(2),:);   
                   end    
                   
           else
                    cenn.deltaA{i}{j} = cennGradientCal(ddU{j});
                    
                    if i>1
                        ddUlast{j} = ddU{j};
                        % generate map the map is cell with size 9 and from first
                        % left to right  then up to down
                        numderive = genenum(pde.U{i}{j},pde.U{i+1}{j},pde.t,pde.a_num, pde.a{i}{j},pde.complex,pde.Beta);
                        
                        for k= 1 : 9
                            numderive{k} = numderive{k}.* ddU{j};
                        end
                        
                        %up
                        ddUlast{j}(1:end-1,1:end-1,:)  =  ddUlast{j}(1:end-1,1:end-1,:) +  numderive{1}(2:end,2:end,:);
                        ddUlast{j}(1:end-1,1:end,:)  =  ddUlast{j}(1:end-1,1:end,:) +  numderive{2}(2:end,1:end,:);
                        ddUlast{j}(1:end-1,2:end,:)  =  ddUlast{j}(1:end-1,2:end,:) +  numderive{3}(2:end,1:end-1,:);
                        %mid
                        ddUlast{j}(1:end,1:end-1,:)  =  ddUlast{j}(1:end,1:end-1,:) +  numderive{4}(1:end,2:end,:);
                        ddUlast{j}(1:end,1:end,:)  =  ddUlast{j}(1:end,1:end,:) +  numderive{5}(1:end,1:end,:);
                        ddUlast{j}(1:end,2:end,:)  =  ddUlast{j}(1:end,2:end,:) +  numderive{6}(1:end,1:end-1,:);
                        %down
                        ddUlast{j}(2:end,1:end-1,:)  =  ddUlast{j}(2:end,1:end-1,:) +  numderive{7}(1:end-1,2:end,:);
                        ddUlast{j}(2:end,1:end,:)  =  ddUlast{j}(2:end,1:end,:) +  numderive{8}(1:end-1,1:end,:);
                        ddUlast{j}(2:end,2:end,:)  =  ddUlast{j}(2:end,2:end,:) +  numderive{9}(1:end-1,1:end-1,:);  
                        
                    end
                    
           end
            
    end
    
    ddU = ddUlast;
    
end

end