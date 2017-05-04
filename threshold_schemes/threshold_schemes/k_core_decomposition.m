function [list_k_cores]=k_core_decomposition(binary,k)

%[1]Alvarez-Hamelin (2006) Large scale networks fingerprinting and
%visualization using the k-core decomposition
%[2]Hagmann et al.,"Mapping the Structural Core of Human Cerebral Cortex",
%Plos Biology, 2008

%a technique that first introduced for the visualization of high
%dimensional graphs [1] but also for the identification of hub regions [2].

%Interpretation of k-core:
%k-core is the largest subgraph comprising nodes of degree at
%least k, and is derived by recursively peeling off nodes with
%degree lower than k until none remain.

%INPUTS:      binary = adjancency matrix (directed/undirected)
%                 k = degree (threshold)
%OUTPUT:list_k_cores=list of the k cores
%Finally, we keep the nodes that are connecting with each other with at least k vertices 

%needs degrees_und/degrees_dir from BCT 

%DIMITRIADIS STAVROS 1/2008 
%see http://users.auth.gr/~stdimitr/index.html

%initial degrees of each node


type=0;

% ensure binary is binary...
binary = double(binary~=0);

id = sum(binary,1);    % indegree = column sum of binary
od = sum(binary,2)';   % outdegree = column sum of binary

%CHECK FOR directed/undirected binary matrix
if(sum(id)==sum(od))
    type=1;
    [degree] = degrees_und(binary);
else
    type=2;
    [ind outd degree] = degrees_dir(binary);
end

 

%take the dimension of the matrix
[nodes nodes]=size(binary);


count=0;
%eliminate each time the node with degree less than the input variable
%k (threshold) and recalculate each time the new degree list

%in each iteration we eliminate the ones that exist in the ith column
%(corresponds to the node that we eliminate)

if type==1

for i=1:nodes
    if(degree(i)<k)
        for l=1:nodes %rows of the graph
             binary(i,l)=0;%delete the ones in ith column
        end

    end  

    %recalculate the list of the degrees
        [degree] = degrees_und(binary);     
        
end%end of for
 

else
    
    for i=1:nodes
    if(degree(i)<k)
        for l=1:nodes %rows of the binary
             binary(i,l)=0;%delete the ones in ith column
        end

    end  

    %recalculate the list of the degrees
     [ind outd degree] = degrees_dir(binary);     
        
end
    
end %end of if


list_k_cores(1:nodes)=0;

for i=1:nodes
    if (degree(i)>0)
        list_k_cores(i)=1;
    end
end
                





