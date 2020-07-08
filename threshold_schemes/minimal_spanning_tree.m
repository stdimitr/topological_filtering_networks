function  [links,weights]=minimal_spanning_tree(d)

% [links,weights]=minimal_spanning_tree(distance_matrix/weights)
%  
%   Prim's algorithm for constructing the Minimal-Spanning Tree (MST)
%   from a given symmetric distance/similarity matrix 

%The input matrix must be a mapping from weight to distance. For 
%   instance, in a weighted correlation network, higher correlations are 
%   more naturally interpreted as shorter distances, and the input matrix 
%   should consequently be some inverse of the connectivity matrix.

%INPUT:      d = distance matrix
%OUTPUT: links = contains the edges, i.e. pairs of nodes, which constitute the MST
%      weights = contains the corresponding weights

%LASKARIS NIKOLAOS
%see http://users.auth.gr/~laskaris/index.htm

[N,N]=size(d);, V=[1:N];, r=1;, VT=r;, 

weights=zeros(1,N); links=zeros(1,N);
 
V_VT=setdiff(V,VT);

weights(V_VT)=d(r,V_VT);
links(V_VT)=r;

for i=1:N-2
 
 [edge_weight,u]=min(weights(V_VT));
  node=V_VT(u);
  VT=union(VT,node);
  V_VT=setdiff(V,VT);
 
 for j=1:N-1-i, 

 [weights(V_VT(j)),index]=min( [weights(V_VT(j)),d(node,V_VT(j))] );,
 if index == 2,  links(V_VT(j))=node;, else,end
 
 
 end

end

links=[2:N; links(2:N)]';
weights=weights(2:N)';

[ignore,list]=sort(weights);
links=links(list,:); weights=weights(list);


