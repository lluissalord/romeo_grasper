qx = 0.647389;
qy = 0.384749;
qz = -0.34923;
qw = 0.557578;
Roc = inv(quat2dcm([qw qx qy qz]));
Poc = [-0.17031; -0.021598; 0.662837];
Toc = [Roc Poc; 0 0 0 1]

Rlo = angle2dcm(pi/2, -pi/2, 0, 'ZYX');
Plo = [0; 0; 0];
Tlo = [Rlo Plo; 0 0 0 1]

qx = -0.65831;
qy = 0.020763;
qz = -0.23624;
qw = 0.71442;
Rlb = inv(quat2dcm([qw qx qy qz]));
Plb = [0.098911; 0.2016; -0.13104];
Tlb = [Rlb Plb; 0 0 0 1]

Tcb = Tlb * inv(Tlo) * inv(Toc)