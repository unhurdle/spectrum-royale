package com.unhurdle.spectrum
{

  COMPILE::JS{
    import org.apache.royale.html.util.addElementToWrapper;
    import org.apache.royale.core.WrappedHTMLElement;
  }
  public class Rating extends SpectrumBase
  {
    public function Rating()
    {
      super();
    }
    override protected function getSelector():String{
      return "spectrum-Rating";
    }
    COMPILE::JS
    private var input:HTMLInputElement;

    COMPILE::SWF
    private var input:Object;

    COMPILE::JS
    override protected function createElement():WrappedHTMLElement{
      addElementToWrapper(this,'div');
      input = newElement("input") as HTMLInputElement;
      input.className = "spectrum-Rating-input";
      input.type = "range";
      element.appendChild(input);
      return element;
    }
    public function get min():Number
    {
    	return Number(input.min);
    }

    public function set min(value:Number):void
    {
      input.min = "" + value;
    }
    
    public function get max():Number
    {
    	return Number(input.max);
    }

    public function set max(value:Number):void
    {
      input.max = "" + value;
    }
    public function get value():Number
    {
    	return Number(input.value);
    }

    public function set value(value:Number):void
    { 
      COMPILE::JS{
        if(input.value){
          //remove old rating icons
        }
        var icon1:Icon;
        var icon2:Icon;
        var span:HTMLElement;
        for(var i:int = min;i<max;i++){
          span = newElement("span");
          span.className = "spectrum-Rating-icon";
          if(i<value){
            span.className += " is-selected";
          }
          icon1 = new Icon("#spectrum-css-icon-Star");
          icon1.className = "spectrum-Icon spectrum-UIIcon-Star spectrum-Rating-starActive";
          icon1.selector = "#spectrum-css-icon-Star";
          span.appendChild(icon1.getElement());
          icon2 = new Icon("#spectrum-css-icon-StarOutline");
          icon2.className = "spectrum-Icon spectrum-UIIcon-StarOutline spectrum-Rating-starInactive";
          icon2.selector = "#spectrum-css-icon-StarOutline";
          span.appendChild(icon2.getElement());
          element.appendChild(span);
        }
    	  input.value = ""+value;
      }
    }
    private var _disabled:Boolean;

    public function get disabled():Boolean
    {
    	return _disabled;
    }

    public function set disabled(value:Boolean):void
    {
      if(value != !!_disabled){
        toggle("is-disabled",value);
        input.disabled = value;
      }
    	_disabled = value;
    }
  }
}