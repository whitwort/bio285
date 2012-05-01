# Transcibes DNA sequence into RNA equivalent
#
# dna A character string containing DNA sequence
#
# value A character string containing RNA sequence 
transcribe <- function(dna) { 
  rna <- gsub( pattern     = "T",
              replacement = "U",
              x           = dna,
              fixed       = TRUE)
  message(rna)
}
# Translates RNA sequence into amino acid sequence 
# 
# rna A character string containing RNA sequence 
# 
# value A character string containing amino sequence 
translate <- function(rna) {
  n<-nchar(rna)
  print(rna)
  codonNumbers<-1:(nchar(rna)/3)
  getCodon<-function(n){substr(rna, start=n*3-2, stop=n*3)}
  Codons<-sapply(X=codonNumbers, FUN=getCodon)
  aminoacids<-translateRNA(Codons)
  paste(aminoacids,collapse="")
  }

# Returns a data.frame describing the ORFs found in the given aminoacid sequence
# 
# aminoacids A character string containing aminoacid sequence 
#
# cutoff An integer giving the minimum aminoacid length of valid ORFs 
# 
# value A data.frame, coordinates refer to amino acid position 
findORF <- function(aminoacids, cutoff = 100) { 
  matches<-gregexpr(pattern="M(.*?)X", text=aminoacids)
  startPositions<-as.vector(matches[[1]])
  lengths<-attr(matches[[1]], "match.length")
  orfSequence<-substring(aminoacids, first=startPositions, last=startPositions+lengths-1)
  orfTable<-data.frame(startPosition=startPositions, length=lengths, aminoacids = orfSequence)
  orfTable<-orfTable[orfTable$length>cutoff,]
  return(orfTable)
}

# Parses a sequence file in FASTA format 
# 
# fastaFile A string giving the name of a fasta file to parse
# 
# value A string containing the parsed sequence 
# loadFASTA <- function(fastaFile) { #Insert your code here }
#
#
# Annotates the ORFs found in a given frame of a dnaString 
# 
# dnaStrand A string containing DNA sequence 
# offset The frame offset (0, 1, or 2)
# 
# value A data.frame. Coordinates are relative to dnaStrand. 
annotateFrame <- function(dnaStrand, offset) {
  dnaStrand<- substr(dnaStrand, offset + 1, nchar(dnaStrand))
  rna <- transcribe(dnaStrand)
  print(rna)
  aminoacids<-translate(rna)
  #orfTable<-findORF(aminoacids)
  #orfTable$length <- orfTable$length * 3
  #orfTable$startPosition<-orfTable$startPosition*3 + cutoff
  #return(orfTable)
} 
#
# Calculates the reverse complement of a dnaStrand 
# 
# dnaStrand A string containing the forward DNA sequence 
# 
# value A string containing the reverse complement to dnaStrand 
reverseComplement <- function(dnaStrand) { 
  dna<-dnaStrand
  dna<-gsub("A","t", dna)
  dna<-gsub("G","c", dna)
  dna<-gsub("C","G", dna)
  dna<-gsub("T","A", dna)
  dna <- toupper(dna)
}
# Reverses the characters in a string 
reverseString <- function(a) { paste(rev(substring(a,1:nchar(a),1:nchar(a))),collapse="") }