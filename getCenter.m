function [ x_cen y_cen ] = getCenter( x, y )
% Center of mass search
% Input parameters:
% x, y - cloud points
% Output parameters:
% x_cen, y_cen - center of mass

    x_cen = sum(x) / length(x);
    y_cen = sum(y) / length(y);
end

