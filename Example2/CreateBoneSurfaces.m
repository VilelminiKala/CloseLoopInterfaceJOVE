%%#########################################################

%  Copyright 2018, Vilelmini Kalampratsidou, All rights reserved.
%  This program and the accompanying material
%  presented at JOVE video journal are available at
%  https://github.com/VilelminiKala/CloseLoopInterfaceJOVE.git

%%#########################################################

function [ Ftt,Ft, Ftt_new ] = CreateBoneSurfaces(ax, boneSequence, scale )
%CreateBoneSurfaces: It created the bone structures initiated at the point
%(0,0,0) with 0 rotation

[x1,y1,z1]=sphere(5);
[x,y,z] = cylinder(1,5);
MscaleS=makehgtform('scale',scale);

for i=1:length(boneSequence)-1
    j=boneSequence(i);
    
    if i==1
        %rigid bodies
        Fs(i)=surface((x1),(y1),(z1),'FaceColor','b');
        Ftt(i) = hgtransform('Parent',ax);
        set(gcf,'Renderer','opengl')
        set(Fs(i),'Parent',Ftt(i))
        copyobj(Fs(i),Ftt(i));
    end
    
    if i~=6 && i~=11 && i~=16 && i~=20 && i~=24  %i~=3 && i~=8 && i~=13 && i~=18 && i~=23
        %extended rigid bodies
        Fs_new(i)=surface(x1,y1,z1,'FaceColor','b');
        Ftt_new(i) = hgtransform('Parent',ax);
        set(gcf,'Renderer','opengl')
        set(Fs_new(i),'Parent',Ftt_new(i))
        copyobj(Fs_new(i),Ftt_new(i));
        
        %%cylinders
        Fcyl(1)=surface(x,y,z,'FaceColor','b');
        Ft(i) = hgtransform('Parent',ax);
        set(gcf,'Renderer','opengl')
        set(Fcyl,'Parent',Ft(i))
        copyobj(Fcyl,Ft(i));
    end
end


end

