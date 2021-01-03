package com.unhurdle.spectrum
{
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

    [Inspectable(category="General", enumeration="top,left,right", defaultValue="right")]
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
    override protected function getTag():String{
      return "form";
    }

  }
}