function grad = graphGrad(KH, S, sigma)

d=size(KH,3);
grad=zeros(d,1);
for k=1:d
     grad(k) = 2 * sigma(k) * trace(KH(:,:,k)'*S);  
end

end