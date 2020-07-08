function [r_path, r_cost] = dijkstra(pathS, pathE, transmat)
% The Dijkstra's algorithm, Implemented by Yi Wang, 2005
% This version support detecting _cyclic-paths_
%
%   pathS : the index of start node, indexing from 1
%   pathE : the index of end node, indexing from 1
% transmat: the transition matrix, or adjacent matrix
%

% Ensure the transition matrix is square
%
if ( size(transmat,1) ~= size(transmat,2) )
  error( 'detect_cycles:Dijkstra_SC', ...
         'transmat has different width and heights' );
end


% Initialization:
%  noOfNode     : nodes in the graph
%  parent(i)    : record the parent of node i
%  distance(i)  : the shortest distance from i to pathS
%  queue        : for width-first traveling of the graph
noOfNode = size(transmat, 1);

for i = 1:noOfNode
  parent(i) = 0;
  distance(i) = Inf;
end

queue = [];


% Start from pathS
%
for i=1:noOfNode
  if transmat(pathS, i)~=Inf 
    distance(i) = transmat(pathS, i);
    parent(i)   = pathS;
    queue       = [queue i];
  end
end



% Width-first exploring the whole graph
%
while length(queue) ~= 0
  
  hopS  = queue(1);
  queue = queue(2:end);
  
  for hopE = 1:noOfNode
    if distance(hopE) > distance(hopS) + transmat(hopS,hopE)
      distance(hopE) = distance(hopS) + transmat(hopS,hopE);
      parent(hopE)   = hopS;
      queue          = [queue hopE];
    end
  end
  
end


% Back-trace the shortest-path
%
r_path = [pathE];    
i = parent(pathE);

while i~=pathS && i~=0
  r_path = [i r_path];
  i      = parent(i);
end

if i==pathS
  r_path = [i r_path];
else
  r_path = [];
end
  

% Return cost
%
r_cost = distance(pathE);

