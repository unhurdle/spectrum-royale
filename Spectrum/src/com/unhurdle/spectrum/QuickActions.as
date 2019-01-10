package com.unhurdle.spectrum
{
  COMPILE::JS
  {
    import org.apache.royale.core.WrappedHTMLElement;
  }

  public class QuickActions extends Group
  {
    public function QuickActions()
    {
      super();
    }
    override protected function getSelector():String{
      return "spectrum-QuickActions";
    }
    private var _textOnly:Boolean;

    /**
     * When the QuickActions contains only Text Buttons, this should be true to reduce padding
     */
    public function get textOnly():Boolean
    {
    	return _textOnly;
    }

    public function set textOnly(value:Boolean):void
    {
      if(value != !!_textOnly){
        toggle(valueToSelector("textOnly"),value);
      }
    	_textOnly = value;
    }
    private var _isOpen:Boolean;

    public function get isOpen():Boolean
    {
    	return _isOpen;
    }

    public function set isOpen(value:Boolean):void
    {
      if(value != _isOpen){
        toggle("is-open",value);
      }
    	_isOpen = value;
    }

    private var _overlay:Boolean;

    /**
     * Show overlay behind the QuickActions
     */
    public function get overlay():Boolean
    {
    	return _overlay;
    }

    public function set overlay(value:Boolean):void
    {
      if(value != !!_overlay){
        COMPILE::JS
        {
          if(value){
            outerElement.className = appendSelector("-overlay");
          } else {
            outerElement.className = null;
          }
        }
      }
    	_overlay = value;
    }

    COMPILE::JS
    private var outerElement:WrappedHTMLElement;
    COMPILE::JS
    override protected function createElement():WrappedHTMLElement{
      var elem:WrappedHTMLElement = super.createElement();
      outerElement = newElement("div") as WrappedHTMLElement;
      outerElement.royale_wrapper = this;
      return elem;
    }
    /**
     * The HTMLElement used to position the component.
     */
    COMPILE::JS
    override public function get positioner():WrappedHTMLElement
    {
        return outerElement;
    }

  }
}