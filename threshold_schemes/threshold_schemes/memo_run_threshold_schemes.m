

%%%% create a random network

nodes=90;

graph=rand(nodes,nodes);

%%%%%%% ABSOLUTE THRESHOLD
thr=0.5;
[binary weighted1]= threshold_abs(graph, thr);

%%%%%%% PROPORTIONAL THRESHOLD
p=0.2; % keep the 20% of the strongest connections
[binary weighted2] = threshold_pro(graph, p);

%%%%%%%% MEAN DEGREE
meand=5;
[bin thres mdegree]=threslold_mean_degree(graph,meand);
weighted3=bin.*graph;

%%%%%%%% SHORTEST PATH LENGTHS
type=1; % directed
[binary weighted4]=threshold_shortest_paths(graph,type);

%%%%%%% MAXIMIZING GLOBAL EFFICIENCY - COST BY ITERATIVELY ABSOLUTE
%%%%%%% THRESHOLDING THE WEIGHTS IN THE RANGE OF [0,1] WITH A SMALL STEP
%%%%%%% e.g.0.01
th=100; % means 100 steps of size 1/100=0.01
[binary threshold globalcosteffmax costmax ef]=threshold_global_cost_efficiency_wd(graph,th);
weighted5=binary.*graph;

%%%% SIMILARLY FOR WEIGHTED UNDIRECTED AND BINARY UNDIRECTED/DIRECTED
%[binary threshold globalcosteffmax costmax ef]=threshold_global_cost_efficiency_wu(w,th);
%[binary threshold globalcosteffmax costmax ef]=threshold_global_cost_efficiency_bu(w,th);
%[binary threshold globalcosteffmax costmax ef]=threshold_global_cost_efficiency_bd(w,th);

%%%%%%%%%%%%%
%%%%%%% MAXIMIZING GLOBAL EFFICIENCY - COST BY ITERATIVELY SAMPLING
%%%%%%% WEIGHTED EDGES VIA ORTHOGONAL MINIMAL SPANNING TREES
flag=1;
[nCIJtree weighted6 mdeg globalcosteffmax costmax E ]=threshold_omst_gce_wd(graph,flag);

%%%%%%%%%%%%%5 PLOT THE ORIGINAL AND THE SIX THRESHOLDED GRAPHS

figure;
subplot(3,3,2),imagesc(graph);colorbar ; title('Original Graph')
subplot(3,3,4),imagesc(weighted1);colorbar ; title('ABSOLUTE THRESHOLD')
subplot(3,3,5),imagesc(weighted2);colorbar ; title('PROPORTIONAL THRESHOLD')
subplot(3,3,6),imagesc(weighted3);colorbar ; title('MEAN DEGREE')

subplot(3,3,7),imagesc(weighted4);colorbar ; title('SHORTEST PATH LENGTHS')
subplot(3,3,8),imagesc(weighted5);colorbar ; title('GCE-ABS')
subplot(3,3,9),imagesc(weighted6);colorbar ; title('GCE-OMST')



%%% IF YOU USE THIS TOOLBOX IN ANY BIOLOGICAL NETWORK ANALYSIS PLEASE CITE
%%% THE FOLLOWING PAPER
%Dimitriadis et al., 2017,Topological Filtering of Dynamic Functional Brain Networks Unfolds Informative Chronnectomics: 
%A Novel Data-Driven Thresholding Scheme Based on Orthogonal Minimal
%Spanning Trees (OMSTs).Front. Neuroinform., 26 April 2017 | https://doi.org/10.3389/fninf.2017.00028




