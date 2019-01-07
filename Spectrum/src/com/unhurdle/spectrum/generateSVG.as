package com.unhurdle.spectrum
{
  COMPILE::JS
  public function generateSVG(markup:String):SVGElement{
    var parser:DOMParser = new DOMParser();
    try {
      var doc:Document = parser.parseFromString(markup, 'image/svg+xml');
      var svg:SVGElement = doc.firstChild as SVGElement;
    }
    catch (err) {
      throw new Error('Error parsing SVG: ' + err);
    }
    return svg;    
  }
}