package com.unhurdle.spectrum
{
  import org.apache.royale.html.Tree;
  COMPILE::JS{
    import org.apache.royale.html.util.addElementToWrapper;
    import org.apache.royale.core.WrappedHTMLElement;
  }
    import org.apache.royale.core.CSSClassList;

  public class Tree extends org.apache.royale.html.Tree implements ISpectrumElement
  {
    /**
     * <inject_html>
     * <link rel="stylesheet" href="assets/css/components/treeview/dist.css">
     * </inject_html>
     * 
     */
    public function Tree()
    {
      super();
      classList = new CSSClassList();
      typeNames = getSelector();
    }

    protected function getSelector():String{
      return "spectrum-TreeView";
    }
    protected function appendSelector(value:String):String{
      return getSelector() + value;
    }
    private var _quiet:Boolean;

    public function get quiet():Boolean
    {
    	return _quiet;
    }

    public function set quiet(value:Boolean):void
    {
      if(_quiet != value){
        toggle(valueToSelector("quiet"),value);
      }
    	_quiet = value;
    }
    private var _standalone:Boolean;

    public function get standalone():Boolean
    {
    	return _standalone;
    }

    public function set standalone(value:Boolean):void
    {
      if(_standalone != value){
        toggle(valueToSelector("standalone"),value);
      }
    	_standalone = value;
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
    
    protected function valueToSelector(value:String):String{
      return getSelector() + "--" + value;
    }
    override public function set dataProvider(value:Object):void{
      super.dataProvider = value;
    }
    COMPILE::JS
    override protected function createElement():WrappedHTMLElement
    {
      return addElementToWrapper(this,'ul');
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
        setAttribute("tabindex",-1);
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
      COMPILE::JS
      {
        element.focus();
      }
    }
  }
}