%%#########################################################

%  Copyright 2018, Vilelmini Kalampratsidou, All rights reserved.
%  This program and the accompanying material
%  presented at JOVE video journal are available at
%  https://github.com/VilelminiKala/CloseLoopInterfaceJOVE.git

%%#########################################################

function [ angle, ax ] = AxisAngle_Between2vectors( v1,v2 )
%angleBetween2vectors: Calculates the angle between 2 vectors and the axis

v1_norm=v1./norm(v1);
v2_norm=v2./norm(v2);

angle=acos(dot(v1_norm, v2_norm));
a=cross(v1_norm, v2_norm);
a_norm=a./norm(a);

if dot(v1, a)>=10^-12 || dot(v2, a)>=10^-12 
    disp('The calculated axis is not orthogonal to the vectors!!!')
end

ax=a_norm;

end



