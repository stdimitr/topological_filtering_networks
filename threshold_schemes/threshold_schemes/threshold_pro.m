function [binary w] = threshold_pro(w, p)

%   proportional thresholding
%
%   This function "thresholds" the connectivity matrix by preserving a
%   proportion p (0<p<1) of the strongest weights. All other weights, and
%   all weights on the main diagonal (self-self connections) are set to 0.
%
%INPUTS: W = weighted or binary connectivity matrix
%        p = proportion of weights to preserve
%           range:  p=1 (all weights preserved) to p=0 (no weights removed)
%OUTPUS: binary = thresholded connectivity matrix
%         w_thr = keeps the weights that overcome the threshold 

%DIMITRIADIS STAVROS 15/1/2008

% Dr.Dimitriadis Stavros
% MARIE-CURIE COFUND EU-UK RESEARCH FELLOW
% CUBRIC NEUROIMAGING CENTER
% RESEARCHGATE: https://www.researchgate.net/profile/Stavros_Dimitriadis
% Email: stidimitriadis@gmail.com/ DimitriadisS@cardiff.ac.uk


n=size(w,1);                                %number of nodes
w(1:n+1:end)=0;                             %clear diagonal
[a b]=sort(nonzeros(w));                    %take all the values of the matrix 
                                            %and sort them

en=round(length(b)*p);

[d1 d2]=size(w);
w_thr(1:d1,1:d1)=0;

thr=a(en);                                %threshold
w(w>thr)=0 ;                        %apply threshold

binary(1:d1,1:d1)=0;
binary(w>thr)=1;   
