package com.unhurdle.spectrum
{
  COMPILE::JS
  {
    import org.apache.royale.core.WrappedHTMLElement;
  }

  public class QuickActions extends Group
  {
    /**
     * <inject_script>
     * var link = document.createElement("link"); 
     * link.setAttribute("rel", "stylesheet");
     * link.setAttribute("type", "text/css");
     * link.setAttribute("href", "assets/css/components/quickaction/dist.css");
     * document.head.appendChild(link);
     * </inject_script>
     */
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

    private var _underlay:Boolean;

    /**
     * Show underlay behind the QuickActions
     */
    public function get underlay():Boolean
    {
    	return _underlay;
    }

    public function set underlay(value:Boolean):void
    {
      COMPILE::JS
      {
      if(value != !!_underlay){
        if(value){
          if(outerElement == element){
            outerElement = newElement("div") as WrappedHTMLElement;
            (outerElement as WrappedHTMLElement).royale_wrapper = this;
            var parent:Element = element.parentElement;
            if(parent){
              parent.insertBefore(outerElement,element);
            }
            outerElement.appendChild(element);
          }
          outerElement.className = appendSelector("-underlay");
        } else {
          outerElement.className = null;
        }
      }

      }
    	_underlay = value;
    }

    private var outerElement:HTMLElement;
    /**
     * @royaleignorecoercion org.apache.royale.core.WrappedHTMLElement
     */
    COMPILE::JS
    override protected function createElement():WrappedHTMLElement{
      var elem:WrappedHTMLElement = super.createElement();
      outerElement = elem;
      return elem;
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