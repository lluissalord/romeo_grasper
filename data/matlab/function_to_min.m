function F = function_to_min(params)
%(S)    matrix of base change
%(v_x)  vector x of the base change
%(v_y)  vector y of the base change
%(v_z)  vector z of the base change
%(p_c)  point of the camera
v_x = params(1,1:3);
v_y = params(2,1:3);
v_z = params(3,1:3);
p_c = params(4,1:3);

on_side = 1;

%Resultat real de camera - base link es aprox [0,0.79,-0.12] de costat i [1.10,0,0.06] i esta
%inclinat uns 15º aprox

%ON SIDE!
if(on_side)
%Wrist
p_1_real = [0.08329,0.2784,-0.312];
%p_1_camera = [-0.11,0.14,0.62]; %on the left
%p_1_camera = [0.05,0.14,0.52]; %on the left turn a bit
p_1_camera = [-0.125731,0.152932,0.685622]; %on the left real
%p_1_camera = [-0.62,0.14,0.11]; %in front

%Shoulder
p_2_real = [0.049862,0.19,0.073851];
%p_2_camera = [-0.085,-0.24,0.533]; %on the left
%p_2_camera = [0.07,-0.24,0.42]; %on the left turn a bit
p_2_camera = [-0.08,0.04,0.62]; %on the left real
%p_2_camera = [-0.533,-0.24,0.085]; %in front

%Elbow
p_3_real = [0.09125,0.1804,0.1332];
%p_3_camera = [-0.085,-0.24,0.533]; %on the left
%p_3_camera = [0.07,-0.24,0.42]; %on the left turn a bit
p_3_camera = [-0.131669,0.0559939,0.70123]; %on the left real
%p_3_camera = [-0.533,-0.24,0.085]; %in front
else
%IN FRONT!!
%Wrist RIGHT
p_1_real = [0.17225,-0.15585,-0.306];
p_1_camera = [-0.233355,0.101,1.07];

%Shoulder RIGHT
p_2_real = [0.04811,-0.19,0.073851];
p_2_camera = [-0.25,-0.318,1.075];

%Elbow RIGHT
p_3_real = [0.1035,-0.178,-0.129];
p_3_camera = [-0.225367,-0.103688,1.04615];
end

S = [(v_x./norm(v_x))' (v_y./norm(v_y))' (v_z./norm(v_z))'];

F(1:3) = p_c' - p_1_real' + S * p_1_camera';
F(4:6) = p_c' - p_2_real' + S * p_2_camera';
F(7:9) = (p_2_real' - p_1_real') - S * (p_2_camera' - p_1_camera');
F(10:12) = (p_3_real' - p_1_real') - S * (p_3_camera' - p_1_camera');
F(5) = abs(v_z(1) - (v_x(2)*v_y(3) - v_x(3)*v_y(2))) + abs(v_z(2) + (v_x(1)*v_y(3) - v_x(3)*v_y(1))) + abs(v_z(3) - (v_x(1)*v_y(2) - v_x(2)*v_y(1)));
F(6) = abs(v_y(1) - (v_z(2)*v_x(3) - v_z(3)*v_x(2))) + abs(v_y(2) + (v_z(1)*v_x(3) - v_z(3)*v_x(1))) + abs(v_y(3) - (v_z(1)*v_x(2) - v_z(2)*v_x(1)));
end