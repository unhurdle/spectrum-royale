package com.unhurdle.spectrum
{
  COMPILE::JS
  {}
  import com.unhurdle.spectrum.includes.SideNavInclude;

  public class SideNav extends Group
  {
    public function SideNav()
    {
      super();
    }
    
    override protected function getSelector():String{
      return SideNavInclude.getSelector();
    }

    private var _multiLevel:Boolean;

		public function get multiLevel():Boolean
		{
			return _multiLevel;
		}

		public function set multiLevel(value:Boolean):void
		{
			if(value != !!_multiLevel){
        COMPILE::JS
        {
          toggle(valueToSelector("multiLevel"),value);
        }
      }
			_multiLevel = value;
    }
  }
}