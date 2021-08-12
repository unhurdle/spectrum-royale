package com.unhurdle.spectrum
{
  import org.apache.royale.core.IChild;

  public class TagGroup extends Group
  {
    /**
     * <inject_html>
     * <link rel="stylesheet" href="assets/css/components/tags/dist.css">
     * </inject_html>
     * 
     */
    public function TagGroup()
    {
      super();
    }
    override protected function getSelector():String{
      return "spectrum-Tags";
    }
    public function get tags():Array
    {
      var retVal:Array = [];
      var numElem:Number = numElements;
      for(var i:int=0;i<numElem;i++){
        var tag:IChild = getElementAt(i);
        if(tag is Tag){
          retVal.push(tag);
        }
      }
      return retVal;
    }
    public function addTag(tag:Tag):void
    {
      if(numElements){
        var idx:int = numElements;
        while(idx > 0){
          if(getElementAt(idx-1) is Tag){
            addElementAt(tag,idx);
            return;
          }
          idx--;
        }
        addElementAt(tag,0);
      } else {
        addElement(tag);
      }
    }
  }
}