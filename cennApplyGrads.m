function cenn = cennApplyGrads(cenn)

    momentum = cenn.momentum;
    weightPenaltyL2 = cenn.weightPenaltyL2;
    
for i = 1 : (cenn.n - 1)
        if   strcmp(cenn.layers{i}.type, 'cenn')           

            for j = 1 : cenn.equ
                
                if(momentum>0)                        
                    cenn.a_old{i}{j}= (1 - momentum) * cenn.da{i}{j} + momentum * cenn.a_old{i}{j};
                    cenn.da{i}{j} =   cenn.a_old{i}{j};
                end
                
                if(weightPenaltyL2>0)                   
                    cenn.da{i}{j}  =     cenn.da{i}{j}  + weightPenaltyL2 *  cenn.da{i}{j} ;
                end

                cenn.a{i}{j}  =  cenn.a{i}{j}  - cenn.learningRate *  cenn.da{i}{j} ;

            end


        end
end





end