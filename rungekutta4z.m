% Deklaracja funkcji dla metody Rungego-Kutty ze zmiennym krokiem:
function [X1,X2,t, H, E1, E2] = rungekutta4z(f1,f2,x01,x02,h,a,b,epsw, epsb, hmin)
% Dziedzina czasu:
t(1,1) = a;
% Warunki początkowe:
x1=x01;
x2=x02;
% Wektory rozwiązań, estymaty błędu i długości kroku:
X1(1,1) = x01;
X2(1,1) = x02;
H(1,1) = h;
E1(1,1) = 0;
E2(1,1) = 0;
i = 1;

% Pętla główna:
while(t(i,1)+h<b)

    % Wyliczenie punktu dla pojedyńczego kroku o długości h:
    k11 = f1(x1, x2);
    k12 = f2(x1, x2);

    k21 = f1(x1+0.5*h*k11, x2 + 0.5*h*k12);
    k22 = f2(x1+0.5*h*k11, x2 + 0.5*h*k12);

    k31 = f1(x1+0.5*h*k21, x2 + 0.5*h*k22);
    k32 = f2(x1+0.5*h*k21, x2 + 0.5*h*k22);

    k41 = f1(x1+h*k31, x2 + h*k32);
    k42 = f2(x1+h*k31, x2 + h*k32);

    x1p = x1 + (1/6)*(k11+2*k21+2*k31+k41)*h;
    x2p = x2 + (1/6)*(k12+2*k22+2*k32+k42)*h;

    x1d = x1;
    x2d = x2;

    % Wyliczenie punktu dla podwójnego kroku o długości 0,5h:
    for j=1:2
        k11d = f1(x1d, x2d);
        k12d = f2(x1d, x2d);
        
        k21d = f1(x1d+0.25*h*k11d, x2d + 0.25*h*k12d);
        k22d = f2(x1d+0.25*h*k11d, x2d + 0.25*h*k12d);
        
        k31d = f1(x1d+0.25*h*k21d, x2d + 0.25*h*k22d);
        k32d = f2(x1d+0.25*h*k21d, x2d + 0.25*h*k22d);
        
        k41d = f1(x1d+0.5*h*k31d, x2d + 0.5*h*k32d);
        k42d = f2(x1d+0.5*h*k31d, x2d + 0.5*h*k32d);
        
        x1d = x1d + (1/6)*(k11d+2*k21d+2*k31d+k41d)*0.5*h;
        x2d = x2d + (1/6)*(k12d+2*k22d+2*k32d+k42d)*0.5*h;

    end
   
    % Szacowanie błędu:
    error1=(abs(x1d-x1p))/15;
    error2=(abs(x2d-x2p))/15;

    % Wyliczenie błędu:
    e1 = abs(x1d) * epsw + epsb;
    e2 = abs(x2d) * epsw + epsb;

    % Obliczenie parametru alfa i wybranie najmniejszego z nich:
    alfa1 = (e1/error1)^(1/5);
    alfa2 = (e2/error2)^(1/5);
    alfa = min(alfa1, alfa2);

    %Wyliczenie korekty kroku:
    corr = 0.9 * alfa * h;

    % Sprawdzenie odpowiednich warunków:
    if 0.9 * alfa >= 1
        % Zwiększenie kroku i przejście do obliczania następnego punktu:
        if (t(i,1) + h <= b)
            h = min([b - t(i,1); 5*h; corr]);
            x1=x1d;
            x2=x2d;
            X1(i,1) = x1;
            X2(i,1) = x2;
            t(i+1,1) = t(i,1)+h;
            E1(i,1) = error1;
            E2(i,1) = error2;
            H(i,1) = h;
            i= i+1;
        end 
    else
        % Zmniejszenie punktu lub przerwanie algorytmu:
        if h < hmin
            break;
        else
            h = corr;
        end
    end
end