package com.unhurdle.spectrum
{
  COMPILE::JS
  {
    import org.apache.royale.html.util.addElementToWrapper;
    import org.apache.royale.core.WrappedHTMLElement;
  }
  import org.apache.royale.html.List;
  [Event(name="itemClicked", type="org.apache.royale.events.ValueEvent")]
  public class Breadcrumbs extends org.apache.royale.html.List
  {
    /**
     * <inject_html>
     * <link rel="stylesheet" href="assets/css/components/breadcrumb/dist.css">
     * </inject_html>
     * 
     */

    public function Breadcrumbs()
    {
      super();
      typeNames = getSelector();
    }
    private function getSelector():String{
      return "spectrum-Breadcrumbs";
    }
    COMPILE::JS
    override protected function createElement():WrappedHTMLElement
    {
      var elem:WrappedHTMLElement = addElementToWrapper(this,'div');
      return elem;
    }
    private var _isTitle:Boolean;

    public function get isTitle():Boolean
    {
    	return _isTitle;
    }

    public function set isTitle(value:Boolean):void
    {
      if(value != !!_isTitle){
        if(value){
          className = getSelector() + "--title";
        } else {
          className = "";
        }
      }
      _isTitle = value;
    }
  }
}
