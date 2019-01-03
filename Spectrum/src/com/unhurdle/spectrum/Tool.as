package com.unhurdle.spectrum
{
  COMPILE::JS{
    import org.apache.royale.core.WrappedHTMLElement;
    import org.apache.royale.html.util.addElementToWrapper;
  }
  public class Tool extends SpectrumBase
  {
    public function Tool()
    {
      super();
      typeNames = "spectrum-Tool";
    }
    COMPILE::JS
    private var button:HTMLButtonElement;
    COMPILE::SWF
    private var button:Object;
    COMPILE::JS
    override protected function createElement():WrappedHTMLElement{
      button = addElementToWrapper(this,'button') as HTMLButtonElement;
      var icon:Icon = new Icon("#spectrum-icon-18-Brush");
      icon.className = "spectrum-Icon spectrum-Icon--sizeS";
      icon.selector = "#spectrum-icon-18-Brush";
      button.appendChild(icon.getElement());
      return element;
    }
    private var _selected:Boolean;

    public function get selected():Boolean
    {
    	return _selected;
    }

    public function set selected(value:Boolean):void
    {
      if(value != !!_selected){
        toggle("is-selected",value);
      }
    	_selected = value;
    }
    private var _disabled:Boolean;

    public function get disabled():Boolean
    {
    	return _disabled;
    }

    public function set disabled(value:Boolean):void
    {
      if(value != !!_disabled){
        button.disabled = true;
      }
    	_disabled = value;
    }
    private var _cornerTriangle:Boolean;

    public function get cornerTriangle():Boolean
    {
    	return _cornerTriangle;
    }

    public function set cornerTriangle(value:Boolean):void
    {
      if(value && !_cornerTriangle ){
        var icon:Icon = new Icon("#spectrum-css-icon-CornerTriangle");
        icon.className = "spectrum-Icon spectrum-UIIcon-CornerTriangle spectrum-Tool-hold";
        icon.selector = "#spectrum-css-icon-CornerTriangle";
        button.appendChild(icon.getElement());
      }
    	_cornerTriangle = value;
    }
  }
}