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
    public function get dropdown():Dropdown
    {
      return _dropdown;
    }
    public function get search():Search
    {
      return _search;
    }
    private var _dropdown:Dropdown;
    private var _search:Search;
    COMPILE::JS
    override protected function createElement():WrappedHTMLElement{
      var elem:WrappedHTMLElement = addElementToWrapper(this,'form');

      _dropdown = new Dropdown();
      _search = new Search();
      _search.searchIcon = false;
      search.addEventListener("submit", handleSubmit);
      addElement(_dropdown);
      addElement(_search);

      return elem;
    }
    private function handleSubmit(ev:Event):Boolean{
      ev.preventDefault();
      dispatchEvent(new Event("submit"));
      return false;
    }
    public function get dataProvider():Object
    {
    	return _dropdown.dataProvider;
    }

    public function set dataProvider(value:Object):void
    {
      _dropdown.dataProvider = value;
    }

    public function get selectedItem():Object
    {
    	return _dropdown.selectedItem;
    }

    public function set selectedItem(value:Object):void
    {
    	_dropdown.selectedItem = value;
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
        _dropdown.disabled = value;
        _search.disabled = value;
      }
    	_disabled = value;
    }
  }
}