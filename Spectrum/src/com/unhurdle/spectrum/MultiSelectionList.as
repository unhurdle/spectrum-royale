package com.unhurdle.spectrum
{
  COMPILE::JS
  {
    import org.apache.royale.html.util.addElementToWrapper;
    import org.apache.royale.core.WrappedHTMLElement;
  }
  import org.apache.royale.html.MultiSelectionList;
  import com.unhurdle.spectrum.includes.SideNavInclude;
  import org.apache.royale.core.CSSClassList;
  import com.unhurdle.spectrum.interfaces.IKeyboardNavigateable;
  import org.apache.royale.utils.sendStrandEvent;

  public class MultiSelectionList extends org.apache.royale.html.MultiSelectionList implements ISpectrumElement, IKeyboardNavigateable
  {
    /**
     * MultiSelectionList is for basic selectable lists. The content of the list is provided by a dataProvider and the rendering is done by DataRendererers.
     * The basic ListDataRenderer accepts text and an optional icon.
     * If the dataProvider is a list of strings, the data will not be converted.
     * Use MultiSelectionList for compact selectable lists. If you want check-able lists, use Menu.
     * For a more spaced styling with room for checkboxes, icons, etc. use AssetList.
     * MultiSelectionList uses the styling for SideNav because it is more compact than AssetList and has background selection unlike Menu.
     * 
     */
    public function MultiSelectionList()
    {
      super();
      classList = new CSSClassList();
      typeNames = getSelector();
    }

    protected function getSelector():String{
      return SideNavInclude.getSelector();
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
      return (classList.compute() + super.computeFinalClassNames()).trim();
    }
    protected function getTag():String{
      return "ul";
    }
    COMPILE::JS
    override protected function createElement():WrappedHTMLElement
    {
      return addElementToWrapper(this,getTag());
    }

    public function setStyle(property:String,value:Object):void
    {
      COMPILE::JS
      {
        element.style[property] = value;
      }
    }

    public function setAttribute(name:String,value:*):void
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
    public function removeAttribute(name:String):void{
      COMPILE::JS
      {
        element.removeAttribute(name);
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
        removeAttribute("tabindex");
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
    public function focus():void
    {
      sendStrandEvent(this,"focusIn");
    }

    public function blur():void
    {
      sendStrandEvent(this,"focusOut");
    }

    public function get focusParent():ISpectrumElement
    {
      return this;
    }
    private var _flexGrow:int = -1;

    public function get flexGrow():int
    {
    	return _flexGrow;
    }

    public function set flexGrow(value:int):void
    {
    	_flexGrow = value;
      COMPILE::JS
      {
        if(value < 0){
          element.style.removeProperty("flex-grow");
        } else {
          element.style.flexGrow = value;
        }

      }
    }
  }
}