package com.unhurdle.spectrum
{

  COMPILE::JS
  {
    import org.apache.royale.core.WrappedHTMLElement;
    import org.apache.royale.html.util.addElementToWrapper;
  }

  import org.apache.royale.core.IBead;
  import org.apache.royale.core.IStrand;
  import org.apache.royale.core.IUIBase;
  import org.apache.royale.events.Event;
  import org.apache.royale.events.IEventDispatcher;
  import org.apache.royale.core.IParent;
  import org.apache.royale.events.MouseEvent;


  public class Underlay extends SpectrumBase implements IBead
  {
    /**
     * <inject_html>
     * <link rel="stylesheet" href="assets/css/components/underlay/dist.css">
     * </inject_html>
     * 
     */
    public function Underlay()
    {
      super();
      addEventListener(MouseEvent.CLICK,handleClick);
    }
    override protected function getSelector():String{
      return "spectrum-Underlay";
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
    // private var hostParent:IParent;
    /**
     *  @royaleignorecoercion Object
     */
    private function handleShown(ev:Event):void
    {
      var hostParent:IParent = host.parent;
      var index:int = hostParent.getElementIndex(host);
      hostParent.addElementAt(this,index);
      toggle("is-open",true);
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
      //TODO enable hide animation
      toggle("is-open",false);
      var parentElem:IParent = parent;
      if(parentElem){
        parentElem.removeElement(this);
      }
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