/*!
 * jQuery Magnify Plugin v1.5.1 by Tom Doan (http://thdoan.github.io/magnify/)
 * Based on http://thecodeplayer.com/walkthrough/magnifying-glass-for-images-using-jquery-and-css3
 *
 * jQuery Magnify by Tom Doan is licensed under the MIT License.
 * Read a copy of the license in the LICENSE file or at
 * http://choosealicense.com/licenses/mit
 */

(function($) {
  $.fn.magnify = function(oOptions) {

    var oSettings = $.extend({
        /* Default options */
        debug: false,
        speed: 100,
        timeout: -1,
        onload: function(){}
      }, oOptions),
      $anchor,
      $container,
      $image,
      $lens,
      nMagnifiedWidth = 0,
      nMagnifiedHeight = 0,
      init = function(el) {
        // Initiate
        $image = $(el);
        $anchor = $image.parents('a');
        // Activate magnification!
        // Try to get zoom image dimensions
        // Proceed only if able to get zoom image dimensions OK
        zoom($image.attr('data-magnify-src') || oSettings.src || $anchor.attr('href') || '');
      },
      zoom = function(sImgSrc, bAnchor) {
        // Disable zooming if no valid zoom image source
        if (!sImgSrc) return;
        // Calculate the native (magnified) image dimensions. The zoomed version
        // is only shown after the native dimensions are available. To get the
        // actual dimensions we have to create this image object.
        var elImage = new Image();
        $(elImage).on({
          load: function() {
            // Got image dimensions OK

            // Fix overlap bug at the edges during magnification
            $image.css('display', 'block');

            // Create container div if necessary
            if (!$image.parent('.magnify').length) {
              $image.wrap('<div class="magnify"></div>');
            }
            $container = $image.parent('.magnify');
            // Create the magnifying lens div if necessary
            if ($image.prev('.magnify-lens').length) {
              $container.children('.magnify-lens').css('background-image', 'url(\'' + sImgSrc + '\')');
            } else {
              $image.before('<div class="magnify-lens loading" style="background:url(\'' + sImgSrc + '\') no-repeat 0 0"></div>');
            }
            $lens = $container.children('.magnify-lens');

            // Remove the "Loading..." text
            $lens.removeClass('loading');
            // This code is inside the .load() function, which is important.
            // The width and height of the object would return 0 if accessed
            // before the image is fully loaded.
            nMagnifiedWidth = elImage.width;
            nMagnifiedHeight = elImage.height;
            if (oSettings.debug) console.log('[MAGNIFY] Got zoom image dimensions OK (width x height): ' + nMagnifiedWidth + ' x ' + nMagnifiedHeight);
            // Clean up
            elImage = null;
            // Callback
            oSettings.onload();
            // Handle mouse movements
            $container.on('mousemove touchmove', function(e) {
              e.preventDefault();
              // x/y coordinates of the mouse pointer or touch point
              // This is the position of .magnify relative to the document.
              var oMagnifyOffset = $container.offset(),
                /* We deduct the positions of .magnify from the mouse or touch
                   positions relative to the document to get the mouse or touch
                   positions relative to the container (.magnify). */
                nX = (e.pageX || e.originalEvent.touches[0].pageX) - oMagnifyOffset.left,
                nY = (e.pageY || e.originalEvent.touches[0].pageY) - oMagnifyOffset.top;
              // Toggle magnifying lens
              if (!$lens.is(':animated')) {
                if (nX<$container.width() && nY<$container.height() && nX>0 && nY>0) {
                  if ($lens.is(':hidden')) $lens.fadeIn(oSettings.speed);
                } else {
                  if ($lens.is(':visible')) $lens.fadeOut(oSettings.speed);
                }
              }
              if ($lens.is(':visible')) {
                // Move the magnifying lens with the mouse
                var nPosX = nX - $lens.width()/2,
                  nPosY = nY - $lens.height()/2;
                if (nMagnifiedWidth && nMagnifiedHeight) {
                  // Change the background position of .magnify-lens according
                  // to the position of the mouse over the .magnify-image image.
                  // This allows us to get the ratio of the pixel under the
                  // mouse pointer with respect to the image and use that to
                  // position the large image inside the magnifying lens.
                  var nRatioX = Math.round(nX/$image.width()*nMagnifiedWidth - $lens.width()/2)*-1,
                    nRatioY = Math.round(nY/$image.height()*nMagnifiedHeight - $lens.height()/2)*-1,
                    sBgPos = nRatioX + 'px ' + nRatioY + 'px';
                }
                // Now the lens moves with the mouse. The logic is to deduct
                // half of the lens's width and height from the mouse
                // coordinates to place it with its center at the mouse
                // coordinates. If you hover on the image now, you should see
                // the magnifying lens in action.
                $lens.css({
                  top: Math.round(nPosY) + 'px',
                  left: Math.round(nPosX) + 'px',
                  backgroundPosition: sBgPos || ''
                });
              }
            });
            // Prevent magnifying lens from getting "stuck"
            $container.mouseleave(function() {
              if ($lens.is(':visible')) $lens.fadeOut(oSettings.speed);
            });
            if (oSettings.timeout>=0) {
              $container.on('touchend', function() {
                setTimeout(function() {
                  if ($lens.is(':visible')) $lens.fadeOut(oSettings.speed);
                }, oSettings.timeout);
              });
            }
            // Ensure lens is closed when tapping outside of it
            $('body').not($container).on('touchstart', function() {
              if ($lens.is(':visible')) $lens.fadeOut(oSettings.speed);
            });

            if ($anchor.length) {
              // Make parent anchor inline-block to have correct dimensions
              $anchor.css('display', 'inline-block');
              // Disable parent anchor if it's sourcing the large image
              if (bAnchor || ($anchor.attr('href') && !($image.attr('data-magnify-src') || oSettings.src))) {
                $anchor.click(function(e) {
                  e.preventDefault();
                });
              }
            }

          },
          error: function() {
            // Clean up
            elImage = null;
            if (bAnchor) {
              if (oSettings.debug) console.log('[MAGNIFY] Parent anchor zoom source is invalid also. Disabling zoom...');
            } else {
              if (oSettings.debug) console.log('[MAGNIFY] Invalid data-magnify-src. Looking in parent anchor instead -> ' + $anchor.attr('href'));
              zoom($anchor.attr('href'), true);
            }
          }
        });

        elImage.src = sImgSrc;
      };

    return this.each(function() {
      // Initiate magnification powers
      init(this);
    });

  };
}(jQuery));
/*!
 * Mobile plugin for jQuery Magnify (http://thdoan.github.io/magnify/)
 *
 * jQuery Magnify by Tom Doan is licensed under the MIT License.
 * Read a copy of the license in the LICENSE file or at
 * http://choosealicense.com/licenses/mit
 */

(function($) {
  // Ensure this is loaded after jquery.magnify.js
  if (!$.fn.magnify) return;
  // Add required CSS
  $('<style>' +
    '.lens-mobile {' +
      'position:fixed;' +
      'top:0;' +
      'left:0;' +
      'width:100%;' +
      'height:100%;' +
      'background:#ccc;' +
      'display:none;' +
      'overflow:scroll;' +
      '-webkit-overflow-scrolling:touch;' +
    '}' +
    '.magnify-mobile>.close {' +
      'position:fixed;' +
      'top:10px;' +
      'right:10px;' +
      'width:32px;' +
      'height:32px;' +
      'background:#333;' +
      'border-radius:16px;' +
      'color:#fff;' +
      'display:inline-block;' +
      'font:normal bold 20px sans-serif;' +
      'line-height:32px;' +
      'opacity:0.8;' +
      'text-align:center;' +
    '}' +
    '@media only screen and (min-device-width:320px) and (max-device-width:773px) {' +
      '/* Assume QHD (1440 x 2560) is highest mobile resolution */' +
      '.lens-mobile { display:block; }' +
    '}' +
    '</style>').appendTo('head');
  // Ensure .magnify is rendered
  $(window).load(function() {
    $('body').append('<div class="magnify-mobile"><div class="lens-mobile loading"></div></div>');
    var $lensMobile = $('.lens-mobile');
    // Only enable mobile zoom on smartphones
    if ($lensMobile.is(':visible') && !!('ontouchstart' in window || (window.DocumentTouch && document instanceof DocumentTouch) || navigator.msMaxTouchPoints)) {
      var $magnify = $('.magnify'),
        $magnifyMobile = $('.magnify-mobile'),
        $magnifyImage = $magnify.children('img'),
        /* NOTE: In iOS background is url(...), not url("...") */
        sZoomImage = $('.magnify-lens').css('background-image').replace(/url\(["']?|["']?\)/g, ''),
        nImageWidth = $magnifyImage.width(),
        nImageHeight = $magnifyImage.height(),
        nZoomWidth,
        nZoomHeight,
        nScrollOffsetX,
        nScrollOffsetY;
      // Disable desktop magnifying lens
      $magnify.off();
      // Initiate mobile zoom
      // NOTE: Fixed elements inside a scrolling div have issues in iOS, so we
      // need to insert the close icon at the same level as the lens
      $magnifyMobile.hide().append('<i class="close">&times;</i>');
      $lensMobile.append('<img src="' + sZoomImage + '" alt="">');
      // Hook up event handlers
      $lensMobile.children('img').load(function() {
        nZoomWidth = this.width;
        nZoomHeight = this.height;
      });
      $magnifyMobile.children('.close').on('touchstart', function() {
        $magnifyMobile.toggle();
      });
      $magnifyImage.on({
        touchend: function() {
          // Only execute on tap
          if ($(this).data('drag')) return;
          $magnifyMobile.toggle();
          // Zoom into touch point
          $lensMobile.scrollLeft(nScrollOffsetX);
          $lensMobile.scrollTop(nScrollOffsetY);
        },
        touchmove: function() {
          // Set drag state
          $(this).data('drag', true);
        },
        touchstart: function(e) {
          // Determine zoom position
          var nX = e.originalEvent.touches[0].pageX - $magnifyImage.offset().left,
            nXPct = nX / nImageWidth,
            nY = e.originalEvent.touches[0].pageY - $magnifyImage.offset().top,
            nYPct = nY / nImageHeight;
          nScrollOffsetX = (nZoomWidth*nXPct)-(window.innerWidth/2);
          nScrollOffsetY = (nZoomHeight*nYPct)-(window.innerHeight/2);
          // Reset drag state
          $(this).data('drag', false);
        }
      });
    }
  });
}(jQuery));
