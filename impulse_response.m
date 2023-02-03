
%ideal impulse response
hnT = ImpulseR(n,T,Ws,Wc1,Wc2);
stem(n,hnT);
xlabel("n")
ylabel("Amplitude: h[nT]")
title("Idealized Impulse Response")

%calculating delta
delta_p = (10^(0.05*Ap)-1)/(10^(0.05*Ap)+1);
delta_a = 10^(-0.05*Aa);
delta = min(delta_p,delta_a);
%calculating actual Aa
Aa_act = -20*log10(delta);
%calculating alpha
alpha = getAlpha(Aa_act);
%calculating D
D = getD(Aa_act);
%getting N
N = getN(Ws,D,Bt);
%kaiser window
WknT = getWknT(alpha,n,N);
stem(n,WknT);
xlabel("n")
ylabel("Amplitude: Wk[nT]")
title("Impulse Response of Kaiser Window")

%filter function in time domain
hn=hnT.*WknT;
stem(n,hn) 
xlabel("n")
ylabel("Amplitude: hn")
title("Impulse Response of Windowed Filter")



function [hnT] = ImpulseR(n,T,Ws,Wc1,Wc2)
hnT = zeros(size(n));
for num = n
    if num == 0
        hnT(n==num) = 2*(Wc2-Wc1)/Ws;
    else
        hnT(n==num) = (sin(Wc2*num*T)-sin(Wc1*num*T))/(num*pi);
    end
end
end

function [alpha] = getAlpha(Aa_act)
if Aa_act<=21
    alpha = 0;
else
    if Aa_act<=50
        alpha = (0.5842*(Aa_act-21)^0.4)+(0.07886*(Aa_act-21));
    else
        alpha = 0.1102*(Aa_act-8.7);
    end
end
end

function [D] = getD(Aa_act)
if Aa_act<=21
    D = 0.9222;
else
    D = (Aa_act-7.95)/14.36;
end
end
function [N] = getN(Ws,D,Bt)
Ntemp = ((Ws*D)/Bt)+1;
Nint = round(Ntemp);
if Nint<Ntemp
    Nint = Nint+1;
end
if mod(Nint,2)==1
    N = Nint;
else 
    N = Nint+1;
end
end
function [W] = getWknT(alpha,n,N)
beta = alpha*(1-(2*n/(N-1)).^2).^0.5;
W = Io(beta)/Io(alpha);
%W = zeros(size(n));
for num1 = n
    %beta = alpha*(1-(2*num1/(N-1)).^2).^0.5;
    if abs(num1) >= ((N-1)/2)
        W(n==num1) = 0;
    %else
        %W(n==num1) = 0;
    end
end
end
function [I] = Io(n)
I = zeros(size(n));
for k = 1:10
    I = I + (((n/2).^k)*(1/factorial(k))).^2;
end
I = 1 + I;
end
