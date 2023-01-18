%4
%magnitude response of pass band
plot(w/pi,db(h))
xlim([Wp1*2/Ws Wp2*2/Ws])
xlabel("Normalized Frequency (\times\pi rad/sample)")
ylabel("Magnitude (dB)")
title("Magnitude Response for the Passband Frequencies")