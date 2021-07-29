function val_out=thresh(val_in,val_min,val_max)
    % THRESH Limits the action between a minimum and a maximum.
    % See also strrep_cl, limit_to.
val_out = val_in;
val_out(val_in>val_max) = val_max;
val_out(val_in<val_min) = val_min;
