%%#########################################################

%  Copyright 2018, Vilelmini Kalampratsidou, All rights reserved.
%  This program and the accompanying material
%  presented at JOVE video journal are available at
%  https://github.com/VilelminiKala/CloseLoopInterfaceJOVE.git

%%#########################################################

function [ bonelength ] = ComputeBoneLength( rigids, boneSequence )
% ComputeBoneLength computes the length of the bones a value that it is
% going to be used later when we tranform the bones

frame=1; %we only use first frame to estimate the length of the bones
for i=1:length(boneSequence)
    if i~=6 && i~=11 && i~=16 && i~=20 && i~=24
        rig_num=boneSequence(i);
        next_rig_num=boneSequence(i+1);
            bonelength(next_rig_num)= norm(rigids{next_rig_num}(frame,1:3)- rigids{rig_num}(frame,1:3));%convert the structure
    end
end

end

