package com.unhurdle.spectrum
{
  public function newSVGElement(type:String,className:String):SVGElement
  {
    var elem:SVGElement = document.createElementNS('http://www.w3.org/2000/svg', type) as SVGElement;
    if(className){
      elem.setAttribute("class",className);
    }
    return elem;
  }
}