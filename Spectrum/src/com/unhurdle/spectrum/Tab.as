package com.unhurdle.spectrum
{
  COMPILE::JS
  {
    import org.apache.royale.html.util.addElementToWrapper;
    import org.apache.royale.core.WrappedHTMLElement;
  }
    import org.apache.royale.events.IEventDispatcher;
    import org.apache.royale.events.ValueEvent;
    import com.unhurdle.spectrum.const.IconPrefix;
    import com.unhurdle.spectrum.const.IconSize;
    import org.apache.royale.events.Event;
[Event(name="childrenAdded", type="org.apache.royale.events.Event")]
  public class Tab extends SpectrumBase
  {
    public function Tab()
    {
      super();
      // typeNames = "spectrum-Tabs-item"
    }
    // override protected function getSelector():String{
    //   return "spectrum-Tabs-item";
    // }
    private var label:TextNode;
    private var icon:Icon;
    private var _iconType:String;
    private var indicator:HTMLElement;
    private var overflowButton:HTMLElement;
    private var overflowIcon:Icon;
    
    COMPILE::JS
    private var elem:WrappedHTMLElement;
    COMPILE::SWF
    private var elem:Object;

    private var _text:String;

    public function get text():String
    {
    	return _text;
    }

    public function set text(value:String):void
    {
    	_text = value;
      label.text = _text;
    }

    public function get iconType():String
    {
    	return _iconType;
    }

    public function set iconType(value:String):void
    {
      if(value){
         switch(value){
          case "Folder":
          case "Image":
          case "Filter":
          case "Comment":
          break;
          default:
            throw new Error("Invalid icon: " + value);
        }
        icon = new Icon(IconPrefix._18 + value); //should really have getters and setters
        icon.size = IconSize.S;
        addElement(icon); //really its there but the SVGIcon doesnt exist.. 
        icon.addedToParent(); //need this?
      }
    	_iconType = value;
    }
     public function set selected(value:Boolean):void{ //selected
      COMPILE::JS
      {
        if(value){
          toggle("is-selected",value);
        } 
      }
    }
    COMPILE::JS
    override protected function createElement():WrappedHTMLElement
    { 
      
      elem = addElementToWrapper(this,'div');
      elem.className = "spectrum-Tabs-item" //wasnt adding the className with getSelector() or typeNames
      // var widthAttribute:String = "width:7%;";
      // elem.setAttribute("style",widthAttribute);
      label = new TextNode("label");
      label.className = "spectrum-Tabs-itemLabel";
      elem.appendChild(label.element);
      this.dispatchEvent(new ValueEvent("childrenAdded", elem));
      return elem;
    }
  }
}