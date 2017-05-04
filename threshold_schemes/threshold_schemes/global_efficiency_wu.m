function [gl_node gl]=global_efficiency_wu(w)

%calculate global efficiency
%INPUT: w = inverse FCG (functional connectivity graph)
%OUTPUT:gl_node = global efficiency per node
%       gl = total global efficiency of the network
% distance = matrix which preserve the weighted shortest path length 
%   binary = matrix which preserve the most significant edges
%Stavros Dimitriadis, 5/2009


n=length(w);


distance(1:n,1:n)=0;
[distance] = all_shortest_paths(sparse(w));


inv_distance(1:n,1:n)=0;

for i=1:n
    for j=(i+1):n
        inv_distance(i,j)=1/distance(i,j);
        inv_distance(j,i)=1/distance(i,j);
    end
end


gl_node(1:n)=0;

for i=1:n
    gl_node(i)=sum(inv_distance(i,:))/(n-1);
end

%total global efficiency of the network
gl=0;
gl=sum(gl_node)/n;



