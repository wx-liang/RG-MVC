function K = remove_large(K)
if size(K,3)>1
    for i=1:size(K,3)
        current_kernel = K(:,:,i);
        mean_value = mean(current_kernel(:));
        std_value = std(current_kernel(:));
        threshold_up = mean_value + std_value*4;
        threshold_dn = mean_value - std_value*4;
        current_kernel(current_kernel > threshold_up) = threshold_up;
        current_kernel(current_kernel < threshold_dn) = threshold_dn;
        K(:,:,i) = current_kernel;
    end
else
    mean_value = mean(K(:));
    std_value = std(K(:));
    threshold_up = mean_value + std_value*4;
    threshold_dn = mean_value - std_value*4;
    K(K > threshold_up) = threshold_up;
    K(K < threshold_dn) = threshold_dn;
end
end