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
  import org.apache.royale.html.elements.Li;
  import org.apache.royale.html.TextNodeContainerBase;
  [Event(name="children", type="org.apache.royale.events.Event")]
  public class TabOverflow extends Group
  {
    public function TabOverflow() 
    {
      super();
      COMPILE::JS
      {
     
        addEventListener("tabs",tabsArray);
      }
     
    }

    override protected function getSelector():String{
      return "spectrum-Tabs" ;
    }

    private var dropDownDiv:HTMLElement;
    private var dropButton:HTMLElement;
    private var dropSpan:TextNode;
    private var dropIcon:Icon;
    private var popIcon:Icon;
    private var indicator:HTMLElement;
    private var dropPop:Popover;
    private var dropList:HTMLElement;
    private var dropItem:HTMLElement;
    private var dropItemSpan:HTMLElement;
    private var _compact:Boolean;
    private var _disabled:Boolean;
    private var tabs:Array;
    COMPILE::JS
    public var child:HTMLElement;
    COMPILE::SWF
    public var child:Object;
    private var _selected:Object;


    public function get selected():Object
    {
    	return _selected;
    }

    public function set selected(value:Object):void
    { 
      if(!value){
        _selected = tabs[0];
    }
    	_selected = value;
      dropSpan.text = selected.textContent;
      for(var i:Number = 0;i<dropList.children.length;i++){
        if(dropList.children.item(i).classList.contains("is-selected")){
          dropList.children.item(i).classList.remove("is-selected");
          if((selected as HTMLElement).parentElement.classList.contains("spectrum-Menu-item")){//sometimes the ev.value IS the parent. //depending if you click on the div or the span
            (selected as HTMLElement).parentElement.classList.add("is-selected");
          }
          else{
            (selected as HTMLElement).classList.add("is-selected");
          }
        }
      }
    }

       
    private function toggleDropdown():void{
      if(!dropDownDiv.classList.contains("is-open")){
           dropDownDiv.classList.add("is-open");
           createPopOver();
           return;
      }
     else if(dropDownDiv.classList.contains("is-open") ){
       dropDownDiv.classList.remove("is-open");
       dropDownDiv.children[0].children[0].remove();
      }
    }
  
    private function fillDrop():void
    {
      for(var i:Number=0;i<tabs.length;i++){
      dropItem = tabs[i].element;
      dropItem.onclick = selectedItem;
      dropList.appendChild(dropItem);
      }
      COMPILE::JS{
      dropPop.element.appendChild(dropList);
      }
    
    popIcon = new Icon("#spectrum-css-icon-CheckmarkMedium");
    popIcon.className = "spectrum-Icon spectrum-UIIcon-CheckmarkMedium spectrum-Menu-checkmark";
    addElement(popIcon); 
    popIcon.addedToParent(); //need this?
    COMPILE::JS{
    dropButton.appendChild(dropPop.element);
    }
    }


  private function selectedItem(ev:*):void
    {
      selected = ev.target;
    }
      
      
    private function createPopOver():void{ 
      dropPop = new Popover();
      dropPop.className = "spectrum-Popover spectrum-Popover--bottom spectrum-Dropdown-popover";
      COMPILE::JS
      {
      dropPop.element.classList.add("spectrum-Dropdown-popover--quiet");
      dropPop.element.classList.add("is-open");
      }
     
      var popStyle:String = "display: block; margin-left: -5px; margin-top: -9px;";
      COMPILE::JS
      {
      dropPop.element.setAttribute("style",popStyle);
      dropList = newElement('ul'); 
      }
      fillDrop();
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
      COMPILE::JS{
        var dummySpace:HTMLElement = newElement('div');
        dummySpace.className= "dummy-spacing";
        element.appendChild(dummySpace);
      }
    }

    COMPILE::JS
    private function tabsArray(ev:ValueEvent):void
    {
      tabs = ev.value;
      dropSpan.text = tabs[0].text; 
    }

    COMPILE::JS
    override protected function createElement():WrappedHTMLElement 
    {   
        addElementToWrapper(this,'div');
        element.classList.add("spectrum-Tabs--horizontal");//dunno if possibility to be vertical.
        var elemStyle:String = "width: 409px";
        element.setAttribute("style",elemStyle);
        dropDownDiv = newElement('div');
        dropDownDiv.className = "spectrum-Dropdown"; 
        dropDownDiv.classList.add("spectrum-Dropdown--quiet");
        dropButton = newElement("button");
        dropButton.className = "spectrum-FieldButton";
        dropButton.classList.add("spectrum-FieldButton--quiet");
        dropButton.classList.add("spectrum-Dropdown-trigger");
        dropButton.addEventListener("click",toggleDropdown)
        dropDownDiv.appendChild(dropButton);
        dropSpan = new TextNode("span");
        dropSpan.className = "spectrum-Dropdown-label";
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