%Resultat real de camera - base link es aprox [0,0.79,-0.20] de costat i [1.10,0,0.06] i esta
%inclinat uns 15º aprox. Tot això amb un error considerable de mesura
on_side = 1;
[params,p_1_real,p_1_camera,p_2_real,p_2_camera,p_3_real,p_3_camera]=loadparams(on_side);
%options = optimset('TolFun',1E-8,'TolX',1E-8,'MaxFunEvals',1E5,'MaxIter',1E5);

problem = createOptimProblem('fmincon','x0',params,'objective',@distance,'nonlcon',@nonlinealconstraint)%,'options',options)
gs = GlobalSearch;
[x,f] = run(gs,problem);

S =[(x(1,1:3)./norm(x(1,1:3)))' (x(2,1:3)./norm(x(2,1:3)))' (x(3,1:3)./norm(x(3,1:3)))']
p_c = x(4,1:3)'

p_1_real' - S * p_1_camera'
p_2_real' - S * p_2_camera'
p_3_real' - S * p_3_camera'

new_p_c = (p_2_real' - S * p_2_camera' + p_2_real' - S * p_2_camera' + p_3_real' - S * p_3_camera')/3
f