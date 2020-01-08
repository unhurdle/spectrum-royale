package com.unhurdle.spectrum
{
  COMPILE::JS
  {
    import org.apache.royale.core.WrappedHTMLElement;
    import org.apache.royale.html.util.addElementToWrapper;
  }
  import com.unhurdle.spectrum.const.IconPrefix;

  public class ImageIcon extends SpectrumBase
  {
    public static function getCSSTypeSelector(type:String):String{
      return IconPrefix.SPECTRUM_CSS_ICON + type;
    }
    public function ImageIcon(src:String = null)
    {
      super();
      if(src){
        this.src = src;
      }
    }
    override protected function getSelector():String{
      return "spectrum-Icon";
    }

    private var _size:String = "S";

    public function get size():String
    {
    	return _size;
    }

    public function set size(value:String):void
    {
      if(value == _size){
        return;
      }
      if(_size){
        toggle(valueToSelector("size" + _size),false);
      }
    	_size = value;
      if(!value){
        return;
      }
      switch(value){
        case "XXS":
        case "XS":
        case "S":
        case "M":
        case "L":
        case "XL":
        case "XXL":
          break;
        default:
          throw new Error("invalid size: " + value);
      }
      toggle(valueToSelector("size" + value),true);
    }

    public function setAttribute(name:String, value:Object):void{
      COMPILE::JS
      {
        element.setAttribute(name,value);
      }
    }
    public function removeAttribute(name:String):void{
      COMPILE::JS
      {
        element.removeAttribute(name);
      }
    }
    
    private var _src:String;

    public function get src():String
    {
    	return _src;
    }

    public function set src(value:String):void
    {
    	_src = value;
      (element as HTMLImageElement).src = value;
    }
    public function setStyle(attribute:String,value:Object):void{
      (element as HTMLElement).style[attribute] = value;
    }

		COMPILE::JS
		override protected function setClassName(value:String):void
		{
			element.setAttribute('class', value);
		}
    /**
     * @royaleignorecoercion org.apache.royale.core.WrappedHTMLElement
     */
    COMPILE::JS
    override protected function createElement():WrappedHTMLElement{
      var elem:WrappedHTMLElement = addElementToWrapper(this,"img");
      elem.setAttribute("focusable", false);
      elem.setAttribute("aria-hidden",true);
      return elem;
    }


  }
}