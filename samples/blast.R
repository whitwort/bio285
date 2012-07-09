# Adapted from blast.pdb in package 'bio3d' by Barry Grant:
#   Grant, B.J. et al. (2006) Bioinformatics 22, 2695–2696.
#   
# License GPLv2
#
# Usage Example:
# 
# resultTable <- blast("ATGTCTGAAGCTCAAGAAACTCACGTAGAGCAACTACCAGAATCTGTTGTCGAT")

blast <- function(seq, 
                  program   = "blastn",
                  database  = "nr",
                  wordsize  = "7",
                  hitlist   = "20000",
                  taxid     = "7029"
                  ) {

  ## Run NCBI blastp on a given 'seq' sequence against a given 'database'
  if(!is.vector(seq)) {
    stop("Input 'seq' should be a single sequence as a single or multi element character vector")
  }
  seq <- paste(seq, collapse="")

  ##- Submit
  rootURL <- "http://www.ncbi.nlm.nih.gov/BLAST/Blast.cgi?CMD=Put"
  urlput <- paste(rootURL, 
                  "&DATABASE=", database,
                  "&HITLIST_SIZE=", hitlist,
                  "&PROGRAM=", program,
                  "&WORD_SIZE=", wordsize,
                  "&CLIENT=web",
                  "&ENTREZ_QUERY=txid", taxid, "+%5BORGN%5D",
                  "&QUERY=", paste(seq,collapse=""),
                  sep="")


  txt <- scan(urlput, what="raw", sep="\n", quiet=TRUE)
  rid <- sub("^.*RID = " ,"",txt[ grep("RID =",txt) ])

  cat(paste(" Searching ... please wait (updates every 5 seconds) RID =",rid,"\n "))

  
  ##- Retrive results via RID code (note 'Sys.sleep()')
  urlget <- paste("http://blast.ncbi.nlm.nih.gov/Blast.cgi?CMD=Get",
                  "&FORMAT_OBJECT=Alignment",
                  "&ALIGNMENT_VIEW=Tabular",
                  "&RESULTS_FILE=on",
                  "&FORMAT_TYPE=CSV",
                  "&ALIGNMENTS=20000",
                  "&RID=",rid, sep="")

  raw  <- read.csv(urlget,
                   header = FALSE, sep = ",", quote="\"", dec=".",
                   fill = TRUE, comment.char="")

  
  ## Check for job completion (retrive html or cvs?)
  html <- 1
  while(length(html) == 1) {
    cat("."); Sys.sleep(5)
    
    raw  <- try(read.csv(urlget,
                     header = FALSE, sep = ",", quote="\"", dec=".",
                     fill = TRUE, comment.char=""), silent=TRUE)
    if(class(raw)=="try-error") { stop("No hits found: thus no output generated") }
    html <- grep("DOCTYPE", raw[1,])
  }
  
  colnames(raw) <- c("subjectids", "identity", "positives",
                     "alignmentlength", "mismatches", "gapopens",
                     "q.start", "q.end", "s.start", "s.end",
                     "evalue", "bitscore")
  
  return(raw)
  
}

