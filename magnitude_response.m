%3
%magnitude response of the filter
[h,w]=freqz(hncau,1); 
plot(w/pi,db(h))
xlabel("Normalized Frequency (\times\pi rad/sample)")
ylabel("Magnitude (dB)")
title("Magnitude response of the Filter")