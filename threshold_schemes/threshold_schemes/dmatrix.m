function y = dmatrix(x)


% d=dmatrix(data =[N x p]), 

%INPUT:         x = [nodes x dimensionality of the coordinates]
%OUTPUT: distance = distance matrix


%NIKOLAOS LASKARIS
%see http://users.auth.gr/~laskaris/index.htm

[m,n]=size(x);



a=x*x';
e=ones(m,m) ;
d=diag(diag(a))*e + e*diag(diag(a))-2*a ;



y=d;


