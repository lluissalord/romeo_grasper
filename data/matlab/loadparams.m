function [params,p_1_real,p_1_camera,p_2_real,p_2_camera,p_3_real,p_3_camera]=loadparams(on_side, seed_num)

%ON SIDE!
if(on_side)
    if(seed_num == 1)
        S1 = angle2dcm(-pi/12, 0, pi/2, 'XYZ');
        S2 = [0 0 1;-1 0 0;0 -1 0];
        params = [S1*S2 ;0.0869 0.73 -0.1897];
    else if(seed_num == 2)
            params = [-1 0 0;0 0 -1;0 -1 0;0.0869 0.73 -0.1897];
        else
            params = [-1 0 0;0 0 -1;0 -1 0;0.0 0.9 -0.1];
        end
    end
    %Wrist
    p_1_real = [0.1974, 0.17626, -0.29891];
    %p_1_camera = [-0.209727, 0.158789, 0.553125];
    p_1_camera = [-0.209727+0.08, 0.158789, 0.553125-0.045]; %apply offset model
    %p_1_camera = [-0.62,0.14,0.11]; %in front

    %Shoulder
    p_2_real = [0.050153,0.1899,0.073851];
    %p_2_camera = [-0.19857-0.02, -0.09369-0.17, 0.5763+0.02];
    p_2_camera = [-0.19857-0.02+0.08, -0.09369-0.17, 0.5763+0.02-0.045]; %apply offset model
    %p_2_camera = [-0.533,-0.24,0.085]; %in front

    %Elbow
    p_3_real = [0.11796,0.18577,-0.1259];
    %p_3_camera = [-0.2128, -0.0116, 0.5529];
    p_3_camera = [-0.2128+0.08, -0.0116, 0.5529-0.045]; %apply offset model
    %p_3_camera = [-0.533,-0.24,0.085]; %in front
else
    %IN FRONT!!
    if(seed_num == 1)
        params = [0 1 0;0 0 -1;-1 0 0;1.10 0 0.06];
    else if(seed_num == 2)
            params = [0 1 0;0 0 -1;-1 0 0;1.10 0 0.06];
        else
            params = [0 1 0;0 0 -1;-1 0 0;1.10 0 0.06];
        end
    end
    
    %Wrist RIGHT
    %p_1_real = [0.17225,-0.15585,-0.306];
    %p_1_camera = [-0.233355,0.101,1.07];
    %Wrist LEFT
    p_1_real = [0.216,0.175,-0.292];
    p_1_camera = [0.1857,0.102,1.023];
    
    %Shoulder RIGHT
    %p_2_real = [0.04811,-0.19,0.073851];
    %p_2_camera = [-0.25,-0.318,1.075];
    %Shoulder LEFT
    p_2_real = [0.051,0.19,0.073851];
    p_2_camera = [-0.277,-0.234-0.07,0.798];
    
    %Elbow RIGHT
    %p_3_real = [0.1035,-0.178,-0.129];
    %p_3_camera = [-0.225367,-0.103688,1.04615];
    %Elbow LEFT
    p_3_real = [0.13,0.185,-0.122];
    p_3_camera = [0.3167,-0.0709,0.9064];
end
end