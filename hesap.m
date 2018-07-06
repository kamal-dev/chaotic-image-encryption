function [correlation_coefficient]=hesap(x,y)
    correlation_coefficient = corrcoef(x(:),y(:));
end

