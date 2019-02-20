package com.unhurdle.spectrum
{
  public class ImageAsset extends Asset
  {
    public function ImageAsset()
    {
      super();
    }

    private var _imageElement:HTMLImageElement;

    public function get imageElement():HTMLImageElement
    {
    	return _imageElement;
    }
    private var _src:String;
    public function get src():String
    {
    	return _src;
    }

    public function set src(value:String):void
    {
      if(value != _src){
        if(!_imageElement){
          createImageElement();
        }
        _imageElement.src = value;
        _src = value;
      }
    }
    private function createImageElement():void{
      _imageElement = newElement("img",appendSelector("-image")) as HTMLImageElement;
      (element as HTMLElement).appendChild(_imageElement);

    }

    public function get imageStyle():CSSStyleDeclaration
    {
      if(!_imageElement){
        createImageElement();
      }
    	return _imageElement.style;
    }
  }
}