%%% interp.m computes the value of some quantity following the weights
%%% ����q����ֵ����w���в�ֵ
function Q_interp = interpolation(W,Q)
    if max(abs(W))==0
        Q_interp = Q(1,:);
    else
        Q_interp = W(1).*Q(1,:) + W(2).*Q(2,:) + W(3).*Q(3,:);
    end
end
