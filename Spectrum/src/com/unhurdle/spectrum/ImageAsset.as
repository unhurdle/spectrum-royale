package com.unhurdle.spectrum
{
  public class ImageAsset extends Asset
  {
    public function ImageAsset()
    {
      super();
    }

    private var imageElement:HTMLImageElement;
    private var _src:String;
    public function get src():String
    {
    	return _src;
    }

    public function set src(value:String):void
    {
      if(value != _src){
        if(!imageElement){
          createImageElement();
        }
        imageElement.src = value;
        _src = value;
      }
    }
    private function createImageElement():void{
      imageElement = newElement("img",appendSelector("-image")) as HTMLImageElement;
      (element as HTMLElement).appendChild(imageElement);

    }

    public function get imageStyle():CSSStyleDeclaration
    {
      if(!imageElement){
        createImageElement();
      }
    	return imageElement.style;
    }
  }
}