package com.unhurdle.spectrum.renderers
{
  COMPILE::JS
  {
    import org.apache.royale.core.WrappedHTMLElement;
  }
  import com.unhurdle.spectrum.Icon;
  import com.unhurdle.spectrum.TextNode;

  import org.apache.royale.core.IParent;
  import org.apache.royale.events.Event;
  import org.apache.royale.events.ItemClickedEvent;
  import org.apache.royale.events.MouseEvent;
  import org.apache.royale.html.elements.A;
  import org.apache.royale.html.supportClasses.TreeListData;

  public class TreeItemRenderer extends TreeItemRendererBase
  {
    public function TreeItemRenderer()
    {
      super();
    }
    private var children:Array;
    public static var indent:Number = 10;
    override protected function getSelector():String{
      return "spectrum-TreeView";
    }
    private var treeListData:TreeListData;
    private var chevronRightIcon:Icon
    COMPILE::JS
    override public function set data(value:Object):void{
      super.data = value;
      if(listData is TreeListData){
        treeListData = listData as TreeListData;
        if(listData.hasChildren){
          var type:String = "ChevronRightMedium";
          if(!chevronRightIcon){
            chevronRightIcon = new Icon(Icon.getCSSTypeSelector(type));
            chevronRightIcon.type = type;
            chevronRightIcon.toggle(appendSelector("-itemIndicator"),true);
            chevronRightIcon.setStyle("flex-shrink",0);
            link.addElementAt(chevronRightIcon,0);
            chevronRightIcon.addEventListener(MouseEvent.CLICK,function (ev:Event):void
            {
              // This is a bit of a hack. Currently for multi-select trees,
              // the logic for opening nodes is dependent on selection.
              // Until that's separated, we can't stop propogation on multi-select trees
              if(!value?.multiSelect){
                ev.stopPropagation(); //to prevent selection when expanding
              }
              if(!disabled){
                isOpen = !isOpen;
                var expandEvent:ItemClickedEvent = new ItemClickedEvent("itemExpanded");
                expandEvent.data = data;
                expandEvent.index = index;
                //wait until all the intem renderers are updated to modify the list 
                setTimeout(function():void{
                  dispatchEvent(expandEvent);
                })
              }
            });
          }
          if(listData.isOpen){
            isOpen = value.isOpen = true;
          }
        }
      }
    }
    private var _isOpen:Boolean = false;

    public function get isOpen():Boolean
    {
    	return _isOpen;
    }

    public function set isOpen(value:Boolean):void
    {
    	_isOpen = value;
      toggle('is-open',value);
      treeListData.isOpen = _isOpen;
    }
    override protected function setText(value:String):void{
       textNode.text = value;
    }
    protected var link:A;
    override protected function get iconParent():IParent{
      return link;
    }
    COMPILE::JS
    override protected function createElement():WrappedHTMLElement
    {
      var elem:WrappedHTMLElement = super.createElement();
      link = new A();
      link.className = appendSelector("-itemLink");
      addElement(link);
      textNode = new TextNode("span");
      textNode.className = appendSelector("-itemLabel");
      textNode.element.style.userSelect = "none";
      textNode.element.style.display = "inline";
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