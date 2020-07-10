# Topological Filtering Networks

This is the codebase taken from the paper ["Topological Filtering of Dynamic Functional Brain Networks Unfolds Informative Chronnectomics: A Novel Data-Driven Thresholding Scheme Based on Orthogonal Minimal Spanning Trees (OMSTs)"](https://www.frontiersin.org/articles/10.3389/fninf.2017.00028/full), originally located [here](https://github.com/stdimitr/topological_filtering_networks)

The codebase was cleaned up and restructure by Yacine Mahdid.

If you want to use this codebase for the OMST you need to credit the following paper:

**Dimitriadis, S. I., Salis, C., Tarnanas, I., and Linden, D. E. (2017). Topological filtering of dynamic functional brain networks unfolds informative chronnectomics: a novel data-driven thresholding scheme based on Orthogonal Minimal Spanning Trees (OMSTs). Front. Neuroinform. 11:28. doi: 10.3389/fninf.2017.00028**

But if we use the component of the codebase you need to credit the right researchers depending on the code used:

**Please cited this Toolbox as: Dimitriadis SI, Laskaris NA, Tsirka V, Vourkas V, Micheloyannis S, Fotopoulos S. Tracking brain dynamics via time-dependent network analysis. Journal of Neuroscience Methods Volume 193, Issue 1, 30 October 2010,Pages 145-155**

or the Brain Connectivity Toolbox for everything inside the folder `/lib/brain_connectivity_toolbox/` :

**Complex network measures of brain connectivity: Uses and interpretations.Rubinov M, Sporns O (2010) NeuroImage 52:1059-69.**

or [Dr. David Gleich](https://github.com/dgleich/matlab-bgl) for his work on MATLAB-BGL see the toolbox for more information

## Table of Content
- [Requirements](#requirements)
- [Abstract](#abstract)
- [Code Structure](#code-structure)
- [References](#references)
- [Troubleshooting](#troubleshooting)


## Requirements
- [Bioinformatics Toolbox](https://www.mathworks.com/products/bioinfo.html?s_tid=AO_PR_info) 

## Abstract
The human brain is a large-scale system of functionally connected brain regions. This system can be modeled as a network, or graph, by dividing the brain into a set of regions, or “nodes,” and quantifying the strength of the connections between nodes, or “edges,” as the temporal correlation in their patterns of activity. Network analysis, a part of graph theory, provides a set of summary statistics that can be used to describe complex brain networks in a meaningful way. The large-scale organization of the brain has features of complex networks that can be quantified using network measures from graph theory. The adaptation of both bivariate (mutual information) and multivariate (Granger causality) connectivity estimators to quantify the synchronization between multichannel recordings yields a fully connected, weighted, (a)symmetric functional connectivity graph (FCG), representing the associations among all brain areas. The aforementioned procedure leads to an extremely dense network of tens up to a few hundreds of weights. Therefore, this FCG must be filtered out so that the “true” connectivity pattern can emerge. Here, we compared a large number of well-known topological thresholding techniques with the novel proposed data-driven scheme based on orthogonal minimal spanning trees (OMSTs). OMSTs filter brain connectivity networks based on the optimization between the global efficiency of the network and the cost preserving its wiring. We demonstrated the proposed method in a large EEG database (N = 101 subjects) with eyes-open (EO) and eyes-closed (EC) tasks by adopting a time-varying approach with the main goal to extract features that can totally distinguish each subject from the rest of the set. Additionally, the reliability of the proposed scheme was estimated in a second case study of fMRI resting-state activity with multiple scans. Our results demonstrated clearly that the proposed thresholding scheme outperformed a large list of thresholding schemes based on the recognition accuracy of each subject compared to the rest of the cohort (EEG). Additionally, the reliability of the network metrics based on the fMRI static networks was improved based on the proposed topological filtering scheme. Overall, the proposed algorithm could be used across neuroimaging and multimodal studies as a common computationally efficient standardized tool for a great number of neuroscientists and physicists working on numerous of projects.

## Code Structure

To learn how to use the algorithms the authors have created the following demo file `memo_run_threshold_schemes.m`.

The files contains MEX functions that are binding between C function created by [David Gleich](https://www.cs.purdue.edu/homes/dgleich/) in 2006. These functions are used to find the shortest path in a graph.

- example: folder containing the examples file, the one that is important is the `memo_run_threshold_schemes.m`
- lib: contains external library used
    - david_gleich: contains the MEX functions to calculate shortest path
    - brain_connectivity_toolbox: contains function from [bct](https://sites.google.com/site/bctnet/)
- src: this contain the actual codebase that is used for the OMST thresholding comparison.
    - threshold: collection of thresholding methods that can be used within this codebase. There are weighted-directed (wd), weighted-undirected (wu), binary-directed (bd) and binary-undirected (bu) for global_cost_efficiency available.

### Notes:
The `memo.m` is missing the `spatial` variable in order to be useable.

If you want to use this library we need to give it a N*N graph.
Watchout you will need to swap the gce calculation depending if 
you are using a weighted or binary / directed or undirected graph. Looking at `memo_run_threshold_schemes.m` is super useful.

## References:

1. Dimitriadis SI et al., 2017.Data-Driven Topological Filtering Based on Orthogonal Minimal Spanning Trees: Application to Multigroup Magnetoencephalography Resting-State Connectivity.
Brain Connect. 2017 Dec;7(10):661-670. doi: 10.1089/brain.2017.0512.


2. Dimitriadis, S. I., Salis, C., Tarnanas, I., and Linden, D. E. (2017). Topological filtering of dynamic functional brain networks unfolds informative chronnectomics: a novel data-driven thresholding scheme based on Orthogonal Minimal Spanning Trees (OMSTs). Front. Neuroinform. 11:28. doi: 10.3389/fninf.2017.00028

## Troubleshooting
- [Can't install a toolbox on Linux](https://www.mathworks.com/matlabcentral/answers/334889-can-t-install-any-toolboxes-because-can-t-write-to-usr-local-matlab-r2017)