#Little gadget that generates a single html page showing example markup using 
#all of the local knitr package themes

themePath <- "~/R/library/knitr/themes/"
cssFiles <- list.files(themePath, ".css")

content = ""
style   = ""

for (cssFile in cssFiles) {
  
  name <- strsplit(cssFile, ".", fixed=TRUE)[[1]][1]
  
  #collect style content, appending name of css file as a class
  css <- paste(readLines(paste(themePath, cssFile, sep = "/")), collapse="\n", sep="")
  style <- paste(style, gsub(pattern = ".", replacement = paste(".", name," .", sep=""), x = css, fixed = TRUE), sep="", collapse="")
  
  #Convert ".name .background { color: ... }" entries into .name { background: ...}"
  style <- sub(
    pattern     = paste(".", name, " .background{\n  color", sep=""), 
    replacement = paste(".", name, "{\n  background", sep=""), 
    x           = style,
    fixed       = TRUE)
  
  #render html content
  html <- renderTemplate(
    template  = readLines("templates/gallery-inner.html"),
    name      = name
    )
  
  content <- paste(content, html, collapse="", sep="")
  
}

galleryHTML <- renderTemplate(
  template  = readLines("templates/gallery.html"),
  content   = content,
  style     = style
  )

write(x = galleryHTML, file = "gallery.html")
