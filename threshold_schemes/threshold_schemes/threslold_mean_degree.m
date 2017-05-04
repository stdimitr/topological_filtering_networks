function [bin thres mdegree]=threslold_mean_degree(graph,kk)

% THRESHOLD_MEAN_DEGREE    Mean Degree thresholding
% 
%   [bin threshold degree]=threslold_mean_degree(graph,kk)
%
%   This function thresholds the connectivity matrix by absolute weight
%   magnitude. All weights below the given threshold, and all weights
%   on the main diagonal (self-self connections) are set to 0.
%
%   Inputs: graph     :     weighted or binary connectivity matrix
%           kk        :       mean degree
%
%   Output: bin       : adjacency matrix - thresholded connectivity matrix
%           thres     : threshold that gives mean degree kk
%          mdegree    : mean degree of the binary matrix - it is the actual
%          mdegree which maybe has a small difference compared to the kk
%          input. This happens because, we search for a threshold such as
%          to get mean degree equals to kk AND NOT finding the kk nearest
%          neighbors of each node !!
%
%   DIMITRIADIS STAVROS 15/5/2008

% Dr.Dimitriadis Stavros
% MARIE-CURIE COFUND EU-UK RESEARCH FELLOW
% CUBRIC NEUROIMAGING CENTER
% RESEARCHGATE: https://www.researchgate.net/profile/Stavros_Dimitriadis
% Email: stidimitriadis@gmail.com/ DimitriadisS@cardiff.ac.uk

%binarize a graph using mean degree

iter=100;
[d1 d2]=size(graph);
step=1/iter;
thres=0;
bin(1:d1,1:d2)=0;

thresdeg=zeros(iter,2);

for i=1:iter
    thres=thres+step;
    bin(1:d1,1:d2)=0;
    for k=1:d1
        for l=(k+1):d2
            if(graph(k,l)>thres)
                bin(k,l)=1;
                bin(l,k)=1;
            end
        end
    end
    [deg] = degrees_und(bin);

    thresdeg(i,1)=mean(deg);
    thresdeg(i,2)=thres;

end

%find the nearest mean degree to kk
dif=zeros(1,iter);

for i=1:iter
    dif(i)=abs(thresdeg(i,1) - kk);
end

%find the mean degree with the min difference from kk
[a r]=min(dif);

%find the threhold corresponds to the mean degree
mdegree=0;
mdegree=thresdeg(r,1);

thres=thresdeg(r,2);

    for k=1:d1
        for l=(k+1):d2
            if(graph(k,l) > thres)
                bin(k,l)=1;
                bin(l,k)=1;
            end
        end
    end




