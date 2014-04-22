translate <- function(rna) {
  
  translationTable <- read.delim( "data/codons"
                                , stringsAsFactors = FALSE
                                )
  
  translateCodon <- function(codon) {  
    translationTable[codon,]
  }
  
  getCodon <- function(n) {  
    substr( rna
          , start  = (n * 3) - 2
          , stop   =  n * 3
          )
  }
  
  codonNumbers <- 1:(nchar(rna) / 3)
  
  aminoAcids <- sapply( codonNumbers
                      , function(n) { 
                          translateCodon(getCodon(n)) 
                        }
                      )
  
  paste(aminoAcids, sep = "")
  
}