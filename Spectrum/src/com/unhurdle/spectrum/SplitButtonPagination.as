package com.unhurdle.spectrum
{
  COMPILE::JS{
    import org.apache.royale.html.util.addElementToWrapper;
    import org.apache.royale.core.WrappedHTMLElement;
  }
  import com.unhurdle.spectrum.const.IconType;
  public class SplitButtonPagination extends SpectrumBase
  {
    public function SplitButtonPagination()
    {
      super();
      toggle(valueToSelector("left"),true);
      type = "primary";
      href = "#";
      pagesNum = 1;
      pageIsSelected = 1;
    }

		override protected function getSelector():String{
				return "spectrum-SplitButton";
		}
    
    private var trigger:HTMLLinkElement;
    private var action:HTMLLinkElement;
    private var label:TextNode;
    COMPILE::JS
    override protected function createElement():WrappedHTMLElement{
      var elem:WrappedHTMLElement = addElementToWrapper(this,"nav");
      var buttonBase:String = "spectrum-Button";
      trigger = newElement("a", buttonBase + " " + appendSelector("-trigger")) as HTMLLinkElement
      var triggerType:String = IconType.CHEVRON_LEFT_MEDIUM;
      var triggerCheckIcon:Icon = new Icon(Icon.getCSSTypeSelector(triggerType));
      triggerCheckIcon.type = triggerType;
      trigger.appendChild(triggerCheckIcon.element);
      trigger.addEventListener("click",prewPage);
      elem.appendChild(trigger);
      action = newElement("a",buttonBase + " " + appendSelector("-action")) as HTMLLinkElement
      label = new TextNode("span");
      label.className = buttonBase + "-label";
      label.text ="Next";
      action.appendChild(label.element);
      var actionType:String = IconType.CHEVRON_RIGHT_MEDIUM;
      var actionCheckIcon:Icon = new Icon(Icon.getCSSTypeSelector(actionType));
      actionCheckIcon.type = actionType;
      actionCheckIcon.className = appendSelector("-ChevronRightMedium");
      action.appendChild(actionCheckIcon.element);
      action.addEventListener("click",nextPage);
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
    private var _pagesNum:int;

    public function get pagesNum():int
    {
    	return _pagesNum;
    }

    public function set pagesNum(val:int):void
    {
        if(val){
        	_pagesNum = val;
        }
        enableOrDisable();
    }
    private function prewPage():void{
      pageIsSelected > 1? pageIsSelected--: pageIsSelected = 1;
    }
    private function nextPage():void{
      pageIsSelected < pagesNum? pageIsSelected++: pageIsSelected = pagesNum;
    }
    private function enableOrDisable():void{
      pageIsSelected == 1? trigger.classList.add("is-disabled"): trigger.classList.remove("is-disabled");
      pageIsSelected >= pagesNum? action.classList.add("is-disabled"): action.classList.remove("is-disabled");
    }
    private var _pageIsSelected:Number;

    public function get pageIsSelected():Number
    {
    	return _pageIsSelected;
    }

    public function set pageIsSelected(val:Number):void
    {
      if(val && val <= pagesNum){
      	_pageIsSelected = val;
      }
      enableOrDisable();
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
        if(_type){
          var oldType:String = "spectrum-Button--" + _type;
  				trigger.classList.remove(oldType);
	  			action.classList.remove(oldType);
        }
				var newType:String = "spectrum-Button--" + value;
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