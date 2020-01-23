package com.unhurdle.spectrum
{
  COMPILE::JS
    {
    import org.apache.royale.core.WrappedHTMLElement;
		import org.apache.royale.html.util.addElementToWrapper;
		}
  public class TableHeaderCell  extends TableCell
  {
   
    public function TableHeaderCell()
    {
      super();
    }


    COMPILE::JS
    private var elem:WrappedHTMLElement;
    COMPILE::SWF
    private var elem:Object;

    private var _sortable:Boolean;
  
    public function get sortable():Boolean
    {
    	return _sortable;
    }
    private var icon:Icon;
    //TODO make the sorting actually work
    public function set sortable(value:Boolean):void //fix 
    {
      if(value != _sortable){
      if(value && !icon){
        var type:String = "ArrowDownSmall";
        icon = new Icon(Icon.getCSSTypeSelector(type));
        icon.type = type;
        icon.className = "spectrum-Table-sortedIcon";
        addElement(icon);
      }
        toggle("is-sortable",value);
      }
      _sortable = value;
    }

    
 
  private var textNode:TextNode;

    COMPILE::JS
		override protected function createElement():WrappedHTMLElement
		{
      elem = addElementToWrapper(this,'th');
      elem.className = "spectrum-Table-headCell";
      // elem.tabIndex = 0;
      textNode = new TextNode("");
      textNode.element = elem;
      return elem;
		}


    public function get text():String
    {
    	return textNode.text;
    }

    public function set text(value:String):void
    {
    	textNode.text = value;
    }
    //event to sort the cells in the column
    //text needs to be label of the first cell in the column ?
  }
}