package com.unhurdle.spectrum
{
  COMPILE::JS
  {
    import org.apache.royale.core.WrappedHTMLElement;
  }
  public class TableHeaderCell extends TableCell
  {
   
    public function TableHeaderCell()
    {
      super();
      typeNames = "spectrum-Table-headCell";
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
    private var _sortedDesc:Boolean;
  
    public function get sortedDesc():Boolean
    {
    	return _sortedDesc;
    }
    public function set sortedDesc(value:Boolean):void 
    {
      if(value != _sortedDesc){
        toggle("is-sorted-desc",value);
      }
      _sortable = value;
    }

    override protected function getTag():String{
      return "th";
    }
    COMPILE::JS
		override protected function createElement():WrappedHTMLElement
		{
      elem = super.createElement();
      return elem;
		}

    //event to sort the cells in the column
    //text needs to be label of the first cell in the column ?
  }
}