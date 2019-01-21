package com.unhurdle.spectrum
{
  COMPILE::JS
  {
    import org.apache.royale.html.util.addElementToWrapper;
    import org.apache.royale.core.WrappedHTMLElement;
  }
  import org.apache.royale.events.Event;

  [Event(name="submit", type="org.apache.royale.events.Event")]
  public class SearchWithin extends SpectrumBase
  {
    public function SearchWithin()
    {
      super();
      typeNames = "spectrum-SearchWithin";
    }
    private var dropdown:Dropdown;
    private var search:Search;
    COMPILE::JS
    override protected function createElement():WrappedHTMLElement{
      var elem:WrappedHTMLElement = addElementToWrapper(this,'form');

      dropdown = new Dropdown();
      search = new Search();
      search.searchIcon = false;
      search.addEventListener("submit", handleSubmit);
      addElement(dropdown);
      addElement(search);
      return elem;
    }
    private function handleSubmit(ev:Event):Boolean{
      ev.preventDefault();
      dispatchEvent(new Event("submit"));
      return false;
    }
    public function get dataProvider():Object
    {
    	return dropdown.dataProvider;
    }

    public function set dataProvider(value:Object):void
    {
      dropdown.dataProvider = value;
    }

    public function get selectedItem():Object
    {
    	return dropdown.selectedItem;
    }

    public function set selectedItem(value:Object):void
    {
    	dropdown.selectedItem = value;
      dropdown.handleListChange();
    }
    private var _disabled:Boolean;

    public function get disabled():Boolean
    {
    	return _disabled;
    }

    public function set disabled(value:Boolean):void
    {
      if(value != !!_disabled){
        dropdown.disabled = value;
        search.disabled = value;
      }
    	_disabled = value;
    }
  }
}