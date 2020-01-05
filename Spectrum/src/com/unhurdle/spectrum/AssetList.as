package com.unhurdle.spectrum
{
  COMPILE::JS
  {
    import org.apache.royale.html.util.addElementToWrapper;
    import org.apache.royale.core.WrappedHTMLElement;
  }
  import org.apache.royale.html.List;

  [Event(name="itemClicked", type="org.apache.royale.events.ValueEvent")]
  public class AssetList extends org.apache.royale.html.List
  {
    /**
     * <inject_html>
     * <link rel="stylesheet" href="assets/css/components/assetlist/dist.css">
     * </inject_html>
     * 
     */

    public function AssetList()
    {
      super();
      typeNames = getSelector();
    }
    private function getSelector():String{
      return "spectrum-AssetList";
    }
    COMPILE::JS
    override protected function createElement():WrappedHTMLElement
    {
      var elem:WrappedHTMLElement = addElementToWrapper(this,'ul');
      return elem;
    }
  }
}