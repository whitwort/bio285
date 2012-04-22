#bio285

Herein lie the source files for the [Introduction to Systems Biology](http://rna.wlu.edu/courses/bio285) ([Bio 285](http://catalog.wlu.edu/content.php?catoid=7&navoid=428)) course website.

## Project credits

A tiny bit of novel code here goes a long way because:

* [courseR](https://github.com/whitwort/courseR) is the backend R script that builds the html pages from markdown source (see `/source`).  It uses [knitr](https://github.com/yihui/knitr)(GPL) to handle [literate programming](http://en.wikipedia.org/wiki/Literate_programming), [highlight](http://cran.r-project.org/web/packages/highlight/index.html)([GPL2](http://www.gnu.org/licenses/gpl.html)) to handle html class annotation on R code fragments, and [markdown](http://cran.r-project.org/web/packages/markdown/)([GPL3](http://cran.r-project.org/web/licenses/GPL-3)) to compile the rest of the document.
* [reveal.js](https://github.com/hakimel/reveal.js) is used as the html slide show engine ([MIT](http://www.opensource.org/licenses/MIT))
* [HTML5BoilerPlate](http://html5boilerplate.com/) is used as the starting point for our html and css ([Unlicense](https://github.com/h5bp/html5-boilerplate)).
* [jQuery](http://jquery.com/) is used extensively for DOM hacking awesomeness ([MIT/GPL](http://jquery.org/license/)). 

## License

Original work copyright © 2012 [Gregg Whitworth](http://www.wlu.edu/x23921.xml?InsertFile=x55999) and licensed under [CC BY-SA 3.0](http://creativecommons.org/licenses/by-sa/3.0/).  See project credits above for additional license information.
