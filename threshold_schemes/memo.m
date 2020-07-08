
%Please cited this Toolbox as:
%Dimitriadis SI, Laskaris NA, Tsirka V, Vourkas V, Micheloyannis S, Fotopoulos S. 
%Tracking brain dynamics via time-dependent network analysis. 
%Journal of Neuroscience Methods Volume 193, Issue 1, 30 October 2010, Pages 145-155

%CAUTION:oNLY OUR APPROACH BASED ON DIJKSTRA'S ALGORITHM AND THE ONE BASED ON MAXIMIZATION
% OF THE GLOBAL COST EFFICIENCY QUARANTEE THE CONNECTNESS OF THE NODES.
%use breadthdist.m from brain connectivity toolbox

%produce an undirected weighted random network
nodes=30;
w=rand(nodes,nodes);

for k=1:nodes
    for l=(k+1):nodes
        w(l,k)=x(k,l);
    end
end
    
for i=1:nodes
    w(i,i)=0;
end


%Calling threshold schemes
%Absolute threshold
thr=0.5;
[binary w]= threshold_abs(w, thr);

%Threshold that keeps a per centage of the strongest connections
p=0.3;
[binary w] = threshold_pro(w, p);

%Threshold based on mean degree
k1=15;
[bin threshold deg]=threslold_mean_degree(w,15);

%Threshold based on the maximization of the global cost efficiency
th=100;
[binary threshold globalcosteffmax costmax ef]=threshold_global_cost_efficiency(w,th);

%Threshold based on the shortest path lengths
%The input matrix must be a mapping from weight to distance. For 
%   instance, in a weighted correlation network, higher correlations are 
%   more naturally interpreted as shorter distances, and the input matrix 
%   should consequently be some inverse of the connectivity matrix.

dist=1./w;%inversing zeros on the main diagonal transformed into Inf
%Corrected the Infs on the main diagonal
for i=1:nodes
    dist(i,i)=0; 
end
[binary]=threshold_shortest_paths(dist,1);

%published in Dimitriadis et al. Tracking brain dynamics via time-dependent
%network analysis, Neuroscience Methods, 2010

%EXTRA FUNCTIONS
%Here we selected a k in order to detect the surviving nodes that are
%connected with at least k connections
%You can use binary matrix as extracted from each of the above techniques
k2=10;
[list_k_cores]=k_core_decomposition(binary,k2);

%The resulting minimally rewired networks lbmrn represented
% a lower bound for the wiring length of a connected network
% with the same total number of edges and identical node positions as
% in the original neural networks.
density=0.35;
%spatial refers to the spatial coordinated of the nodes e.g.Macaque, Cat,
%Brain cortical regions
lbmrn= mst_density(spatial,density);
