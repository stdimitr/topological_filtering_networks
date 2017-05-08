function [nCIJtree CIJtree mdeg  globalcosteffmax costmax E]=threshold_omst_gce_wu(CIJ,flag)

% threshold_omst_gce_w    Optimizing the formula GE-C via orthogonal MSTs.
% 
%   [nCIJtree CIJtree mdeg degree vector cost ]=threshold_omst_gce_wu(CIJ)
%
%   This function thresholds the connectivity matrix by absolute weight
%   magnitude. All weights below the given threshold, and all weights
%   on the main diagonal (self-self connections) are set to 0.
%   This function attemtps to detect the optimal communication within a
%   given network by maximizing the formula (global efficiency - cost)by
%   searching within a given range of degree and by selecting connections
%   through orthogonal MSTs.
%   The objective formula max(global efficiency - cost)derived from the article:
% Bassett & Bullmore Cognitive fitness of COST EFFICIENCT BRAIN
% FUNCTIONAL NETWORKS PNAS, 2009
% 
%
%   Inputs: graph     : weighted or binary connectivity matrix
%           flag      : 1 for ploting the functiona GE-COST vs COST   
%
%   Output: nCIJtree  : is a 3D matrix where the 1st dimension refers to
%   the orthogonal MSTs and the rest to the aggregated MSTs till the
%   selection of all the edges
%           CIJtree   :  thresholded connectivity matrix based on orthogonal MSTs
%           mdeg      : is the mean degree of the thresholded graph 
%globalcosteffmax     : is the formula of GE-Cost at each iteration of the algorithm which means at each OMST
%         costmax     : is the ratio of the sum of the weights of the selection edges divided by the total sum 
%                       of the weights of the original full-weighted graph
%              E      : the global efficiency of the thresholed graph
%   DIMITRIADIS STAVROS 16/7/2013

% Dr.Dimitriadis Stavros
% MARIE-CURIE COFUND EU-UK RESEARCH FELLOW
% CUBRIC NEUROIMAGING CENTER
% RESEARCHGATE: https://www.researchgate.net/profile/Stavros_Dimitriadis
% Email: stidimitriadis@gmail.com/ DimitriadisS@cardiff.ac.uk

[nodes nodes]=size(CIJ);

for k=1:nodes
    for l=(k+1):nodes
        CIJ(l,k)=0;
    end
end

% find the number of orthogonal msts according to the desired mean degree

no_edges=length(find(CIJ > 0));
no_msts=round(no_edges/(nodes-1))+1;

pos_no_msts=round(length(find(CIJ > 0))/(nodes-1));

if no_msts > pos_no_msts
    no_msts = pos_no_msts;
end

CIJnotintree=CIJ;

%% keep the N-1 connections of the no_msts MSTs
mst_con=zeros(no_msts*(nodes-1),2);
no_msts=15;

% repeat N-2 times
count=0;
CIJtree = zeros(nodes);
for no=1:no_msts
    
    %[links,weights]=minimal_spanning_tree(1./CIJnotintree);
    %%%%%%% Using kruskal m-file for directed graphs
    adj=zeros(nodes);
    adj(CIJnotintree > 0 )=1;
    
   [w_st, links, X_st]= kruskal(adj,sparse(1./CIJnotintree));
    
   for kk=1:length(links)
       links(kk,:)=sortrows(links(kk,:));
   end
   
    mst=zeros(nodes,nodes);
    for k=1:size(links,1)
        count=count+1;
        CIJtree(links(k,1),links(k,2))=CIJ(links(k,1),links(k,2));
        CIJtree(links(k,2),links(k,1))=CIJ(links(k,1),links(k,2));

        mst_con(count,1)=links(k,1);
        mst_con(count,2)=links(k,2);
        mst(links(k,1),links(k,2))=CIJ(links(k,1),links(k,2));
       mst(links(k,2),links(k,1))=CIJ(links(k,1),links(k,2));
    end
    
    % now add connections back, with the total number of added connections 
% determined by the desired 'avgdeg'
CIJnotintree = CIJnotintree.*~CIJtree;
   
nCIJtree(no,:,:)=CIJtree;
omst(no,:,:)=mst;
end;

[gl_node E_ini]=global_efficiency_wu(1./CIJ);
cost_ini=sum(CIJ(:));

%%%%%%%% insert the 1st MST
graph=zeros(nodes,nodes);
globalcosteff=zeros(1,no_msts);
degree=zeros(1,no_msts);
cost=zeros(1,no_msts);

for  k=1:no_msts
   
   graph=squeeze(nCIJtree(k,:,:));
   [deg] = degrees_und(graph);
   degree(k)=mean(deg);
     
    cost(k)=sum(graph(:))/cost_ini;
    [gl_node E ]=global_efficiency_wu(1./graph);
    globalcosteff(k)=E/E_ini-(cost(k));
end

%%%%%%%% GET THE OMST WHERE THE FORMULE GE-C IS MAXIMIZED
[val ind]=max(globalcosteff);

%%%%% FINAL OUTPUT
mdeg=degree(ind);
CIJTree=zeros(nodes,nodes);

CIJtree=squeeze(nCIJtree(ind,:,:));


costmax=cost(ind);
[gl_node E ]=global_efficiency_wu(1./CIJtree);

globalcosteffmax=globalcosteff(ind);

if flag==1
    
figure(1),plot(cost,globalcosteff),hold on, plot(costmax,globalcosteffmax,'r*')

xlabel('Cost')
ylabel('Global Cost Efficiency')
title('Economical small-world network at max Global Cost Efficiency')
text(costmax,globalcosteffmax,'\leftarrow max Global Cost Efficiency',...
     'HorizontalAlignment','left')
  
end