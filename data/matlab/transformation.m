qx = 0.548424;
qy = 0.51898;
qz = -0.437241;
qw = 0.488581;
Roc = inv(quat2dcm([qw qx qy qz]));
Poc = [-0.146128; 0.183089; 0.664464];
Toc = [Roc Poc; 0 0 0 1]

Rlo = angle2dcm(pi/2, 0, pi/2, 'ZYX');
Plo = [0; 0; 0];
Tlo = [Rlo Plo; 0 0 0 1]

qx = -0.10142;
qy = -0.79816;
qz = -0.15579;
qw = 0.57305;
Rlb = inv(quat2dcm([qw qx qy qz]));
Plb = [0.16042; 0.2048; -0.31142];
Tlb = [Rlb Plb; 0 0 0 1]

Tcb = Tlb * inv(Tlo) * inv(Toc)
S = Tcb(1:3,1:3);
[r1, r2, r3] = dcm2angle(S, 'ZYX')
p_c = Tcb(1:3,4)