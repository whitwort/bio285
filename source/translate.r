
translate <- function(rna) {
  
  translationTable <- read.delim("source/translationTable.txt", stringsAsFactors = FALSE)
  
  #Takes a table where codons are row names and AA's are the 1st column
  #and returns an amino acid for the given codon
  translateCodon <- function(codon) {
    
    translationTable[codon,1]
    
  }
  
  #Takes an RNA sequence and returns the n'th codon
  getCodon <- function(n) {
    
    substr(rna, 
           start  = (n * 3) - 2, 
           stop   = n * 3
           )
    
  }
  
  #Create a series of codon numbers
  codonNumbers <- 1:(nchar(rna) / 3)
  
  #Translate each of the codons at positions given by codonNumbers
  aminoAcids <- sapply(codonNumbers, 
                       FUN = function(n) {
                         translateCodon( getCodon(n))
                        }
                       )
  
  return( paste(aminoAcids, sep = "") )
  
}


#Takes a DNA sequence and returns an RNA sequence
transcribe <- function(dna) {

  #Substitute U's for T's
  gsub( pattern     = "T",
        replacement = "U",
        x           = dna,
        fixed       = TRUE
        )
  
}