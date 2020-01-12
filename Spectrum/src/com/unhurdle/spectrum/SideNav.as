package com.unhurdle.spectrum
{
  COMPILE::JS
  {
    import org.apache.royale.html.util.addElementToWrapper;
    import org.apache.royale.core.WrappedHTMLElement;
  }
  import org.apache.royale.html.List;
  import org.apache.royale.collections.IArrayList;
  import com.unhurdle.spectrum.data.SideNavItem;
  import org.apache.royale.html.util.getLabelFromData;
  import com.unhurdle.spectrum.includes.SideNavInclude;

  public class SideNav extends Tree
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