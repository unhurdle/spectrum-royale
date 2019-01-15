package com.unhurdle.spectrum
{
  import org.apache.royale.html.ComboBox;

  public class ComboBox extends SpectrumBase
  {

    public function ComboBox()
    {
      super();
    }
    override protected function getSelector():String{
      return "spectrum-InputGroup";
    }
    private function getModel():IComboBoxModel{
      return model as IComboBoxModel;
    }

		
		/**
		 *  The data for display by the ComboBox.
		 */
		public function get dataProvider():Object
		{
			return getModel().dataProvider;
		}
		public function set dataProvider(value:Object):void
		{
			getModel().dataProvider = value;
		}
		
        [Bindable("change")]
		/**
		 *  The index of the currently selected item. Changing this item changes
		 *  the selectedItem value.
		 *
		 */
		public function get selectedIndex():int
		{
			return getModel().selectedIndex;
		}
		public function set selectedIndex(value:int):void
		{
			getModel().selectedIndex = value;
		}
		
        [Bindable("change")]
		/**
		 *  The item that is currently selected. Changing this item changes
		 *  the selectedIndex.
		 *
		 *  @langversion 3.0
		 *  @playerversion Flash 10.2
		 *  @playerversion AIR 2.6
		 *  @productversion Royale 0.0
		 */
		public function get selectedItem():Object
		{
			return getModel().selectedItem;
		}
		public function set selectedItem(value:Object):void
		{
			getModel().selectedItem = value;
		}

    public function get placeholder():String
    {
    	return getModel().placeholder;
    }

    public function set placeholder(value:String):void
    {
    	getModel().placeholder = value;
    }

    public function get pattern():String
    {
    	return getModel().pattern;
    }

    public function set pattern(value:String):void
    {
    	getModel().pattern = value;
    }

    public function get required():Boolean
    {
    	return getModel().required;
    }

    public function set required(value:Boolean):void
    {
    	getModel().required = value;
    }

    public function get disabled():Boolean
    {
    	return getModel().disabled;
    }

    public function set disabled(value:Boolean):void
    {
    	getModel().disabled = value;
    }

		private var _invalid:Boolean;

		public function get invalid():Boolean
		{
			return _invalid;
		}

		public function set invalid(value:Boolean):void
		{
			if(value != !!_invalid){
				toggle("is-invalid",value);
			}
			_invalid = value;
		}

  }
}