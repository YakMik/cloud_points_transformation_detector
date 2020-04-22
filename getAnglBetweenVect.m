function [angl] = getAnglBetweenVect(V, V_trans)
% Search of an angle between vectors
% Input parameters:
% V - first vector
% V_trans - second vector
% Output parameters:
% angl = angle of an between vectors

    angl = acos(V(1)*V_trans(1) + V(2)*V_trans(2));
end

