function r=distance(params)
params;
%(S)    matrix of base change
%(v_x)  vector x of the base change
%(v_y)  vector y of the base change
%(v_z)  vector z of the base change
%(p_c)  point of the camera
v_x = params(1,1:3);
v_y = params(2,1:3);
v_z = params(3,1:3);
p_c = params(4,1:3);

tolerance = 0.01;
tol = 0.05;
r = 0;

global on_side;

[~,p_1_real,p_1_camera,p_2_real,p_2_camera,p_3_real,p_3_camera]=loadparams(on_side);

% if(abs(v_x(1)*v_y(1) + v_x(2)*v_y(2) + v_x(3)*v_y(3)) > tolerance)
%     r = r + inf;
% end
% if(abs(v_x(1)*v_z(1) + v_x(2)*v_z(2) + v_x(3)*v_z(3)) > tolerance)
%     r = r + inf;
% end
% if(abs(v_z(1)*v_y(1) + v_z(2)*v_y(2) + v_z(3)*v_y(3)) > tolerance)
%     r = r + inf;
% end

% if(abs(norm(v_x) - 1) > tol || abs(norm(v_y) - 1) > tol || abs(norm(v_z) - 1) > tol)
%     r = r + inf;
% end

S = [(v_x./norm(v_x))' (v_y./norm(v_y))' (v_z./norm(v_z))'];
%p_c

% if(det(S) < 0)
%     r = r + inf;
% end

err_1_vect = p_c' - p_1_real' + S * p_1_camera';
err_1 = err_1_vect' * err_1_vect;

err_2_vect = p_c' - p_2_real' + S * p_2_camera';
err_2 = err_2_vect' * err_2_vect;

err_3_vect = p_c' - p_3_real' + S * p_3_camera';
err_3 = err_3_vect' * err_3_vect;

err_dif_vect = (p_2_real' - p_1_real') - S * (p_2_camera' - p_1_camera');
err_dif = err_dif_vect' * err_dif_vect;

err_dif2_vect = (p_3_real' - p_1_real') - S * (p_3_camera' - p_1_camera');
err_dif2 = err_dif2_vect' * err_dif2_vect;

% Only two difference because the third vector is linear dependent with the
% others two vectors
% err_dif3_vect = (p_3_real' - p_2_real') - S * (p_3_camera' - p_2_camera');
% err_dif3 = err_dif3_vect' * err_dif3_vect;

r = r + (err_1 + err_2 + err_3);
%r = r + 1E2*(err_dif + err_dif2 + err_dif3);
r = r + (err_dif + err_dif2);
%r = r + (abs(norm(v_x) - 1) + abs(norm(v_y) - 1) + abs(norm(v_z) - 1));
%r = r + (abs(v_x(1)*v_y(1) + v_x(2)*v_y(2) + v_x(3)*v_y(3)) + abs(v_x(1)*v_z(1) + v_x(2)*v_z(2) + v_x(3)*v_z(3)) + abs(v_z(1)*v_y(1) + v_z(2)*v_y(2) + v_z(3)*v_y(3)))
%r = r + abs(v_z(1) - (v_x(2)*v_y(3) - v_x(3)*v_y(2))) + abs(v_z(2) + (v_x(1)*v_y(3) - v_x(3)*v_y(1))) + abs(v_z(3) - (v_x(1)*v_y(2) - v_x(2)*v_y(1)));
%r = r + abs(v_y(1) - (v_z(2)*v_x(3) - v_z(3)*v_x(2))) + abs(v_y(2) + (v_z(1)*v_x(3) - v_z(3)*v_x(1))) + abs(v_y(3) - (v_z(1)*v_x(2) - v_z(2)*v_x(1)))



end

