# Transcibes DNA sequence into RNA equivalent
#
# dna   A character string containing DNA sequence
#
# value A character string containing RNA sequence
#
transcribe <- function(dna) {
  
  gsub("T", "U",dna, fixed=TRUE)
  
}
# Translates RNA sequence into amino acid sequence
#
# rna   A character string containing RNA sequence
#
# value A character string containing amino sequence
#
translate <- function(rna) {
  #read translation table
  translationTable<- read.delim("translationTable.txt", stringsAsFactors=FALSE)
  #function provides codon values where n is the number of rna characters
  getCodon <- function(n) {substring (rna, first=(n*3)-2, last=n*3)}
  
  n <- 1:(nchar(rna)/3)
  #prints codons out to console
  Codons<-getCodon(n)
 
  
  translateCodon= function(codon){
    translationTable[codon,1]
    }
  
  sapply(Codons , FUN=translateCodon)
}

# Returns a data.frame describing the ORFs found in the given aminoacid sequence
#
# aminoacids  A character string containing aminoacid sequence
# cutoff      An integer giving the minimum aminoacid length of valid ORFs
#
# value       A data.frame, coordinates refer to amino acid position
#
findORF <- function(aminoacids, cutoff = 100) {
  
  
  matches <- gregexpr( pattern = "M(.*?)X", text = aminoacids )
  startPositions <- as.vector(matches[[1]])
  lengths <- attr(matches[[1]], "match.length")
  
  orfSequence <- substring( aminoacids,
                            first = startPositions,
                            last = startPositions + lengths -1)
 
  orfTable <- data.frame(
    startPosition = startPositions,
    length        = lengths,
    aminoacids    = orfSequence
    )
  
  #orfTableF<-orfTable[lengths>cutoff,]
  print(matches)  
  return(orfTable)

  }

# Parses a sequence file in FASTA format
#
# fastaFile   A string giving the name of a fasta file to parse
#
# value       A string containing the parsed sequence
#
loadFASTA <- function(fastaFile) {
  dnaLines <- readLines(fastaFile)
  dnaLines <- dnaLines[2:length(dnaLines)]
  dna <- paste(dnaLines, collapse="", sep="")
return(dna)
  
}

# Annotates the ORFs found in a given frame of a dnaString
#
# dnaStrand   A string containing DNA sequence
# offset      The frame offset (0, 1, or 2)
#
# value       A data.frame.  Coordinates are relative to dnaStrand.
#
annotateFrame <- function(dnaStrand, offset) {
  
  rnaStrand<-transcribe(substr(dnaStrand, offset+1:nchar(dnaStrand)))
  
  aminoAcid<-translate(rnaStrand)
  
  findORF(aminoAcid)
  
  
}


# Calculates the reverse complement of a dnaStrand
#
# dnaStrand   A string containing the forward DNA sequence
#
# value       A string containing the reverse complement to dnaStrand
#
reverseComplement <- function(dnaStrand) {
  
  gsub("A","T", dnaStrand)
  
  gsub("G","C", dnaStrand)

  gsub("T","A", dnaStrand)
 
  gsub("C","G", dnaStrand)
  
}

# Reverses the characters in a string
reverseString <- function(a) {
  paste(rev(substring(a,1:nchar(a),1:nchar(a))),collapse="")
}




