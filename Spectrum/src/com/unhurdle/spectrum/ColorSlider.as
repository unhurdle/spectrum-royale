package com.unhurdle.spectrum
{
   COMPILE::JS{
        import org.apache.royale.core.WrappedHTMLElement;
    }
    import org.apache.royale.events.MouseEvent;
    import org.apache.royale.utils.PointUtils;
    import org.apache.royale.geom.Point;
    import com.unhurdle.spectrum.utils.ColorUtil;
    import org.apache.royale.events.ValueEvent;

	[Event(name="colorChanged", type="org.apache.royale.events.ValueEvent")]

  public class ColorSlider extends SpectrumBase
  {
    public function ColorSlider()
    {
      super();
      colorStop = ["rgb(255, 0, 0)", "rgb(255, 255, 0)", "rgb(0, 255, 0)", "rgb(0, 255, 255)", "rgb(0, 0, 255)", "rgb(255, 0, 255)", "rgb(255, 0, 0)"];
    }
    
    override protected function getSelector():String{
      return "spectrum-ColorSlider";
    }
    protected var handle:ColorHandle;
		protected var gradient:HTMLElement;
		private var input:HTMLInputElement;

    COMPILE::JS
    override protected function createElement():WrappedHTMLElement{
      var elem:WrappedHTMLElement = super.createElement();
      var checkerboardContainer:HTMLElement = newElement("div",appendSelector("-checkerboard"));
      checkerboardContainer.setAttribute("role","presentation");
      gradient = newElement("div",appendSelector("-gradient"));
      gradient.setAttribute("role","presentation");
      checkerboardContainer.appendChild(gradient);
      elem.appendChild(checkerboardContainer);
      handle = new ColorHandle();
      // handle.style.left = "40%"
      handle.className = appendSelector("-handle");
      handle.element.style.left = '0%';
      addElement(handle);
      input = newElement("input",appendSelector("-slider")) as HTMLInputElement;
      input.type = "range";
      input.step = "1";
      input.min = "0";
      input.max = "100";
      elem.appendChild(input);
      return elem;
    }

    private var _disabled:Boolean = false;

    public function get disabled():Boolean
    {
    	return _disabled;
    }

    public function set disabled(value:Boolean):void
    {
      if(value != _disabled){
      	_disabled = value;
        handle.disabled = value;
        toggle("is-disabled",value);
      }
    }

    private var _vertical:Boolean = false;

    public function get vertical():Boolean
    {
    	return _vertical;
    }

    public function set vertical(value:Boolean):void
    {
      if(value != _vertical){
      	_vertical = value;
        toggle(valueToSelector("vertical"),value);
        changeBackgroundColor();
        COMPILE::JS{
          handle.element.style.left = "40%";
        }
      }
    }

    private var _colorStop:Array;

    public function get colorStop():Array
    {
    	return _colorStop;
    }

    public function set colorStop(value:Array):void
    {
      _colorStop = value;
      changeBackgroundColor();
      handle.backgroundStyleColor = colorStop[0];
    }

		override public function addedToParent():void{
			super.addedToParent();
			if(!disabled){
					addEventListener('mousedown', onMouseDown);
			}
      handle.addEventListener("colorChanged",function(ev:ValueEvent):void{
        dispatchEvent(new ValueEvent("colorChanged",ev));
      });
		}

		// Element interaction
		protected function onMouseDown(e:MouseEvent):void {
			onMouseMove(e);
			window.addEventListener('mouseup', onMouseUp);
			window.addEventListener('mousemove', onMouseMove);
		}

		protected function onMouseUp():void {
			window.removeEventListener('mouseup', onMouseUp);
			window.removeEventListener('mousemove', onMouseMove);
		}

    protected function onMouseMove(e:MouseEvent):void {
      if(disabled){
        return;
      }
      var elem:HTMLElement = element as HTMLElement;
			var percent:Number;
      if(vertical){
        var sliderOffsetHeight:Number = elem.offsetHeight;
        var localY:Number = PointUtils.globalToLocal(new Point(e.clientX,e.clientY),this).y;
        var y:Number = Math.max(Math.min(localY, sliderOffsetHeight), 0);
        percent = (y / sliderOffsetHeight) * 100;
      }else{
        var sliderOffsetWidth:Number = elem.offsetWidth;
        var localX:Number = PointUtils.globalToLocal(new Point(e.clientX,e.clientY),this).x;
        var x:Number = Math.max(Math.min(localX, sliderOffsetWidth), 0);
        percent = (x / sliderOffsetWidth) * 100;
      }
      var num:Number = percent/(100/(colorStop.length - 1));
      if(isInt(num)){
        handle.backgroundStyleColor = colorStop[num];
      }else{
        var ind:int = num - num % 1;
        var color1:String = colorStop[ind];
        var color2:String = colorStop[ind + 1];
        var rgb1:Array = colorToRGBA(color1);
        var rgb2:Array = colorToRGBA(color2);
        handle.backgroundStyleColor = ColorUtil.rgbStr(pickHex(rgb1,rgb2,getWeightColor(ind+1,ind,percent)));
      }
      COMPILE::JS{
        if(vertical){
          handle.element.style.top = percent + "%";
        }else{
          handle.element.style.left = percent + "%";
        }
      }
    }

    private function isInt(n:Number):Boolean{
      return Number(n) === n && n % 1 === 0;
    }

    private function getWeightColor(num1:Number, num2:Number, percent:Number):Number {
      var w1:Number = num1 *(100/(colorStop.length - 1));
      var w2:Number = num2 *(100/(colorStop.length - 1));
      var weight:Number = (percent - w1) / (w2 - w1);
      return weight;
    }

    protected function pickHex(color1:Array, color2:Array, weight:Number):Array {
      var w1:Number = weight;
      var w2:Number = 1 - w1;
      var rgb:Array = [Math.round(color1[0] * w1 + color2[0] * w2),
      Math.round(color1[1] * w1 + color2[1] * w2),
      Math.round(color1[2] * w1 + color2[2] * w2)];
      return rgb;
    }

    protected function convertHexToRgb(hexVal:String):Array{
      var rStr:String = hexVal.slice(0,2);
      var gStr:String = hexVal.slice(2,4);
      var bStr:String = hexVal.slice(4);
      var rVal:Number = parseInt(rStr,16);
      var gVal:Number = parseInt(gStr,16);
      var bVal:Number = parseInt(bStr,16);
      return [rVal,gVal,bVal];
    }

    protected function colorToRGBA(color:String):* {
      var cvs:*, ctx:*;
      cvs = document.createElement('canvas');
      cvs.height = 1;
      cvs.width = 1;
      ctx = cvs.getContext('2d');
      ctx.fillStyle = color;
      ctx.fillRect(0, 0, 1, 1);
      return ctx.getImageData(0, 0, 1, 1).data;
    }

    protected function changeBackgroundColor():void{
      var startStr:String;
      if(!!vertical){
        startStr = "linear-gradient(to bottom, ";
      }
      else{
        startStr = "linear-gradient(to right, ";
      }
      for each(var c:String in colorStop){
        startStr += c +", ";
      }
      startStr = startStr.slice(0,startStr.length-2);
      startStr += ")";
      gradient.style.background = startStr;
    }
  }
}
