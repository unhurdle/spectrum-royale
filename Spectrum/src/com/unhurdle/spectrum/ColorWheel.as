package com.unhurdle.spectrum
{
   COMPILE::JS{
        import org.apache.royale.html.util.addElementToWrapper;
        import org.apache.royale.core.WrappedHTMLElement;
    }
    import org.apache.royale.events.MouseEvent;
    import org.apache.royale.utils.PointUtils;
    import org.apache.royale.geom.Point;
	[Event(name="change", type="org.apache.royale.events.Event")]

  public class ColorWheel extends SpectrumBase
  {
    public function ColorWheel()
    {
      super();
      // typeNames = getSelector() + " " + valueToSelector("color");
    }
    
    override protected function getSelector():String{
      return "spectrum-ColorWheel";
    }
    private var handle:ColorHandle;
		private var gradient:HTMLElement;
		private var input:HTMLInputElement;
    COMPILE::JS

    COMPILE::JS
    override protected function createElement():WrappedHTMLElement{
        var elem:WrappedHTMLElement = super.createElement();
        var checkerboardContainer:HTMLElement = newElement("svg",appendSelector("-wheel"));
        checkerboardContainer.setAttribute("viewBox","0 0 160 160");
        checkerboardContainer.setAttribute("aria-hidden","true");
        var defs:HTMLElement = newElement("defs");
        var mask:HTMLElement = newElement("mask");
        mask.id = "mask";
        gradient = newElement("div",appendSelector("-gradient"));
        gradient.setAttribute("role","presentation");
        // gradient.style = {"background":"linear-gradient(to right, rgb(255, 0, 0) 0%, rgb(255, 255, 0) 17%, rgb(0, 255, 0) 33%, rgb(0, 255, 255) 50%, rgb(0, 0, 255) 67%, rgb(255, 0, 255) 83%, rgb(255, 0, 0) 100%)"};
        // gradient.style = "background:linear-gradient(to right, rgb(255, 0, 0) 0%, rgb(255, 255, 0) 17%, rgb(0, 255, 0) 33%, rgb(0, 255, 255) 50%, rgb(0, 0, 255) 67%, rgb(255, 0, 255) 83%, rgb(255, 0, 0) 100%);";
        gradient.style.background = "linear-gradient(to right, rgb(255, 0, 0) 0%, rgb(255, 255, 0) 17%, rgb(0, 255, 0) 33%, rgb(0, 255, 255) 50%, rgb(0, 0, 255) 67%, rgb(255, 0, 255) 83%, rgb(255, 0, 0) 100%);";
        checkerboardContainer.appendChild(gradient);
        handle = new ColorHandle();
        // handle.style.left = "40%"
        input = newElement("input",appendSelector("-slider")) as HTMLInputElement;
        input.type = "range";
        input.step = "1";
        input.min = "0";
        input.max = "100";
        // input.setAttribute("aria-valuetext","#2680eb");
        handle.element.appendChild(input);
        checkerboardContainer.appendChild(handle.element);
        elem.appendChild(checkerboardContainer);
        // element.addEventListener('mousedown', onMouseDown);
        return elem;
    }
    override public function addedToParent():void{
      super.addedToParent();
      gradient.style.background = "linear-gradient(to right, rgb(255, 0, 0) 0%, rgb(255, 255, 0) 17%, rgb(0, 255, 0) 33%, rgb(0, 255, 255) 50%, rgb(0, 0, 255) 67%, rgb(255, 0, 255) 83%, rgb(255, 0, 0) 100%);";
    }
    // protected function onMouseMove(e:MouseEvent):void {
    //   if(disabled){
    //     return;
    //   }
    //   var elem:HTMLElement = element as HTMLElement;
		// 	var sliderOffsetWidth:Number = elem.offsetWidth;
    //   var localX:Number = PointUtils.globalToLocal(new Point(e.clientX,e.clientY),this).x;
		// 	var x:Number = Math.max(Math.min(localX, sliderOffsetWidth), 0);

		// 	var percent:Number = (x / sliderOffsetWidth) * 100;
		// 	value = getValue();
    //   handle.style.left = percent + "%";
    // }
    // public function get value():String
    // {
    // 	return String(input.value);
    // }
    //  override public function addedToParent():void{
		// 	super.addedToParent();
		// 	positionElements();
    // }

    // override protected function positionElements():void{
    //   super.positionElements();
    //   displayValue = true;
    // }
    // public function set value(value:String):void
    // {
		// 	//TODO why is this a string?
		// 	input.value = value;
		// 	if(parent){
		// 		positionElements();
		// 	}
		// 	if(valueNode){
		// 		valueNode.text = value;
		// 	}
    // }
    //  override protected function getValue():String{
		// 	return input.getAttribute("aria-valuetext");
		// }
    // private function changeBackgroundColor():void{
    //   if(!!color){
    //     if(!!showingAlpha){
    //       gradient.style.backgroundImage = "linear-gradient(to right, rgba(38, 128, 235, .5), rgb(9, 90, 186))";
    //     }
    //     else{
    //       gradient.style.backgroundImage = "linear-gradient(to right, rgb(38, 128, 235), rgb(9, 90, 186))";
    //     }
    //   }
    //   else{
    //     if(!!showingAlpha){
    //       gradient.style.backgroundImage = "linear-gradient(to right, rgba(128,128,128, .5), rgb(255, 255, 255))";
    //     }
    //     else{
    //       gradient.style.backgroundImage = "linear-gradient(to right, rgb(128,128,128), rgb(255, 255, 255))";
    //     }
    //   }
    //   positionElements();
    // }
    // private var _color:Boolean = true;
    // public function get color():Boolean
    // {
    //     return _color;
    // }
    // public function set color(val:Boolean):void
    // {
    //     if(val != !!_color){
    //         toggle(valueToSelector("color"),val);
    //     }
    //     _color = val;
    //     changeBackgroundColor();
    // }

    // private var _showingAlpha:Boolean;
    // public function get showingAlpha():Boolean
    // {
    //     return _showingAlpha;
    // }
    // public function set showingAlpha(val:Boolean):void
    // {
    //     _showingAlpha = val;
    //     changeBackgroundColor();
    // }
  }
}
