package com.unhurdle.spectrum.renderers
{
  COMPILE::JS
  {
    import org.apache.royale.core.WrappedHTMLElement;
    import org.apache.royale.html.util.addElementToWrapper;
  }
  import org.apache.royale.html.supportClasses.TreeListData;
  import com.unhurdle.spectrum.TextNode;
  import org.apache.royale.events.MouseEvent;    
  import com.unhurdle.spectrum.Icon;
  import org.apache.royale.events.ItemClickedEvent;
  import org.apache.royale.html.elements.A;
  import org.apache.royale.core.IParent;

  public class TreeItemRenderer extends ListItemRenderer
  {
    public function TreeItemRenderer()
    {
      super();
      typeNames = '';
    }
    private var children:Array;
    public static var indent:Number = 10;
    override protected function getSelector():String{
      return "spectrum-TreeView";
    }
    COMPILE::JS
    override public function set data(value:Object):void{
      super.data = value;
      children = value.children;
      toggle(appendSelector("-item"),true);
      if(listData is TreeListData){
        var treeListData:TreeListData = listData as TreeListData;
        var indentVal:String = "";
        if(treeListData.depth != -1){
          
          indentVal = (treeListData.depth - 1) * indent + "px";
        }
        element.style.paddingLeft = indentVal;
        if(icon){
          icon.toggle(appendSelector('-itemIcon'),true);
        }
        if(treeListData.hasChildren){
          var type:String = "ChevronRightMedium";
          var chevronRightIcon:Icon = new Icon(Icon.getCSSTypeSelector(type));
          chevronRightIcon.type = type;
          chevronRightIcon.toggle(appendSelector("-itemIndicator"),true);
          chevronRightIcon.addEventListener(MouseEvent.CLICK,function (ev:Event):void
          {
            if(disabled){
              ev.stopImmediatePropagation();
            }
          })
          link.addElementAt(chevronRightIcon,0);
          link.addEventListener(MouseEvent.CLICK,function ():void
          {
            isOpen = !isOpen;
            toggle('is-open',isOpen);
            treeListData.isOpen = isOpen;
            var expandEvent:ItemClickedEvent = new ItemClickedEvent("itemExpanded");
            expandEvent.data = data;
            expandEvent.index = index;
            //wait until all the intem renderers are updated to modify the list 
            setTimeout(function():void{
              dispatchEvent(expandEvent);
            })
          });
        }
      }
    }
    private var isOpen:Boolean = false;
    override protected function setText(value:String):void{
       textNode.text = value;
    }
    private var link:A;
    override protected function get iconParent():IParent{
      return link;
    }
    COMPILE::JS
    override protected function createElement():WrappedHTMLElement
    {
      var elem:WrappedHTMLElement = addElementToWrapper(this,getTag());
      link = new A();
      link.className = appendSelector("-itemLink");
      addElement(link);
      textNode = new TextNode("span");
      textNode.className = appendSelector("-itemLabel");
      textNode.element.style.userSelect = "none";
      textNode.element.style.display = "inline-flex";
      link.element.appendChild(textNode.element)
      // setStyle("cursor","default");
      return elem;
    }
    // COMPILE::JS
    // override public function set selected(value:Boolean):void
    // {
    //   super.selected = value;
    //   //TODO can we avoid writing these style directly?
    //   var background:String = "";
    //   if(value){
    //     background = 'rgb(55, 142, 240)';
    //   }
    //   element.style.background = background;
    // }
  }
}