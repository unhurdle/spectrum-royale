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
      var retVal:String = '';
      var suffix:Array = getSuffix();
      if(!suffix.length){
        return getTypographySelector();
      }
      for(var i:int =0;i<suffix.length;i++){
        retVal += getTypographySelector() + suffix[i] + ' ';
      }
      return retVal.trim();
    }
    protected function getSuffix():Array{
      return [];
    }
    protected function getDefaultSize():Number{
      return 1;
    }

    protected var _size:String;

    public function get size():String
    {
    	return _size;
    }
    public function validateSize(value:String):Boolean{
      switch(value){
        case "XXS":
        case "XS":
        case "S":
        case "M":
        case "L":
        case "XL":
        case "XXL":
        case "XXXL":
          return true;
        default:
          return false;
      }
    }
    public function set size(value:String):void
    {
      if(!value || value == _size){
        return;
      }
      if(!validateSize(value)){
          throw new Error("invalid size: " + value);
      }
      if(_size){
        toggle(valueToSelector(_size),false);
      }
    	_size = value;
      toggle(valueToSelector(value),true);
    }

    private var _italic:Boolean;

    public function get isItalic():Boolean
    {
        return _italic;
    }

    public function set isItalic(value:Boolean):void
    {
        if(value != !!_italic){
            toggle(valueToSelector("italic"),value);
        }
        _italic = value;
    }
    private var _serif:Boolean;

    public function get serif():Boolean
    {
    	return _serif;
    }

    public function set serif(value:Boolean):void
    {
      if(value != !!_serif){
        toggle(valueToSelector("serif"),value);
      }
      _serif = value;
    }
    private var _isSecondary:Boolean;

    public function get isSecondary():Boolean
    {
    	return _isSecondary;
    }

    public function set isSecondary(value:Boolean):void
    {
      if(value != !!_isSecondary){
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