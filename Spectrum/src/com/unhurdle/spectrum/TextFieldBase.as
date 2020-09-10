package com.unhurdle.spectrum
{
  import com.unhurdle.spectrum.interfaces.IKeyboardFocusable;
  import org.apache.royale.debugging.assert;
  import com.unhurdle.spectrum.beads.KeyboardFocusHandler;

  COMPILE::JS
  {}

  [Event(name="change", type="org.apache.royale.events.Event")]
/**
 * <input type="text" placeholder="Enter your name" name="field" value="Not a valid input" class="spectrum-Textfield" pattern="[\d]+" required>
 * <input type="text" placeholder="Enter your name" name="field" value="A valid input" class="spectrum-Textfield spectrum-Textfield--quiet is-valid" pattern="[\w\s]+" required disabled>
 */
  public class TextFieldBase extends SpectrumBase implements IKeyboardFocusable
  {
    /**
     * <inject_html>
     * <link rel="stylesheet" href="assets/css/components/textfield/dist.css">
     * </inject_html>
     * 
     */
    public function TextFieldBase()
    {
      super();
      addEventListener('focus',function():void{
        focused = true;
      });
      addEventListener('blur',function():void{
        focused = false;
      });
      addEventListener('keyboardFocus',function():void{
        keyboardFocused = true;
      });
      addEventListener('keyboardBlur',function():void{
        keyboardFocused = false;
      });
    }
    override protected function getSelector():String{
      return "spectrum-Textfield";
    }
    public function get focusElement():HTMLElement{
      assert(false,"Must override focusElement getter!");
      return null;
    }

    private var _quiet:Boolean;

    public function get quiet():Boolean
    {
    	return _quiet;
    }

    public function set quiet(value:Boolean):void
    {
      if(value != !!_quiet){
          toggle(valueToSelector("quiet"),value);
      }
    	_quiet = value;
    }
    
    //TODO
    public function validate():Boolean{
      return true;
    }

    public function setValidity(value:Boolean):void{
      valid = value;
      invalid = !value;
    }
    private var _valid:Boolean;

    public function get valid():Boolean
    {
    	return _valid;
    }

    public function set valid(value:Boolean):void
    {
      if(value != _valid){
        toggle("is-valid",value);
      }
    	_valid = value;
    }

    private var _invalid:Boolean;

    public function get invalid():Boolean
    {
    	return _invalid;
    }

    public function set invalid(value:Boolean):void
    {
      if(value != _invalid){
        toggle("is-invalid",value);
      }
    	_invalid = value;
    }

  private var _disabled:Boolean;

    public function get disabled():Boolean
    {
    	return _disabled;
    }

    public function set disabled(value:Boolean):void
    {
      if(!!value != !!_disabled){
        toggle("is-disabled",value);
      }
      _disabled = value;
    }

    private var _focused:Boolean;

    public function get focused():Boolean
    {
    	return _focused;
    }

    public function set focused(value:Boolean):void
    {
      if(value != _focused){
        toggle("is-focused",value);
        if(value){
          toggle("is-keyboardFocused",false);
        }
      }
    	_focused = value;
    }

    private var _keyboardFocused:Boolean;

    public function get keyboardFocused():Boolean
    {
    	return _keyboardFocused;
    }

    public function set keyboardFocused(value:Boolean):void
    {
      if(value != _keyboardFocused){
        toggle("is-keyboardFocused",value);
        if(value){
          toggle("is-focused",false);
        }
      }
    	_keyboardFocused = value;
    }

    private var _icon:String;

    /**
     * Icon selector name
     */
    public function get icon():String
    {
    	return _icon;
    }

    public function set icon(value:String):void
    {
    	_icon = value;
      createIcon(value);
    }

    private var _iconClass:String = "";

    public function get iconClass():String
    {
    	return _iconClass;
    }

    public function set iconClass(value:String):void
    {
    	_iconClass = value;
      if(iconElement){
        iconElement.className = value;
      }
    }
    private var _iconSize:String; "S"

    public function get iconSize():String
    {
    	return _iconSize;
    }

    public function set iconSize(value:String):void
    {
      if(!Icon.validateSize(value)){
        return;
      }
    	_iconSize = value;
      if(iconElement){
        iconElement.size = value;
      }
    }
    private var _iconType:String;

    public function get iconType():String
    {
    	return _iconType;
    }

    public function set iconType(value:String):void
    {
    	_iconType = value;
      if(iconElement){
        iconElement.type = value;
      }
    }
    private var _iconElement:Icon;

    public function get iconElement():Icon
    {
    	return _iconElement;
    }

    public function set iconElement(value:Icon):void
    {
      if(_iconElement){
        removeElement(_iconElement);
      }
    	_iconElement = value;
      if(_iconElement){
        addElementAt(_iconElement,0);
      }
    }

    protected function createIcon(selector:String):void{
      if(_iconElement){
        _iconElement.selector = selector;
        setIconProps();
      } else {
        _iconElement = new Icon(selector);
        setIconProps();
        addElementAt(_iconElement,0);
      }
    }
    protected function setIconProps():void{
      if(iconClass){
        _iconElement.className = iconClass;
      }
      _iconElement.size = iconSize;
      _iconElement.type = iconType;
      _iconElement.toggle(appendSelector("-icon"),true);
    }
    private var _autoFocus:Boolean = true;
    /**
     * if autoFocus is true the component handles its own focus management
     */
    public function get autoFocus():Boolean
    {
    	return _autoFocus;
    }

    public function set autoFocus(value:Boolean):void
    {
    	_autoFocus = value;
    }

    override public function addedToParent():void{
      super.addedToParent();
      if(autoFocus){
        addBead(new KeyboardFocusHandler());
      }
    }
  }
}