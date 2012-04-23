// Here be the core client side code!

// Our document.ready function
$(function() {

  console.log("The script finished loading.  Who knew?")

  function loadStuff(url) {
      console.log('load stuff fired')

      // RE to strip script tags from content
      var rscript = /<script\b[^<]*(?:(?!<\/script>)<[^<]*)*<\/script>/gi

      // load the new content asynchronously
      $.get(url, function(data) {
  
        // With heavy inspiration (copying) fron jQuery.load(), we'll make a new
        // div, load the recieved html into it, removing script tags, 
        var newPage = jQuery("<div>").append(data.replace(rscript, ""))
          
        //TODO we could add pretty animations here...
        $('#courser-stuff').replaceWith(newPage.find('#courser-stuff'))
        $('title').replaceWith(newPage.find('title'))

        // push new state to the browser address bar/history record
        history.pushState(null, '', url)

        // wrap all non-linky images with links to the image file
        $('img')
          .filter(function() { return !$(this).parent().attr('href') })
          .wrap(function() { return '<a href="' + $(this).attr('src') + '"></a>' } )

        // Add a timer that will fadeout our fadeyThings
        window.setTimeout(function() {
            $('.fadeyThing').addClass('fadeOut')
          }, 3 * 1000)

        // if this isn't the index page, set it up to with nav buttons
        $('#nav-buttons').remove()
        if ($('#index').length == 0) {

          //Add nav-buttons div
          $('#courser-stuff').prepend("<div id = 'nav-buttons'></div>")

          // Add a button to load back to the index
          $('#nav-buttons').append("<button id = 'index-button' class = 'pageButton'>index</button>")
          $('#index-button').click(function() {
            loadStuff('index.html')
          })
      
          // Add a button to load the slide view
          $('#nav-buttons').append("<button id = 'slide-button' class = 'pageButton'>presentation</button>")
          $('#slide-button').click(function() {
            launchPresentation()
          })

        }

      });
  }


  function launchPresentation() {

    // Unbind out popstate watcher
    $(window).unbind('popstate')

    // Get the current content from #courser-stuff
    var pageContent = $('#courser-stuff').remove()

    // Per reveal.js API add a #reveal div
    $('body').append("<div id = 'reveal'></div>")
    
    // Per reveal.js API add a .slides div
    $('#reveal').append("<div class = 'slides'></div>")

    // To this second div, add all top-level sections from our pageContent
    $('.slides').append(pageContent.find('> section'))

    // Hide long paragraphs (>140 chars; too big to tweet = too big for a slide)
    $('p').filter(function() {return $(this).text().length > 140}).addClass('slideHide')

    // A little hakery to make .svg images look better
    $('img').filter(function() {return $(this).attr('src').search(".svg")>0}).addClass('icon')

    // Append the navigation control elements to #reveal
    $('#reveal').append('<aside class="controls">              \
				                    <a class="left" href="#"><</a>     \
  			                    <a class="up" href="#">^</a>       \
				                    <a class="down" href="#">v</a>     \
				                    <a class="right" href="#">></a>    \
			                   </aside>')

    //Add nav-buttons div
    $('#reveal').append("<aside id = 'nav-buttons'></aside>")
    $('#nav-buttons').append('<button class="slideButton" onclick="parent.location=' + "'index.html'" + '">index</button>')
    $('#nav-buttons').append('<button class="slideButton" onclick="parent.location=' + "'" + $(location).attr('href') + "'" + '">page</button>')

    // Append a div to hold the progress bar to #reveal
    $('#reveal').append("<div class='progress'><span></span></div>")
    
    // Apply the reveal.css and slide.css style sheets
    $('head').append("<link rel='stylesheet' href='css/reveal.css'>")
    $('head').append("<link rel='stylesheet' href='css/slide.css'>")

    // Finally, call Reveal.initialize from reveal.js (code from reveal.js demo)
    Reveal.initialize({
        // Display controls in the bottom right corner
        controls: true,
    
        // Display a presentation progress bar
        progress: true,
    
        // If true; each slide will be pushed to the browser history
        history: true,
    
        // Flags if mouse wheel navigation should be enabled
        mouseWheel: true,
    
        // Apply a 3D roll to links on hover
        rollingLinks: false,
    
        // UI style
        theme: 'default', // default/neon
    
        // Transition style
        transition: 'default' // default/cube/page/concave/linear(2d)
    });

  }

  // if the browser supports history.push state, load other pages ajaxy
  if (history.pushState) {

      // Replace link clicks with sexy ajaxy content loads
      $('.courserLink').live('click', function() {

          // load and inject content asyncrhonously
          loadStuff(this.href)

          // return false to prevent the link from being followed
          return false

      })


    // Handle the back button
    $(window).bind('popstate', function() {
      // TODO: handle leaving presentation mode.

      loadStuff(location.pathname)
    })

    // The bind above fires on page load in chrome but not firefox, so we'll call again
    loadStuff(location.pathname)

  }

});