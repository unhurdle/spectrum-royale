package com.unhurdle.spectrum
{
  import org.apache.royale.html.Group;
  import org.apache.royale.core.CSSClassList;
  COMPILE::JS
  {
    import org.apache.royale.html.util.addElementToWrapper;
    import org.apache.royale.core.WrappedHTMLElement;
  }

  public class Group extends org.apache.royale.html.Group implements ISpectrumElement
  {
    public function Group()
    {
      super();
      classList = new CSSClassList();
      typeNames = getSelector();
    }
    override protected function requiresView():Boolean{
      return false;
    }
    override protected function requiresController():Boolean{
      return false;
    }
    override protected function requiresLayout():Boolean{
      return false;
    }

    protected function getSelector():String{
      return "";
    }
    protected function appendSelector(value:String):String{
      return getSelector() + value;
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
    protected function getTag():String{
      return "div";
    }

    COMPILE::JS
    override protected function createElement():WrappedHTMLElement{
      return addElementToWrapper(this,getTag());
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
        removeAttribute("tabindex");
      }
    }

    public function blur():void
    {
      COMPILE::JS
      {
        element.blur();
      }
    }

    public function focus():void
    {
      COMPILE::JS
      {
        element.focus();
      }
    }

    COMPILE::JS
    override public function addedToParent():void{
      super.addedToParent();
      if(autofocus){
        requestAnimationFrame(function():*{
          element.focus();
        });
      }
    }
    private var _flexGrow:int = -1;
    /**
     * if less than zero, this takes the native browser default behaviour which is '0' (unless subject to indirect styling via css styling lookups)
    */ 
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
      
    private var _flexShrink:int = -1;
    /**
     * if less than zero, this takes the native browser default behaviour which is '1' (unless subject to indirect styling via css styling lookups)
    */  
    public function get flexShrink():int
    {
       return _flexShrink;
    }
    
    public function set flexShrink(value:int):void
    {
       _flexShrink = value;
       COMPILE::JS
       {
        if(value < 0){
          element.style.removeProperty("flex-shrink");
        } else {
          element.style.flexShrink = value;
        }
      }
    }
      
    private var _flexBasis:String = null;
    /**
     * if null, this takes the native browser default behaviour which is 'auto' (unless subject to indirect styling via css styling lookups)
    */  
    public function get flexBasis():String
    {
       return _flexBasis || 'auto';
    }
    
    public function set flexBasis(value:String):void
    {
        _flexBasis = value ;
       COMPILE::JS
       {
        if(!value || value == 'auto'){
          element.style.removeProperty("flex-basis");
        } else {
          element.style.flexBasis = value;
        }
      }
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


  }
}