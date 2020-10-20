package com.unhurdle.spectrum.utils
{
  import com.unhurdle.spectrum.ISpectrumElement;
  import org.apache.royale.core.IChild;
  /**
   * elements is an array of found components within the tree of the specified element.
   * The array is modified as elements are found
   */
  public function hasAutoFocus(element:ISpectrumElement,elements:Array):Boolean{
    var numElements:Number = element.numElements;
    var i:int = 0;
    while(i++ < numElements){
      
      var child:IChild = element.getElementAt(i);
      if(child is ISpectrumElement){
        var childElem:ISpectrumElement = child as ISpectrumElement;
        if(childElem.autofocus){
          COMPILE::JS
          {
            childElem.element.focus()
          }
          return true;
        }
        if(childElem.tabFocusable){
          elements.push(childElem);
        }
        if(hasAutoFocus(childElem,elements)){
          return true;
        }
      }
    }
    return false;
  }
}