%% Create a random network
% If you want to use this library we need to five it a N*N graph
% Watchout you will need to swap the gce calculation depending if 
% you are using a weighted or binary / directed or undirected graph
nodes=90;
graph=rand(nodes,nodes);

%% Threshold the graph using the 6 thresholding scheme

% 1) ABSOLUTE THRESHOLD
thr=0.5;
[~, weighted1]= threshold_abs(graph, thr);

% 2) PROPORTIONAL THRESHOLD
p=0.2; % keep the 20% of the strongest connections
[~, weighted2] = threshold_pro(graph, p);

% 3) MEAN DEGREE
meand=5;
[bin, thres, mdegree]=threslold_mean_degree(graph,meand);
weighted3=bin.*graph;

% 4) SHORTEST PATH LENGTHS
type=1; % directed
[~, weighted4]=threshold_shortest_paths(graph,type);

% 5) GCE
% MAXIMIZING GLOBAL EFFICIENCY - COST BY ITERATIVELY ABSOLUTE
% THRESHOLDING THE WEIGHTS IN THE RANGE OF [0,1] WITH A SMALL STEP
% e.g.0.01

th=100; % means 100 steps of size 1/100=0.01
[binary, ~, ~, ~, ~]=threshold_global_cost_efficiency_wd(graph,th);
weighted5=binary.*graph;

% Note: SIMILARLY FOR WEIGHTED UNDIRECTED AND BINARY UNDIRECTED/DIRECTED
% [binary threshold globalcosteffmax costmax ef]=threshold_global_cost_efficiency_wu(w,th);
% [binary threshold globalcosteffmax costmax ef]=threshold_global_cost_efficiency_bu(w,th);
% [binary threshold globalcosteffmax costmax ef]=threshold_global_cost_efficiency_bd(w,th);

% 6) GCE-OMST
%%%%%%% MAXIMIZING GLOBAL EFFICIENCY - COST BY ITERATIVELY SAMPLING
%%%%%%% WEIGHTED EDGES VIA ORTHOGONAL MINIMAL SPANNING TREES
flag=1;
[~, weighted6, ~, ~, ~, ~]=threshold_omst_gce_wd(graph,flag);

%% PLOT THE ORIGINAL AND THE SIX THRESHOLDED GRAPHS

figure;
subplot(3,3,2),imagesc(graph);colorbar ; title('Original Graph')
subplot(3,3,4),imagesc(weighted1);colorbar ; title('ABSOLUTE THRESHOLD')
subplot(3,3,5),imagesc(weighted2);colorbar ; title('PROPORTIONAL THRESHOLD')
subplot(3,3,6),imagesc(weighted3);colorbar ; title('MEAN DEGREE')

subplot(3,3,7),imagesc(weighted4);colorbar ; title('SHORTEST PATH LENGTHS')
subplot(3,3,8),imagesc(weighted5);colorbar ; title('GCE-ABS')
subplot(3,3,9),imagesc(weighted6);colorbar ; title('GCE-OMST')
