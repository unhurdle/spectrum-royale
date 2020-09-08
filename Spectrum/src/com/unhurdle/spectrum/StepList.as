package com.unhurdle.spectrum
{
  COMPILE::JS
  {
    import org.apache.royale.html.util.addElementToWrapper;
    import org.apache.royale.core.WrappedHTMLElement;
  }
  import org.apache.royale.html.elements.Div;
  import org.apache.royale.html.elements.Span;
  import org.apache.royale.core.UIBase;
  import org.apache.royale.html.elements.A;

  public class StepList extends SpectrumBase{
    /**
     * <inject_html>
     * <link rel="stylesheet" href="assets/css/components/steplist/dist.css">
     * </inject_html>
     * 
     */
    public function StepList()
    {
      super();
      max = 4;
      value = 0;
    }
    override protected function getSelector():String{
        return "spectrum-Steplist";
    }
    override public function addedToParent():void{
      super.addedToParent();
      value = value;
    }
    private var _isSmall:Boolean;
    public function get isSmall():Boolean
    {
    	return _isSmall;
    }
    public function set isSmall(val:Boolean):void
    {
      if(val != !!_isSmall){
        toggle(valueToSelector("small"),val);
      }
    	_isSmall = val;
    }
    private var _interactive:Boolean;
    public function get interactive():Boolean
    {
    	return _interactive;
    }
    public function set interactive(val:Boolean):void
    {
      if(val != !!_interactive){
        toggle(valueToSelector("interactive"),val);
      }
    	_interactive = val;
    }
    private var _withLabel:Boolean;
    public function get withLabel():Boolean
    {
    	return _withLabel;
    }
    public function set withLabel(val:Boolean):void
    {
    	_withLabel = val;
    }
    private var _withToolTip:Boolean;
    public function get withToolTip():Boolean
    {
    	return _withToolTip;
    }
    public function set withToolTip(val:Boolean):void
    {
    	_withToolTip = val;
    }
    private var _value:Number;

    public function get value():Number
    {
    	return _value;
    }

    COMPILE::SWF
    public function set value(val:Number):void{}

    COMPILE::JS
    public function set value(val:Number):void
    {
    	_value = val;
      if(!parent){
        return;
      }
      validateSteplistItems();
      var len:int = numElements;
      for(var i:int=0;i<len;i++){
        if(i + 1 > val){
          (element.children[i] as Element).classList.remove("is-selected");
          (element.children[i] as Element).classList.remove("is-complete");
        } else  if(i + 1 < val){
          (element.children[i] as Element).classList.add("is-complete");
        }
        else {
          (element.children[i] as Element).classList.add("is-selected");
        }
      }
    }
    private var _max:Number;

    public function get max():Number
    {
    	return _max;
    }

    public function set max(val:Number):void
    {
    	_max = val;
      if(!parent){//wait until addedToParent
        return;
      }
      validateSteplistItems();
    }
    private var markerContainer:Span;
    private var marker:Span;
    private var segment:Span
    private function validateSteplistItems():void{
      while(numElements > max){
        var elem:UIBase = getElementAt(numElements-1) as UIBase;
        removeElement(elem);
      }
      while(numElements < max){
        var div:Div = new Div();
        div.className = appendSelector("-item");
        markerContainer = new Span();
        markerContainer.className = appendSelector("-markerContainer");
        marker = new Span();
        marker.className = appendSelector("-marker");
        markerContainer.addElement(marker);
        if(interactive){
          var a:A = new A();
          a.className = appendSelector("-link");
          a.setAttribute('tabindex','-1');
          (a.element as HTMLElement).removeAttribute('href');
          a.addElement(markerContainer);
          div.addElement(a);
        }else{
          div.addElement(markerContainer);
        }
        segment = new Span();
        segment.className = appendSelector("-segment");
        div.addElement(segment);
        addElement(div);
        if(withLabel || withToolTip){
          if(withToolTip){
            //TODO change the += to toggle?
            div.className += " u-tooltip-showOnHover";
            var toolTip:Tooltip = new Tooltip();
            toolTip.text = "Step " + numElements;
            markerContainer.addElementAt(toolTip,getElementIndex(marker) );
          }
          else{
            var label:Span = new Span();
            label.className = "spectrum-Steplist-label"
            label.text = "Step " + numElements;
            div.addElementAt(label,div.getElementIndex(markerContainer));      
          }
        }
      }
    }
  }
}