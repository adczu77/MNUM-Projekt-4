% Deklaracja funkcji dla metody predyktor-korektor ze stałym krokiem:
function [x1v, x2v, t] = predcorr(f1,f2,x01,x02,a,b,h)
% Dziedzina czasu:
t = (a:h:b);
% Warunki początkowe:
y(:,1) = [x01 x02];
x1v(:,1) = x01;
x2v(:,1) = x02;
% Wyliczenie czterech pierwszych punktów za pomocą metody Rungego-Kutty:
[y1, y2] = rungekutta(f1,f2,x01,x02,t(1),t(4),h);
for i=1:3
    x1 = y1(i);
    x2 = y2(i);
    x1v(i) = x1;
    x2v(i) = x2;
    y(:,i+1)=[x1 x2];
end
% Pętla główna:
for i=4:length(t)
% Wyliczenie współczynników predyktorów:
p1 = x1 + (h/24)*(55*f1(x1,x2) - 59*f1(x1v(i-1),x2v(i-1)) + 37*f1(x1v(i-2),x2v(i-2)) - 9*f1(x1v(i-3),x2v(i-3)));
p2 = x2 + (h/24)*(55*f2(x1,x2) - 59*f2(x1v(i-1),x2v(i-1)) + 37*f2(x1v(i-2),x2v(i-2)) - 9*f2(x1v(i-3),x2v(i-3)));
% Korekcja, która oblicza kolejne wartości punktów:
x1 = x1 + (h/720)*(646*f1(x1,x2) - 264*f1(x1v(i-1),x2v(i-1)) + 106*f1(x1v(i-2),x2v(i-2)) - 19*f1(x1v(i-3),x2v(i-3)) + 251*f1(p1, p2));
x2 = x2 + (h/720)*(646*f2(x1,x2) - 264*f2(x1v(i-1),x2v(i-1)) + 106*f2(x1v(i-2),x2v(i-2)) - 19*f2(x1v(i-3),x2v(i-3)) + 251*f2(p1, p2));
% Dodanie punktów do wektora rozwiązań:
x1v(i) = x1;
x2v(i) = x2;
end