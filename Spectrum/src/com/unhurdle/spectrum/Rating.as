package com.unhurdle.spectrum
{

  COMPILE::JS{
    import org.apache.royale.html.util.addElementToWrapper;
    import org.apache.royale.core.WrappedHTMLElement;
  }
  import com.unhurdle.spectrum.const.IconType;
  import org.apache.royale.html.elements.Span;

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
      input.className = appendSelector("-input");
      input.type = "range";
      element.appendChild(input);
      element.addEventListener("click",handleClick);
      return element;
    }
    COMPILE::JS
    private function handleClick(ev:*):void
    {
      if(ev.target){
        var index:Number = Number((ev.target as HTMLElement).getAttribute("data-index"));
        if(!isNaN(index)){
          value = index;
        }
      }
      console.log(ev.target);
    }
    public function get min():Number
    {
    	return Number(input.min);
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
        //TODO we can probably avoid constant adding and removing of the elements.
        if(input.value){
          //remove old rating icons
          while(numElements > 1){
            removeElement(getElementAt(numElements-1));
          }
        }
        var icon1:Icon;
        var icon2:Icon;
        var span:Span;
        for(var i:int = min;i<max;i++){
          span = new Span();
          span.className = appendSelector("-icon");
          if(i<=value){
            span.className += " is-selected";
          }
          span.element.setAttribute("data-index",i);

          var type:String = IconType.STAR;
          icon1 = new Icon(Icon.getCSSTypeSelector(type));
          icon1.type = type;
          icon1.className = appendSelector("-starActive");
          span.addElement(icon1);

          type = IconType.STAR_OUTLINE;
          icon2 = new Icon(Icon.getCSSTypeSelector(type));
          icon2.type = type;
          icon2.className = appendSelector("-starInactive");
          span.addElement(icon2);

          addElement(span);
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