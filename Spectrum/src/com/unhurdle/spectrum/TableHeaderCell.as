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
      typeNames = 'spectrum-Table-headCell';
    }

    private var _sortable:Boolean;

    public function get sortable():Boolean
    {
    	return _sortable;
    }

    // public function set sortable(value:Boolean):void //fix 
    // {
    //   element.classList.toggle("is-sortable");
    //   var icon:Icon = new Icon("#spectrum-css-icon-ArrowDownSmall");
    //   icon.className = "spectrum-Icon spectrum-UIIcon-ArrowDownSmall spectrum-Table-sortedIcon"; // 2 sep
    //   icon.setAttribute("focusable",true);
    //   addElement(icon);
    //   _sortable = value;
    // }

    // is-sorted-desc -- decide what to do with this.
    
    COMPILE::JS
		override protected function createElement():WrappedHTMLElement
		{
      var elem:WrappedHTMLElement = addElementToWrapper(this,'th');
      elem.tabIndex = 0;
			return elem;
		}

    //event to sort the cells in the column
    //text needs to be label of the first cell in the column ?
  }
}