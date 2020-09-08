package com.unhurdle.spectrum
{
  import org.apache.royale.core.IChild;

  public class HSplitView extends SplitView
  {
    public function HSplitView()
    {
      super();
      direction = "horizontal";
			position = 50;
    }
    private var _rightVisible:Boolean = true;

    public function get rightVisible():Boolean
    {
    	return _rightVisible;
    }

    public function set rightVisible(value:Boolean):void
    {
      COMPILE::JS{
        _rightVisible = value;
        if(!value && !_leftVisible){
          leftVisible = true;
        }
        if(value){
          if(leftVisible){
            splitter.style.visibility = "unset";
          }
          if(element.children && element.children[2]){
            element.children[2].style.visibility = "unset";
          }
        } else{
          
          if(element.children && element.children[2]){
            position = 100;
            element.children[2].style.visibility = "hidden";
            splitter.style.visibility = "hidden";
          }
        }
      }
    }
    private var _leftVisible:Boolean = true;

    public function get leftVisible():Boolean
    {
    	return _leftVisible;
    }

    public function set leftVisible(value:Boolean):void
    {
      COMPILE::JS{
        _leftVisible = value;
        if(!value && !_rightVisible){
          rightVisible = true;
        }
        if(value){
          if(rightVisible){
            splitter.style.visibility = "unset";
          }
          if(element.children && element.children[0]){
            element.children[0].style.visibility = "unset";
          }
        } else{
          
          if(element.children && element.children[0]){
            position = 0;
            element.children[0].style.visibility = "hidden";
            splitter.style.visibility = "hidden";
          }
        }
      }
    }
		override public function addElement(c:IChild, dispatchEvent:Boolean = true):void{
			super.addElement(c,dispatchEvent);
      // apply changes
      leftVisible = leftVisible;
      rightVisible = rightVisible;
    }
  }
}