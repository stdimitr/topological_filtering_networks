function [binary w]= threshold_abs(w, thr)

%   Absolute thresholding
%
%   This function thresholds the connectivity matrix by absolute weight
%   magnitude. All weights below the given threshold, and all weights
%   on the main diagonal (self-self connections) are set to 0.
%
%INPUTS:      W = weighted (directed or undirected) connectivity matrix
%           thr = weight treshold
%OUTPUS: binary = thresholded connectivity matrix
%         w_thr = keeps the weights that overcome the threshold   
%
%   STAVROS DIMITRIADIS 5/11/2007

% Dr.Dimitriadis Stavros
% MARIE-CURIE COFUND EU-UK RESEARCH FELLOW
% CUBRIC NEUROIMAGING CENTER
% RESEARCHGATE: https://www.researchgate.net/profile/Stavros_Dimitriadis
% Email: stidimitriadis@gmail.com/ DimitriadisS@cardiff.ac.uk

w(1:size(w,1)+1:end)=0;                 %clear diagonal
w(w<thr)=0 ;                            %apply threshold

[d1 d2]=size(w);
binary(1:d1,1:d1)=0;

binary(w>thr)=1;   

