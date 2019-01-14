package com.unhurdle.spectrum
{
  COMPILE::JS{
    import org.apache.royale.html.util.addElementToWrapper;
    import org.apache.royale.core.WrappedHTMLElement;
  }

  import com.unhurdle.spectrum.const.IconType;
  import com.unhurdle.spectrum.data.DropdownItem;
  import org.apache.royale.html.util.getLabelFromData;
  import org.apache.royale.collections.IArrayList;
  import com.unhurdle.spectrum.data.MenuItem;
  import org.apache.royale.html.SimpleAlert;

  public class Dropdown extends SpectrumBase
  {
    public function Dropdown()
    {
      super();
    }
    override protected function getSelector():String{
      return "spectrum-Dropdown";
    }
    private var button:FieldButton;
    COMPILE::JS
    override protected function createElement():WrappedHTMLElement{
      var elem:WrappedHTMLElement = addElementToWrapper(this,'div');
      button = new FieldButton();
      button.className = appendSelector("-trigger");
      button.addEventListener("click",toggleDropdown);
      var type:String = IconType.CHEVRON_DOWN_MEDIUM;
      button.icon = Icon.getCSSTypeSelector(type);
      button.iconType = type;
      button.iconClass = appendSelector("-icon");
      addElement(button);
      popover = new Popover();
      popover.className = appendSelector("-popover");
      popover.position = "bottom";
      popover.style = {"width":"100%"};
      menu = new Menu();
      popover.addElement(menu);
      popover.addEventListener("click", handleListChange);
      addElement(popover);

      return elem;
    }
    private var popover:Popover;
    private var menu:Menu;

    private function toggleDropdown():void{
      popover.open = !popover.open;
      if(popover.open){
        button.className += " is-selected";
        // button.classList.add("is-selected");//?????
        }
      else{
        // button.classList.remove("is-selected");//?????
      }
    }
    public function get dataProvider():Object{
      return menu.dataProvider;
    }
    public function set dataProvider(value:Object):void{
      if(value is Array){
        convertArray(value);
      } else if(value is IArrayList){
        convertArray(value.source);
      }
      menu.dataProvider = value;
    }

    public function get selectedIndex():int
    {
    	return menu.selectedIndex;
    }

    public function set selectedIndex(value:int):void
    {
    	menu.selectedIndex = value;
    }

    public function get selectedItem():Object
    {
    	return menu.selectedItem;
    }

    public function set selectedItem(value:Object):void
    {
    	menu.selectedItem = value;
    }
    private function convertArray(value:Object):void{
      var newVal:Array;
      newVal = new Array(value.length);
      var len:int = value.length;
      for(var i:int = 0;i<len;i++){
        var item:MenuItem = new MenuItem(getLabelFromData(this,value[i]));
        if(value[i].selected){
          item.selected = value[i]["selected"];
        }
        if(value[i].isDivider){
          item.isDivider = value[i]["isDivider"];
        }
        if(value[i].disabled){
          item.disabled = value[i]["disabled"];
        }
        if(value[i].icon){
          item.icon = value[i]["icon"];
        }
        value[i] = item;
      }
    }
    private var _placeholder:String;
    public function get placeholder():String
    {
    	return _placeholder;
    }

    public function set placeholder(value:String):void
    {
      _placeholder = value;
    	button.placeholderText = value;
    }

    private function handleListChange():void{
      // popover.open = false;
      if(!selectedItem.isDivider && !selectedItem.disabled){
        button.text = selectedItem.text;
      }
    }
  }
}
// <h4>Closed</h4>
// <div class="spectrum-Dropdown" style="width: 240px;">
//   <button class="spectrum-FieldButton spectrum-Dropdown-trigger" >
//     <span class="spectrum-Dropdown-label is-placeholder">Select a Country</span>
//     <svg class="spectrum-Icon spectrum-UIIcon-ChevronDownMedium spectrum-Dropdown-icon" focusable="false" >
//       <use xlink:href="#spectrum-css-icon-ChevronDownMedium" />
//     </svg>
//   </button>
// </div>

// <h4>Open</h4>
// <div class="spectrum-Dropdown is-open" style="width: 240px;">
//   <button class="spectrum-FieldButton spectrum-Dropdown-trigger is-selected" >
//     <span class="spectrum-Dropdown-label">Ballard</span>
//     <svg class="spectrum-Icon spectrum-UIIcon-ChevronDownMedium spectrum-Dropdown-icon" focusable="false" >
//       <use xlink:href="#spectrum-css-icon-ChevronDownMedium" />
//     </svg>
//   </button>
//   <div class="spectrum-Popover spectrum-Popover--bottom spectrum-Dropdown-popover is-open" style="width: 100%">
//     <ul class="spectrum-Menu" role="listbox">
//       <li class="spectrum-Menu-item is-selected" role="option"  tabindex="0">
//         <span class="spectrum-Menu-itemLabel">Ballard</span>
//         <svg class="spectrum-Icon spectrum-UIIcon-CheckmarkMedium spectrum-Menu-checkmark" focusable="false" >
//           <use xlink:href="#spectrum-css-icon-CheckmarkMedium" />
//         </svg>
//       </li>
//       <li class="spectrum-Menu-item" role="option" tabindex="0">
//         <span class="spectrum-Menu-itemLabel">Fremont</span>
//       </li>
//       <li class="spectrum-Menu-item" role="option" tabindex="0">
//         <span class="spectrum-Menu-itemLabel">Greenwood</span>
//       </li>
//       <li class="spectrum-Menu-divider" role="separator"></li>
//       <li class="spectrum-Menu-item is-disabled" role="option" >
//         <span class="spectrum-Menu-itemLabel">United States of America</span>
//       </li>
//     </ul>
//   </div>
// </div>

// <div class="dummy-spacing"></div>

// <h4>With Thumbnails</h4>
// <div class="spectrum-Dropdown is-open" style="width: 240px;">
//   <button class="spectrum-FieldButton spectrum-Dropdown-trigger is-selected" >
//     <svg class="spectrum-Icon spectrum-Icon--sizeS" focusable="false" >
//       <use xlink:href="#spectrum-icon-18-Image" />
//     </svg>
//     <span class="spectrum-Dropdown-label">Ballard</span>
//     <svg class="spectrum-Icon spectrum-UIIcon-ChevronDownMedium spectrum-Dropdown-icon" focusable="false" >
//       <use xlink:href="#spectrum-css-icon-ChevronDownMedium" />
//     </svg>
//   </button>
//   <div class="spectrum-Popover spectrum-Popover--bottom spectrum-Dropdown-popover is-open" style="width: 100%">
//     <ul class="spectrum-Menu" role="listbox">
//       <li class="spectrum-Menu-item is-selected" role="option" tabindex="0">
//         <svg class="spectrum-Icon spectrum-Icon--sizeS" focusable="false" >
//           <use xlink:href="#spectrum-icon-18-Image" />
//         </svg>
//         <span class="spectrum-Menu-itemLabel">Ballard</span>
//         <svg class="spectrum-Icon spectrum-UIIcon-CheckmarkMedium spectrum-Menu-checkmark" focusable="false" >
//           <use xlink:href="#spectrum-css-icon-CheckmarkMedium" />
//         </svg>
//       </li>
//       <li class="spectrum-Menu-item" role="option" tabindex="0">
//         <svg class="spectrum-Icon spectrum-Icon--sizeS" focusable="false" >
//           <use xlink:href="#spectrum-icon-18-Image" />
//         </svg>
//         <span class="spectrum-Menu-itemLabel">Fremont</span>
//       </li>
//       <li class="spectrum-Menu-item" role="option" tabindex="0">
//         <svg class="spectrum-Icon spectrum-Icon--sizeS" focusable="false" >
//           <use xlink:href="#spectrum-icon-18-Image" />
//         </svg>
//         <span class="spectrum-Menu-itemLabel">Greenwood</span>
//       </li>
//       <li class="spectrum-Menu-divider" role="separator"></li>
//       <li class="spectrum-Menu-item is-disabled" role="option" >
//         <svg class="spectrum-Icon spectrum-Icon--sizeS" focusable="false" >
//           <use xlink:href="#spectrum-icon-18-Image" />
//         </svg>
//         <span class="spectrum-Menu-itemLabel">United States of America</span>
//       </li>
//     </ul>
//   </div>
// </div>

// <div class="dummy-spacing"></div>

// <h4>Disabled</h4>
// <div class="spectrum-Dropdown is-disabled" style="width: 240px;">
//   <button class="spectrum-FieldButton spectrum-Dropdown-trigger" disabled >
//     <span class="spectrum-Dropdown-label is-placeholder">Select a Country</span>
//     <svg class="spectrum-Icon spectrum-UIIcon-ChevronDownMedium spectrum-Dropdown-icon" focusable="false" >
//       <use xlink:href="#spectrum-css-icon-ChevronDownMedium" />
//     </svg>
//   </button>
// </div>

// <h4>Closed</h4>
// <div class="spectrum-Dropdown is-invalid" style="width: 240px;">
//   <button class="spectrum-FieldButton spectrum-Dropdown-trigger is-invalid" >
//     <span class="spectrum-Dropdown-label is-placeholder">Select a Country</span>
//     <svg class="spectrum-Icon spectrum-Icon--sizeS" focusable="false" >
//       <use xlink:href="#spectrum-icon-18-Alert" />
//     </svg>
//     <svg class="spectrum-Icon spectrum-UIIcon-ChevronDownMedium spectrum-Dropdown-icon" focusable="false" >
//       <use xlink:href="#spectrum-css-icon-ChevronDownMedium" />
//     </svg>
//   </button>
// </div>

// <h4>Open</h4>
// <div class="spectrum-Dropdown is-open is-invalid" style="width: 240px;">
//   <button class="spectrum-FieldButton spectrum-Dropdown-trigger is-invalid is-selected" >
//     <span class="spectrum-Dropdown-label">Ballard</span>
//     <svg class="spectrum-Icon spectrum-Icon--sizeS" focusable="false" >
//       <use xlink:href="#spectrum-icon-18-Alert" />
//     </svg>
//     <svg class="spectrum-Icon spectrum-UIIcon-ChevronDownMedium spectrum-Dropdown-icon" focusable="false" >
//       <use xlink:href="#spectrum-css-icon-ChevronDownMedium" />
//     </svg>
//   </button>
//   <div class="spectrum-Popover spectrum-Popover--bottom spectrum-Dropdown-popover is-open" style="width: 100%">
//     <ul class="spectrum-Menu" role="listbox">
//       <li class="spectrum-Menu-item is-selected" role="option"  tabindex="0">
//         <span class="spectrum-Menu-itemLabel">Ballard</span>
//         <svg class="spectrum-Icon spectrum-UIIcon-CheckmarkMedium spectrum-Menu-checkmark" focusable="false" >
//           <use xlink:href="#spectrum-css-icon-CheckmarkMedium" />
//         </svg>
//       </li>
//       <li class="spectrum-Menu-item" role="option" tabindex="0">
//         <span class="spectrum-Menu-itemLabel">Fremont</span>
//       </li>
//       <li class="spectrum-Menu-item" role="option" tabindex="0">
//         <span class="spectrum-Menu-itemLabel">Greenwood</span>
//       </li>
//       <li class="spectrum-Menu-divider" role="separator"></li>
//       <li class="spectrum-Menu-item is-disabled" role="option" >
//         <span class="spectrum-Menu-itemLabel">United States of America</span>
//       </li>
//     </ul>
//   </div>
// </div>

// <div class="dummy-spacing"></div>

// <h4>Disabled</h4>
// <div class="spectrum-Dropdown is-invalid is-disabled" style="width: 240px;">
//   <button class="spectrum-FieldButton spectrum-Dropdown-trigger is-invalid" disabled >
//     <span class="spectrum-Dropdown-label is-placeholder">Select a Country</span>
//     <svg class="spectrum-Icon spectrum-Icon--sizeS" focusable="false" >
//       <use xlink:href="#spectrum-icon-18-Alert" />
//     </svg>
//     <svg class="spectrum-Icon spectrum-UIIcon-ChevronDownMedium spectrum-Dropdown-icon" focusable="false" >
//       <use xlink:href="#spectrum-css-icon-ChevronDownMedium" />
//     </svg>
//   </button>
// </div