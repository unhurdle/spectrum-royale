package com.unhurdle.spectrum
{
  import com.unhurdle.spectrum.includes.InputGroupInclude;
  import org.apache.royale.collections.IArrayList;
  import com.unhurdle.spectrum.data.IMenuItem;
  import com.unhurdle.spectrum.interfaces.IKeyboardFocusable;
  import com.unhurdle.spectrum.beads.KeyboardFocusHandler;

	[Event(name="change", type="org.apache.royale.events.Event")]

  public class ComboBox extends SpectrumBase implements IKeyboardFocusable, ITextContent
  {
    public function ComboBox()
    {
      super();
    }
    override protected function requiresView():Boolean{
      return true;
    }
    override protected function requiresController():Boolean{
      return true;
    }

		override protected function loadBeads():void{
			super.loadBeads();
			addBead(new KeyboardFocusHandler());
		}
    override protected function getSelector():String{
      return InputGroupInclude.getSelector();
    }
		public function get focusElement():HTMLElement{
			return getView().textInputField.focusElement;
		}
    private function getModel():IComboBoxModel{
      return model as IComboBoxModel;
    }
		private function getView():ComboBoxView{
			return view as ComboBoxView;
		}

		// is-open?????????????????????????????????????????????????????????????
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

		private var _text:String;
		public function get text():String{
			var field:TextField = getView().textInputField;
			if(field){
				return field.text;
			}
			return _text;
		}

		public function set text(value:String):void
		{
			var field:TextField = getView().textInputField;
			if(field){
				field.text = value;
			}
			_text = value;
			_previousText = _text;
		}
		// this is the previosly typed value
		// Not the previous set text value
		private var _previousText:String
		public function get previousText():String {
				return _previousText;
		}
		public function set previousText(value:String):void {
			_previousText = value;
		}
		public function get limitToList():Boolean{
			return getModel().limitToList;
		}
		public function set limitToList(value:Boolean):void{
			getModel().limitToList = value;
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
			return getModel().invalid;
		}

		public function set invalid(value:Boolean):void
		{
			getModel().invalid = value;
		}
		private var _quiet:Boolean;

		public function get quiet():Boolean
		{
			return getModel().quiet;
		}

		public function set quiet(value:Boolean):void
		{
			getModel().quiet = value;
		}

		public function get focused():Boolean{
			return getModel().focused;
		}
		public function set focused(value:Boolean):void{
			getModel().focused = value;
		}

		public function get keyboardFocused():Boolean{
			return getModel().keyboardFocused;
		}
		public function set keyboardFocused(value:Boolean):void{
			getModel().keyboardFocused = value;
		}

		private var _popupWidth:Number;
		public function get popupWidth():Number
		{
			return _popupWidth;
		}

		public function set popupWidth(value:Number):void
		{
			_popupWidth = value;
		}
		public var filterFunction:Function = function(input:String,dataProvider:Object):Array{
			var inArray:Array;
			if(dataProvider is IArrayList){
				inArray = (dataProvider as IArrayList).source;
			} else {
				inArray = dataProvider as Array;
			}
			input = input.toLowerCase();
			// work on a copy
			inArray = inArray.slice();
			return inArray.filter(function(item:Object):Boolean{
				var label:String = (item as IMenuItem).label;
				if(!label){
					return false;
				}
				return label.toLowerCase().indexOf(input) != -1;
			});			
		};
		// private var _open:Boolean;

		// public function get open():Boolean
		// {
		// 	return _open;
		// }

		// public function set open(value:Boolean):void
		// {
		// 	if(value != !!_open){
		// 		toggle("is-open",value);
		// 	}
		// 	_open = value;
		// }

  }
}