package com.unhurdle.spectrum.renderers
{

  import com.unhurdle.spectrum.TextNode;
  import com.unhurdle.spectrum.Icon;
  import org.apache.royale.html.util.getLabelFromData;
  import com.unhurdle.spectrum.data.BreadcrumbsItem;

  COMPILE::JS
  {
    import org.apache.royale.html.util.addElementToWrapper;
    import org.apache.royale.core.WrappedHTMLElement;
  }
  import com.unhurdle.spectrum.newElement;
  import org.apache.royale.events.ValueEvent;
  import org.apache.royale.events.IEventDispatcher;
  import com.unhurdle.spectrum.const.IconType;
  import org.apache.royale.events.MouseEvent;
  import com.unhurdle.spectrum.ActionButton;
  import com.unhurdle.spectrum.const.IconPrefix;
  
  public class BreadcrumbsItemRenderer extends DataItemRenderer
  {
    public function BreadcrumbsItemRenderer()
    {
      super();
    }
    override protected function getSelector():String{
      return "spectrum-Breadcrumbs";
    }

    override public function set tabFocusable(value:Boolean):void{
          
    }

    COMPILE::JS
    override public function set data(value:Object):void{
      super.data = value
      var breadCrumbsItem:BreadcrumbsItem;
      breadCrumbsItem = value as BreadcrumbsItem;
      textNode.text = getLabelFromData(this,value);
      element.className = appendSelector("-item");
      if(breadCrumbsItem){
        if(breadCrumbsItem.isTitle){
          //TODO Use Typography classes
          var h1:HTMLElement = newElement("h1");
          h1.className = "spectrum-Heading--pageTitle";
          // element.removeChild(textNode.element);
          if(icon.parent){
            removeElement(icon);
          }
          // element.removeChild(icon.getElement());
          h1.appendChild(textNode.element);
          element.appendChild(h1);
        }
        if(breadCrumbsItem.isDragged){
          element.classList.add("is-dragged");
        }
        if(breadCrumbsItem.isFolder){
          element.removeChild(textNode.element);
          var button:ActionButton = new ActionButton();
          button.quiet = true;
          button.element.style.height = '100%';
          var type:String = IconType.FOLDER_BREADCRUMB;
          button.icon = Icon.getCSSTypeSelector(type);
          button.iconClass = appendSelector("-folder");
          button.iconElement = createFolderIcon();
          button.iconType = type;
          element.insertBefore(button.element,icon.element);
          element.style.marginTop = 'inherit';
          if(breadCrumbsItem.isDisabled){
            button.disabled = true;
          }
        }else if(breadCrumbsItem.isDisabled){
          textNode.element.classList.add("is-disabled");
        }
      }
      else{
        element.style.marginTop = '8px';
      }
      if(!breadCrumbsItem.isDisabled){
        addEventListener(MouseEvent.CLICK,handleClicked);        
      }
    }

    protected function createFolderIcon():Icon{
      var type:String = IconPrefix._18 + "Folder"
      var folder:Icon = new Icon(type);
      folder.type = type;
      return folder;
    }
    
    private function handleClicked(ev:MouseEvent):void{
      COMPILE::JS
      {
        (parent as IEventDispatcher).dispatchEvent(new ValueEvent("itemClicked",ev.target.data));
      }
    }
    override public function set selected(value:Boolean):void{
      //do nothing
    }
    private var icon:Icon;
    private var textNode:TextNode;
    COMPILE::JS
    override protected function createElement():WrappedHTMLElement
    {
      var elem:WrappedHTMLElement = super.createElement();
      textNode = new TextNode("a");
      textNode.className = appendSelector("-itemLink");
      textNode.element.setAttribute('tabindex',"0");
      elem.appendChild(textNode.element);
      var type:String = IconType.CHEVRON_RIGHT_SMALL;
      icon = new Icon(Icon.getCSSTypeSelector(type));
      icon.type = type;
      icon.className = appendSelector("-itemSeparator");
      addElement(icon);
      return elem;
    }
  }
}
