package com.unhurdle.spectrum
{
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
        retVal.push(getElementAt(i));
      }
      return retVal;
    }
  }
}