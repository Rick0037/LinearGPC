function q=my_log(x)
    % MY_LOG customized version of log
    % See also my_div, my_log, opset.

protection = 1e-3;
q=log10(abs(x).*(abs(x)>=protection)+protection*(abs(x)<protection));
end
