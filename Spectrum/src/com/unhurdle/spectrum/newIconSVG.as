package com.unhurdle.spectrum
{
  public function newIconSVG(className:String):SVGElement
  {
    var elem:SVGElement = newSVGElement("svg",className);
    elem.setAttribute("focusable", false);
    elem.setAttribute("aria-hidden",true);
    return elem;
  }
}