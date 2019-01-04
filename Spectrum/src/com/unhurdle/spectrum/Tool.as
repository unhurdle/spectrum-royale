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
    }
    override protected function getSelector():String{
      return "spectrum-Tool";
    }
    COMPILE::JS
    private var button:HTMLButtonElement;
    COMPILE::SWF
    private var button:Object;
    private var icon:Icon;
    COMPILE::JS
    override protected function createElement():WrappedHTMLElement{
      button = addElementToWrapper(this,'button') as HTMLButtonElement;
      icon = new Icon("");
      icon.className = "spectrum-Icon spectrum-Icon--sizeS";
      button.appendChild(icon.getElement());
      return element;
    }

    public function get toolName():String
    {
    	return icon.selector;
    }

    public function set toolName(value:String):void
    {
    	icon.selector = value;
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
    private var cornerIcon:Icon;
    public function set cornerTriangle(value:Boolean):void
    {
      if(value != !!_cornerTriangle){
        if(!cornerIcon ){
          cornerIcon = new Icon("#spectrum-css-icon-CornerTriangle");
          cornerIcon.className = "spectrum-Icon spectrum-UIIcon-CornerTriangle spectrum-Tool-hold";
          button.appendChild(cornerIcon.getElement());
        }
        COMPILE::JS
        {
          if(value){
            cornerIcon.getElement().style.display = null;
          } else {
            cornerIcon.getElement().style.display = "none";
          }

        }

      }

    	_cornerTriangle = value;
    }
  }
}