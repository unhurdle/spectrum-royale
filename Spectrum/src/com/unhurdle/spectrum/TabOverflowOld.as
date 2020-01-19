package com.unhurdle.spectrum
{
  COMPILE::JS
  {
  import org.apache.royale.core.WrappedHTMLElement;
  import org.apache.royale.events.ValueEvent;
  import org.apache.royale.html.util.addElementToWrapper;
  }
  import org.apache.royale.events.ValueEvent;
  [Event(name="children", type="org.apache.royale.events.Event")]
  public class TabOverflowOld extends Group
  {
    public function TabOverflowOld() 
    {
      super();
      COMPILE::JS
      {
        addEventListener("tabs",tabsArray);
      }
    }

    override protected function getSelector():String
    {
      return getTabsSelector() + direction; //direction
    }

    override protected function appendSelector(value:String):String{
      return getSelector() + value;
    }
    
    private var dropDownDiv:HTMLElement; 
    private var dropButton:HTMLElement; 
    private var dropSpan:TextNode; 
    private var indicator:HTMLElement; 
    private var dropPop:Popover; 
    private var dropList:HTMLElement; 
    private var dropItem:HTMLElement;
    private var _compact:Boolean;
    private var _disabled:Boolean;
    private var tabs:Array;
    private var _selectedTab:Object;
    private var direction:String;


    public function get selectedTab():Object
    {
    	return _selectedTab;
    }

    public function set selectedTab(value:Object):void
    { 
      if(!value){
        _selectedTab = tabs[0];
    }
    	_selectedTab = value;
      dropSpan.text = selectedTab.textContent;
      // (selectedTab as Tab).selected = true;

     

          // if((selected as HTMLElement).parentElement.classList.contains("spectrum-Menu-item")){ //deal with 
          //   (selected as HTMLElement).parentElement.classList.add("is-selected");
          // }
          // else{
          //   (selected as HTMLElement).classList.add("is-selected");
          // }
        
      
    }

       
    private function toggleDropdown():void{
      if(!dropDownDiv.classList.contains("is-open")){
        dropDownDiv.classList.add("is-open");
        removeIndicator();
        createPopOver();
        return;
      }
     else if(dropDownDiv.classList.contains("is-open") ){
       dropDownDiv.classList.remove("is-open");
       dropDownDiv.children[0].children[0].remove();
       addIndicator();
      }
    }

    private function checkForSelectedTag():void
    { 
      COMPILE::JS
      {
        for(var i:Number=0;i<tabs.length;i++){
        if(tabs[i].selected){
          tabs[i].selected == false;
          removeSelectedIndicator(tabs[i]);
        }
      }
      }
      
    }
    private function removeSelectedIndicator(tab:Object):void
    {
      for (var i:int =0;i<tab.element.children.length;i++){
        if(tab.element.children[i].classList.contains("spectrum-Tabs-selectionIndicator")){
            tab.element.children[i].remove();
          }
      }
    }
    private function fillDrop():void
    {
      for(var i:Number=0;i<tabs.length;i++){
      // checkForSelectedTag(tabs[i]);
      dropItem = tabs[i].element;
      dropItem.onclick = selectedItem;
      dropList.appendChild(dropItem);
      }
      COMPILE::JS{
      dropPop.element.appendChild(dropList);
      }
    
    var popIcon:Icon = new Icon("#spectrum-css-icon-CheckmarkMedium");
    popIcon.className = "spectrum-Icon spectrum-UIIcon-CheckmarkMedium spectrum-Menu-checkmark";
    addElement(popIcon); 
    popIcon.addedToParent(); //need this?
    COMPILE::JS{
    dropButton.appendChild(dropPop.element);
    }
    }


  private function selectedItem(ev:*):void //*?
    {
      selectedTab = ev.currentTarget; //.target
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
      checkForSelectedTag();
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
        direction = " spectrum-Tabs--horizontal";
        element.className = appendSelector("");;
        var elemStyle:String = "width: 409px";
        element.setAttribute("style",elemStyle);

        dropDownDiv = newElement('div');
        dropDownDiv.className = "spectrum-Dropdown"; 
        dropDownDiv.classList.add("spectrum-Dropdown--quiet");

        dropButton = newElement("button");
        dropButton.className = "spectrum-FieldButton";
        dropButton.classList.add("spectrum-FieldButton--quiet");
        dropButton.classList.add("spectrum-Dropdown-trigger");
        dropButton.addEventListener("click",toggleDropdown);

        dropDownDiv.appendChild(dropButton);

        dropSpan = new TextNode("span");
        dropSpan.className = "spectrum-Dropdown-label";

        dropDownDiv.appendChild(dropSpan.element);

        var dropIcon:Icon = new Icon("#spectrum-css-icon-ChevronDownMedium");
        dropIcon.className = "spectrum-Icon spectrum-UIIcon-ChevronDownMedium spectrum-Dropdown-icon";
        addElement(dropIcon); 
        dropIcon.addedToParent(); 

        element.appendChild(dropDownDiv);
        
        addIndicator();

        return element;
    }

    private function removeIndicator():void
    {
      COMPILE::JS
      {
        for (var i:int = 0;i<element.children.length;i++){
          if(element.children[i].classList.contains("spectrum-Tabs-selectionIndicator")){
            element.children[i].remove();
          }
        }
      }
      
    }

    private function addIndicator():void
    { 
      COMPILE::JS
      {
      var indicator:TabIndicator = new TabIndicator();
      var styleStr:String = "width: 50px; left: 8px;";
      indicator.setAttribute("style",styleStr);
      addElement(indicator);
      }
    }
      
  }
}