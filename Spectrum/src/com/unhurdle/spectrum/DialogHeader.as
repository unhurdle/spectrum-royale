package com.unhurdle.spectrum
{
  import org.apache.royale.core.IChild;

  public class DialogHeader extends Group
  {
    public function DialogHeader()
    {
      super();
    }
    override protected function getSelector():String{
      return "spectrum-Dialog-header";
    }

    private var _title:String;

    public function get title():String
    {
    	return _title;
    }

    public function set title(value:String):void
    {
    	_title = value;
      if(value){
        var needElem:Boolean = titleElem == null;
        if(numElements > 0){
          var firstElem:IChild = getElementAt(0);
          if(firstElem is DialogTitle){
            titleElem = firstElem as DialogTitle;
            needElem = false;
          }
        }
        if(needElem){
          titleElem = new DialogTitle();
          addElementAt(titleElem,0);
        }
      }
      if(titleElem){
        titleElem.text = value;
      }
    }
    private var titleElem:DialogTitle;
  }
}