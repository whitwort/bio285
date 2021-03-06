# Lab:  Explorying Genomes

In lab today we are going to perform a *de novo* annotation of the entire yeast genome.  We'll be using R to find Open Reading Frames (ORFs) on yeast chromosomes, search for introns, and even annotate the locations of common transcription factor binding sites.  Because of the amazing power of R and modern computational hardware you'll be able to run your software to analyze the yeast genome in its entirety!

Here's an overview of each of the stages of today's lab:

* Step 1: refine `transcribe` and `translate`.  We'll start by refining your earlier versions of the `transribe` and `translate` functions.  We're going to use these to help us write an ORF finder.

* Step 2: write an `findORF` function.  Next, we'll write a function which takes a string of amino acids and returns all of the possible true ORFs in that string.  This function will accept a `cutoff` argument which filters out ORFs which are likely too small to be real.

* Step 3: write an `annotateChromosome` function which takes the name of a file containing genomic DNA sequence for a yeast chromosome and returns a `data.frame` where each row is a description of a different putative ORF on that chromosome.

* Step 4: glue everything together with an `annotateGenome` function that loads DNA sequence for each yeast chromosome and annotates it with `annotateChromosome`.


# Step 1: transcribe and translate

## Refine your transcribe function

In this lab we'll be using the two pieces of software you've already written this week.  Let's start off by creating a fresh script file.  Use "File" > "New" > "R Script" in the Rstudio menus to open a blank script file.  Save this file with the name `genomeAnnotation.r`.

Now copy and paste one of the `transcribe` functions you wrote earlier in the week.  We're going to update the function *interface* to better meet our needs today.  When we talk about a function's interface, we mean (a) what the function expects you to pass into it as arguments, and (b) what the result of the function is, or it's value.  Today we're going to practice the good habit of using comment lines to keep a clear record of the interface for each of our functions, so that we don't get confused.

Here's a template for today's version of your transcribe function should look like:


```r
# Transcibes DNA sequence into RNA equivalent
# 
# dna A character string containing DNA sequence
# 
# value A character string containing RNA sequence
transcribe <- function(dna) {
    
    # Insert your code here
    
}
```





See how we've used the comment lines to clearly describe:

* What our function does (fist line)
* What kinds of data we expect for the arguments (dna)
* What kinds of data the function produces (value)

We'll write descriptions like this for all of the functions we include in our `genomeAnnotation.r` script today.

How is the interface for this transcribe function different from the version you wrote earlier in the week?  Update the body of your function so that it conforms to this new interface.  

Once you're finished load your script into the interactive session (console) so that you can test it.  You can load or `source` your script easily in couple of ways:

* Click on the `source` button on the right hand side of the script editor window
* Hit `ctrl + shift + s`
* Check the "Source on save" check box and then save you changes to the script by click on the save button (disk icon) or hitting `ctrl + s`

Now let's test your transcribe function with some sample input:


```r
transcribe("ATGCTTATCTA")
```

```
## [1] "AUGCUUAUCUA"
```


If you got a different result, go back and try to fix your function.


## Refine your translate function

We're also going to make use of the `translate` function you wrote earlier in the week, but we'll need to update its interface a bit as well.

Add a `translate` function to `genomeAnnotation.r` that follows the following template:


```r
# Translates RNA sequence into amino acid sequence
# 
# rna A character string containing RNA sequence
# 
# value A character string containing amino sequence
translate <- function(rna) {
    
    # Insert your code here
    
}
```





There are two aspects to this new version of the `translate` function which are probably different than the version your wrote before.

First, as was the case with the `transcribe` function, we've written this function so it expects to recieve a string of RNA sequence, rather than the name of a file to load.

Second, we've explicitly stated that our function should return a **single** character string containing the amino acid sequence.  This is probably different than the value produced by your current version of `translate`.  Consider the difference between:


```r
# Here are two example character vectors

# A vector of many elements; each element is only one character
c("V", "R", "S", "P", "L")
```

```
## [1] "V" "R" "S" "P" "L"
```

```r

# A vector of one element; the element has many characters
"VRSPL"
```

```
## [1] "VRSPL"
```


What we want our translate function to produce is like the 2nd example, what it produces is like the first.  So how can you take a character vector of many elements and turn it into a single-element vector of many characters?

The answer is the `paste` function:


```r
# Some example uses of the paste function

paste(c("A", "B", "C", "D"), sep = "")
```

```
## [1] "A" "B" "C" "D"
```

```r

paste(c("A", "B", "C", "D"), sep = ", ")
```

```
## [1] "A" "B" "C" "D"
```


Refactor your earlier version of the `translate` function so that it conforms to the interface in the template above.

Now test your translate function with some different inputs:


```r
translate("AUG")
```

```
## [1] "M"
```

```r
translate("UUCUAAAUUAACAAAAUC")
```

```
## [1] "F" "X" "I" "N" "K" "I"
```

```r
translate("UUCUAAAUUAACAAAAU")
```

```
## [1] "F" "X" "I" "N" "K"
```

```r
translate("UUCUAAAUUAACAAAA")
```

```
## [1] "F" "X" "I" "N" "K"
```


Did those last two lines fail for your function or did it work?  If you got an error or an "NA" at the end of your result vector, let's make our `translate` function a little bit smarter, so we don't have to worry about it choking on input strings that aren't evenly divisible by 3.  The easiest thing to do is to just have it ignore incomplete final codons.  Use your knowledge of the `nchar` and `substr` functions along with the arithematic modulo operator `%%` to refine the `translate` function.

When your function is working on all of the inputs above, you're ready to move on to step 2!


# Step 2: Writing an ORF finder

## Function template 

We now have the tools in place that we'll need to write a function that finds ORFs.  This function will take a string containing a sequence of amino acids and find *all* of the possible ORFs in that string.  The logic of this function will be to identify stretches of aminoacids that start with a methionine ("M") and end with one of our stop codons ("X").  This function will also accept a 'cutoff' argument which will be used to filter ORFs that are too short to be believable.

Let's start off by adding a template for the `findORF` function to our `genomeAnnotation.r` script.


```r
# Returns a data.frame describing the ORFs found in the given aminoacid
# sequence
# 
# aminoacids A character string containing aminoacid sequence cutoff An
# integer giving the minimum aminoacid length of valid ORFs
# 
# value A data.frame, coordinates refer to amino acid position
findORF <- function(aminoacids, cutoff = 100) {
    
    # Insert your code here
    
}
```


In this function definition we've done something new:  provide a default value for one of our arguments.  The expression `cutoff = 100` sets 100 as the default value of the cutoff argument.  If the user of the function supplies a cutoff it will override the default; if they don't the default will be used.  It is a good "best-practice" to provide reasonable default values for optional arguments.  Optional arguments are usually arguments which tweak the behavior of the function in some way, but don't represent data that are fundamental to its operation.

So what's the first thing this function is going to need to do?  We want it to find stretches of amino acids that look like they correspond to real open reading frames.  What's the best way to look for small patterns in larger strings?  The answer is regular expressions.

## Regular expressions

Regular expressions are a powerful tool available in many programming languages which are designed to find patterns in text.  Regular expressions are a mini-programming language all of their own which allows us to describe many different types of complex patterns.

In this case the pattern we need to find is:

`M...X`

Where "M" is a methionine, "X" is one of our stop codons, and "..." represents a variable number of amino acids between M and X.  Furthermore, we want to find ALL of the non-overlapping instances of the "M...X" pattern in our input aminoacid sequence.

You can read about the full power of the [regular expression syntax](http://stat.ethz.ch/R-manual/R-devel/library/base/html/regex.html) in the R help, but for today I'll guide you through how to write them.

Our regular expression pattern is going to be the string:

`"M(.*?)X"`

Here's what's going on in the pattern:

* The "M" at the begining says 'look for patterns that start with M'
* The "X" at the end says '...and end with X'
* The "(...)" adds a subpattern that we'll search for between the M and X
* "." says 'find any character that isn't a space'
* The "*" says 'find between 0 and an infinite number of those non-space characters'
* The "?" says 'but make the stuff inside of the "(...)" as small as possible, while still conforming to my other rules'.  If we didn't add the "?" this pattern would match starting at the first M in our sequence -- then gobble up all other M's and X's -- until it hit the last X in the sequence.  Obviously, not what we want!

All of the functions listed on the help page for `?sub` can take regular expressions as their search patterns.  Today we'll use `gregexpr` (global regular expression) function.

When trying to learn how a new function works, it's often useful to make up some example data that will make it easy to discover what a function is doing.  Let's make a sample "amino acid" sequence that will be easy to keep track of.


```r
sampleAminoAcids <- "aaaaMbbbbXccccMddddXeeee"
```


See what I did there?  If everything is working correctly we should find "MbbbbX" and "MddddX" and nothing else.

Let's give `gregexpr` a whirl with our sample data and our regular expression:


```r
gregexpr(pattern = "M(.*?)X", text = sampleAminoAcids)
```

```
## [[1]]
## [1]  5 15
## attr(,"match.length")
## [1] 6 6
## attr(,"useBytes")
## [1] TRUE
```


There's a lot going with the output from this function -- we're starting to get a peak at some advanced R features.  But notice that line that has the vector `5, 15`?  That suspiciously similar to the positions of our "M"'s in the sample string.  See the line that has the vector `6, 6`?  Rather interesting, since both of our sample ORF sequences should be 6 amino acids long!  As a novice user, you should be thinking to yourself "I think this is going to work for us"!

The structure being returned by `gregexpr` is called a `list`.  It's kind of like a basket that can hold other smaller types of data, like vectors.  We're not going to get distracted with the details today; instead let's jump to how we can extract our ORF start poistions and lengths from this structure.

Try the following:


```r
matches <- gregexpr(pattern = "M(.*?)X", text = sampleAminoAcids)
startPositions <- as.vector(matches[[1]])
lengths <- attr(matches[[1]], "match.length")

# ORF match staring positions
startPositions
```

```
## [1]  5 15
```

```r

# ORF match lengths
lengths
```

```
## [1] 6 6
```


If you're interested in what the "[[1]]" is about:  had our text argument been a vector with more than one string matches would have had additional elements accisible with [[2]]...[[n]].  If this detail stresses you out; ignore it!

Let's also use our knowledge of `substring` to get the actual amino acid sequence:


```r
orfSequence <- substring(sampleAminoAcids, first = startPositions, last = startPositions + 
    lengths - 1)
```


What does orfSequence hold now?  Why do we need the "-1" in the last argument?  

So now we know how to write code that will match all of the possible ORFs in a sequence of amino acids!  Now let's think about how we want to collect our ORF information in a user friendly way.


## Creating a data.frame

We've used data.frame's before by loading tabular data in from files, but you can also create them *de novo* from with in an R session.  The syntax is:


```r
data.frame(variable1 = c(1, 2, 3, 4), variable2 = c("a", "b", "c", "d"))
```

```
##   variable1 variable2
## 1         1         a
## 2         2         b
## 3         3         c
## 4         4         d
```


See what happened there?  Each argument will become a column heading in your data.frame, and its value will become the data in that column.  You'll want to make sure your value vectors are all the same lengths or you'll get an error.

So how can we store our ORF information in a convenient tabular format?  With something like this:


```r
orfTable <- data.frame(startPosition = startPositions, length = lengths, aminoacids = orfSequence)
```


Take a look at the contents of orfTable.  We're nearly there!  It's time to take all of the parts we've just looked at and assemble them back into a whole.  

Return to the template for your `findOrf` function above and fill in the function body.  The thing we promised that this function would do that we haven't handled yet is filtering out ORFs that are below the size given by the `cutoff` argument.  Use your knowledge of selectors (`[]`) to filter the final version version of your orfTable based on the values in the `length` column.

Finally, we've promised that our function returns a data.frame.  Up to this point we haven't explicitly addressed how we tell R what to return as the value of our functions.  If we don't tell R what to do, it will just return the result of the last computation by default.  We can be explicit about what we want to return from our function using the `return` function, like: `return(orfTable)`


# Step 3:  Chromosome annotation

## Overview

Now we're ready to think about the structure of our function which will annotate all of the possible ORFs in the sequence for a chromosome.  Here's the template we'll use for our big annotation function:


```r
# Finds all open reading frames in the chromosome sequence in a FASTA file
# 
# fastaFile A string containing the name of a chromosome file in FASTA
# format
# 
# value A data.frame.  Coordinates are relative to DNA sequence in input.
annotateChromosome <- function(fastaFile) {
    
    # Insert your code here
    
}
```


We'll also write a few helper functions to keep annotateChromosome from becomming too bloated.

Here are the templates:


```r
# Parses a sequence file in FASTA format
# 
# fastaFile A string giving the name of a fasta file to parse
# 
# value A string containing the parsed sequence
loadFASTA <- function(fastaFile) {
    
    # Insert your code here
    
}

# Annotates the ORFs found in a given frame of a dnaString
# 
# dnaStrand A string containing DNA sequence offset The frame offset (0,
# 1, or 2)
# 
# value A data.frame.  Coordinates are relative to dnaStrand.
annotateFrame <- function(dnaStrand, offset) {
    
    # Insert your code here
    
}

# Calculates the reverse complement of a dnaStrand
# 
# dnaStrand A string containing the forward DNA sequence
# 
# value A string containing the reverse complement to dnaStrand
reverseComplement <- function(dnaStrand) {
    
    # Insert your code here
    
}

# Reverses the characters in a string
reverseString <- function(a) {
    paste(rev(substring(a, 1:nchar(a), 1:nchar(a))), collapse = "")
}
```


I snuck in a function implementation in the last section; this is a common idiom used in R to reverse the sequence of a string.  Hopefully you can prove to yourself that you understand why it works!

I'm not going to walk you through exactly how to write the body of each of these functions.  Instead, I'll give some pointers for each in the sections that follow.

## reverseComplement

To implement this function you'll probably want to use the `reverseString` utility function.  You'll hopefully also be thinking that you'll want to use `gsub` to switch A -> T, G -> C and visa versa.

However, consider the following:


```r
dna <- "ATGCATCG"
dna <- gsub("A", "T", dna)
dna
```

```
## [1] "TTGCTTCG"
```

```r
dna <- gsub("G", "C", dna)
dna
```

```
## [1] "TTCCTTCC"
```

```r
dna <- gsub("T", "A", dna)
dna
```

```
## [1] "AACCAACC"
```

```r
dna <- gsub("C", "G", dna)
dna
```

```
## [1] "AAGGAAGG"
```


What happened here?  To get around this problem you can use a little trick: switch the case of the substitution letter then use the `toupper` function to convert lower case letters back to upper case.  For example:


```r
dna <- "ATGCATCG"
dna <- gsub("A", "t", dna)
dna
```

```
## [1] "tTGCtTCG"
```

```r
dna <- toupper(dna)
dna
```

```
## [1] "TTGCTTCG"
```


## annotateFrame

This function is setup to accept a frame `offset` argument.  You'll call `annotateFrame` from annotate chromosome six times, once for each strand, and three times with offset = 0, offset = 1, and offset = 2.

If you call findORFs from annotateFrame remember that you'll want to convert lenths and startPositions from the amino acid coordinates to the correct DNA coordinates.  To update the data from a data.frame in place you can use the following syntax:


```r
orfTable$length <- orfTable$length * 2
```


## loadFASTA

You can download yeast genome sequence [here](http://downloads.yeastgenome.org/sequence/S288C_reference/chromosomes/fasta/).  Each of these files contains the DNA sequence for one of the yeast chromosomes.

Take a look at the format of FASTA files.  You'll want to omit the first line of this file because it doesn't contain sequence.  We can do that with selectors:


```r
dnaLines <- readLines("sample.fasta")
```

```
## Warning: cannot open file 'sample.fasta': No such file or directory
```

```
## Error: cannot open the connection
```

```r
dnaLines <- dnaLines[2:length(dnaLines)]
```

```
## Error: object 'dnaLines' not found
```


Also we'll want to collapse all of the strings in this vector into a single string.  We can use paste to do that:


```r
dna <- paste(dnaLines, collapse = "", sep = "")
```

```
## Error: object 'dnaLines' not found
```


## Combining data.frame objects

In several places you'll want to be able to combine `data.frame` tables, adding the rows of one table to another.  See the `merge` function of a convenient way to do this!

# Step 4: Annotate the whole genome!

Once you have your annotateChromosome function working (takes the name of a chromosome FASTA file and produces a data.frame with ORF information), we're ready to write our final annotateGenome function.  This function should run annotateChromosome on each of the yeast chromosome FASTA files (in your directory), and aggregate all of the results in to a big table!

You can save this final data.frame using the "write.table" function like:


```r
sampleTable = data.frame()
write.table(sampleTable, "myFile.txt", sep = "\t")
```


# Challenge #1:  Transcription factor binding site

The TATA-Binding Protein ([TBP](http://en.wikipedia.org/wiki/TATA-binding_protein)) is an important eukaryotic transcription factor.  It promotes transcription at many, but not all, eukaryotic genes.  It binds to the "TATA-box" sequence upstream of genes:

TATAAA

Modify your annotation script so that it produces a table listing TBP binding sites in the yeast genome.  Include a column that lists the likely ORF that is the target of TBP transcription target.  Remember that you'll have to keep track of both DNA strands.

What percentage of yeast genes are likely transcribed by TBP bound promoters?


# Challenge #2:  Handle introns

Yeast is a eukaryote, which means the protein coding sequences (ORFs) can be interupted by introns.  Introns are defined by 3 sequences: start sequence, end sequence and a special sequence in the middle of the intron called a branch point sequence.  Unlike the TATA-Box however, each of these sequences comes in several different flavors.  Specifically, the variants are:

Start sites: 
GUAUGU 
GUAAGU 
GUAUGC 
GUAUGA 
GUACGU 
GUCAGU 
GUUAAG 
GUAGUA 
GCAUGU 
GUUCGU 
GUGAGU 
GCAAGU

Branch points:
GACUAAC 
UACUAAC 
AACUAAC 
AAUUAAC 
CACUAAC 
UGCUAAC 
UAUUAAC 
AGUUAAC 
CGUUAAC 
UGUUAAC 
CAUUAAC

End sites:
CAG
AAG
UAG

We can use regular expressions to find patterns that have variable characters at different positions.  Consider the following example:


```r
grepl("bio285", "Hello bio285!")
```

```
## [1] TRUE
```

```r
grepl("bio285", "Hello bio385!")
```

```
## [1] FALSE
```

```r

# Match course number 285 or 385
grepl("bio[23]85", "Hello bio285!")
```

```
## [1] TRUE
```

```r
grepl("bio[23]85", "Hello bio285!")
```

```
## [1] TRUE
```


See what happened there?  The "[ ... ]" say 'match any of the letters or numbers listed inside these brackets at this position.  So to match all splice end sites we could use the regular expression:

`"[CAU]AG"`

Refactor your annotateChromosome function so that it first finds and then removes (hint: gsub) all of the likely introns from the chromosomal sequence before attempting to annotate the ORFs.

How did your ORF list change when you accounted for introns?
