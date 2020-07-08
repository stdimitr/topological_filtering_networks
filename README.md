# Topological Filtering Networks

This is the codebase taken from the paper ["Topological Filtering of Dynamic Functional Brain Networks Unfolds Informative Chronnectomics: A Novel Data-Driven Thresholding Scheme Based on Orthogonal Minimal Spanning Trees (OMSTs)"](https://www.frontiersin.org/articles/10.3389/fninf.2017.00028/full), originally located [here](https://github.com/stdimitr/topological_filtering_networks)

The codebase was cleaned up and restructure by Yacine Mahdid.

If we use this codebase we need to credit the following paper:

**Dimitriadis, S. I., Salis, C., Tarnanas, I., and Linden, D. E. (2017). Topological filtering of dynamic functional brain networks unfolds informative chronnectomics: a novel data-driven thresholding scheme based on Orthogonal Minimal Spanning Trees (OMSTs). Front. Neuroinform. 11:28. doi: 10.3389/fninf.2017.00028**


## Table of Content
- [Abstract](#abstract)
- [Code Structure](#code-structure)
- [Pseudo Code](#pseudo-code)
- [References](#references)

## Abstract
The human brain is a large-scale system of functionally connected brain regions. This system can be modeled as a network, or graph, by dividing the brain into a set of regions, or “nodes,” and quantifying the strength of the connections between nodes, or “edges,” as the temporal correlation in their patterns of activity. Network analysis, a part of graph theory, provides a set of summary statistics that can be used to describe complex brain networks in a meaningful way. The large-scale organization of the brain has features of complex networks that can be quantified using network measures from graph theory. The adaptation of both bivariate (mutual information) and multivariate (Granger causality) connectivity estimators to quantify the synchronization between multichannel recordings yields a fully connected, weighted, (a)symmetric functional connectivity graph (FCG), representing the associations among all brain areas. The aforementioned procedure leads to an extremely dense network of tens up to a few hundreds of weights. Therefore, this FCG must be filtered out so that the “true” connectivity pattern can emerge. Here, we compared a large number of well-known topological thresholding techniques with the novel proposed data-driven scheme based on orthogonal minimal spanning trees (OMSTs). OMSTs filter brain connectivity networks based on the optimization between the global efficiency of the network and the cost preserving its wiring. We demonstrated the proposed method in a large EEG database (N = 101 subjects) with eyes-open (EO) and eyes-closed (EC) tasks by adopting a time-varying approach with the main goal to extract features that can totally distinguish each subject from the rest of the set. Additionally, the reliability of the proposed scheme was estimated in a second case study of fMRI resting-state activity with multiple scans. Our results demonstrated clearly that the proposed thresholding scheme outperformed a large list of thresholding schemes based on the recognition accuracy of each subject compared to the rest of the cohort (EEG). Additionally, the reliability of the network metrics based on the fMRI static networks was improved based on the proposed topological filtering scheme. Overall, the proposed algorithm could be used across neuroimaging and multimodal studies as a common computationally efficient standardized tool for a great number of neuroscientists and physicists working on numerous of projects.

## Code Structure

To learn how to use the algorithms the authors have created the following demo file `memo_run_threshold_schemes.m`.

The files contains MEX functions that are binding between C function created by [David Gleich](https://www.cs.purdue.edu/homes/dgleich/) in 2006. These functions are used to find the shortest path in a graph.


- lib: contains the MEX binding to C files





## Pseudo Code


## References:

1. Dimitriadis SI et al., 2017.Data-Driven Topological Filtering Based on Orthogonal Minimal Spanning Trees: Application to Multigroup Magnetoencephalography Resting-State Connectivity.
Brain Connect. 2017 Dec;7(10):661-670. doi: 10.1089/brain.2017.0512.


2. Dimitriadis, S. I., Salis, C., Tarnanas, I., and Linden, D. E. (2017). Topological filtering of dynamic functional brain networks unfolds informative chronnectomics: a novel data-driven thresholding scheme based on Orthogonal Minimal Spanning Trees (OMSTs). Front. Neuroinform. 11:28. doi: 10.3389/fninf.2017.00028