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
    
    public function get max():Number
    {
    	return Number(input.max);
    }

    public function set max(val:Number):void
    {
      if(input.max && val != Number(input.max)){
        if(val < Number(input.max)){
          removeFromArray(Number(input.max)-val);
        }
        else if(val > Number(input.max)){
          addToArray(val-Number(input.max));
        }
      }
      input.max = "" + val;
    }
    private function removeFromArray(amount:Number):void
    {
      COMPILE::JS{
        for(var index:int = 0; index < amount; index++)
        {
          iconArray.pop();
          element.removeChild(element.lastChild);
        }
      }
    }
    private function addToArray(amount:Number):void
    {
      COMPILE::JS{
        for(var index:int = 0; index < amount; index++)
        {
          span = new Span();
          span.className = appendSelector("-icon");
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
          // element.appendChild(span);
          iconArray.push(span);
        }
      }
    }
    private var iconArray:Array;
    public function get value():Number
    {
    	return Number(input.value);
    }
    private var icon1:Icon;
    private var icon2:Icon;
    private var span:Span;
    public function set value(val:Number):void
    { 
      COMPILE::JS{
        if(!iconArray){
          iconArray = [];
          addToArray(max);
          for(var i:int = 0;i<iconArray.length;i++){
            //// span.className = appendSelector("-icon");
            // element.children[i].className = appendSelector("-icon");
            //// element.children[i].className = "spectrum-Rating-icon";
            if(i <= val){
              element.children[i].className += " is-selected";
              // span.className += " is-selected";
            }
            // span.element.setAttribute("data-index",i);
          }
        }
        else{
          if(val < Number(input.value)){
            for(i = Number(input.value); i > val ; i--){
              if(element.children[i]){
                element.children[i].classList.remove("is-selected");
              }
            }
          }
          else if(val > Number(input.value)){
            for(i = Number(input.value); i <= val; i++){
              if(element.children[i]){
                element.children[i].classList.add("is-selected");
              }
            }
          }
        }
    	  input.value = "" + val;
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
//SET VALUE

  }
}