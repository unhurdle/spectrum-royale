package com.unhurdle.spectrum
{
  import org.apache.royale.core.IChild;
  import org.apache.royale.core.IUIBase;

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
        splitter.visible = value && leftVisible;
        if(!value){
          position = 100;
        }
        if(numElements > 2){
          (getElementAt(2) as IUIBase).visible = value;
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
        splitter.visible = value && rightVisible;
        if(!value){          
          position = 0;
        }
        if(numElements){
          (getElementAt(0) as IUIBase).visible = value;
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