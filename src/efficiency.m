function E=efficiency(G,local)
%Global and local efficiency for binary undirected graph G.
%
%Eglob=efficiency(G); outputs the inverse distance matrix: the mean of this
%matrix (excluding main diagonal) is equivalent to the global efficiency.
%
%Eloc=efficiency(G,1); outputs individual nodal local efficiency.
%For directed networks, local efficiency works with the out-degree.
%
%Reference: Latora and Marchiori, 2001, Phys Rev Lett 87:198701.
%
%Algebraic shortest path algorithm.
%
%Mika Rubinov, UNSW, 2008 (last modified September 2008).

if nargin==2;                           %local efficiency
    N=length(G);                        %number of nodes
    E=zeros(N,1);                       %local efficiency

    for u=1:N
        V=find(G(u,:));                 %neighbors
        k=length(V);                    %degree
        if k>=2;                        %degree must be at least two
            e=distance_inv(G(V,V));
            E(u)=sum(e(:))./(k.^2-k);	%local efficiency
        end
    end
else
    E=distance_inv(G);                  %global efficiency
end

function D=distance_inv(g);
D=eye(length(g));
n=1;
nPATH=g;                        %n-path matrix
L=(nPATH~=0);                   %shortest n-path matrix

while find(L,1);
    D=D+n.*L;
    n=n+1;
    nPATH=nPATH*g;
    L=(nPATH~=0).*(D==0);
end

D(~D)=inf;                      %disconnected nodes are assigned d=inf;
D=1./D;                         %invert distance
D=D-eye(length(g));