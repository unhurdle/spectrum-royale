package com.unhurdle.spectrum
{
  COMPILE::JS{
    import org.apache.royale.core.WrappedHTMLElement;
  }
  import com.unhurdle.spectrum.utils.ColorUtil;
  import org.apache.royale.events.ValueEvent;

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

    COMPILE::JS
    override protected function createElement():WrappedHTMLElement{
        var elem:WrappedHTMLElement = super.createElement();
        gradient = newElement("canvas",appendSelector("-gradient"));
        elem.appendChild(gradient);
        handle = new ColorHandle();
        addElement(handle);
        input = newElement("input",appendSelector("-slider")) as HTMLInputElement;
        input.type = "range";
        input.step = "`";
        input.min = "0";
        input.max = "360";
        elem.appendChild(input);
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
    override public function addedToParent():void{
      super.addedToParent();
      canvas = document.querySelector('canvas.spectrum-ColorWheel-gradient');
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
      // if(!disabled){
      addEventListener('mousedown', onMouseDown);
      handle.addEventListener("colorChanged",function(ev:ValueEvent):void{
        dispatchEvent(new ValueEvent("colorChanged",ev));
      });
      // }
      COMPILE::JS{
        handle.element.style.left = (width - ((width/2 - ringSize)/2)) + "px";
        handle.element.style.top = height/2 + "px";
      }
    }

		// Element interaction
		protected function onMouseDown(e:MouseEvent):void {
			onMouseMove(e);
			gradient.addEventListener('mouseup', onMouseUp);
			gradient.addEventListener('mousemove', onMouseMove);
		}

		protected function onMouseUp():void {
			gradient.removeEventListener('mouseup', onMouseUp);
			gradient.removeEventListener('mousemove', onMouseMove);
		}

    private function getPosition(el:*):Object {
      var xPos:Number = 0;
      var yPos:Number = 0;
    
      while (el) {
        if (el.tagName == "BODY") {
          // deal with browser quirks with body/window/document and page scroll
          var xScroll:Number = el.scrollLeft || document.documentElement.scrollLeft;
          var yScroll:Number = el.scrollTop || document.documentElement.scrollTop;
    
          xPos += (el.offsetLeft - xScroll + el.clientLeft);
          yPos += (el.offsetTop - yScroll + el.clientTop);
        } else {
          // for all other non-BODY elements
          xPos += (el.offsetLeft - el.scrollLeft + el.clientLeft);
          yPos += (el.offsetTop - el.scrollTop + el.clientTop);
        }
    
        el = el.offsetParent;
      }
      return {
        x: xPos,
        y: yPos
      };
    }
    protected function onMouseMove(e:MouseEvent):void {
      // if(disabled){
      //   return;
      // }
      var elem:HTMLElement = element as HTMLElement;
      var position:Object = getPosition(elem);
      var gradWidth:Number = gradient.offsetWidth;
      var gradHeight:Number = gradient.offsetHeight;
      var x:Number = gradWidth/2 + position.x;
      var y:Number = gradHeight/2 + position.y;
      var a:Number = e.clientX;
      var b:Number = e.clientY;
      var radians:Number = Math.atan2(b-y,a-x);
      COMPILE::JS{
        var left:Number = (Math.cos(radians) * (gradWidth/2 - ((gradWidth/2 - ringSize)/2)) + gradWidth/2);
        var top:Number = (Math.sin(radians) * (gradHeight/2 - ((gradHeight/2 - ringSize)/2)) + gradHeight/2);
        handle.element.style.left = left + "px";
        handle.element.style.top = top + "px";
        var context:* = canvas.getContext('2d');
        const imageDataData:Array = context.getImageData(left, top, 1, 1).data;
        handle.backgroundStyleColor = ColorUtil.rgbStr(imageDataData);
      }
    }
  }
}
