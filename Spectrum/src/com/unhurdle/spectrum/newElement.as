package com.unhurdle.spectrum
{
  COMPILE::JS
  public function newElement(tag:String,className:String = null):HTMLElement{
    var element:HTMLElement = document.createElement(tag) as HTMLElement;
    if(className){
      element.className = className;
    }
    return element;
  }
}