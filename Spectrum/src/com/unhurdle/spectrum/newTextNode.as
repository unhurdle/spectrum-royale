package com.unhurdle.spectrum
{
  COMPILE::JS
  public function newTextNode(content:String):Text{
    return document.createTextNode(content) as Text;
  }

  COMPILE::SWF
  public function newTextNode(content:String):Object{
    return null;
  }

}