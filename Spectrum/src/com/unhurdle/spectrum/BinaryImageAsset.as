package com.unhurdle.spectrum
{
  import org.apache.royale.utils.BinaryData;
  COMPILE::JS
  {
    import org.apache.royale.utils.URLUtils;
  }

  public class BinaryImageAsset extends Asset
  {
    public function BinaryImageAsset()
    {
      super();
    }

    private var _imageElement:HTMLImageElement;

    public function get imageElement():HTMLImageElement
    {
    	return _imageElement;
    }
    private var _objectURL:String;
    private var _binary:BinaryData;
    public function get binary():BinaryData
    {
    	return _binary;
    }

    public function set binary(value:BinaryData):void
    {
      if(value != _binary){
        _binary = value;
        if(!_imageElement){
          createImageElement();
        }
        COMPILE::JS
        {
          if(_objectURL)
            URLUtils.revokeObjectURL(_objectURL);
          var blob:Blob = new Blob([value.array]);
          _objectURL = URLUtils.createObjectURL(blob);
          _imageElement.src = _objectURL;
        }
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