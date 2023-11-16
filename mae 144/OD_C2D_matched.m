function [Dz] = OD_C2D_matched(Ds, h, omega_bar, causal)
    % function [Dz] = OD_C2D_matched(Ds, h, omega_bar, causal)
    % Compute the matched Z transform D(z) by mapping the poles and zeros of D(s) to D(z)
    % NOTE: If the argument causal = 1, the function returns a semi-causal D(z)
    % TEST: z1=1; p1=10; xs=[1 p1 0]; ys=[1 z1]; Ds=RR_tf(ys,xs); h=0.1; omega_bar=0; causal=0; [Dz]=OD_C2D_matched(Ds,h,omega_bar,causal)
    if nargin == 3, causal = 0; end
    omega = 0; omega = omega_bar;
    m = Ds.num.n; n = Ds.den.n;
    zeros = RR_roots(Ds.num); poles = RR_roots(Ds.den);
    for j=1:m, z(j) = exp((zeros(j)*h)); end
    if causal == 1
        if m < n, for i=1:n-m, z(m+i) = -1; end; end
    end
    for j = 1:n, p(j) = exp((poles(j)*h)); end
    gain = RR_evaluate(Ds, 1i*omega);
    if (isnan(gain) || isinf(gain)), bs = RR_poly(z,1); as = RR_poly(p,1);
    else, bs = RR_poly(z,gain); as = RR_poly(p,gain); end
    Dz = RR_tf(bs, as);
end