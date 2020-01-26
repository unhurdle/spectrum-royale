package com.unhurdle.spectrum
{

  COMPILE::JS{
    import org.apache.royale.html.util.addElementToWrapper;
    import org.apache.royale.core.WrappedHTMLElement;
  }
  import com.unhurdle.spectrum.const.IconType;
  import org.apache.royale.html.elements.Span;
  import org.apache.royale.core.UIBase;

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
      max = 5;
      value = 0;
      // element.addEventListener("click",handleClick);
      return element;
    }
    override public function addedToParent():void{
      super.addedToParent();
      value = value;
    }
    private function handleClick(ev:*):void
    {
      if(_readOnly){
        return;
      }
      if(ev.target){
        var index:Number = this.getElementIndex(ev.target);// Number(ev.target.id);
        // var index:Number = Number((ev.target as HTMLElement).getAttribute("data-index"));
        if(!isNaN(index)){
          if(value == index){
            value = 0;
          }else{
            value = index;
          }
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
      input.max = "" + val;
      if(!parent){//wait until addedToParent
        return;
      }
      validateIconElements();
    }
    private function validateIconElements():void{
      while(numElements > max + 1){
        var elem:UIBase = getElementAt(numElements-1) as UIBase;
        elem.removeEventListener("click",handleClick);
        removeElement(elem);
      }
      while(numElements < max + 1){
        var span:Span = new Span();
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
        span.addEventListener("click",handleClick);

      }
    }

    public function get value():Number
    {
    	return Number(input.value);
    }
    private var icon1:Icon;
    private var icon2:Icon;
    private var span:Span;
    COMPILE::SWF
    public function set value(val:Number):void{}

    COMPILE::JS
    public function set value(val:Number):void
    {
      input.value = "" + val;
      if(!parent){
        return;
      }
      validateIconElements();
      var len:int = numElements;
      for(var i:int=1;i<len;i++){
        if(i > val){
          (element.children[i] as Element).classList.remove("is-selected");
          (element.children[i] as Element).classList.remove("is-currentValue");
        } else {
          (element.children[i] as Element).classList.add("is-selected");

        }
        if(i==val){
          (element.children[i] as Element).classList.add("is-currentValue");
        }
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
  }
}