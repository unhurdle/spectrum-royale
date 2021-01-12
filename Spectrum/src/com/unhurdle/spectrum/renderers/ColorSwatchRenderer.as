package com.unhurdle.spectrum.renderers
{
  COMPILE::JS
  {
    import org.apache.royale.core.WrappedHTMLElement;
  }

  import com.unhurdle.spectrum.ColorSwatch;
  import com.unhurdle.spectrum.interfaces.IRGBA;
  import com.unhurdle.spectrum.data.RGBColor;
  import com.unhurdle.spectrum.newElement;

  public class ColorSwatchRenderer extends DataItemRenderer
  {
    public function ColorSwatchRenderer()
    {
      super();
    }
    override protected function getSelector():String{
      return "spectrum-ColorSwatch";
    }
    protected var swatch:ColorSwatch;

    override public function set data(value:Object):void{
      if(data is IRGBA){
        var color:IRGBA = data as IRGBA;
      } else {
        color = new RGBColor();
        color.colorValue = data as uint;
      }
      super.data = color;
      COMPILE::JS
      {
        if(lineDiv){
          element.removeChild(lineDiv);
          lineDiv = null;
        }
        if(color.isValid){
          swatch.color = color;
        } else {
          swatch.color = new RGBColor([255,255,255]);
          lineDiv = newElement("div") as HTMLDivElement;
          lineDiv.style.top = "6px";
          lineDiv.style.left = "6px";
          lineDiv.style.width = "34px";
          lineDiv.style.height = "34px";
          lineDiv.style.borderTop = "2px solid red";
          lineDiv.style.transform = "rotate(-45deg)";
          lineDiv.style.position = "absolute";
          element.appendChild(lineDiv);

        }
        
      }
    }
    COMPILE::JS
    private var lineDiv:HTMLDivElement;

    COMPILE::JS
    override protected function createElement():WrappedHTMLElement{
      swatch = new ColorSwatch();
      swatch.square = true;
      var elem:WrappedHTMLElement = element = swatch.element;
      elem.style.outline = "none";
      return elem;
    }
  }
}