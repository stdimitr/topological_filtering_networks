function lbmrn= mst_density(spatial,density)


%INPUTS: spatial = spatial coordinates of the nodes 
%                  (M x d) = M # of nodes,d dimensions                                                                     
%        density = number of connections divide by the possible number of
%              connections
%OUTPUT:   lbmrn = lower bound minimum rewiring network  

%adopted from Kaiser & Hiltegag Nonoptimal Component Placement, but Short
%Processing Paths, due to Long-Distance Projections in Neural Systems, Plos
%Computational Biology, 2006

%%%%%%%%%%%%%%%HOW THE ALGORITHM WORKS %%%%%%%%%%%%%%%%%%%%%%

% Starting with the spatial configuration of nodes in the original
% networks, but without edges, a minimum spanning tree was
% generated, to ensure that the resulting network would be connected.
% The minimum spanning tree for N nodes consists of N-1 edges such
% that all nodes are part of the network and the total wiring length of
% all edges is minimal
% In the next step, all pairwise distances of nodes were calculated and
% sorted by length. Starting with the shortest distance between any two
% nodes, edges between these nodes were generated until the total
% number of edges matched those of the original w or cortical
% networks. Thus, the resulting minimally rewired networks represented
% a lower bound for the wiring length of a connected network
% with the same total number of edges and identical node positions as
% in the original neural networks.


%needs dmatrix()

%DIMITRIADIS STAVROS 2/2008 
%see http://users.auth.gr/~laskaris/index.htm


%Since each iteration of minimal spanning tree (MST) returns N-1 edges, we
%find first the total number of rounds.

%# of nodes
nodes=0;
nodes=length(spatial);

%possible number of nodes
no=0;
no=(nodes*(nodes-1))/2;

%number of connections
con=0;
con=round(density*no);

%# rounds of MST
rmst=0;
rmst=ceil(con/(nodes-1));

%matrix that keeps the indices of the connections returned by the MST
indices(1:rmst*(nodes-1),1:2)=0;

%call dmatrix to transform spatial coordinates of the nodes into distance
%matrix

d=dmatrix(spatial);


for i=1:rmst  
    [links,weights]=minimal_spanning_tree(d);
    
    for j=1:nodes-1
        %keep the indices of the links
        indices((i-1)*(nodes-1) + j,1)=links(j,1);
        indices((i-1)*(nodes-1) + j,2)=links(j,2);
        %substitute the edges traversed by MST with Inf
        d(links(j,1),links(j,2))=Inf;
        d(links(j,2),links(j,1))=Inf;
    end
    
end

lbmrn(1:nodes,1:nodes)=0;

for k=1:con
    lbmrn(indices(k,1),indices(k,2))=1;
    lbmrn(indices(k,2),indices(k,1))=1;
end



