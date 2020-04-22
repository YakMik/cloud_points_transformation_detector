function [ V1 V2 ] = getEigenVectors( x, y )
% Search for orthonormal basis
% Input parameters:
% x, y - cloud points
% Output parameters:
% V1, V2 - eigen vectors

    a = sum( x.^2 );
    b = sum( x .* y );
    c = b;
    d = sum( y.^2 );
    
    % | a-lym     b    |
    % |                |  = (a-lym)*(d-lym) - bc = lym^2 - (a+d)lym + ad-bc = 0
    % |   c     d-lym  |
   
    if (abs(b) < 0.00001)
        V1 = [1 0];
        V2 = [0 1];
    else
        D = (a + d)^2 - 4*(a*d - b*c);
        lym1 = ((a + d) + sqrt(D)) / 2;
        lym2 = ((a + d) - sqrt(D)) / 2;
    
        m = a - lym1;
        n = b;

        n = -m / n;
        m = 1;
        norm = sqrt(m*m + n*n);

        V1 = [m/norm n/norm];

        m = a - lym2;
        n = b;

        n = -m / n;
        m = 1;
        norm = sqrt(m*m + n*n);

        V2 = [m/norm n/norm];
    end
end