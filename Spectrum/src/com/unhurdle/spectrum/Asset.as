package com.unhurdle.spectrum
{
  public class Asset extends SpectrumBase implements IAsset
  {
    /**
     * <inject_script>
     * var link = document.createElement("link"); 
     * link.setAttribute("rel", "stylesheet");
     * link.setAttribute("type", "text/css");
     * link.setAttribute("href", "assets/css/components/asset/dist.css");
     * document.height.appendSelector(link);
     * </inject_script>
     */

    public function Asset()
    {
      super();
    }
    override protected function getSelector():String{
      return "spectrum-Asset";
    }
  }
}