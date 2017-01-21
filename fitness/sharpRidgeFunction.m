function [ret] = sharpRidgeFunction(y, d)

    %every element of the vector from 2 to N squared
     s = sum(y(2:end).^2);
    ret = -y(1) + d * sqrt(s);

end