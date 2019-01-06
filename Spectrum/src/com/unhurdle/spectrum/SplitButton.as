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
      typeNames = "spectrum-SplitButton"
    }
    private var actionButton:HTMLButtonElement;
    private var triggerButton:HTMLButtonElement;

    override protected function createElement():WrappedHTMLElement{
      var elem:WrappedHTMLElement = addElementToWrapper(this,'div');
      actionButton = newElement('button') as HTMLButtonElement;
      actionButton.className = "spectrum-Button spectrum-Button--cta spectrum-SplitButton-action"
      triggerButton = newElement('button') as HTMLButtonElement;
      triggerButton.className = "spectrum-Button spectrum-Button--cta spectrum-SplitButton-trigger";
      var icon:Icon = new Icon("#spectrum-css-icon-ChevronDownMedium")
      icon.className = "spectrum-Icon spectrum-UIIcon-ChevronDownMedium spectrum-SplitButton-icon";
      icon.selector = "#spectrum-css-icon-ChevronDownMedium";
      triggerButton.appendChild(icon.getElement());
      if(_left){
        elem.appendChild(triggerButton);
        elem.appendChild(actionButton);
      }
      else{
        elem.appendChild(actionButton);
        elem.appendChild(triggerButton);
      }
      return elem;
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
        var oldType:String = valueToCSS(_type);
        var newType:String = valueToCSS(value);
        actionButton.classList.add(newType);
        triggerButton.classList.add(newType);
        actionButton.classList.remove(oldType);
        triggerButton.classList.remove(oldType);
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
        toggle("spectrum-SplitButton--left",value);
      }
    	_left = value;
    }
    
    private function valueToCSS(value:String):String{
      return "spectrum-Button--" + value;
    }
  }
}