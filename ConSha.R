## Title: ConSha
## Version: 0.1-1
## Date: 2022-06-15
## Author: Ambrosio Torres
## Maintainer: Ambrosio Torres <atorresgalvis@gmail.com>
## Depends: R version (>= 3.6.3), geomorph, abind
## Description: obtain the CONsensus (average) SHApes of multiple specimens, for each species in a same tps (.tps) file.
## License: GPL (3)

ConSha <- function(x) {   ## x must be the name of the tps file
		library(geomorph)
		library(abind)
		data1 <- readland.tps(x, specID = "ID")
		NameList <- dimnames(data1)[[3]]							
		UniqueNames <- unique(gsub('[[:digit:]]+', '', NameList))
		UniqueNames <- unique(gsub('[[:space:]]', '', UniqueNames))
		UniqueNames <- unique(gsub('-', '', UniqueNames))
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
