function [ x_offs y_offs angl ] = getTransform( x, y, x_trans, y_trans )
    % search for transformation parameters
    % Input parameters:
    % x, y - source point cloud
    % x_trans, y_trans - transformed point cloud
    % Output parameters:
    % x_offs, y_offs - transformed point cloud offset
    % angl - transformed point cloud angle of rotation
    
    [cen_x cen_y] = getCenter(x, y);
    [cen_x_trans cen_y_trans] = getCenter(x_trans, y_trans);
    
    x_offs = cen_x_trans - cen_x;
    y_offs = cen_y_trans - cen_y;
    
    x_c = x - cen_x;
    y_c = y - cen_y;
    
    x_trans_c = x_trans - cen_x_trans;
    y_trans_c = y_trans - cen_y_trans;
    
    [ V1 V2 ] = getEigenVectors( x_c, y_c );
    [ V1_trans V2_trans ] = getEigenVectors( x_trans_c, y_trans_c );
   
    angl_1_trans1 = getAnglBetweenVect(V1, V1_trans);
    angl_2_trans2 = getAnglBetweenVect(V2, V2_trans);
    
    angl_1_trans2 = getAnglBetweenVect(V1, V2_trans);
    angl_2_trans1 = getAnglBetweenVect(V2, V1_trans);
    
    if ( abs(angl_1_trans1 - angl_2_trans2) < 0.01 )
        angle = angl_1_trans1;
    end

    if (abs(angl_1_trans2 - angl_2_trans1) < 0.01)
        angle = angl_1_trans2;
    end
    
    angls = [angle angle+pi/2 angle+pi angle+pi+pi/2];
    cos_angls = cos(angls);
    sin_angls = sin(angls);
    
    sum_err = zeros(1,length(angls));
    for i = 1:4
        x_check =  x .* cos_angls(i) + y .* sin_angls(i);
        y_check = -x .* sin_angls(i) + y .* cos_angls(i);
        
        sum_err(i) = sum( sqrt( (x_trans-x_check).^2 + (y_trans - y_check).^2 ) );
    end
    
    [minVal minInd] = min(sum_err);
    angl = angls(minInd);
end

