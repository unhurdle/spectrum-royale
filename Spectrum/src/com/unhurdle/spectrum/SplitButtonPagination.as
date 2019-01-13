package com.unhurdle.spectrum
{
  COMPILE::JS{
    import org.apache.royale.html.util.addElementToWrapper;
    import org.apache.royale.core.WrappedHTMLElement;
    import com.unhurdle.spectrum.const.IconType;
  }
  public class SplitButtonPagination extends SpectrumBase
  {
    public function SplitButtonPagination()
    {
      super();
      type = "primary";
      href = "#";
    }

		override protected function getSelector():String{
				return "spectrum-SplitButton spectrum-SplitButton--left";
		}
    
    private var elem:WrappedHTMLElement;
    private var trigger:HTMLLinkElement;
    private var action:HTMLLinkElement;
    private var label:TextNode;
    COMPILE::JS
    override protected function createElement():WrappedHTMLElement{
      elem = addElementToWrapper(this,"nav");
      trigger = newElement("a","spectrum-Button spectrum-SplitButton-trigger") as HTMLLinkElement
      var triggerType:String = IconType.CHEVRON_LEFT_MEDIUM;
      var triggerCheckIcon:Icon = new Icon(Icon.getCSSTypeSelector(triggerType));
      triggerCheckIcon.type = triggerType;
      triggerCheckIcon.className = appendSelector("-ChevronLeftMedium");
      trigger.appendChild(triggerCheckIcon.element);
      elem.appendChild(trigger);
      action = newElement("a","spectrum-Button spectrum-SplitButton-action") as HTMLLinkElement
      label = new TextNode("");
      label.element = newElement("span","spectrum-Button-label") as HTMLSpanElement;
      label.text ="next";
      action.appendChild(label.element);
      var actionType:String = IconType.CHEVRON_RIGHT_MEDIUM;
      var actionCheckIcon:Icon = new Icon(Icon.getCSSTypeSelector(actionType));
      actionCheckIcon.type = actionType;
      actionCheckIcon.className = appendSelector("-ChevronRightMedium");
      action.appendChild(actionCheckIcon.element);
      elem.appendChild(action);
      return elem;
    }
    private var _href:String;

    public function get href():String
    {
    	return _href;
    }

    public function set href(value:String):void
    {
     if(value != !!_href){
      if(value){
      	_href = value;
      } else {
        _href = "#";
        }
        COMPILE::JS
        {
          trigger.href = _href;
          action.href = _href;
        }
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
          case "cta":
          case "primary":
          case "secondary":
            break;
          default:
              throw new Error("Invalid type: " + value);
        }
				var oldType:String = "spectrum-Button--" + _type;
				var newType:String = "spectrum-Button--" + value;
				trigger.classList.remove(oldType);
				action.classList.remove(oldType);
				trigger.classList.add(newType);
				action.classList.add(newType);
        _type = value;
      }
    }
   
    private var _text:String;

    public function get text():String
    {
    	return _text;
    }

    public function set text(value:String):void
    {
    	_text = value || "";
      label.text = _text;
    }
  }
}