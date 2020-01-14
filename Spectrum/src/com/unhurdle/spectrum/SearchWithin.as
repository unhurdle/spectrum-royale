package com.unhurdle.spectrum
{
  COMPILE::JS
  {
    import org.apache.royale.html.util.addElementToWrapper;
    import org.apache.royale.core.WrappedHTMLElement;
  }
  import org.apache.royale.events.Event;

  [Event(name="search", type="org.apache.royale.events.Event")]
  [Event(name="menuChange", type="org.apache.royale.events.Event")]
  public class SearchWithin extends SpectrumBase
  {
    
    /**
     * <inject_html>
     * <link rel="stylesheet" href="assets/css/components/searchwithin/dist.css">
     * </inject_html>
     * 
     */
    public function SearchWithin()
    {
      super();
      typeNames = "spectrum-SearchWithin";
    }
    public function get dropdown():Dropdown
    {
      return _dropdown;
    }
    // public function get search():Search
    // {
    //   return _search;
    // }
    private var _dropdown:Dropdown;
    private var input:TextField;
    private var button:ClearButton;
    COMPILE::JS
    override protected function createElement():WrappedHTMLElement{
      var elem:WrappedHTMLElement = addElementToWrapper(this,'form');

      _dropdown = new Dropdown();
      input = new TextField();
      input.placeholder = "Search";
      button = new ClearButton();
      button.addEventListener("clear" , clear);
      element.addEventListener("submit", handleSubmit);
      addElement(_dropdown);
      addElement(input);
      addElement(button);
      _dropdown.addEventListener("change",handleChange);
      _dropdown.addEventListener("showMenu",handleShowMenu);
      // input.element.addEventListener("change",cancelChange);

      return elem;
    }
    private function clear(ev:Event):void{
      input.text = "";
      dispatchEvent(new Event("search"));
    }
    private function handleSubmit(ev:Event):Boolean{
      ev.preventDefault();
      dispatchEvent(new Event("search"));
      return false;
    }
    private function handleChange(ev:Event):void{
      dispatchEvent(new Event("menuChange"));
    }
    private function handleShowMenu(ev:Event):void{
      _dropdown.popupWidth = width;
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
        input.disabled = value;
        button.disabled = value;
      }
    	_disabled = value;
    }
    private var _position:String;

    public function get position():String
    {
    	return _position;
    }

    public function set position(value:String):void
    {
      if(value != !!_position){
        _dropdown.position = value;
      }
    	_position = value;
    }

    public function get placeholder():String
    {
    	return input.placeholder;
    }

    public function set placeholder(value:String):void
    {
    	input.placeholder = value;
    }

    public function get text():String
    {
    	return input.text;
    }

    public function set text(value:String):void
    {
    	input.text = value;
    }
  }
}