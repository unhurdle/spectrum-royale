package com.unhurdle.spectrum
{
  COMPILE::JS{
        import org.apache.royale.core.WrappedHTMLElement;
        import org.apache.royale.html.util.addElementToWrapper;
    }
  public class CycleButton extends SpectrumBase
  {
    public function CycleButton()
    {
      super();
      typeNames = "spectrum-ActionButton spectrum-ActionButton--quiet spectrum-CycleButton";
    }
    private var playIcon:Icon;
    private var pauseIcon:Icon;
    COMPILE::JS
    override protected function createElement():WrappedHTMLElement{
      var elem:WrappedHTMLElement = addElementToWrapper(this,'button');
      playIcon = new Icon("#spectrum-icon-18-PlayCircle");
      playIcon.className = "spectrum-Icon spectrum-Icon--sizeS spectrum-CycleButton-item";
      playIcon.selector = "#spectrum-icon-18-PlayCircle";
      elem.appendChild(playIcon.getElement());
      pauseIcon = new Icon("#spectrum-icon-18-PauseCircle");
      pauseIcon.className = "spectrum-Icon spectrum-Icon--sizeS spectrum-CycleButton-item";
      pauseIcon.selector = "#spectrum-icon-18-PauseCircle";
      elem.appendChild(pauseIcon.getElement());
      return elem;
    }
    private var _play:Boolean;

    public function get play():Boolean
    {
    	return _play;
    }

    public function set play(value:Boolean):void
    {
      if(value != !! _play){
        playIcon.className = "spectrum-Icon spectrum-Icon--sizeS spectrum-CycleButton-item ";
        if(value){
          playIcon.className += "is-selected";
        }
      }
    	_play = value;
    }
    private var _pause:Boolean;

    public function get pause():Boolean
    {
    	return _pause;
    }

    public function set pause(value:Boolean):void
    {
      if(value != !! _pause){
        pauseIcon.className = "spectrum-Icon spectrum-Icon--sizeS spectrum-CycleButton-item ";
        if(value){
          pauseIcon.className += "is-selected";
        }
      }
    	_pause = value;
    }
  }
}