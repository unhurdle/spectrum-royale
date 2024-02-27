package com.unhurdle.spectrum
{
  import org.apache.royale.utils.BinaryData;
  COMPILE::JS
  {
    import org.apache.royale.utils.URLUtils;
  }

  public class BinaryImageAsset extends ImageAsset
  {
    COMPILE::JS
    private static function revokeObjURL(objectUrl:String):void{
      if(objectUrl)
        URLUtils.revokeObjectURL(objectUrl);
    }
    
    
    public function BinaryImageAsset()
    {
      super();
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
          revokeObjURL(_objectURL);
          if (value) {
            var blob:Blob = new Blob([value.array]);
            _objectURL = URLUtils.createObjectURL(blob);
            _imageElement.src = _objectURL;
          } else {
            _imageElement.src = "";
          }
          
          _src = "";
        }
      }
    }
    override public function set src(value:String):void{
      super.src = value;
      _binary = null;
      COMPILE::JS
      {
        revokeObjURL(_objectURL);
      }
    }

  }
}