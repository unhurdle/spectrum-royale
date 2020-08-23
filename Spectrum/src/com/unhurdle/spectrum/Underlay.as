package com.unhurdle.spectrum
{
  
  import org.apache.royale.events.EventDispatcher;
  import org.apache.royale.core.IBead;
  import org.apache.royale.core.IStrand;
  import org.apache.royale.core.IUIBase;
  import org.apache.royale.events.Event;
  import org.apache.royale.events.IEventDispatcher;
  import org.apache.royale.core.IParent;
  import org.apache.royale.core.UIBase;
  import org.apache.royale.events.MouseEvent;
  import org.apache.royale.html.elements.Div;


  public class Underlay extends EventDispatcher implements IBead
  {
    /**
     * <inject_script>
     * var link = document.createElement("link"); 
     * link.setAttribute("rel", "stylesheet");
     * link.setAttribute("type", "text/css");
     * link.setAttribute("href", "assets/css/components/underlay/dist.css");
     * document.head.appendChild(link);
     * </inject_script>
     */
    public function Underlay()
    {
      super();
    }

    protected var _strand:IStrand;

    public function set strand(value:IStrand):void
    {
        if(_strand){
          (_strand as IEventDispatcher).removeEventListener("modalShown", handleShown);
          (_strand as IEventDispatcher).removeEventListener("modalHidden", handleHidden);
        }
        _strand = value;
        
        (_strand as IEventDispatcher).addEventListener("modalShown", handleShown);
        (_strand as IEventDispatcher).addEventListener("modalHidden", handleHidden);
    }
    
    /**
     *  The host component. 
     */
    public function get host():IUIBase
    {
        return _strand as IUIBase;
    }
    // Application and View are both possible parents,
    // but there's no single interface for both that will work.
    private var hostParent:IParent;
    private var underlay:UIBase;
    /**
     *  @royaleignorecoercion Object
     */
    private function handleShown(ev:Event):void
    {
      hostParent = host.parent;
      var index:int = hostParent.getElementIndex(host);
      underlay = new Div();
      underlay.className = "spectrum-Underlay is-open";
      hostParent.addElementAt(underlay,index);
      underlay.addEventListener(MouseEvent.CLICK,handleClick);
    }

    private function handleClick(ev:MouseEvent):void
    {
      ev.preventDefault();
      ev.stopImmediatePropagation();
      if(_hideOnClick)
      {
        var dialog:IDialog = host as IDialog;
        dialog.hide();
      }
    }

    private function handleHidden(ev:Event):void
    {
      hostParent.removeElement(underlay);
    }

    private var _hideOnClick:Boolean = true;

    /**
     * If <code>hideOnClick</code> is true, the host will be closed when clicking
     *  on the underlay. default is true
     * 
     *  @langversion 3.0
     *  @playerversion Flash 10.2
     *  @playerversion AIR 2.6
     *  @productversion Royale 0.9.4
     */
    public function get hideOnClick():Boolean
    {
    	return _hideOnClick;
    }

    public function set hideOnClick(value:Boolean):void
    {
    	_hideOnClick = value;
    }

  }
}