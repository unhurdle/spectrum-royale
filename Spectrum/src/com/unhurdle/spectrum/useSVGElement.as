package com.unhurdle.spectrum
{
  COMPILE::JS
  public function useSVGElement(tag:String):HTMLElement{
    return document.createElementNS('http://www.w3.org/2000/svg', 'use');
  }
}