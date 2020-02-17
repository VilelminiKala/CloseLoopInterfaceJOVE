%%#########################################################

%  Copyright 2018, Vilelmini Kalampratsidou, All rights reserved.
%  This program and the accompanying material
%  presented at JOVE video journal are available at
%  https://github.com/VilelminiKala/CloseLoopInterfaceJOVE.git

%%#########################################################


clear all
close all
clc

% set parameters
scale=0.04;
step=3;
sampling_rate=480;

% create figure window
h=figure;
ax=axes;
hold on;
xlabel('x'); ylabel('y'); zlabel('z');
axis([-2 2  -2 2 0 2])
view([-65,9])
grid on;

%% load files
load('motion-data.mat');

boneSequence=[1 2 3 4 5 6  3 10 12 14 16   3 9 11 13 15   1 20 22 24    1 19 21 23];
%spine: 1 2 3 4 5 6
%left arm: 3 9 11 13 15
%right arm: 3 10 12 14 16
%left leg: 1 20 22 24
%right leg:  1 19 21 23

selected_frames=1:step:length(data);

disp('Done loading data')

%% Change Data structure

%depending on your data structure this migh be no necesary of you
%may need to adapt the following function to your data
[ rigids ] = create_structure( data,selected_frames );

%% Create bone surfaces
[ Ftt,Ft, Ftt_new ] = CreateBoneSurfaces( ax, boneSequence, scale );
disp('Done creating surfaces')

%% Compute bonelength
[ bonelength ] = ComputeBoneLength( rigids, boneSequence );
disp('Done computing bonelength')
    
%% Transform objects (bones)
scale=0.04;
inc=1;

tic

% we transform the bones/objects for each frames
for frame=1%:length(selected_frames)
    hold on    
    
    for i=1:length(boneSequence)-1
        rig_num=boneSequence(i); % find the rigid
        
        if i~=6 && i~=11 && i~=16 && i~=20 && i~=24%i~=3 && i~=8 && i~=13 && i~=18 && i~=23
            
            %root
            if i==1
                new_rigids{rig_num}(frame,1:3)=rigids{rig_num}(frame,1:3);
                %transfrom the root
                M_translateS_new= makehgtform('translate', new_rigids{rig_num}(frame,1:3));
                MscaleS=makehgtform('scale',0.03);
                set(Ftt(i),'Matrix',M_translateS_new*MscaleS)
            end
            
            next_rig_num=boneSequence(i+1);
            %apply offset
            new_rigids{next_rig_num}(frame,1:3)=rigids{next_rig_num}(frame,1:3);
            
            a = new_rigids{rig_num}(frame,1:3);
            b = new_rigids{next_rig_num}(frame,1:3);
            extended_point{next_rig_num}(frame,:) = a + (bonelength(next_rig_num)/norm(a-b))*(b-a); % the position of the extented rigid body
            c = [a(1) a(2) norm(a-extended_point{next_rig_num}(frame,:))+a(3)];
            
            new_rigids{next_rig_num}(frame,1:3)=extended_point{next_rig_num}(frame,:);
            
            %transfrom the new extended spheres
            if next_rig_num==6
                scale=0.09;                
                MscaleS=makehgtform('scale',scale);
            else
                scale=0.04;                
                MscaleS=makehgtform('scale',scale);
            end
            M_translateS_new= makehgtform('translate',new_rigids{next_rig_num}(frame,1:3));
            set(Ftt_new(i),'Matrix',M_translateS_new*MscaleS);
            
            %compute the transformation of the cylinders
            A=c-a; % the initial vector passing through cylinder
            B=(extended_point{next_rig_num}(frame,:)-a); % the new vector
            [ angle, axiss ] = AxisAngle_Between2vectors( A, B );
            
            %transform the cylinders
            M_rotate=rotationTO4x4matrix( AxisAngle2RotationMatrix( axiss, angle) );
            scale=0.04;
            M_scale=makehgtform('scale',[ scale,scale,bonelength(next_rig_num) ]);
            M_translate= makehgtform('translate',new_rigids{rig_num}(frame,1:3));
            set(Ft(i),'Matrix',M_translate*M_rotate*M_scale);
            
            %drawnow
            drawnow limitrate
        end    
    end 
end


disp('Done creating frames')

%% check if the animation was played in the right speed
toc %estimates the time from the last tic (line 43), which estimates the length of the animation
(selected_frames(end)-selected_frames(1))/sampling_rate %estimates the time duration of the collected data

% these two parameters should be approximately equal, if not play with
% the "step" value (line 3) to make the animation play in a realistic speed.
% how fast the animation is produced depends on your computers processing
% ability among other parameters. Therefore, we control the speed of he 
% produced animation by increasing and reducing the skipped frames 
% (corresponding parameter "step").

