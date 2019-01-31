package com.unhurdle.spectrum.renderers
{
  COMPILE::JS
  {
    import org.apache.royale.html.util.addElementToWrapper;
    import org.apache.royale.core.WrappedHTMLElement;
  }
  import org.apache.royale.html.supportClasses.DataItemRenderer;
  import com.unhurdle.spectrum.newElement;
  import com.unhurdle.spectrum.Icon;
  import com.unhurdle.spectrum.const.IconType;
  import com.unhurdle.spectrum.TextNode;
  import com.unhurdle.spectrum.TreeViewNested;
  import goog.events.Event;
  import com.unhurdle.spectrum.const.IconPrefix;
  import com.unhurdle.spectrum.const.IconSize;
  import com.unhurdle.spectrum.data.TreeViewNestedItem;
  
  public class TreeViewNestedItemRenderer extends DataItemRenderer
  {
    public function TreeViewNestedItemRenderer()
    {
      super();
      typeNames = '';
    }
    protected function appendSelector(value:String):String{
      return "spectrum-TreeView" + value;
    }
    // protected var classList:CSSClassList;
    //from spectrumBase but added in elem before .add and .remove
    protected function toggle(classNameVal:String,add:Boolean):void{
      COMPILE::JS{
        add? element.classList.add(classNameVal) : element.classList.remove(classNameVal);
        (element as TreeViewNestedItem).opened = add;
      }
    }
    private var icon:Icon;
    private var link:TextNode;
    COMPILE::JS
    override public function set data(value:Object):void{
      super.data = value
      var elem:HTMLElement = element as HTMLElement;
      var treeViewNestedItem:TreeViewNestedItem = value as TreeViewNestedItem;
      elem.className += appendSelector("-item");
      link.element.setAttribute("href",treeViewNestedItem.href || "#");
      link.text =treeViewNestedItem.text;
      elem.appendChild(link.element);
      if(!!treeViewNestedItem.isList){
        var type:String = IconType.CHEVRON_RIGHT_MEDIUM;
        icon = new Icon(Icon.getCSSTypeSelector(type));
        icon.type = type;
        icon.className += "spectrum-TreeView-indicator";
        elem.addEventListener("click",openOrClose);
        link.element.insertBefore(icon.element,link.element.firstChild || null);
        var ul:TreeViewNested = new TreeViewNested();
        ul.dataProvider = treeViewNestedItem.dataProvider;
        addElement(ul);
      }
      if(treeViewNestedItem.opened){
        toggle("is-open",true);
        icon.element.style.transform = "rotate(" + 90 + "deg)";
      } else {
        toggle("is-open",false);
      }
      if(treeViewNestedItem.disabled){
        toggle("is-disabled",true);
      } else {
        toggle("is-disabled",false);
      }
      if(treeViewNestedItem.withIcon){
        createIcon(!!treeViewNestedItem.isList);
      }
    }

    private function createIcon(isFolder:Boolean):void{
      COMPILE::JS{
        var type:String;
        var folderOrFileIcon:Icon
        if(isFolder){
          type = IconType.FOLDER;
        }else{
          type = IconType.LAYERS;
        }
        folderOrFileIcon = new Icon(IconPrefix._18 + type);
        folderOrFileIcon.type = type;
        folderOrFileIcon.size = IconSize.S;
        link.element.insertBefore(folderOrFileIcon.element,link.element.lastChild || null);
      }
    }
    private function openOrClose(event:Event):void{
      var styleStr:String;
      COMPILE::JS{
        var el:HTMLElement = event.target.closest('.spectrum-TreeView-item');
        if(el != null && !el.classList.contains("is-disabled")){
          event.stopPropagation();
          if(el.classList.contains('is-open')){
            toggle('is-open',false);
            styleStr="transform:rotate("+0+"deg)";
          }else{
            toggle('is-open',true);
            styleStr="transform:rotate("+90+"deg)";
          }
          icon.element.setAttribute("style",styleStr);
        }
      }
    }
    COMPILE::JS
    override protected function createElement():WrappedHTMLElement
    {
      var elem:WrappedHTMLElement = addElementToWrapper(this,'li');
      link = new TextNode("");
      link.element = newElement("a",appendSelector("-itemLink"));
      return elem; 
    }   
  }
}
