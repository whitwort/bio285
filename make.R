#Build our pages using courseR
make <- function() {
  
  #Load courseR
  source('~/courseR/courseR.R')
  
  #Build the site
  makeSite(html.template  = "templates/page.html",
           pages          = read.csv("source/pages.csv", stringsAsFactors = FALSE),
           page.css       = c("css/style.css", "css/page.css", "css/code.css"),
           page.js        = c("js/main.js", "js/plugins.js", "js/vendor/jquery-1.7.2.min.js"),
           index          = "templates/index.md",
           index.section  = "templates/index-section.md",
           index.entry    = "templates/index-entry.md",
           index.css      = c("css/style.css", "css/page.css"),
           index.js       = c("js/main.js", "js/plugins.js", "js/vendor/jquery-1.7.2.min.js")
  )
  
  #And we're done
  message("Done building site!  May the learning commence.")
  
}

make()

#browseURL()