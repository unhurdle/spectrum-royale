package com.unhurdle.spectrum
{
  COMPILE::JS
  {
    import org.apache.royale.html.util.addElementToWrapper;
    import org.apache.royale.core.WrappedHTMLElement;
  }
  import org.apache.royale.events.Event;
  import com.unhurdle.spectrum.utils.getDataProviderItem;

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
    }
    override protected function getSelector():String{
      return "spectrum-SearchWithin";
    }
    public function get dropdown():Picker
    {
      return _dropdown;
    }
    // public function get search():Search
    // {
    //   return _search;
    // }
    private var _dropdown:Picker;
    private var input:TextField;
    private var button:ClearButton;
    override protected function getTag():String{
      return "form";
    }
    COMPILE::JS
    override protected function createElement():WrappedHTMLElement{
      var elem:WrappedHTMLElement = super.createElement();

      _dropdown = new Picker();
      _dropdown.toggle(appendSelector("-picker"),true);
      _dropdown.button.toggle(appendSelector("-pickerTrigger"),true);
      _dropdown.visible = false;
      //TODO this should really be fixed in the spectrum css
      // https://github.com/adobe/spectrum-css/issues/880
      _dropdown.style = {"max-width": "calc(100% - 96px)"};
      input = new TextField();
      input.placeholder = "Search";
      input.inputClass = appendSelector("-input");
      button = new ClearButton();
      button.className = appendSelector("-clearButton");
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

    public function set dataProvider(value:Object):void{
        if(!value || _selectedIndex > value.length){
          _selectedIndex = -1;
        }
      _dropdown.dataProvider = value;
      if(value && value.length){
        _dropdown.visible = true;
        if(_selectedIndex > -1){
          selectedItem = getDataProviderItem(value,_selectedIndex);
        } else {
          selectedItem = null;
        }
      }
      else{
        _dropdown.visible = false;
      }
    }

    private var _selectedIndex:int;

    public function get selectedIndex():int{
    	return _selectedIndex;
    }

    public function set selectedIndex(value:int):void{
      if(value == -1)
        selectedItem = null;
    	_selectedIndex = value;
      if(_selectedIndex > -1 && dataProvider)
      {
        selectedItem = getDataProviderItem(_dropdown.dataProvider,0);
      }
    }

    public function get selectedItem():Object{
    	return _dropdown.selectedItem;
    }

    public function set selectedItem(value:Object):void{
      if(_dropdown.selectedItem != value){        
        _dropdown.selectedItem = value;
        dropdown.handleListChange();
      }
    }
    
    private var _disabled:Boolean;

    public function get disabled():Boolean{
    	return _disabled;
    }

    public function set disabled(value:Boolean):void{
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
