package com.unhurdle.spectrum.renderers
{
  import org.apache.royale.html.supportClasses.DataItemRenderer;
  import org.apache.royale.core.CSSClassList;
  import com.unhurdle.spectrum.data.IDataItem;
  COMPILE::JS
  {
    import org.apache.royale.core.WrappedHTMLElement;
    import org.apache.royale.html.util.addElementToWrapper;
  }
  import org.apache.royale.utils.getSelectionRenderBead;
  import org.apache.royale.core.ISelectableItemRenderer;
  import com.unhurdle.spectrum.interfaces.IKeyboardFocusable;
  import com.unhurdle.spectrum.ISpectrumElement;

  public class DataItemRenderer extends org.apache.royale.html.supportClasses.DataItemRenderer implements IKeyboardFocusable, ISpectrumElement
  {
		public function DataItemRenderer()
		{
			super();
      classList = new CSSClassList();
      typeNames = getSelector();
		}

    protected function getSelector():String{
      return "";
    }
    protected function appendSelector(value:String):String{
      return getSelector() + value;
    }
    protected function valueToSelector(value:String):String{
      return getSelector() + "--" + value;
    }

    protected var classList:CSSClassList;

    public function toggle(classNameVal:String,add:Boolean):void
    {
      COMPILE::JS
      {
        add ? classList.add(classNameVal) : classList.remove(classNameVal);
        setClassName(computeFinalClassNames());
      }
    }

    COMPILE::JS
    override protected function computeFinalClassNames():String
    {
      return classList.compute() + super.computeFinalClassNames();
    }
    protected function getTag():String{
      return "div";
    }
    
    COMPILE::JS
    override protected function createElement():WrappedHTMLElement{
      return addElementToWrapper(this,getTag());
    }

    public function setStyle(property:String,value:Object):void
    {
      COMPILE::JS
      {
        element.style[property] = value;
      }
    }
    override public function set data(value:Object):void{
      super.data = value;
      selected = getItemSelected();
      disabled = getItemDisabled();
      focused = getItemFocused();
      keyboardFocused = getItemKeyboardFocused();
    }
    private function getItemSelected():Boolean{
      if(data is IDataItem){
        return (data as IDataItem).selected;
      }
      return data["selected"];
    }
    private function getItemDisabled():Boolean{
      if(data is IDataItem){
        return (data as IDataItem).disabled;
      }
      return data["disabled"];
    }
    private function getItemFocused():Boolean{
      if(data is IDataItem){
        return (data as IDataItem).focused;
      }
      return data["focused"];
    }
    private function getItemKeyboardFocused():Boolean{
      if(data is IDataItem){
        return (data as IDataItem).keyboardFocused;
      }
      return data["keyboardFocused"];
    }
    public function set selected(value:Boolean):void{
      var selectionBead:ISelectableItemRenderer = getSelectionRenderBead(this);
      if(selectionBead)
        selectionBead.selected = value;
    }
    public function get selected():Boolean{
      var selectionBead:ISelectableItemRenderer = getSelectionRenderBead(this);
      if(selectionBead)
        return selectionBead.selected;
      
      return false;
    }
    private var _disabled:Boolean;

    public function get disabled():Boolean
    {
    	return _disabled;
    }

    public function set disabled(value:Boolean):void{
    	_disabled = value;
      toggle("is-disabled",value);
      if(value){
        setStyle("pointerEvents","none");
      }
    }
    
    public function get focusElement():HTMLElement{
      COMPILE::JS{
        return element;
      }
      return null;
    }
    
    private var _keyboardFocused:Boolean;
    public function get keyboardFocused():Boolean{
    	return _keyboardFocused;
    }
    public function set keyboardFocused(value:Boolean):void{
      toggle("focus-ring",value);
    	_keyboardFocused = value;
      if(value){
        focused = !value;
        tabFocusable = true;
      }else{
        tabFocusable = false;
      }
    }

    private var _focused:Boolean;
    public function get focused():Boolean{
    	return _focused;
    }
    public function set focused(value:Boolean):void{
      toggle("is-focused",value);
    	_focused = value;
      if(value){
        keyboardFocused = !value;
      }
    }


    COMPILE::SWF
    private var _autofocus:Boolean;

    public function get autofocus():Boolean
    {
      COMPILE::SWF{
        return _autofocus;
      }
      COMPILE::JS
      {
        return element["autofocus"];
      }
    }

    public function set autofocus(value:Boolean):void
    {
      COMPILE::SWF{
    	_autofocus = value;
      }
      COMPILE::JS
      {
        element["autofocus"] = value;
      }
    }

    protected var _tabFocusable:Boolean;

    public function get tabFocusable():Boolean
    {
    	return _tabFocusable;
    }

    public function set tabFocusable(value:Boolean):void
    {
    	_tabFocusable = value;
      if(value){
        setAttribute("tabindex",0);
      } else {
        setAttribute("tabindex",-1);
      }
    }
    public function focus():void
    {
      COMPILE::JS
      {
        element.focus();
      }
    }
    public function setAttribute(name:String, value:*):void
    {    	
      COMPILE::JS
      {
        element.setAttribute(name,value);
      } 
    }

    public function getAttribute(name:String):*
    {
      COMPILE::JS
      {
        return element.getAttribute(name);
      }
      COMPILE::SWF
      {
        return "";
      }
    }

    public function removeAttribute(name:String):void
    {
      COMPILE::JS
      {
        element.removeAttribute(name);
      }
    }
  }
}