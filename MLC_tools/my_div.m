function q=my_div(x,y)
    % MY_DIV customized version of division
    % See also my_exp, my_log, opset
protection = 1e-3;

y(y==0)=inf;
q=x./(y.*(abs(y)>protection)+protection*sign(y).*(abs(y)<=protection));
end
