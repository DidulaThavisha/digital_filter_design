A = 5;
B = 6;
C = 4;
%parameters
Ap = 0.03 + (0.01*A)    %dB
Aa = 45 + B             %dB
Wp1 = (C*100) + 300     %rad/s
Wp2 = (C*100) + 700     %rad/s
Wa1 = (C*100) + 150     %rad/s
Wa2 = (C*100) + 800     %rad/s
Ws = 2*((C*100) + 1200)    %rad/s
Bt = min(Wp1-Wa1, Wa2-Wp2);
Wc1 = Wp1 - (Bt/2);
Wc2 = Wp2 + (Bt/2);
T = 2*pi/Ws;
len = 150;
n = -len:len;


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
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
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
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [D] = getD(Aa_act)
if Aa_act<=21
    D = 0.9222;
else
    D = (Aa_act-7.95)/14.36;
end
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
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
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
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
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [I] = Io(n)
I = zeros(size(n));
for k = 1:10
    I = I + (((n/2).^k)*(1/factorial(k))).^2;
end
I = 1 + I;
end
