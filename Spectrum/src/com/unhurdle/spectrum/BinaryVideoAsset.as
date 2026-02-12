package com.unhurdle.spectrum
{
  import org.apache.royale.utils.BinaryData;
  COMPILE::JS
  {
    import org.apache.royale.utils.URLUtils;
  }

  public class BinaryVideoAsset extends VideoAsset
  {
    COMPILE::JS
    private static function revokeObjURL(inst:BinaryVideoAsset):void{
      if(inst._objectURL) {
        URLUtils.revokeObjectURL(inst._objectURL);
        inst._objectURL = null;
      }
    }
    
    
    public function BinaryVideoAsset()
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
        if(!_videoElement){
          createVideoElement();
        }
        COMPILE::JS
        {
          revokeObjURL(this);
          if (value) {
            var blob:Blob = new Blob([value.array]);
            _objectURL = URLUtils.createObjectURL(blob);
            _videoElement.src = _objectURL;
          } else {
            _videoElement.src = "";
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
        revokeObjURL(this);
      }
    }

  }
}