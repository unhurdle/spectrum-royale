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
			position = 50;
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