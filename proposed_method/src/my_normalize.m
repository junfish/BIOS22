% You can defined your own normalization for response value here!
function [norm_y] = yj_normalize(y)
    max_value = max(y);
    min_value = min(y);
    k = 1 / (max_value - min_value);
    b = - min_value / (max_value - min_value);
    norm_y = k * y + b;
end