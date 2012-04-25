transcribe <- function(dnaFile, rnaFile) {
  
  #Read the file
  dna <- readLines(dnaFile)
  
  #Substitute U's for T's
  rna <- sub( pattern     = "T", 
              replacement = "U",
              x           = dna, 
              fixed       = TRUE
            )
  
  #Save the results
  write(rna, rnaFile)
  
}