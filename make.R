#Build our pages using courseR
make <- function() {
  
  #Load courseR
  source('~/courseR/courseR.R')

  #Build the site
  makeSite(html.template  = "templates/page.html",
           pages          = read.csv("source/pages.csv", stringsAsFactors = FALSE),
           css            = c("css/style.css", 
                              "css/page.css",
                              "css/code.css", 
                              "css/print.css"),
           js             = c("js/vendor/jquery-1.7.2.min.js",
                              "js/plugins.js", 
                              "js/main.js",
                              "js/vendor/reveal.js"),
           index          = "templates/index.md",
           index.section  = "templates/index-section.md",
           index.entry    = "templates/index-entry.md"
  )
  
  #And we're done
  message("Done building site!  May the learning commence.")
  
}

make()

#browseURL()