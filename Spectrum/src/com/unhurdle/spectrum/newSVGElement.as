package com.unhurdle.spectrum
{
  COMPILE::JS
  public function newSVGElement(tag:String):HTMLElement{
    return document.createElementNS('http://www.w3.org/2000/svg', 'svg');
  }
}
