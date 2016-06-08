function [params,p_1_real,p_1_camera,p_2_real,p_2_camera,p_3_real,p_3_camera]=loadparams(on_side, param_num)

%ON SIDE!
if(on_side)
    if(param_num == 1)
        params = [-1 0 0;0 0 -1;0 -1 0;0.05 0.7 -0.3];
    else if(param_num == 2)
            params = [-1 0 0;0 0 -1;0 -1 0;0.05 0.7 -0.3];
        else
            params = [-1 0 0;0 0 -1;0 -1 0;0.05 0.7 -0.3];
        end
    end
    %Wrist
    %p_1_real = [0.08329,0.2784,-0.312];
    p_1_real = [0.17225, 0.15585,-0.306];
    %p_1_camera = [-0.11,0.14,0.62]; %on the left
    %p_1_camera = [0.05,0.14,0.52]; %on the left turn a bit
    %p_1_camera = [-0.125731,0.152932,0.685622]; %on the left real
    p_1_camera = [-0.146, 0.183, 0.664]; %on the left real (last try)
    %p_1_camera = [-0.62,0.14,0.11]; %in front

    %Shoulder
    p_2_real = [0.049862,0.19,0.073851];
    %p_2_camera = [-0.085,-0.24,0.62]; %on the left
    %p_2_camera = [0.07,-0.24,0.42]; %on the left turn a bit
    %p_2_camera = [-0.08,-0.04,0.62]; %on the left real (NO POT ESTAR BE, NO HO ENTENC!!)
    p_2_camera = [-0.13, -0.12-0.12, 0.63]; %on the left real (last try)
    %p_2_camera = [-0.533,-0.24,0.085]; %in front

    %Elbow
    p_3_real = [0.09125,0.1804,-0.1332];
    %p_3_camera = [-0.085,-0.24,0.533]; %on the left
    %p_3_camera = [0.07,-0.24,0.42]; %on the left turn a bit
    %p_3_camera = [-0.131669,0.0559939,0.70123]; %on the left real
    p_3_camera = [-0.17, -0.02, 0.663]; %on the left real (last try)
    %p_3_camera = [-0.533,-0.24,0.085]; %in front
else
    %IN FRONT!!
    if(param_num == 1)
        params = [0 1 0;0 0 -1;-1 0 0;1.10 0 0.06];
    else if(param_num == 2)
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