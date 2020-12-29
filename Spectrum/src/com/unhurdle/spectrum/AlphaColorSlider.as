package com.unhurdle.spectrum
{

	import org.apache.royale.utils.PointUtils;
	import org.apache.royale.geom.Point;
  import org.apache.royale.events.MouseEvent;
  import com.unhurdle.spectrum.interfaces.IRGBA;

	[Event(name="change", type="org.apache.royale.events.Event")]
	[Event(name="colorChanged", type="org.apache.royale.events.ValueEvent")]

  public class AlphaColorSlider extends ColorSlider
  {
    public function AlphaColorSlider()
    {
      super();
      colorStops = ["rgb(0, 0, 0)"];
      changeBackgroundColor()
    }

    public function get color():String{
        return colorStops[0];
    }
    public function set color(val:String):void{
        if(val != colorStops[0]){
          colorStops[0] = val;
          changeBackgroundColor();
        }
    }
    override protected function changeBackgroundColor():void{
      var startStr:String;
      var endStr:String =" 0%, rgba(0, 0, 0, 0) 100%)";
      if(!!vertical){
        startStr = "linear-gradient(to bottom, ";
      }
      else{
        startStr = "linear-gradient(to right, ";
      }
      startStr += color;
      gradient.style.background = startStr + endStr;
      handle.appliedColor = colorToRGBA(color);
    }
    override protected function onMouseMove(e:MouseEvent):void {
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
      var rgbColor:IRGBA = appliedColor;
      rgbColor.alpha = percent/100;
      handle.appliedColor = rgbColor;
      COMPILE::JS{
        if(vertical){
          handle.element.style.top = percent + "%";
        }else{
          handle.element.style.left = percent + "%";
        }
      }
    }
  }
}