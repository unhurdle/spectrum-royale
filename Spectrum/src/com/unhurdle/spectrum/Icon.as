package com.unhurdle.spectrum
{
  COMPILE::JS
  {
    import org.apache.royale.core.WrappedHTMLElement;
  }
  import com.unhurdle.spectrum.const.IconPrefix;

  public class Icon extends SpectrumBase
  {
    public static function getCSSTypeSelector(type:String):String{
      return IconPrefix.SPECTRUM_CSS_ICON + type;
    }
    public function Icon(selector:String)
    {
      _selector = selector;
      super();
    }
    override protected function getSelector():String{
      return "spectrum-Icon";
    }

    private var _size:String;

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

    private var _type:String;

    public function get type():String
    {
    	return _type;
    }

    public function set type(value:String):void
    {
      if(value != _type){
        if(_type){
          toggle("spectrum-UIIcon-" + _type,false);
        }
        if(value){
          toggle("spectrum-UIIcon-" + value,true);
        }
      }
    	_type = value;
    }

    private var _selector:String;

    public function get selector():String
    {
    	return _selector;
    }
    
    public function set selector(value:String):void
    {
    	_selector = value;
      useElement.setAttributeNS('http://www.w3.org/1999/xlink', 'xlink:href', value);
    }

    override public function set x(value:Number):void{
      super.x = value;
      setAttribute("x",value);
    }
    override public function set y(value:Number):void{
      super.y = value;
      setAttribute("y",value);
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

    public function setStyle(attribute:String,value:Object):void{
      (element as HTMLElement).style[attribute] = value;
    }

		COMPILE::JS
		override protected function setClassName(value:String):void
		{
			element.setAttribute('class', value);
		}
    COMPILE::JS
    override protected function createElement():WrappedHTMLElement{
      var elem:SVGElement = newSVGElement("svg","");
      elem.setAttribute("focusable", false);
      elem.setAttribute("aria-hidden",true);
      useElement = newSVGElement("use","") as SVGUseElement;
      useElement.setAttributeNS('http://www.w3.org/1999/xlink', 'xlink:href', selector);
      elem.appendChild(useElement);
      element = elem as WrappedHTMLElement;
      return element;
    }

    private var useElement:SVGUseElement;

  }
}