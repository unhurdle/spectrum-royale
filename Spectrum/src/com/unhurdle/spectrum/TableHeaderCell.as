package com.unhurdle.spectrum
{
  COMPILE::JS
    {
    import org.apache.royale.core.WrappedHTMLElement;
		import org.apache.royale.html.util.addElementToWrapper;
		import org.apache.royale.events.Event;
    }
  public class TableHeaderCell  extends TableCell
  {
   
    public function TableHeaderCell()
    {
      super();
      // typeNames = 'spectrum-Table-headCell';
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

    COMPILE::JS
    public function set sortable(value:Boolean):void //fix 
    {   
      if(value){
        icon =  new Icon("#spectrum-css-icon-ArrowDownSmall");
        icon.type = 'ArrowDownSmall';
        icon.className = "spectrum-Table-sortedIcon";
        addElement(icon); 
        icon.addedToParent(); 
        elem.classList.add("is-sortable");
    }
      _sortable = value;
    }

    
 


  

    COMPILE::JS
		override protected function createElement():WrappedHTMLElement
		{
      elem = addElementToWrapper(this,'th');
      elem.className = "spectrum-Table-headCell";
      elem.tabIndex = 0;
      return elem;
		}

    //event to sort the cells in the column
    //text needs to be label of the first cell in the column ?
  }
}