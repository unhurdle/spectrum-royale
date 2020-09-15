package com.unhurdle.spectrum.renderers
{
  import org.apache.royale.html.util.getLabelFromData;
  import com.unhurdle.spectrum.TextNode;
  import com.unhurdle.spectrum.Icon;

  COMPILE::JS
  {
    import org.apache.royale.html.util.addElementToWrapper;
    import org.apache.royale.core.WrappedHTMLElement;
  }
  import com.unhurdle.spectrum.ImageIcon;
  import com.unhurdle.spectrum.data.IListItem;
  import org.apache.royale.core.IListDataItemRenderer;
  import org.apache.royale.core.IParent;

  public class ListItemRenderer extends DataItemRenderer implements IListDataItemRenderer
  {
    public function ListItemRenderer()
    {
      super();
      typeNames = appendSelector('-item');
    }
    override protected function getSelector():String{
      return "spectrum-SideNav";
    }

    private var _listData:Object;
    
    [Bindable("__NoChangeEvent__")]
    /**
     *  Additional data about the list structure the itemRenderer may
     *  find useful.
     *
     *  @langversion 3.0
     *  @playerversion Flash 10.2
     *  @playerversion AIR 2.6
     *  @productversion Royale 0.0
     */
    public function get listData():Object
    {
      return _listData;
    }
    public function set listData(value:Object):void
    {
      _listData = value;
    }

		// override public function updateRenderer():void{
    //   COMPILE::JS
    //   {
    //     // Hover is handled by the css classes
		// 		if (selected){
		// 			element.style.backgroundColor = Application.getSelectionColor();
    //       element.style.color = "#FFFFFF";
    //     } else {
    //       element.style.backgroundColor = null;
    //       element.style.color = null
    //     }

    //   }
    // }
    protected var firstElementPosition:Number = 0;
    protected function get iconParent():IParent{
      return this;
    }
    override public function set data(value:Object):void{
      super.data = value;
     setText(getLabelFromData(this,value));
      COMPILE::JS
      {
        var iconSelector:String = getIconSelector();
        if(iconSelector){
          if(!icon){
            icon = new Icon(iconSelector);
            iconParent.addElementAt(icon,firstElementPosition);
          } else {
            icon.setStyle("display",null);
            icon.selector = iconSelector;
          }
        } else if(icon){
          icon.setStyle("display","none");
        }
        
        var iconSrc:String = getImageIcon();
        if(iconSrc){
          if(!imageIcon){
            imageIcon = new ImageIcon(iconSrc);
            iconParent.addElementAt(imageIcon,firstElementPosition);
          } else {
            imageIcon.setStyle("display",null);
            imageIcon.src = iconSrc;
          }
        } else if(imageIcon){
          imageIcon.setStyle("display","none");
        }
      }
    }
    protected function setText(value:String):void{
       textNode.text = value;
    }
    private function getIconSelector():String{
      if(data is IListItem){
        return (data as IListItem).icon;
      }
      return data["icon"];
    }
    private function getImageIcon():String{
      if(data is IListItem){
        return (data as IListItem).imageIcon;
      }
      return data["imageIcon"];
    }
    protected var icon:Icon;
    protected var imageIcon:ImageIcon;
    protected var textNode:TextNode;

    override protected function getTag():String{
      return "li";
    }
    COMPILE::JS
    override protected function createElement():WrappedHTMLElement
    {
      var elem:WrappedHTMLElement = super.createElement();
      textNode = new TextNode("span");
      textNode.className = appendSelector("-itemLink");
      textNode.element.style.userSelect = "none";
      textNode.element.style.display = "inline-flex";
      elem.appendChild(textNode.element);
      // setStyle("cursor","default");
      return elem;
    }

  }
}