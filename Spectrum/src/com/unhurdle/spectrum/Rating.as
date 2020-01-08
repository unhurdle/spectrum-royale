package com.unhurdle.spectrum
{

  COMPILE::JS{
    import org.apache.royale.html.util.addElementToWrapper;
    import org.apache.royale.core.WrappedHTMLElement;
  }
  import com.unhurdle.spectrum.const.IconType;
  import org.apache.royale.html.elements.Span;
  import org.apache.royale.events.MouseEvent;

  public class Rating extends SpectrumBase
  {
    /**
     * <inject_html>
     * <link rel="stylesheet" href="assets/css/components/rating/dist.css">
     * </inject_html>
     * 
     */
    public function Rating()
    {
      super();
    }
    override protected function getSelector():String{
      return "spectrum-Rating";
    }
    private var input:HTMLInputElement;

    COMPILE::JS
    override protected function createElement():WrappedHTMLElement{
      addElementToWrapper(this,'div');
      input = newElement("input") as HTMLInputElement;
      input.className = appendSelector("-input");
      input.type = "range";
      element.appendChild(input);
      // element.addEventListener("click",handleClick);
      return element;
    }
    private function handleClick(ev:*):void
    {
      if(_readOnly){
        return;
      }
      if(ev.target){
        var index:Number = Number(ev.target.id);
        // var index:Number = Number((ev.target as HTMLElement).getAttribute("data-index"));
        if(!isNaN(index)){
          value = index;
        }
      }
      // console.log(ev.target);
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
      var elem:HTMLElement = element as HTMLElement;
        for(var index:int = 0; index < amount; index++)
        {
          iconArray.pop();
          elem.removeChild(elem.lastChild);
        }
    }
    private function addToArray(amount:Number):void
    {
      var len:int = iconArray.length + amount;
      for(var index:int = iconArray.length; index < len; index++)
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
        span.id = (index + 1).toString();
        span.addEventListener("click",handleClick);
        // span.addEventListener("click",changeValue)
        iconArray.push(span);
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
      var elem:HTMLElement = element as HTMLElement;
      if(!iconArray){
        iconArray = [];
        addToArray(max);
        for(var i:int = 1;i<=iconArray.length;i++){
          //// span.className = appendSelector("-icon");
          // elem.children[i].className = appendSelector("-icon");
          //// elem.children[i].className = "spectrum-Rating-icon";
          if(i <= val){
            elem.children[i].classList.add("is-selected");
            if(i == val){
              elem.children[i].classList.add("is-currentValue");              
            }
            // span.className += " is-selected";
          }
          // span.elem.setAttribute("data-index",i);
        }
      }
      else{
        var inputVal: Number = Number(input.value);
        elem.children[inputVal].classList.remove("is-currentValue");
        elem.children[val].classList.add("is-currentValue");
        if(val < inputVal){
          for(i = inputVal; i > val ; i--){
            if(elem.children[i]){
              elem.children[i].classList.remove("is-selected");
            }
          }
        }
        else if(val > inputVal){
          for(i = inputVal; i <= val; i++){
            if(elem.children[i]){
              elem.children[i].classList.add("is-selected");
            }
          }
        }
      }
      input.value = "" + val;
      
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
    private var _quiet:Boolean;

    public function get quiet():Boolean
    {
    	return _quiet;
    }

    public function set quiet(value:Boolean):void
    {
      if(value != !!_quiet){
        toggle(valueToSelector("quiet"),value);
      }
    	_quiet = value;
    }
    private var _readOnly:Boolean;

    public function get readOnly():Boolean
    {
    	return _readOnly;
    }

    public function set readOnly(value:Boolean):void
    {
      if(value != !!_readOnly){
        toggle("is-readOnly",value);
        input.readOnly = value;
      }
    	_readOnly = value;
    }
    private function changeValue(ev:MouseEvent):void{
      value = ev.target.id + 1;
    }
  }
}