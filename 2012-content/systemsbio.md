# What is Systems Biology?

### Exploring *systems-level* approaches in biomedical research

Welcome to Introduction to Systems Biology!  I try to answer the question "What is systems biology?" by beginning with a brief overview of this modern history of molecular biology.  This is because, although it is still hard to give a precise definition of what systems biology is as it currently means different things to different people, everyone seems to agree that it is a *new* way of thinking about molecular biology.  So now let's consider where molecular biology has come from, in order to better understand how "systems-level" approaches may be its future...


# The origins of Molecular Biology

## Biology enters the era of "*hard*" science

![Microscope](img/noun_project_648.svg)

Modern molecular biology can be thought of as being born at the time when biologists began to adopt the quantitative and experimental techniques of the other so called "hard" sciences.  From its [theological origins](http://en.wikipedia.org/wiki/Natural_philosophy) in antiquity, biology arrived in the modern era still a fundamentally *observational* science.  However, in the 19th century advances in physics, including optics, and in chemistry began to give biologists tools that we could use to move beyond, passive, macroscopic observation of the biological world.  The technologies developed in the 19th century gave way to the studies of physiology, and later cell biology, genetics ([Mendel](http://en.wikipedia.org/wiki/Gregor_Mendel)) and biochemistry.  From its roots, biological investigation in the modern era has been driven by technological development.


## Genetics

![Fruit fly](http://upload.wikimedia.org/wikipedia/commons/4/4c/Drosophila_melanogaster_-_side_%28aka%29.jpg)

[Genetics](http://en.wikipedia.org/wiki/Genetics) is the study of how genetic variations (natural or engineered) affect the phenotype of organisms.  In genetics, the phenotype is cornerstone of all inquiry.  The pursuit of genetics is to elucidate the rules by which genotype affects phenotype.


## Biochemistry

![Hemoglobin](http://upload.wikimedia.org/wikipedia/commons/thumb/3/3d/1GZX_Haemoglobin.png/600px-1GZX_Haemoglobin.png)

[Biochemistry](http://en.wikipedia.org/wiki/Biochemistry) (or Biological Chemistry) is the marriage of the mechanistic rigor brought by chemists to the understanding of reaction mechanics and the search for an understanding of biological systems.  While genetics can be thought of as a "top-down" approach to biological inquiry (phenotype -> genotype), biochemistry can be thought of as the "bottom-up" approach: fundamentally concerned first and foremost with the mechanics of proteins and other biological molecules.


## Cell Biology

![SEM pollen](http://upload.wikimedia.org/wikipedia/commons/thumb/a/a4/Misc_pollen.jpg/788px-Misc_pollen.jpg)

Cell biology can be thought as beginning in the era of the [microscope](http://en.wikipedia.org/wiki/Leeuwenhoek), when cells were first discovered because they were *seen* for the first time.  In many ways, cell biology grew out of the traditional fields of anatomy and physiology,  as these disciplines looked to microscopy to understand the structure and function of the body at greater and greater levels of detail.  In cell biology, the image -- and the structure/functions relationships inferred from it -- are primary.


## The power of complimentary approaches

>  Doing *biochemistry* can teach you nearly everything about practically nothing; but *genetics* can teach you almost nothing about practically everything.

> [Pascal Preker][]

Together, each of these three fundamentally complimentary approaches build the family of disciplines that comprise the molecular biomedical sciences today.  In addition to the three original pillars this large group includes neuroscience, developmental biology, biophysics, enzymology, pharmacology, molecular medicine, immunology, infectious disease, cancer biology, among many, many others.


# Big Tech, Big Biology

## New technologies usher in a new era...

(that [no one](http://www.nature.com/nbt/journal/v22/n4/pdf/nbt0404-473.pdf) really [understands](http://en.wikipedia.org/wiki/Systems_biology) [yet](http://blogs.nature.com/sevenstones/2007/07/what_is_systems_biology_3.html))

Over the last decade a host of innovations have dramatically changed the scale on which biologists can perform experiments and interrogate molecular processes.  These technologies have allowed us to move from single "component" or single "process" views of the cell to being able to ask questions of entire molecular systems.  These new technologies, and the shift in intellectual focus of biological inquiry they have catalyzed, will be the focus of this course.  We will review some of the new technologies which have been driving this change, delve into the primary literature to consider different types of data produced by large-scale studies, and explore some of the computational and statistical approaches that are being used to make sense of these large datasets.

## "Genomes to Life"

![Genomes to life](http://upload.wikimedia.org/wikipedia/commons/0/01/Genomics_GTL_Pictorial_Program.jpg)

## Genomes

Sequencing technology > Genome Era

![human genetics](img/noun_project_628.svg)

The first of the -omics eras was that of genomics.  This will be our focus for the first week of the course.  We'll consider the history of technological innovation that allowed us to first sequence microbial genomes, then the human genome, and recently many more large genomes in just the last few years.  You will also write software designed to help you explore and make sense of genomic DNA sequence.

## Comparative Genomics

More genomes = More context

![comparative genomics](http://www.ploscompbiol.org/article/fetchObject.action?uri=info%3Adoi%2F10.1371%2Fimage.pcbi.v01.i07.g001&representation=PNG_M)

Comparative genomics is the study of, well, the comparison of genomes!  Our ability to understand the structure of any given genome expands combinatorially with each new genome we sequence because we can study what has changed (diverged) and what has stayed the same (been conserved) over the course of evolutionary time between the two modern genomes and their common ancestor.  Not only has comparative genomics been incredibly powerful in helping us to better understand patterns of molecular evolution, but it has also been immensely important in helping us to annotate the structure of genomes.

## *Functional* genomics

The study of gene expression patterns

![microarray](http://valelab.ucsf.edu/images/res-rnatran/mechsec6sm.jpg)

Functional genomics is the study of gene expression dynamics in cells -- or the *function* of genomes.  The primary technologies are microarrays, and more recently, direct RNA sequencing.  In the second week of the class we will focus on functional genomics and you will write software to explore a full microarray data set containing 10's of thousands of gene expression observations.

## Proteomics

The old Central Dogma: 
gene -> protein

The **new** Central Dogma: 
modules -> cell

![protein network](http://www.plosbiology.org/article/fetchObject.action?uri=info%3Adoi%2F10.1371%2Fjournal.pbio.0020038.g001&representation=PNG_M)

Proteomics is the study of the functional dynamics between proteins, and more importantly protein complexes, in whole systems.  The fundamental technology that has made proteomics possible is mass spectroscopy ("mass spec") based peptide sequencing.  In the third week of the class we will focus on proteomics and you will write software to explore complex interaction patterns in a proteomics data set, constructing a network topology to explore its structure.

# Quantitative Biology

## Math + Biology = Power

![mathbio](http://www.ploscompbiol.org/article/fetchObject.action?uri=info%3Adoi%2F10.1371%2Fimage.pcbi.v07.i11.g001&representation=PNG_M)

Genomics, functional genomics, and proteomics will be the focus of this class.  The tools used by these disciplines are computation analysis (to handle the very large datasets) and classical statistics as well as machine learning approaches.  The "other" side of Systems Biology is mathematical biology and modeling.  We won't cover these topics in this course because they will be the focus of a new course taught next fall by Professor Toporikova.

## Modeling

![Bacterial cytoplasm](http://www.ploscompbiol.org/article/fetchObject.action?uri=info%3Adoi%2F10.1371%2Fimage.pcbi.v06.i03.g001&representation=PNG_M)

## QB3

<iframe src="http://www.qb3.org/" width="500" height="300">  
  <p>Your browser does not support iframes.</p>  
</iframe>

# How do we understand a system?

So what puts the "systems" in Systems Biology?  What does it mean to study biology at a systems level?  How have new technologies shifted the focus of traditional molecular biology (Genetics + Biochemistry + Cell Biology)?  Is this a revolution or an evolution in the study of biological systems?  This course should provide you with some perspective on these questions.

## A thought experiment...

![coffee maker](img/noun_project_1972.svg)

## How about this?

![silicon die](http://upload.wikimedia.org/wikipedia/commons/4/4e/Diopsis.jpg)

[Pascal Preker]: http://pure.au.dk/portal/en/persons/id(651f0536-3a87-493d-939f-a2a97573506c).html
