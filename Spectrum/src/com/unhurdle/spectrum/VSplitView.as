package com.unhurdle.spectrum
{
  import org.apache.royale.core.IChild;
  import org.apache.royale.core.IUIBase;

  public class VSplitView extends SplitView
  {
    public function VSplitView()
    {
      super();
      direction = "vertical";
      splitter.style = {'height': '2px','width': '100%'};
			position = 50;
    }
    override public function set isDraggable(value:Boolean):void{
      super.isDraggable = value;
      if(splitter.gripper){
        splitter.gripper.style.top = '-4px';
        splitter.gripper.style.transform = 'translate(-50%, 0)';
        splitter.gripper.style.width = '16px';
        splitter.gripper.style.height = '4px';
        splitter.gripper.style.borderTopWidth = '3px';
        splitter.gripper.style.borderBottomWidth = '3px';
        splitter.gripper.style.borderLeftWidth = '4px';
        splitter.gripper.style.borderRightWidth = '4px';
      }
    }
    private var _bottomVisible:Boolean = true;

    public function get bottomVisible():Boolean
    {
    	return _bottomVisible;
    }

    public function set bottomVisible(value:Boolean):void
    {
      COMPILE::JS{
        _bottomVisible = value;
        if(!value && !_topVisible){
          topVisible = true;
        }
        splitter.visible = value && topVisible;
        if(!value){
            position = 100;
        }
        if(numElements > 2){
          (getElementAt(2) as IUIBase).visible = value;
        }
      }
    }
    private var _topVisible:Boolean = true;

    public function get topVisible():Boolean
    {
    	return _topVisible;
    }

    public function set topVisible(value:Boolean):void
    {
      COMPILE::JS{
        _topVisible = value;
        if(!value && !_bottomVisible){
          bottomVisible = true;
        }
        splitter.visible = value && bottomVisible;
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
      topVisible = topVisible;
      bottomVisible = bottomVisible;
    }
  }
}