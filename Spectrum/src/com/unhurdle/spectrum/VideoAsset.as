package com.unhurdle.spectrum
{
  import org.apache.royale.core.ValuesManager;
  import org.apache.royale.core.IValuesImpl;
  import org.apache.royale.events.Event;

	[Event(name="error", type="org.apache.royale.events.Event")]
  [Event(name="load", type="org.apache.royale.events.Event")]
  public class VideoAsset extends Asset
  {
    public function VideoAsset()
    {
      super();
    }

    protected var _videoElement:HTMLVideoElement;

    public function get videoElement():HTMLVideoElement
    {
    	return _videoElement;
    }
    protected var _src:String;
    public function get src():String
    {
    	return _src;
    }

    public function set src(value:String):void
    {
      if(value != _src){
        if(!_videoElement){
          createVideoElement();
        }
        _videoElement.src = value;
        _src = value;
      }
    }
    protected function createVideoElement():void{
      _videoElement = newElement("video",appendSelector("-image")) as HTMLVideoElement;
      _videoElement.setAttribute("controls","true");
      _videoElement.addEventListener('load', loadHandler);
      _videoElement.addEventListener('error', errorHandler);
      (element as HTMLElement).appendChild(_videoElement);

    }
    private function loadHandler(ev:Event):void{
      dispatchEvent(new Event("load"));
    }

    private function errorHandler(ev:Event):void{
      dispatchEvent(new Event("error"));
    }

    public function get videoStyle():CSSStyleDeclaration
    {
      if(!_videoElement){
        createVideoElement();
      }
    	return _videoElement.style;
    }
    public function set imageStyleString(value:String):void{
      var valuesImpl:IValuesImpl = ValuesManager.valuesImpl;
      var styles:Object = valuesImpl.parseStyles(value);
      var vidStyles:CSSStyleDeclaration = videoStyle;
      for(var x:String in styles){
        vidStyles[x] = styles[x];
      }      
    }

  }
}