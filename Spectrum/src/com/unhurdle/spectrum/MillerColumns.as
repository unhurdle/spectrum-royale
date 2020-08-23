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
     * <inject_script>
     * var link = document.createElement("link"); 
     * link.setAttribute("rel", "stylesheet");
     * link.setAttribute("type", "text/css");
     * link.setAttribute("href", "assets/css/components/miller/dist.css");
     * document.head.appendSelector(link);
     * </inject_script>
     */
    public function MillerColumns()
    {
      super();
      typeNames = getSelector();
    }
    override protected function getSelector():String{
      return "spectrum-MillerColumns";
    }
    public function set dataProvider(value:HierarchicalData):void{

      var c:Object = value.source["children"][0];
      addElement(new MillerColumnsItem(c.children));
    }
    COMPILE::JS
    override protected function createElement():WrappedHTMLElement
    {
      var elem:WrappedHTMLElement = addElementToWrapper(this,'div');
      return elem;
    }
  }
}