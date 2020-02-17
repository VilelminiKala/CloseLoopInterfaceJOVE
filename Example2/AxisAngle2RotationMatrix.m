%%#########################################################

%  Copyright 2018, Vilelmini Kalampratsidou, All rights reserved.
%  This program and the accompanying material
%  presented at JOVE video journal are available at
%  https://github.com/VilelminiKala/CloseLoopInterfaceJOVE.git

%%#########################################################

function [ M] = AxisAngle2RotationMatrix( axis, angle )
%AxisAngle2RotationMatrix: Converts the axis angle rotation to rotation
%matrix

c=cos(angle);
s=sin(angle);
t=1-c;

x=axis(1);
y=axis(2);
z=axis(3);

MA=c*eye(3)+t*[x*x x*y x*z; ...
               y*x y*y y*z;...
               z*x z*y z*z]+s*SkewSymetricMatrix( axis );

M=MA;

end

