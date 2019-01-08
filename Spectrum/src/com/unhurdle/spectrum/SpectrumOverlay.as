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


  public class SpectrumOverlay extends EventDispatcher implements IBead
  {
    public function SpectrumOverlay()
    {
      super();
    }

    protected var _strand:IStrand;

    public function set strand(value:IStrand):void
    {
        if(_strand){
          (_strand as IEventDispatcher).removeEventListener("show", handleShown);
          (_strand as IEventDispatcher).removeEventListener("hide", handleHidden);
        }
        _strand = value;
        
        (_strand as IEventDispatcher).addEventListener("show", handleShown);
        (_strand as IEventDispatcher).addEventListener("hide", handleHidden);
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
    private var overlay:UIBase;
    /**
     *  @royaleignorecoercion Object
     */
    private function handleShown(ev:Event):void
    {
      hostParent = host.parent;
      var index:int = hostParent.getElementIndex(host);
      overlay = new UIBase();
      overlay.className = "spectrum-Underlay is-open";
      hostParent.addElementAt(overlay,index);
      overlay.addEventListener(MouseEvent.CLICK,handleClick);
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
      hostParent.removeElement(overlay);
    }

    private var _hideOnClick:Boolean = true;

    /**
     * If <code>hideOnClick</code> is true, the host will be closed when clicking
     *  on the overlay. default is true
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