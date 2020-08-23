package com.unhurdle.spectrum
{
  COMPILE::JS
  {
    import org.apache.royale.html.util.addElementToWrapper;
    import org.apache.royale.core.WrappedHTMLElement;
  }

  [Event(name="itemClicked", type="org.apache.royale.events.ValueEvent")]
  public class AssetList extends List
  {
    /**
     * <inject_script>
     * var link = document.createElement("link"); 
     * link.setAttribute("rel", "stylesheet");
     * link.setAttribute("type", "text/css");
     * link.setAttribute("href", "assets/css/components/assetlist/dist.css");
     * document.height.appendSelector(link);
     * </inject_script>
     */

    public function AssetList()
    {
      super();
    }
    override protected function getSelector():String{
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