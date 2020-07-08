function [deg] = degrees_und(CIJ)

% input:  
%         CIJ  = connection/adjacency matrix
% output: 
%         deg  = degree for all vertices
%
% Computes the degree for a nondirected binary matrix.  Weights are
% discarded.
%
% Olaf Sporns, Indiana University, 2002/2006/2008
% =========================================================================

% ensure CIJ is binary...
CIJ = double(CIJ~=0);

deg = sum(CIJ);

