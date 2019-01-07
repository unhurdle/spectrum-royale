package com.unhurdle.spectrum
{
  COMPILE::JS{
        import org.apache.royale.html.util.addElementToWrapper;
        import org.apache.royale.core.WrappedHTMLElement;
    }
  public class ComboBox_old extends SpectrumBase
  {
    public function ComboBox_old()
    {
      super();
      typeNames = "spectrum-InputGroup";
    }
    COMPILE::JS{
      private var input:HTMLInputElement;
      private var button:HTMLButtonElement;
    }

    COMPILE::SWF{
      private var input:Object;
      private var button:Object;
    }
    COMPILE::JS
    override protected function createElement():WrappedHTMLElement{
      var elem:WrappedHTMLElement = addElementToWrapper(this,'div');
      input = newElement("input") as HTMLInputElement;
      input.className = "spectrum-Textfield spectrum-InputGroup-field";
      input.type = "text";
      elem.appendChild(input);
      button = newElement("button") as HTMLButtonElement;
      button.className = "spectrum-FieldButton spectrum-InputGroup-button";
      var icon:Icon = new Icon("#spectrum-css-icon-ChevronDownMedium");
      icon.className = "spectrum-Icon spectrum-UIIcon-ChevronDownMedium spectrum-InputGroup-icon";
      icon.selector = "#spectrum-css-icon-ChevronDownMedium";
      button.appendChild(icon.getElement());
      elem.appendChild(button);
      return elem;
    }
    public function get placeholder():String
    {
      return input.placeholder;
    }

    public function set placeholder(value:String):void
    {
      input.placeholder = value;
    }
    private var _isOpen:Boolean;

    public function get isOpen():Boolean
    {
    	return _isOpen;
    }
    
    public function set isOpen(value:Boolean):void
    {
      if(value != !!_isOpen){
        toggle("is-open",value);
        value ? button.classList.add("is-selected") : button.classList.remove("is-selected");
        COMPILE::JS
        if(value){
          // var div:HTMLDivElement = newElement("div") as HTMLDivElement;
          // div.className = "spectrum-Popover spectrum-Popover--bottom is-open";
          // div.style.position = "absolute" ;
          // div.style.top = "100%" ;
          // div.style.width = "100%" ;
          // var ul:HTMLUListElement = newElement("ul") as HTMLUListElement;
          // ul.className = "spectrum-Menu";
          // ul.setAttribute("role","listbox");
          // var li:HTMLLIElement = newTextNode("li") as HTMLLIElement;
          // ????????????????????????????????????????????
        }
      }
    	_isOpen = value;
    }
    private var _disabled:Object;

    public function get disabled():Object
    {
    	return _disabled;
    }

    public function set disabled(value:Object):void
    {
      if(value != !!_disabled){
        toggle("is-disabled",value);
        input.disabled = value;
        button.disabled = value;
      }
    	_disabled = value;
    }
    private var _quiet:Boolean;

    public function get quiet():Boolean
    {
    	return _quiet;
    }

    public function set quiet(value:Boolean):void
    {
    	if(value != !!_quiet){
        toggle("spectrum-InputGroup--quiet",value);
        value ? input.classList.add("spectrum-Textfield--quiet") : input.classList.remove("spectrum-Textfield--quiet");
        value ? button.classList.add("spectrum-FieldButton--quiet") : button.classList.remove("spectrum-FieldButton--quiet");
      }
      _quiet = value;
    }
    
    private var _isInvalid:Boolean;

    public function get isInvalid():Boolean
    {
    	return _isInvalid;
    }

    public function set isInvalid(value:Boolean):void
    {
      if(value != !!_isInvalid){
        toggle("is-invalid",value);
        value ? input.classList.add("is-invalid") : input.classList.remove("is-invalid");
        value ? button.classList.add("is-invalid") : button.classList.remove("is-invalid");
      }
    	_isInvalid = value;
    }
  }
}

// <h4>Open</h4>
// <div class="spectrum-InputGroup is-open">
//   <input type="text" placeholder="Type here" name="field" value="" class="spectrum-Textfield spectrum-InputGroup-field">
//   <button class="spectrum-FieldButton spectrum-InputGroup-button is-selected" aria-haspopup="true">
//     <svg class="spectrum-Icon spectrum-UIIcon-ChevronDownMedium spectrum-InputGroup-icon" focusable="false" aria-hidden="true">
//       <use xlink:href="#spectrum-css-icon-ChevronDownMedium" />
//     </svg>
//   </button>
//   <div class="spectrum-Popover spectrum-Popover--bottom is-open" style="position: absolute; top: 100%; left: 0; width: 100%">
//     <ul class="spectrum-Menu" role="listbox">
//       <li class="spectrum-Menu-item is-selected" role="option" tabindex="0">
//         <span class="spectrum-Menu-itemLabel">Ballard</span>
//       </li>
//       <li class="spectrum-Menu-item" role="option" tabindex="0">
//         <span class="spectrum-Menu-itemLabel">Fremont</span>
//       </li>
//       <li class="spectrum-Menu-item" role="option" tabindex="0">
//         <span class="spectrum-Menu-itemLabel">Greenwood</span>
//       </li>
//       <li class="spectrum-Menu-divider" role="separator"></li>
//       <li class="spectrum-Menu-item is-disabled" role="option" aria-disabled="true">
//         <span class="spectrum-Menu-itemLabel">United States of America</span>
//       </li>
//     </ul>
//   </div>
// </div>

// <div class="dummy-spacing"></div>

// <h4>Disabled</h4>
// <div class="spectrum-InputGroup is-disabled">
//   <input type="text" placeholder="Type here" name="field" value="" class="spectrum-Textfield spectrum-InputGroup-field" disabled>
//   <button class="spectrum-FieldButton spectrum-InputGroup-button" aria-haspopup="true" disabled>
//     <svg class="spectrum-Icon spectrum-UIIcon-ChevronDownMedium spectrum-InputGroup-icon" focusable="false" aria-hidden="true">
//       <use xlink:href="#spectrum-css-icon-ChevronDownMedium" />
//     </svg>
//   </button>
// </div>

// <h4>Invalid</h4>
// <div class="spectrum-InputGroup is-invalid">
//   <input type="text" placeholder="Type here" name="field" value="" class="spectrum-Textfield spectrum-InputGroup-field is-invalid">
//   <button class="spectrum-FieldButton spectrum-InputGroup-button is-invalid" aria-haspopup="true">
//     <svg class="spectrum-Icon spectrum-UIIcon-ChevronDownMedium spectrum-InputGroup-icon" focusable="false" aria-hidden="true">
//       <use xlink:href="#spectrum-css-icon-ChevronDownMedium" />
//     </svg>
//   </button>
// </div>

/////////////////
// quiet

// <h4>Default</h4>
// <div class="spectrum-InputGroup spectrum-InputGroup--quiet">
//   <input type="text" placeholder="Type here" name="field" value="" class="spectrum-Textfield spectrum-Textfield--quiet spectrum-InputGroup-field">
//   <button class="spectrum-FieldButton spectrum-FieldButton--quiet spectrum-InputGroup-button" aria-haspopup="true">
//     <svg class="spectrum-Icon spectrum-UIIcon-ChevronDownMedium spectrum-InputGroup-icon" focusable="false" aria-hidden="true">
//       <use xlink:href="#spectrum-css-icon-ChevronDownMedium" />
//     </svg>
//   </button>
// </div>

// <h4>Open</h4>
// <div class="spectrum-InputGroup spectrum-InputGroup--quiet is-open">
//   <input type="text" placeholder="Type here" name="field" value="" class="spectrum-Textfield spectrum-Textfield--quiet spectrum-InputGroup-field">
//   <button class="spectrum-FieldButton spectrum-FieldButton--quiet spectrum-InputGroup-button is-selected" aria-haspopup="true">
//     <svg class="spectrum-Icon spectrum-UIIcon-ChevronDownMedium spectrum-InputGroup-icon" focusable="false" aria-hidden="true">
//       <use xlink:href="#spectrum-css-icon-ChevronDownMedium" />
//     </svg>
//   </button>
//   <div class="spectrum-Popover spectrum-Popover--bottom is-open" style="position: absolute; top: 100%; width: 100%">
//     <ul class="spectrum-Menu" role="listbox">
//       <li class="spectrum-Menu-item is-selected" role="option" tabindex="0">
//         <span class="spectrum-Menu-itemLabel">Ballard</span>
//       </li>
//       <li class="spectrum-Menu-item" role="option" tabindex="0">
//         <span class="spectrum-Menu-itemLabel">Fremont</span>
//       </li>
//       <li class="spectrum-Menu-item" role="option" tabindex="0">
//         <span class="spectrum-Menu-itemLabel">Greenwood</span>
//       </li>
//       <li class="spectrum-Menu-divider" role="separator"></li>
//       <li class="spectrum-Menu-item is-disabled" role="option" aria-disabled="true">
//         <span class="spectrum-Menu-itemLabel">United States of America</span>
//       </li>
//     </ul>
//   </div>
// </div>

// <div class="dummy-spacing"></div>

// <h4>Disabled</h4>
// <div class="spectrum-InputGroup spectrum-InputGroup--quiet is-disabled">
//   <input type="text" placeholder="Type here" name="field" value="" class="spectrum-Textfield spectrum-Textfield--quiet spectrum-InputGroup-field" disabled>
//   <button class="spectrum-FieldButton spectrum-FieldButton--quiet spectrum-InputGroup-button" aria-haspopup="true" disabled>
//     <svg class="spectrum-Icon spectrum-UIIcon-ChevronDownMedium spectrum-InputGroup-icon" focusable="false" aria-hidden="true">
//       <use xlink:href="#spectrum-css-icon-ChevronDownMedium" />
//     </svg>
//   </button>
// </div>

// <h4>Invalid</h4>
// <div class="spectrum-InputGroup spectrum-InputGroup--quiet is-invalid">
//   <input type="text" placeholder="Type here" name="field" value="" class="spectrum-Textfield spectrum-Textfield--quiet spectrum-InputGroup-field is-invalid">
//   <button class="spectrum-FieldButton spectrum-FieldButton--quiet spectrum-InputGroup-button is-invalid" aria-haspopup="true">
//     <svg class="spectrum-Icon spectrum-UIIcon-ChevronDownMedium spectrum-InputGroup-icon" focusable="false" aria-hidden="true">
//       <use xlink:href="#spectrum-css-icon-ChevronDownMedium" />
//     </svg>
//   </button>
// </div>