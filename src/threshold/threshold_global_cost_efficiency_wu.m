function [binary threshold globalcosteffmax costmax ef]=threshold_global_cost_efficiency_wu(w,th)


%define the threshold in a a network as the max value of global cost efficiency versus cost
%adopted from Bassett & Bullmore Cognitive fitness of COST EFFICIENCT BRAIN
%FUNCTIONAL NETWORKS PNAS, 2009
%needs efficiency and degrees_und from BCT 
%https://sites.google.com/a/brain-connectivity-toolbox.net/bct/Home

%INPUT:         w = weighted  undirected 
%              th = no of steps as a resolution for searching of optimum
%              treshold from 0 to 1 e.g.100
%OUTPUTS:   binary = thresholded matrix
%       threshold = threshold [0 1] that maximize the global cost efficiency 
%globalcosteffmax = value of global cost efficiency   
%         costmax = cost of the network at the maximum global cost efficiency 
 
%DIMITRIADIS STAVROS 14/5/2009 

% Dr.Dimitriadis Stavros
% MARIE-CURIE COFUND EU-UK RESEARCH FELLOW
% CUBRIC NEUROIMAGING CENTER
% RESEARCHGATE: https://www.researchgate.net/profile/Stavros_Dimitriadis
% Email: stidimitriadis@gmail.com/ DimitriadisS@cardiff.ac.uk

tic

thres(1:th)=0;
step=1/th;
thres=(0:step:1);
[d1 d2]=size(w);


no=(d1*(d1-1))/2; %total no of connections

binary(1:d1,1:d1)=0;

globalcosteff(1:th)=0;
E1=0;
cost(1:th)=0;
total=0;

for i=1:th
    binary(1:d1,1:d1)=0;
    for k=1:d1
        for l=(k+1):d1
            if(w(k,l) > thres(i))
                binary(k,l)=1;
                binary(l,k)=1;
            end
        end
    end
   
    
    %calculate global efficiency
    E=efficiency(binary);
    E1=sum(sum(triu(E)));
    E1=E1/no;
    [deg] = degrees_und(binary);
    total=sum(deg);
    cost(i)=(0.5*total)/no;
    globalcosteff(i)=E1-cost(i);
end % end of for

%get the adjacency matrix for the maximum global cost efficiency

[a b]=max(globalcosteff);

threshold=thres(b);

    for k=1:d1
        for l=(k+1):d1
            if(w(k,l) > thres(b))
                binary(k,l)=1;
                binary(l,k)=1;
            end
        end
    end

costmax=0;
costmax=cost(b);
globalcosteffmax=globalcosteff(b);

E=efficiency(binary);
E1=sum(sum(triu(E)));
ef=E1/no;

figure(1),plot(cost,globalcosteff),hold on, plot(costmax,globalcosteffmax,'r*')

xlabel('Cost')
ylabel('Global Cost Efficiency')
title('Economical small-world network at max Global Cost Efficiency')
text(costmax,globalcosteffmax,'\leftarrow max Global Cost Efficiency',...
     'HorizontalAlignment','left')
 
 
toc