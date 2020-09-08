package com.unhurdle.spectrum
{
  COMPILE::JS
  {
    import org.apache.royale.core.WrappedHTMLElement;
    import org.apache.royale.html.util.addElementToWrapper;
    import org.apache.royale.core.CSSClassList;
  }

  public class Modal extends SpectrumBase
  {
    public function Modal()
    {
      super();
    }
    override protected function getSelector():String{
      return "spectrum-Modal";
    }
    private var _open:Boolean = false;

    public function get open():Boolean
    {
    	return _open;
    }

    public function set open(value:Boolean):void
    {
    	_open = value;
      var selector:String = "is-open";
      toggle(selector, value);
      COMPILE::JS
      {
        var classList:DOMTokenList = outerElement.classList;
        if(value){
          if(!classList.contains(selector)){
            classList.add(selector);
          }
        } else {
          classList.remove(selector);
        }
      }
    }

    COMPILE::JS
    private var outerElement:HTMLElement;
    COMPILE::JS
    override protected function createElement():WrappedHTMLElement{
      var elem:WrappedHTMLElement = super.createElement();
      outerElement = newElement("div",appendSelector("-wrapper"));
      outerElement.appendChild(elem);
      return elem
    }
    /**
     * The HTMLElement used to position the component.
     * @royaleignorecoercion org.apache.royale.core.WrappedHTMLElement
     */
    COMPILE::JS
    override public function get positioner():WrappedHTMLElement
    {
        return outerElement as WrappedHTMLElement;
    }

  }
}