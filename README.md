# Nuclei Orientation

## Requirements
### For BatchOrientationJ
Script assumes 3D image.

Need to install:
- OrientationJ as described here: https://bigwww.epfl.ch/demo/orientation/



### For BatchThreshAndFitEllipse
Script assumes 2 channel 3D image with nuclei in the first channel.

Need to install:
- 3D ImageJ Suite and dependencies as described here: https://mcib3d.frama.io/3d-suite-imagej/#installation
- CLIJ and CLIJ2 as described here: https://clij.github.io/clij2-docs/installationInFiji

## Method

Open script in Fiji and run. 

Three inputs are requested:

- Input folder - folder that contains the images
- Output folder - folder to save the results
- File suffix - file extension/image type, default is .oir

The method will be run for all images in the input folder.

## References

OrientationJ:

Reference on the method: Z. Püspöki, M. Storath, D. Sage, M. Unser, Transforms and Operators for Directional Bioimage Analysis: A Survey Advances in Anatomy, Embryology and Cell Biology, vol. 219, Focus on Bio-Image Informatics, Springer International Publishing, ch. 3, pp. 69-93, May 21, 2016.
Reference on the angular distribution: R. Rezakhaniha, A. Agianniotis, J.T.C. Schrauwen, A. Griffa, D. Sage, C.V.C. Bouten, F.N. van de Vosse, M. Unser, N. Stergiopulos, Experimental Investigation of Collagen Waviness and Orientation in the Arterial Adventitia Using Confocal Laser Scanning Microscopy Biomechanics and Modeling in Mechanobiology, vol. 11, no. 3-4, pp. 461-473, 2012.
Reference on the local measurements: E. Fonck, G.G. Feigl, J. Fasel, D. Sage, M. Unser, D.A. Rüfenacht, N. Stergiopulos, Effect of Aging on Elastin Functionality in Human Cerebral Arteries Stroke, vol. 40, no. 7, pp. 2552-2556, July 2009.

CLIJ:

Robert Haase, Loic Alain Royer, Peter Steinbach, Deborah Schmidt, Alexandr Dibrov, Uwe Schmidt, Martin Weigert, Nicola Maghelli, Pavel Tomancak, Florian Jug, Eugene W Myers. CLIJ: GPU-accelerated image processing for everyone. Nat Methods 17, 5-6 (2020) doi:10.1038/s41592-019-0650-1

Daniela Vorkel, Robert Haase. GPU-accelerating ImageJ Macro image processing workflows using CLIJ. arXiv preprint

Robert Haase, Akanksha Jain, Stéphane Rigaud, Daniela Vorkel, Pradeep Rajasekhar, Theresa Suckert, Talley J. Lambert, Juan Nunez-Iglesias, Daniel P. Poole, Pavel Tomancak, Eugene W. Myers. Interactive design of GPU-accelerated Image Data Flow Graphs and cross-platform deployment using multi-lingual code generation. bioRxiv preprint

3D ImageJ Suite:

J. Ollion, J. Cochennec, F. Loll, C. Escudé, T. Boudier. (2013) TANGO: A Generic Tool for High-throughput 3D Image Analysis for Studying Nuclear Organization. Bioinformatics 2013 Jul 15;29(14):1840-1. doi:10.1093/bioinformatics/btt276



