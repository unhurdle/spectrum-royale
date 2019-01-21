package com.unhurdle.spectrum
{
  COMPILE::JS
  {
  import org.apache.royale.html.util.addElementToWrapper;
  import org.apache.royale.core.WrappedHTMLElement;
  import org.apache.royale.events.ValueEvent;}
  import org.apache.royale.events.IEventDispatcher;
  import org.apache.royale.events.ValueEvent;
  import com.unhurdle.spectrum.const.IconPrefix;
  import com.unhurdle.spectrum.const.IconSize;
  import org.apache.royale.events.Event;
  public class TabOverflow extends Group
  {
    public function TabOverflow() 
    {
      super();
    }

    override protected function getSelector():String{
      return "spectrum-Tabs" ;
    }

    private var dropDownDiv:HTMLElement; //dropDown element?
    private var dropButton:HTMLElement;
    private var dropSpan:TextNode;
    private var dropIcon:Icon;
    private var popIcon:Icon;
    private var indicator:HTMLElement;
    private var dropPop:Popover;
    private var dropList:HTMLElement;
    private var dropItem:HTMLElement;
    private var _compact:Boolean;
    private var _disabled:Boolean;
    private var tabsArray:Array;

    // private var _text:String;
    // public function get text():String
    // {
    // 	return _text;
    // }
    // public function set text(value:String):void
    // {
    // 	_text = value;
    //   dropSpan.text = _text;
    // }

    private var _selected:Boolean;

    public function get selected():Boolean
    {
    	return _selected;
    }

    public function set selected(value:Boolean):void
    {
    	_selected = value;
      dropItem.classList.add("is-selected"); //needs 2b single selection
      // dropItem.classList.remove("is-selected"); //find the time 
    }

    public function openDropDown():void{
      dropDownDiv.classList.add("is-open");
      dropButton.classList.add("is-selected");
      createPopOver();
    }

    private function fillDrop():void
    {
    dropItem = newElement('li');
    dropItem.className = "spectrum-Menu-item";
    dropItem.setAttribute("role","option");
    dropItem.tabIndex = 0;
    dropItem.addEventListener("click",selected); //not smart
    popIcon = new Icon("#spectrum-css-icon-CheckmarkMedium");
    popIcon.className = "spectrum-Menu-itemLabel";
    addElement(popIcon); 
    popIcon.addedToParent(); //need this?
    dropList.appendChild(dropItem);
    //get the tabsArray 
    //create a dropDownListItem for each of them //need a loop
    //send to another function that will allow for a click on the tab requested to open that tab
    //text of the dropItem is the name of the tab element [i] of the tabArray
    //*************************************************************************************************************************** */
    //*************************************************************************************************************************** */
    // for(var i:Number = 0;i<tabsArray.length;i++){ 
    // need to set the tabsArray[i] to be the element opened when dropItem is pressed
    //dropItem.text = tabsArray[i].text //name of tab
    // dropItem = newElement('li');
    // dropItem.className = "spectrum-Menu-item";
    // dropItem.setAttribute("role","option");
    // dropItem.tabIndex = 0;
    // dropItem.addEventListener("click",selected); //not smart
    // popIcon = new Icon("#spectrum-css-icon-CheckmarkMedium");
    // popIcon.className = "spectrum-Menu-itemLabel";
    // addElement(popIcon); 
    // popIcon.addedToParent(); //need this?
    // dropList.appendChild(dropItem);
    // }
     //*************************************************************************************************************************** */
     //*************************************************************************************************************************** */
    }

    public function createPopOver():void{ //markup for popOver here
      dropPop = new Popover();
      dropPop.className = "spectrum-Popover spectrum-Popover--bottom spectrum-Dropdown-popover";
      dropPop.element.classList.add("spectrum-Dropdown-popover--quiet");
      dropPop.element.classList.add("is-open");
      var popStyle:String = "display: block; margin-left: -5px; margin-top: -9px;";
      dropPop.element.setAttribute("style",popStyle);
      dropList = newElement('ul'); 
      fillDrop();
      dropPop.element.appendChild(dropList);
      dummySpacing();
      }

    public function get compact():Boolean
    {
      return _compact;
    }
    
    COMPILE::JS
    public function set compact(value:Boolean):void 
    {
      if(value != !!_compact){
      element.classList.add("spectrum-Tabs--compact");
      _compact = value;
        }
    }
     
    public function get disabled():Boolean
    {
      return _disabled;
    }

    public function set disabled(value:Boolean):void
    {
      _disabled = value;
      dropItem.classList.add("is-disabled");
    }
    private function dummySpacing():void //what is this
    {
      var dummySpace:HTMLElement = newElement('div');
      dummySpace.className= "dummy-spacing";
       element.appendChild(dummySpace);
      
     
    }

COMPILE::JS
    override protected function createElement():WrappedHTMLElement 
    {
        addElementToWrapper(this,'div');
        element.classList.add(element.classList.add("spectrum-Tabs--horizontal"));//dunno if possibility to be vertical.
        var elemStyle:String = "width: 409px";
        element.setAttribute("style",elemStyle);
        dropDownDiv = newElement('div');
        dropDownDiv.className = "spectrum-Dropdown"; 
        dropDownDiv.classList.add("spectrum-Dropdown--quiet");
        dropButton = newElement("button");
        dropButton.className = "spectrum-FieldButton";
        dropButton.classList.add("spectrum-FieldButton--quiet");
        dropButton.classList.add("spectrum-Dropdown-trigger");
        dropButton.onclick = openDropDown;
        dropDownDiv.appendChild(dropButton);
        dropSpan = new TextNode("span");
        dropSpan.className = "spectrum-Dropdown-label";
        // dropSpan.text  //needs to be the dropDown selected cell name 
        dropDownDiv.appendChild(dropSpan.element);
        dropIcon = new Icon("#spectrum-css-icon-ChevronDownMedium");
        dropIcon.className = "spectrum-Icon spectrum-UIIcon-ChevronDownMedium spectrum-Dropdown-icon";
        addElement(dropIcon); 
        dropIcon.addedToParent(); //need this?
        element.appendChild(dropDownDiv);
        indicator = newElement('div');
        indicator.className = "spectrum-Tabs-selectionIndicator";
        var indStyle:String = "width: 50px; left: 8px;";
        indicator.setAttribute("style",indStyle);
        element.appendChild(indicator);
        return element;
    }
  }
}