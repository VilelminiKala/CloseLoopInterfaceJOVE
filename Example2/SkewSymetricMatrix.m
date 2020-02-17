%%#########################################################

%  Copyright 2018, Vilelmini Kalampratsidou, All rights reserved.
%  This program and the accompanying material
%  presented at JOVE video journal are available at
%  https://github.com/VilelminiKala/CloseLoopInterfaceJOVE.git

%%#########################################################

function [ M ] = SkewSymetricMatrix( v )
%SkewSymetricMatrix: We want to find a 3x3 matrix which is equivalent to 
%vector cross multiplication. Cross multiplication only applies to 3 
%dimensional vectors and represents a vector which is perpendicular to 
%both the vectors being multiplied.

MA=[0 -v(3) v(2);
    v(3) 0 -v(1);
    -v(2) v(1) 0];

if sum(sum(-MA==MA'))~=9
    disp('Skew matrix does not satisfy its properties ')
end

M=MA;

end

