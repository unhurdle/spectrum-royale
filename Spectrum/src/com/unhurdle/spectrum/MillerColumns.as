package com.unhurdle.spectrum
{
  COMPILE::JS
  {
    import org.apache.royale.html.util.addElementToWrapper;
    import org.apache.royale.core.WrappedHTMLElement;
  }
  import org.apache.royale.collections.HierarchicalData;
  import com.unhurdle.spectrum.data.MillerColumnsItem;

  public class MillerColumns extends SpectrumBase
  {
    /**
     * <inject_html>
     * <link rel="stylesheet" href="assets/css/components/miller/dist.css">
     * </inject_html>
     * 
     */
    public function MillerColumns()
    {
      super();
    }
    override protected function getSelector():String{
      return "spectrum-MillerColumns";
    }
    public function set dataProvider(value:HierarchicalData):void{

      var c:Object = value.source["children"][0];
      addElement(new MillerColumnsItem(c.children));
    }
  }
}