package com.unhurdle.spectrum.renderers
{
  COMPILE::JS
  {
    import org.apache.royale.html.util.addElementToWrapper;
    import org.apache.royale.core.WrappedHTMLElement;
  }
  import org.apache.royale.html.supportClasses.DataItemRenderer;
  import com.unhurdle.spectrum.data.AssetListItem;
  import com.unhurdle.spectrum.newElement;
  import com.unhurdle.spectrum.CheckBox;
  import com.unhurdle.spectrum.TextNode;
  import com.unhurdle.spectrum.Icon;
  import com.unhurdle.spectrum.const.IconPrefix;
  import com.unhurdle.spectrum.const.IconSize;
  import com.unhurdle.spectrum.const.IconType;
  import org.apache.royale.events.IEventDispatcher;
  import org.apache.royale.events.ValueEvent;
  import org.apache.royale.html.util.getLabelFromData;

  public class AssetListItemRenderer extends DataItemRenderer
  {
    public function AssetListItemRenderer()
    {
      super();
      typeNames = '';
    }
    protected function appendSelector(value:String):String{
      return "spectrum-AssetList" + value;
    }
    override public function updateRenderer():void{
      // do nothing
    }

    COMPILE::JS
    override public function set data(value:Object):void{
      super.data = value;
      var assetListItem:AssetListItem;
      assetListItem = value as AssetListItem;
      span.text = getLabelFromData(this,value);
      element.className = appendSelector("-item");
      if(assetListItem.selectable){
        element.classList.add("is-selectable");
      }
      if(assetListItem.src){
        src = assetListItem.src;
      }
      if(assetListItem.iconType){
        iconType = assetListItem.iconType;
      }
      if(assetListItem.isBranch){
        (element as HTMLElement).classList.add("is-branch");
      }
      (element as HTMLElement).classList.toggle("is-selected",false);
      // addEventListener("itemClicked",itemClicked);
      
    }
    override public function set selected(value:Boolean):void{
      super.selected = value;
      COMPILE::JS
      {
        if(value){
          (parent as IEventDispatcher).dispatchEvent(new ValueEvent("itemClicked",data));
        } 
      }
    }
    private var image:HTMLImageElement;
    private var span:TextNode;
    private var iconImage:Icon;
    private var checkBox:CheckBox;
    COMPILE::JS
    override protected function createElement():WrappedHTMLElement
    {
      var elem:WrappedHTMLElement = addElementToWrapper(this,'li');

      checkBox = new CheckBox();
      checkBox.className += appendSelector("-itemSelector");
      addElement(checkBox);

      span = new TextNode("span");
      span.className = appendSelector("-itemLabel");
      elem.appendChild(span.element);

      var type:String = IconType.CHEVRON_RIGHT_MEDIUM;
      var icon:Icon = new Icon(Icon.getCSSTypeSelector(type));
      icon.type = type;
      icon.className = appendSelector("-itemChildIndicator");
      addElement(icon);
      
      addEventListener("click",itemClicked);
      return elem;
    }

    public function get src():String
    {
      if(image)
    	  return image.src;
      return "";
    }
    COMPILE::SWF
    public function set src(value:String):void{}

    COMPILE::JS
    public function set src(value:String):void
    {
      if(iconImage){
        element.removeChild(iconImage.element);
      }
      if(!image){
        image = newElement("img") as HTMLImageElement;
        image.className = appendSelector("-itemThumbnail");
        element.insertBefore(image,span.element);
      }
      image.src = value;
    }
    private var _iconType:String;

    public function get iconType():String
    {
    	return _iconType;
    }

    public function set iconType(value:String):void
    {
      if(image){
        (element as HTMLElement).removeChild(image);
      }
      if(!iconImage){
        iconImage = new Icon(IconPrefix._24 + value);
        iconImage.size = IconSize.M;
        iconImage.className = appendSelector("-itemThumbnail");
        (element as HTMLElement).insertBefore(iconImage.element as HTMLElement,span.element as HTMLElement);
      }
      else{
        iconImage.selector = IconPrefix._24 + value;
      }
    	_iconType = value;
    }

    private function itemClicked(ev:*):void
    {
      checkBox.checked = (element as HTMLElement).classList.toggle("is-selected");
    }
  }
}