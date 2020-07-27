package com.unhurdle.spectrum
{
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
        if(value){
          if(topVisible){
            splitter.style.visibility = "unset";
          }
          if(element.children && element.children[2]){
            element.children[2].style.visibility = "unset";
          }
        } else{
          splitter.style.visibility = "hidden";
          if(element.children && element.children[2]){
            element.children[2].style.visibility = "hidden";
          }
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
        if(value){
          if(bottomVisible){
            splitter.style.visibility = "unset";
          }
          if(element.children && element.children[0]){
            element.children[0].style.visibility = "unset";
          }
        } else{
          splitter.style.visibility = "hidden";
          if(element.children && element.children[0]){
            position = 0;
            element.children[0].style.visibility = "hidden";
          }
        }
      }
    }
  }
}