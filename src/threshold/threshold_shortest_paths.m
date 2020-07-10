function [binary weighted]=threshold_shortest_paths(w,type)


%transform a weighted (direct or undirected) network in binary via shortest path identification using
%Dijkstra's algorithm
%adopted from Dimitriadis et al. Tracking brain dynamics via time-dependent
%network analysis, Neuroscience Methods, 2010


%INPUT:         w = distance matrix
%            type = 1 (undirected)/ 2 (directed)
%OUTPUT:   binary = thresholded matrix

%The input matrix must be a mapping from weight to distance. For 
%   instance, in a weighted correlation network, higher correlations are 
%   more naturally interpreted as shorter distances, and the input matrix 
%   should consequently be some inverse of the connectivity matrix.


%DIMITRIADIS STAVROS 19/2/2010

% Dr.Dimitriadis Stavros
% MARIE-CURIE COFUND EU-UK RESEARCH FELLOW
% CUBRIC NEUROIMAGING CENTER
% RESEARCHGATE: https://www.researchgate.net/profile/Stavros_Dimitriadis
% Email: stidimitriadis@gmail.com/ DimitriadisS@cardiff.ac.uk

[d1 d2]=size(w);

%initialize a matrix
binary=zeros(d1,d1);
weighted=zeros(d1,d1);

if(type==1)%undirected
    for k=1:d1
        for l=(k+1):d1
            [r_cost, r_path, pred]=graphshortestpath(sparse(w),k,l,'Directed',false);
          
            ind1=0;
            ind2=0;
            for m=1:length(r_path)-1
                ind1=ind1+1;
                ind2=ind1+1;
                binary(r_path(ind1),r_path(ind2))=1;
                binary(r_path(ind2),r_path(ind1))=1;
            end
            
        end   
    end
    weighted=binary.*w;
    
elseif(type==2)%directed

    for k=1:d1
        for l=1:d1
            if(k~=l)
            [r_cost, r_path, pred]=graphshortestpath(sparse(w),k,l,'Directed',true);
            
            ind1=0;
            ind2=0;
            for m=1:length(r_path)-1
                ind1=ind1+1;
                ind2=ind1+1;
                binary(r_path(ind1),r_path(ind2))=1;
            end
            
            end
        end  
    end
    weighted=binary.*w;
end%end of if
