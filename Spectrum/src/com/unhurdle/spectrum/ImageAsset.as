package com.unhurdle.spectrum
{
  public class ImageAsset extends Asset
  {
    public function ImageAsset()
    {
      super();
    }

    COMPILE::JS
    private var imageElement:HTMLImageElement;
    private var _src:String;
    public function get src():String
    {
    	return _src;
    }

    public function set src(value:String):void
    {
      COMPILE::JS
      {
        if(value != _src){
          if(!imageElement){
            imageElement = newElement("img",appendSelector("-image")) as HTMLImageElement;
            element.appendChild(imageElement);
          }
          imageElement.src = value;
          _src = value;
        }
      }
    }
  }
}