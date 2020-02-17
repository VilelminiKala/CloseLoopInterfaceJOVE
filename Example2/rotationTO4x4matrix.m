%%#########################################################

%  Copyright 2018, Vilelmini Kalampratsidou, All rights reserved.
%  This program and the accompanying material
%  presented at JOVE video journal are available at
%  https://github.com/VilelminiKala/CloseLoopInterfaceJOVE.git

%%#########################################################

function [ M ] = rotationTO4x4matrix( dcm )
%rotationTO4x4matrix Converts the rotation matrix
%to a 4x4 matrix

M=[[dcm [0 0 0]']; [0 0 0 1]];

end

