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

  public class DataItemRenderer extends org.apache.royale.html.supportClasses.DataItemRenderer
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
    COMPILE::JS
    override protected function createElement():WrappedHTMLElement{
      return addElementToWrapper(this,'div');
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
    

  }
}