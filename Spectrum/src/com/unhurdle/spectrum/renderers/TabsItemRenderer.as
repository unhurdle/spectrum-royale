package com.unhurdle.spectrum.renderers
{
  import org.apache.royale.html.supportClasses.DataItemRenderer;
  import com.unhurdle.spectrum.TextNode;
  
  COMPILE::JS
  {
    import org.apache.royale.html.util.addElementToWrapper;
    import org.apache.royale.core.WrappedHTMLElement;
  }

  import org.apache.royale.events.ValueEvent;
  import org.apache.royale.events.IEventDispatcher;
  import com.unhurdle.spectrum.data.TabsItem;
  import org.apache.royale.html.util.getLabelFromData;
  import com.unhurdle.spectrum.Icon;
  import org.apache.royale.core.CSSClassList;
  import com.unhurdle.spectrum.const.IconPrefix;
  import com.unhurdle.spectrum.const.IconSize;
  import com.unhurdle.spectrum.newElement;
  import com.unhurdle.spectrum.Tabs;

  
  public class TabsItemRenderer extends DataItemRenderer
  {
    public function TabsItemRenderer()
    {
      super();
      typeNames = getSelector();
    }
 
    //from spectrumBase
    public function getSelector():String{
      return "spectrum-Tabs-item";
    }
    protected var classList:CSSClassList;
    //from spectrumBase but added in elem before .add and .remove
    protected function toggle(classNameVal:String,add:Boolean):void
    {
      COMPILE::JS
      {
        add ? elem.classList.add(classNameVal) : elem.classList.remove(classNameVal);
        setClassName(computeFinalClassNames());
      }
    }
		override public function updateRenderer():void{
      // do nothing
    }
    private var label:TextNode;
    private var icon:Icon;
    private var iconType:String;
    private var tabs:Tabs = new Tabs();
    private var indicator:HTMLElement;
    private var overflowButton:HTMLElement;
    private var overflowIcon:Icon;
    // private var tabArray:Array = new Array();
    
    COMPILE::JS
    private var elem:WrappedHTMLElement;
    COMPILE::SWF
    private var elem:Object;
    COMPILE::JS
    override public function set data(value:Object):void{
      super.data = value
      var tabsItem:TabsItem;
      tabsItem = value as TabsItem;
      label.text = getLabelFromData(this,value);
      iconType = value.icon;
      if(iconType){
        switch(iconType){
          case "Folder":
          case "Image":
          case "Filter":
          case "Comment":
          break;
          default:
            throw new Error("Invalid icon: " + iconType);
        }
        icon = new Icon(IconPrefix._18 + iconType); //should really have getters and setters
        icon.size = IconSize.S;
        addElement(icon); //really its there but the SVGIcon doesnt exist.. 
        icon.addedToParent(); //need this?
      }
    }

    override public function set selected(value:Boolean):void{
      super.selected = value;
      COMPILE::JS
      {
        if(value){
          (parent as IEventDispatcher).dispatchEvent(new ValueEvent("itemClicked",data));
          toggle("is-selected",value);
        } 
      }
    }
    public function overflow():void{ //overfow tabs - but 2 diff....
      // overflowButton = newElement('button') as HTMLButtonElement; //this is for one of the versions
      // overflowIcon = new Icon(IconPrefix._18 + "-More"); 
      // overflowIcon.className = "spectrum-Icon spectrum-Icon--sizeS"
      // addElement(overflowIcon); 
      // overflowIcon.addedToParent(); //need this?
      // elem.appendChild(overflowButton);
      // overflowButton.addEventListener("click",fillTabBar);
      
    }

    // public function fillTabBar():void{
      
    //   //display all the tabs into the tabBar
    // }
   
    COMPILE::JS
    override protected function createElement():WrappedHTMLElement
    {
      elem = addElementToWrapper(this,'div');
      var widthAttribute:String = "width:5%;";
      elem.setAttribute("style",widthAttribute);
      label = new TextNode("label");
      label.className = "spectrum-Tabs-itemLabel";
      elem.appendChild(label.element);
      elem.addEventListener("overflow",overflow); //for overflow tabs //here? 
      // if(!tabs.internalChildren){
      // indicator = newElement('div');
      // var styleStr:String = "height: 46px; top: 0px;"
      // indicator.setAttribute("style",styleStr);
      // element.appendChild(indicator);  
      // }
      return elem;
 
    }


  
      
   
  }
}

