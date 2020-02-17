------------------------------------------------------------------------------------------------------------------------------
This code is part of the publication “Real-time proxy-control of re-parameterized peripheral signals using close-loop interface”
at JOVE (link:…). Specifically, it is the Matlab interface described in example 2, section “The real-time analyses of data and 
monitoring of the human system”.
-------------------------------------------------------------------------------------------------------------------------------

To execute this code, run the script “createAvatarAnimation.m”. The file “motion-data.mat” are sample data from a person 
walking and can be used for running the script.

--Use your own data--
To use your own data, make sure to alter the data structure you are using so that it matched the structure “rigids”. This 
can be achieved by altering the function “create_structure” called in line 42.

Also, make sure that your data match the kinematic chain of the code which is demonstrated in Figure 1.

<--Figure 1--> 
Figure 1: Sequence of rigid bodies of the data used in the specific example code. In the specific display 
of the rigids the participant is facing towards us. The right side of the picture demonstrates the left 
hand and leg and the left side of the picture demonstrates the right hand and leg.

-- Real-time streaming
To use this code on a real time streaming utilizing LabStreamingLayer (LSL, https://github.com/sccn/labstreaminglayer) add the 
following code on your script adapted to the equipment you are using.

%% Initialize communication with PhaseSpace
disp('Loading the library...');
lib = lsl_loadlib();
% resolve a stream...
disp('Resolving an Mocap stream...');
result = {};
while isempty(result)
    result = lsl_resolve_byprop(lib,'type','Mocap');
end
% create a new inlet
disp('Opening an inlet...');
inlet = lsl_inlet(result{1});
%load data
[chunk{i},stamps{i}] = inlet.pull_chunk(); 

For more information about how to use LSL with Matlab see here: https://github.com/sccn/labstreaminglayer


