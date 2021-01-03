package com.unhurdle.spectrum
{

  [Event(name="itemClicked", type="org.apache.royale.events.ValueEvent")]
  public class AssetList extends List
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
    }
    override protected function getSelector():String{
      return "spectrum-AssetList";
    }
  }
}