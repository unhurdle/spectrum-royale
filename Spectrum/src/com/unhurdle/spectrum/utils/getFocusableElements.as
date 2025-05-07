package com.unhurdle.spectrum.utils
{
  import com.unhurdle.spectrum.ISpectrumElement;
  import org.apache.royale.core.IChild;
  
  public function getFocusableElements(element:ISpectrumElement,elements:Array):void{
    var numElements:Number = element.numElements;
    var i:int = 0;
    while(i < numElements){
      var child:IChild = element.getElementAt(i);
      i++;
      if(child is ISpectrumElement){
        var childElem:ISpectrumElement = child as ISpectrumElement;
        // Add all elements to the array, regardless of their state
        if (elements.indexOf(childElem) == -1) {
          elements.push(childElem);
        }
        getFocusableElements(childElem,elements);
      }
    }
  }
}