package com.unhurdle.spectrum.renderers
{
  COMPILE::JS
  {
    import org.apache.royale.core.WrappedHTMLElement;
  }

  import com.unhurdle.spectrum.ColorSwatch;
  import com.unhurdle.spectrum.interfaces.IRGBA;

  public class ColorSwatchRenderer extends DataItemRenderer
  {
    public function ColorSwatchRenderer()
    {
      super();
    }
    override protected function getSelector():String{
      return "spectrum-ColorSlider";
    }
    protected var swatch:ColorSwatch;

    override public function set data(value:Object):void{
      super.data = value;
      swatch.color = data as IRGBA;
    }
    COMPILE::JS
    override protected function createElement():WrappedHTMLElement{
      swatch = new ColorSwatch();
      swatch.square = true;
      var elem:WrappedHTMLElement = element = swatch.element;
      return elem;
    }
  }
}