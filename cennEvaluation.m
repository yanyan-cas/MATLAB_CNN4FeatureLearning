function [acc] = cennEvaluation(cenn, train_x, train_y, val_x, val_y,lambda)

n = cenn.n;
equ = cenn.equ;

cenn = cennFeedForward(cenn, train_x);

m = size(train_x, 3);

outputsize = size(cenn.U{n}{1});

temp = outputsize(1)*outputsize(2);
fea1 = zeros(temp * equ, m);

for j = 1 : equ
    
    feal(temp * (j-1) + 1 : temp * j, :) = reshape(cenn.U{n}{j}, temp, m);
end

feal = [ones(1, m); feal];
cenn.W = train_y * feal' * inv(feal * feal' + diag([1 lambda * ones(1, temp * equ)]));

[labelsize, m] = size(val_y);

acc = 0;

for i = 1 : ceil(m/2000)
    val_xtemp1 = val_x(:,:, (i-1)*2000+1:  min(i*2000,m));
    val_ytemp1   = val_y(:, (i-1)*2000+1:  min(i*2000,m));
    
    cenn= cennFeedForward(cenn, val_xtemp1);
    
    outputsize = size(cenn.U{n}{1});
    
    temp = outputsize(1)*outputsize(2);
    mm = size(val_xtemp1,3);
    fea2 = zeros(temp*equ, mm);
    
    for j=1:equ
        fea2(temp*(j-1)+1:temp*j,:)=reshape(cenn.U{n}{j},temp,mm);
    end
    
    fea2=[ones(1,mm);fea2];
    
    val_label=zeros(1,mm);
    
    for k=1:mm
        val_label(k)=find( val_ytemp1(:,k)~=0);
    end  
    acc = acc + predictLabels(fea2,val_label, cenn.W,labelsize);
end
acc = acc/m;
end

    

