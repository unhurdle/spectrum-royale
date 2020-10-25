package com.unhurdle.spectrum
{
  COMPILE::JS
  {
    import org.apache.royale.core.WrappedHTMLElement;
    import org.apache.royale.html.util.addElementToWrapper;
  }
  import org.apache.royale.core.IChild;

	[Event(name="change", type="org.apache.royale.events.Event")]
	[Event(name="selectionChanged", type="org.apache.royale.events.Event")]
  public class ActionBar extends Group
  {
    public function ActionBar()
    {
      super()
    }
    override protected function getSelector():String{
      return "spectrum-ActionBar";
    }
    
    private var checkBox:CheckBox;
    private var popover:Popover;
    COMPILE::JS
    override protected function createElement():WrappedHTMLElement{
      var elem:WrappedHTMLElement = addElementToWrapper(this,'div');
      popover = new Popover();
      popover.className = appendSelector("-popover");
      popover.element.style.position = "relative";
      checkBox = new CheckBox();
      checkBox.indeterminate = true;
      popover.addElement(checkBox);
      elem.appendChild(popover.element);
      return elem;
    }

    override public function addElement(c:IChild, dispatchEvent:Boolean = true):void{
      popover.addElement(c,dispatchEvent);
    }


    private var _countSelected:Number;

    public function get countSelected():Number
    {
    	return _countSelected;
    }

    public function set countSelected(value:Number):void
    {
      if(value != _countSelected){
        checkBox.text = value + " Selected";
      }
    	_countSelected = value;
    }
    private var _flexible:Boolean;

    public function get flexible():Boolean
    {
    	return _flexible;
    }

    public function set flexible(value:Boolean):void
    {
      if(value != _flexible){
        toggle(valueToSelector("flexible"),value);
      }
    	_flexible = value;
    }
    private var _sticky:Boolean;

    public function get sticky():Boolean
    {
    	return _sticky;
    }

    public function set sticky(value:Boolean):void
    {
      if(value != _sticky){
        toggle(valueToSelector("sticky"),value);
      }
    	_sticky = value;
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
        popover.open = value;
      }
    	_isOpen = value;
    }
  }
}