function r=distance(params)
params;
options = optimset('TolFun',0.0001,'TolX',1E-4,'MaxFunEvals',1E4,'MaxIter',1E4);
r = fminsearch(@distance,params,options);

end