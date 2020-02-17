%%#########################################################

%  Copyright 2018, Vilelmini Kalampratsidou, All rights reserved.
%  This program and the accompanying material
%  presented at JOVE video journal are available at
%  https://github.com/VilelminiKala/CloseLoopInterfaceJOVE.git

%%#########################################################

function [ rigids ] = create_structure( data,selected_frames )
% create_structure Changes the data structure to rigids. This step 
% is not necesary it is done to adapt the loaded data to the code of
% createAvatarAnimation script. You could either adapt this function 
% your data or not use it if not needed.

for frame=1:size(selected_frames,2)
    for i=289:8:size(data,1)-1;
        bone=1+floor((i-289+1)/8);
        
        rigids{bone}(frame,1)=data(i,selected_frames(frame));
        rigids{bone}(frame,2)=data(i+2,selected_frames(frame));
        rigids{bone}(frame,3)=data(i+1,selected_frames(frame));
    end
end

end

