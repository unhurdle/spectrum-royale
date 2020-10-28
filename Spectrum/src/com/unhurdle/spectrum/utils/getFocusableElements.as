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
        if(childElem.tabFocusable){
          elements.push(childElem);
        }
        getFocusableElements(childElem,elements);
      }
    }
  }
}