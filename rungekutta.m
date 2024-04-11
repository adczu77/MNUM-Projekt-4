% Deklaracja funkcji dla metody Rungego-Kutty ze stałym krokiem:
function [x1v,x2v,t] = rungekutta(f1,f2,x01,x02,a,b,h)
% Dziedzina czasu:
t = (a:h:b);
% Warunki początkowe:
x1 = x01;
x2 = x02;
% Wektory rozwiązań:
x1v = (x01);
x2v = (x02);
% Pętla główna:
for i=1:(length(t))

    % Wyznaczenie pierwszej pary współczynników:
    k11 = f1(x1, x2);
    k12 = f2(x1, x2);

    % Wyznaczenie drugiej pary współczynników:
    k21 = f1(x1+0.5*h*k11, x2 + 0.5*h*k12);
    k22 = f2(x1+0.5*h*k11, x2 + 0.5*h*k12);

    % Wyznaczenie trzeciej pary współczynników:
    k31 = f1(x1+0.5*h*k21, x2 + 0.5*h*k22);
    k32 = f2(x1+0.5*h*k21, x2 + 0.5*h*k22);

    % Wyznaczenie czwartej pary współczynników:
    k41 = f1(x1+h*k31, x2 + h*k32);
    k42 = f2(x1+h*k31, x2 + h*k32);

    % Wyznaczenie i-tego rozwiązania:
    x1 = x1 + (1/6)*(k11+2*k21+2*k31+k41)*h;
    x2 = x2 + (1/6)*(k12+2*k22+2*k32+k42)*h;

    % Dodanie rozwiązań do wektorów rozwiązań:
    x1v(i+1) = x1;
    x2v(i+1) = x2;
end

