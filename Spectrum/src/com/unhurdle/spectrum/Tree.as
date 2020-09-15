package com.unhurdle.spectrum
{
  import org.apache.royale.html.Tree;
  COMPILE::JS{
    import org.apache.royale.html.util.addElementToWrapper;
    import org.apache.royale.core.WrappedHTMLElement;
  }
    import org.apache.royale.core.CSSClassList;

  public class Tree extends org.apache.royale.html.Tree
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
  }
}