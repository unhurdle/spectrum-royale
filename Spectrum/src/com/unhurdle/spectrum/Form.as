package com.unhurdle.spectrum
{
  COMPILE::JS
  {
    import org.apache.royale.core.WrappedHTMLElement;
    import org.apache.royale.html.util.addElementToWrapper;
  }
  import com.unhurdle.spectrum.includes.FieldLabelInclude;
  public class Form extends Group
  {
    public function Form()
    {
      super();
    }
    public static const TOP:String = "top"
    public static const LEFT:String = "left"
    public static const RIGHT:String = "right"
    override protected function getSelector():String{
      return FieldLabelInclude.getFormSelector();
    }

    private var _labelPosition:String = "right";

    public function get labelPosition():String
    {
    	return _labelPosition;
    }

    public function set labelPosition(value:String):void
    {
      if(_labelPosition == value){
        return;
      }
      switch(value){
        case "top":
        case "left":
        case "right":
          break;
        default: return;
      }
      if(_labelPosition == "top"){
        toggle(valueToSelector("labelsAbove"),false);
      }
      if(value == "top"){
        toggle(valueToSelector("labelsAbove"),true);
      }
    	_labelPosition = value;

    }


    COMPILE::JS
    override protected function createElement():WrappedHTMLElement{
      return addElementToWrapper(this,'form');
    }
  }
}