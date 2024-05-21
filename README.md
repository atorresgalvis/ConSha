# ConSha
The function calculates the Consensus Shapes of different species from a same .tps file.

In the case that we have one (1) file with landmark data (.tps) of multiple specimens to each of multiple species (e.g. 100 specimens of specia A, 30 specimens of specie B, 47 specimens of specie C, etc.). The information could be unordered. Then, ConSha takes the configurations of the 100 specimens of specie A and calculates the consensus shape of specie A, subsequently, takes the configurations of the 30 specimens of specie B and calculates the consensus shape of specie B, etc. We obtain an output file (.tps) with the consensus shapes for each specie (A,B,C...).

## ConSha usage
Fist of all, we must install "abind" and "geomorph" packages:
**__install.packages("geomorph"); install.packages("abind")__**

We load the ConSha function:
**__source("ConSha.R")__**

And finally we run ConSha function:
**__ConSha("dataset.tps")__**

Obtaining the file __dataset_AlgnBySpecies.tps__ that contains the consensus shapes of the species.

###Note1:
we tested the function with a file that contains 571 specimens belonging to 18 species and the run takes 0.81 secs. to obatin the consensus shapes.

###Note2:
it is needed to be very careful with the assigned names to the specimens, being sure that the name of the species are the same in all their specimens. (E.g. Two specimens named as "Genus_Specie" y "genus_speCie" will be recognized as two different species).

## Citation
Torres, A. (2024). ConSha: R function to perform multiple Consensus Shapes. Zenodo. https://doi.org/10.5281/zenodo.11226178

