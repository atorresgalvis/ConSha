## Title: ConSha
## Version: 0.1-1
## Date: 2018-03-28
## Author: Ambrosio Torres
## Maintainer: Ambrosio Torres <atorresgalvis@gmail.com>
## Depends: R version (>= 3.4.1), geomorph, abind
## Description: obtain the CONsensus (average) SHApes of multiple specimens, for each species in a same tps (.tps) file.
## License: GPL (3)

ConSha <- function(x) {   ## x must be the name of the tps file without the ".tps"
		library(geomorph)
		library(abind)
		tpsfile_name <- paste(x, ".tps", sep="")
		data1 <- readland.tps(tpsfile_name, specID = "ID")
		NameList <- dimnames(data1)[[3]]							
		UniqueNames <- unique(gsub('[[:digit:]]+', '', NameList))
		UniqueNames <- unique(gsub('[[:space:]]', '', UniqueNames))
		finalData <- NULL											
		for(i in 1:length(UniqueNames)) {							
				name <- UniqueNames[i]
				NewData <- NULL											
				for (j in 1:length(NameList)) {							
						NameToProve <- NameList[j]						
						Y_N <- grepl(name, NameToProve)					
						if (Y_N == TRUE) {								
								toNewData <- data1[,, j]				
								NewData <- abind(NewData, toNewData, along=3)	
						}
				}
				Y.gpa <- gpagen(NewData)								
				averageShape <- mshape(Y.gpa$coords)					
				finalData <- abind(finalData, averageShape, along=3)	
		}
		dimnames(finalData)[[3]] <- UniqueNames						
		gpaFinalData <- gpagen(finalData)							
		nombre  <-paste(x, "_AlgnBySpecies.tps", sep="")
		writeland.tps(gpaFinalData$coords, file= nombre)
}
