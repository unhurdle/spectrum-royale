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
      splitter.style = {'width': '2px','height': '100%'};
			position = 50;
    }
    override public function set isDraggable(value:Boolean):void{
      super.isDraggable = value;
      if(splitter.gripper){
        splitter.gripper.style.top = '50%';
        splitter.gripper.style.transform = 'translate(0, -50%)';
        splitter.gripper.style.width = '4px';
        splitter.gripper.style.height = '16px';
        splitter.gripper.style.borderTopWidth = '4px';
        splitter.gripper.style.borderBottomWidth = '4px';
        splitter.gripper.style.borderLeftWidth = '3px';
        splitter.gripper.style.borderRightWidth = '3px';
      }

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