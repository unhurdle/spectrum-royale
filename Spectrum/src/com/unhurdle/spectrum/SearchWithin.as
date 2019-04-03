package com.unhurdle.spectrum
{
  COMPILE::JS
  {
    import org.apache.royale.html.util.addElementToWrapper;
    import org.apache.royale.core.WrappedHTMLElement;
  }
  import org.apache.royale.events.Event;

  [Event(name="submit", type="org.apache.royale.events.Event")]
  [Event(name="change", type="org.apache.royale.events.Event")]
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
      (input.element as HTMLInputElement).type = "search";
      input.placeholder = "Search";
      button = new ClearButton();

      element.addEventListener("submit", handleSubmit);
      addElement(_dropdown);
      addElement(input);
      addElement(button);
      _dropdown.addEventListener("change",handleChange);

      return elem;
    }
    /**
     *   <input type="text" placeholder="Search" class="spectrum-Textfield">
  <button type="reset" class="spectrum-ClearButton">
    <svg class="spectrum-Icon spectrum-UIIcon-CrossSmall" focusable="false" aria-hidden="true">
      <use xlink:href="#spectrum-css-icon-CrossSmall" />
    </svg>
  </button>

     */
    private function handleSubmit(ev:Event):Boolean{
      ev.preventDefault();
      dispatchEvent(new Event("submit"));
      return false;
    }
    private function handleChange(ev:Event):void{
      dispatchEvent(new Event("change"));
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