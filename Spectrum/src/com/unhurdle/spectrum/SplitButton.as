package com.unhurdle.spectrum
{
  COMPILE::JS
  {
    import org.apache.royale.html.util.addElementToWrapper;
    import org.apache.royale.core.WrappedHTMLElement;
  }

  public class SplitButton extends SpectrumBase
  {
    public function SplitButton()
    {
      super();
      _type = "primary";
    }
    override protected function getSelector():String{
      return "spectrum-SplitButton";
    }
    private var actionButton:Button;
    private var triggerButton:Button;

    override public function addedToParent():void{
      super.addedToParent();
      actionButton = new Button();
      actionButton.className = getSelector() + "-action";
      actionButton.flavor = _type;
      triggerButton = new Button();
      triggerButton.className = getSelector() + "-trigger";
      triggerButton.flavor = _type;
      triggerButton.icon = "#spectrum-css-icon-ChevronDownMedium";
      triggerButton.iconClass = "spectrum-Icon spectrum-UIIcon-ChevronDownMedium spectrum-SplitButton-icon";
      if(_left){
        addElement(triggerButton);
        addElement(actionButton);
      } else {
        addElement(actionButton);
        addElement(triggerButton);
      }
    }

    private var _type:String;

    public function get type():String
    {
      return _type;
    }

    public function set type(value:String):void
    {
      if(value != _type){
        switch (value){
        // check that values are valid
          case "act":
          case "primary":
          case "secondary":
            break;
          default:
              throw new Error("Invalid type: " + value);
        }
        if(actionButton){
          actionButton.flavor = value;
        }
        if(triggerButton){
          triggerButton.flavor = value;
        }
        _type = value;
      }
    }
   
    private var _left:Boolean;

    public function get left():Boolean
    {
    	return _left;
    }

    public function set left(value:Boolean):void
    {
      if(value != !!_left){
        toggle(valueToSelector("left"),value);
      }
    	_left = value;
    }
    
    //TODO add dataProvider and menu
  }
}