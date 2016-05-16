function [c, ceq] = nonlinealconstraint(params)
v_x = params(1,1:3);
v_y = params(2,1:3);
v_z = params(3,1:3);
S = [(v_x./norm(v_x))' (v_y./norm(v_y))' (v_z./norm(v_z))'];

ceq(1) = abs(v_z(1) - (v_x(2)*v_y(3) - v_x(3)*v_y(2))) + abs(v_z(2) + (v_x(1)*v_y(3) - v_x(3)*v_y(1))) + abs(v_z(3) - (v_x(1)*v_y(2) - v_x(2)*v_y(1)));
ceq(2) = abs(v_y(1) - (v_z(2)*v_x(3) - v_z(3)*v_x(2))) + abs(v_y(2) + (v_z(1)*v_x(3) - v_z(3)*v_x(1))) + abs(v_y(3) - (v_z(1)*v_x(2) - v_z(2)*v_x(1)));

c(1)= - det(S); %det(S) > 0

end