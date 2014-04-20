#bio285

Herein lie the source files for the [Introduction to Systems Biology](http://rna.wlu.edu/courses/bio285) ([Bio 285](http://catalog.wlu.edu/content.php?catoid=7&navoid=428)) course website.

## Project Credits

#### Software

The [tiny bit](https://github.com/whitwort/bio285/blob/master/make.R) of code used to build this site goes a long way because:

* [courseR](https://github.com/whitwort/courseR) is the backend R script that builds the html pages from markdown source (see `/source`).  It uses [knitr](https://github.com/yihui/knitr) ([GPL][]) to handle [literate programming](http://en.wikipedia.org/wiki/Literate_programming), [highlight](http://cran.r-project.org/web/packages/highlight/index.html) ([GPL][]) to handle html class annotation on R code fragments, and [markdown](http://cran.r-project.org/web/packages/markdown/) ([GPL3](http://cran.r-project.org/web/licenses/GPL-3)) to compile the rest of the document.
* [reveal.js](https://github.com/hakimel/reveal.js) is used as the html slide show engine ([MIT](http://www.opensource.org/licenses/MIT))
* [HTML5BoilerPlate](http://html5boilerplate.com/) is used as the starting point for our html and css ([Unlicense](https://github.com/h5bp/html5-boilerplate)).
* [jQuery](http://jquery.com/) is used extensively for DOM hacking. ([MIT/GPL](http://jquery.org/license/)).

#### Images

All images used in the project are links to a hosted file or their original source.  Credits for the sources of redistributed images:

* Pizza icon (noun_project_1158.svg) from [The Noun Project][] ([CC BY-SA 3.0][])
* Idea icon (noun_project_762.svg) from [The Noun Project][] ([CC BY-SA 3.0][])

## License

Original work copyright © 2014 [Gregg Whitworth](http://www.wlu.edu/x23921.xml?InsertFile=x55999) and licensed under [CC BY-SA 3.0][].  See project credits above for additional license information.

[CC BY-SA 3.0]: http://creativecommons.org/licenses/by-sa/3.0/
[The Noun Project]: http://www.thenounproject.com
[GPL]: http://www.gnu.org/licenses/gpl.html
