package com.unhurdle.spectrum
{
  import org.apache.royale.core.ValuesManager;
  import org.apache.royale.core.IValuesImpl;
  import org.apache.royale.events.Event;

	[Event(name="error", type="org.apache.royale.events.Event")]
  [Event(name="load", type="org.apache.royale.events.Event")]
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
      _imageElement.addEventListener('load', loadHandler);
      _imageElement.addEventListener('error', errorHandler);
      (element as HTMLElement).appendChild(_imageElement);

    }
    private function loadHandler(ev:Event):void{
      dispatchEvent(new Event("load"));
    }

    private function errorHandler(ev:Event):void{
      dispatchEvent(new Event("error"));
    }

    public function get imageStyle():CSSStyleDeclaration
    {
      if(!_imageElement){
        createImageElement();
      }
    	return _imageElement.style;
    }
    public function set imageStyleString(value:String):void{
      var valuesImpl:IValuesImpl = ValuesManager.valuesImpl;
      var styles:Object = valuesImpl.parseStyles(value);
      var imgStyles:CSSStyleDeclaration = imageStyle;
      for(var x:String in styles){
        imgStyles[x] = styles[x];
      }      
    }
  }
}