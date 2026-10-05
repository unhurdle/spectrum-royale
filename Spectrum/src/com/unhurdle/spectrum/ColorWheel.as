package com.unhurdle.spectrum
{
  COMPILE::JS{
    import org.apache.royale.core.WrappedHTMLElement;
  }
  import com.unhurdle.spectrum.utils.PointerDrag;
  import org.apache.royale.events.MouseEvent;
  import org.apache.royale.events.ValueEvent;
  import com.unhurdle.spectrum.data.RGBColor;

	[Event(name="colorChanged", type="org.apache.royale.events.ValueEvent")]

  public class ColorWheel extends SpectrumBase
  {
    public function ColorWheel()
    {
      super();
    }
    
    override protected function getSelector():String{
      return "spectrum-ColorWheel";
    }
    private var handle:ColorHandle;
		private var gradient:HTMLElement;
		private var input:HTMLInputElement;
    private var pointerDrag:PointerDrag;

    COMPILE::JS
    override protected function createElement():WrappedHTMLElement{
        var elem:WrappedHTMLElement = super.createElement();
        gradient = newElement("canvas",appendSelector("-gradient"));
        elem.appendChild(gradient);
        handle = new ColorHandle();
        addElement(handle);
        input = newElement("input",appendSelector("-slider")) as HTMLInputElement;
        input.type = "range";
        input.step = "1";
        input.min = "0";
        input.max = "360";
        input.value = "0";
        elem.appendChild(input);
        input.addEventListener("input", handleNativeInput);
        return elem;
    }

    // private var _disabled:Boolean = false;

    // public function get disabled():Boolean
    // {
    // 	return _disabled;
    // }

    // public function set disabled(value:Boolean):void
    // {
    //   if(value != _disabled){
    //   	_disabled = value;
    //     handle.disabled = value;
    //     toggle("is-disabled",value);
    //   }
    // }

    private var ringSize:Number = 57;
    private var canvas:*;
    private var addedOnce:Boolean;
    override public function addedToParent():void{
      super.addedToParent();
      canvas = gradient;
      canvas.width = canvas.offsetWidth;
      canvas.height = canvas.offsetHeight;
      var context:* = canvas.getContext('2d');
      context.rect(0, 0, canvas.width, canvas.height);
      var width:Number = canvas.width;
      var height:Number = canvas.height;
      var centerX:Number = width / 2;
      var centerY:Number = height / 2;
      for (var i:Number = 0; i < 360; i += Math.PI / 8) {
        var rad:Number = i * (2 * Math.PI) / 360;
        context.strokeStyle = "hsla("+ i +", 100%, 50%, 1.0)";
        context.beginPath();
        context.moveTo(centerX + ringSize * Math.cos(rad), centerY + ringSize * Math.sin(rad));
        context.lineTo(centerX + centerX * Math.cos(rad), centerY + centerY * Math.sin(rad));
        context.stroke();
      }
      if(!addedOnce){
        pointerDrag = new PointerDrag(element, handlePointerStart, handlePointerMove, handlePointerEnd, "none");
        handle.addEventListener("colorChanged",function(ev:ValueEvent):void{
          dispatchEvent(new ValueEvent("colorChanged",ev));
        });
        addedOnce = true;
      }
      updateFromHue(Number(input.value));
    }

    private function handlePointerStart(event:PointerEvent):Boolean {
			if(event.target === input){
				return false;
			}
			onMouseDown(event as MouseEvent);
			return true;
		}

    private function handlePointerEnd():void {
			onMouseUp();
		}

    private function handlePointerMove(event:PointerEvent):void {
		onMouseMove(event as MouseEvent);
    }

    protected function onMouseDown(event:MouseEvent):void {
		handle.toggle("is-dragged",true);
    }

    protected function onMouseUp():void {
		handle.toggle("is-dragged",false);
    }

    COMPILE::JS
    protected function onMouseMove(event:MouseEvent):void {
      var bounds:ClientRect = gradient.getBoundingClientRect();
      var radians:Number = Math.atan2(event.clientY - (bounds.top + bounds.height / 2), event.clientX - (bounds.left + bounds.width / 2));
      var hue:Number = radians * 180 / Math.PI;
      if(hue < 0){
        hue += 360;
      }
      updateFromHue(hue);
    }

    COMPILE::SWF
    protected function onMouseMove(event:MouseEvent):void {}

    private function handleNativeInput():void {
      updateFromHue(Number(input.value));
    }

    private function updateFromHue(hue:Number):void {
      var gradWidth:Number = gradient.offsetWidth;
      var gradHeight:Number = gradient.offsetHeight;
      if(gradWidth == 0 || gradHeight == 0){
        return;
      }
      hue = (hue + 360) % 360;
      input.value = "" + hue;
      var radians:Number = hue * Math.PI / 180;
      COMPILE::JS{
        var left:Number = (Math.cos(radians) * (gradWidth/2 - ((gradWidth/2 - ringSize)/2)) + gradWidth/2);
        var top:Number = (Math.sin(radians) * (gradHeight/2 - ((gradHeight/2 - ringSize)/2)) + gradHeight/2);
        handle.element.style.left = left + "px";
        handle.element.style.top = top + "px";
        var context:* = canvas.getContext('2d');
        //TODO optimize this to get all the image data at once. See ColorArea.
        handle.appliedColor = new RGBColor(context.getImageData(left, top, 1, 1).data);
      }
    }
  }
}
