function D = peakVally(S)
[m,n] =size(S);
D = sign([diff(S,1,1);zeros(1,m)])+sign(-[zeros(1,m);diff(S,1,1)])+sign(-[zeros(n,1),diff(S,1,2)])+sign([diff(S,1,2),zeros(n,1)]);