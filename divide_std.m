function K = divide_std(K)
if size(K,3)>1
    for i=1:size(K,3)
        current_kernel = K(:,:,i);
        std_value = std(current_kernel(:));
        current_kernel = current_kernel / std_value;
        K(:,:,i) = current_kernel;
    end
else
    std_value = std(K(:));
    K = K / std_value;
end
end