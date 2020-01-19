package com.unhurdle.spectrum.typography
{
  COMPILE::JS
  {
    import org.apache.royale.html.util.addElementToWrapper;
    import org.apache.royale.core.WrappedHTMLElement;
  }
  import com.unhurdle.spectrum.Group;
  import com.unhurdle.spectrum.TextNode;

  public class Typography extends TypographyBase
  {
    public static const STRONG:String = "strong;"
    public static const QUIET:String = "quiet;"
    public static const NORMAL:String = "normal;"

    public function Typography()
    {
      super();
    }
    protected function getTypographySelector():String{
      return "";
    }
    override protected function getSelector():String{
      var sizeStr:String = "" + size;
      var retVal:String = '';
      var suffix:Array = getSuffix();
      if(!suffix.length){
        return getTypographySelector() + sizeStr;
      }
      for(var i:int =0;i<suffix.length;i++){
        retVal += getTypographySelector() + sizeStr + suffix[i] + ' ';
      }
      return retVal.trim();
    }
    protected function getSuffix():Array{
      return [];
    }
    protected function getDefaultSize():Number{
      return 1;
    }

    protected var _size:Number;

    public function get size():Number
    {
      if(isNaN(_size)){
        _size = getDefaultSize();
      }
    	return _size;
    }
    protected function getMax():int{
      return 5;
    }
    public function set size(value:Number):void
    {
      if(value != _size){
        value = Math.min(value,getMax());
        value = Math.max(value,1);
        value = Math.round(value);
      	_size = value;
        setTypeNames();
      }
    }

    protected var _textSize:String;

    public function get textSize():String
    {
        return _textSize;
    }
    public function set textSize(value:String):void
    {
      if(value != _textSize){
        if(value){
          _size = 0;
        }
        switch (value){
          case "small":
          case "large":
          case "":
              break;
          default:
              throw new Error("Invalid size: " + value);
        }
        if(_textSize){
          toggle(valueToSelector(_textSize), false);
        }
        if(value == "small" || value == "large"){
          toggle(valueToSelector(value),true);
        }
        _textSize = value;
      }
    }    
    private var _italic:Boolean;

    public function get isItalic():Boolean
    {
        return _italic;
    }

    public function set isItalic(value:Boolean):void
    {
        if(value != !!_italic){
            if(value){
              _size = 0;
            }
            toggle(valueToSelector("italic"),value);
        }
        _italic = value;
    }
    private var _isSecondary:Boolean;

    public function get isSecondary():Boolean
    {
    	return _isSecondary;
    }

    public function set isSecondary(value:Boolean):void
    {
      if(value != !!_isSecondary){
        if(value){
          _size = 0;
        }
        toggle(valueToSelector("secondary"),value);
      }
      _isSecondary = value;
    }
    protected function setTypeNames():void{
      typeNames = getSelector();
      COMPILE::JS
      {
        setClassName(computeFinalClassNames());
      }
    }

  }
}