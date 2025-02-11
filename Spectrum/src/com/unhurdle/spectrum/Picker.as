package com.unhurdle.spectrum
{
	COMPILE::JS{
		import org.apache.royale.core.WrappedHTMLElement;
	}

	import com.unhurdle.spectrum.const.IconType;
	import org.apache.royale.events.KeyboardEvent;
	import org.apache.royale.html.util.getLabelFromData;
	import org.apache.royale.collections.IArrayList;
	import com.unhurdle.spectrum.data.MenuItem;
	import org.apache.royale.events.MouseEvent;
	import org.apache.royale.events.Event;
	import org.apache.royale.geom.Rectangle;
	import org.apache.royale.utils.DisplayUtils;
	import org.apache.royale.utils.callLater;
	// import com.unhurdle.spectrum.data.IMenuItem;
	import com.unhurdle.spectrum.const.IconPrefix;
	import com.unhurdle.spectrum.data.IMenuItem;
	import com.unhurdle.spectrum.interfaces.IKeyboardNavigateable;
	import com.unhurdle.spectrum.utils.getExplicitZIndex;
	import org.apache.royale.events.utils.WhitespaceKeys;
	import org.apache.royale.events.utils.NavigationKeys;
	import com.unhurdle.spectrum.utils.cloneNativeKeyboardEvent;
	import org.apache.royale.events.utils.UIKeys;
	/**
	 * TODO maybe add flexible with styling of min-width: 0;width:auto;
	 */
	[Event(name="change", type="org.apache.royale.events.Event")]
	[Event(name="showMenu", type="org.apache.royale.events.Event")]
	public class Picker extends SpectrumBase implements IKeyboardNavigateable
	{
		/**
		 * <inject_html>
		 * <link rel="stylesheet" href="assets/css/components/picker/dist.css">
		 * </inject_html>
		 * 
		 */
		public function Picker()
		{
			super();
		}
		override protected function getSelector():String{
			return "spectrum-Picker";
		}
		private var _button:FieldButton;
		public function get button():FieldButton{
			return _button;
		}
		COMPILE::JS
		override protected function createElement():WrappedHTMLElement{
			var elem:WrappedHTMLElement = super.createElement();
			_button = new FieldButton();
			_button.labelClass = appendSelector("-label");
			_button.className = appendSelector("-trigger");
			_button.addEventListener("click",toggleDropdown);
			var type:String = IconType.CHEVRON_DOWN_MEDIUM;
			_button.icon = Icon.getCSSTypeSelector(type);
			_button.iconType = type;
			_button.iconClass = appendSelector("-icon");
			// _button.textNode.element.style.maxWidth = '85%';
			addElement(_button);
			popover = new ComboBoxList();
			popover.className = appendSelector("-popover");
			popover.addEventListener("openChanged",handlePopoverChange);
			// popover.percentWidth = 100;
			// popover.setStyle("z-index",100);//????
			// menu = new Menu();
			// popover.addElement(menu);
			menu.addEventListener("change", handleListChange);
			menu.percentWidth = 100;
			// popover.style = {"z-index": "2"};
			return elem;
		}
		public var popover:ComboBoxList;
		public function get menu():Menu{
			return popover.list;
		}
		private function handlePopoverChange(ev:Event):void{
			_button.selected = popover.open;
			toggle("is-open",popover.open);
		}
		private function positionPopup():void{
			var componentBounds:Rectangle = DisplayUtils.getScreenBoundingRect(this);
			popover.positionPopup(componentBounds,componentBounds.width);
		}

		private function toggleDropdown(ev:*):void{
			ev.preventDefault();
			var open:Boolean = !popover.open;
			toggle("is-open",open);
			if(open){
				positionPopup();
				dispatchEvent(new Event("showMenu"));
				callLater(openPopup)
			} else {
				closePopup();
			}
		}
		private var zIndexSet:Boolean = false;
		private function openPopup():void{
			if(!zIndexSet){
				var zIndex:Number = getExplicitZIndex(this);
				if(zIndex > 2){
					popover.setStyle("z-index",zIndex);
				}
				zIndexSet = true;
			}
			popover.open = true;
			popover.filterFunction = filterFunction;
			_button.addEventListener(MouseEvent.MOUSE_DOWN, handleControlMouseDown);
			_button.removeEventListener(KeyboardEvent.KEY_DOWN, handleKeyDown);
			if(searchable){
				popover.search.input.focus();
			}
		}
		private function closePopup():void{
			if(popover && popover.open){
				_button.removeEventListener(MouseEvent.MOUSE_DOWN, handleControlMouseDown);
				popover.open = false;
			}
		}
		
		protected function handleControlMouseDown(event:MouseEvent):void
		{			
			event.stopImmediatePropagation();
		}
		public function get dataProvider():Object{
			return menu.dataProvider;
		}
		public function set dataProvider(value:Object):void{
			if(value is Array){
				convertArray(value);
			} else if(value is IArrayList){
				convertArray(value.source);
			}
			menu.dataProvider = value;
		}

		public function get selectedIndex():int
		{
			return menu.selectedIndex;
		}

		public function set selectedIndex(value:int):void
		{
			menu.selectedIndex = value;
			setButtonText();
		}

		private var _filterFunction:Function;
		public function set filterFunction(func:Function):void {
			_filterFunction = func;
		}

		public function get filterFunction():Function
		{
			return _filterFunction;
		}

		private function setButtonAsset(index:int,icon:Boolean):void{
			if(_button.getElementAt(0) is IAsset){
				_button.removeElement(_button.getElementAt(0));
			}
			if (icon)
			{
				var iconClone:Icon = new Icon(dataProvider[index].icon);
				_button.addElementAt(iconClone, 0);
			} else
			{
				var asset:ImageAsset = new ImageAsset();
				asset.width = 18;
				asset.setStyle("margin-right","8px");      
				asset.src = icon? dataProvider[index].icon: dataProvider[index].imageIcon;
				_button.addElementAt(asset,0);
			}
		}
		private function setButtonText():void{
			if(selectedIndex){
				if(selectedIndex < 0 || dataProvider[selectedIndex].isDivider){
					_button.text = "";
				}else{
					_button.text = dataProvider[selectedIndex].text;
					if(dataProvider[selectedIndex].imageIcon){
						setButtonAsset(selectedIndex,false);
					}else if(dataProvider[selectedIndex].icon){
						setButtonAsset(selectedIndex,true);
					}
				}
			}else if(!selectedItem ||selectedItem.isDivider){
				_button.text = "";
			}else{
				_button.text = selectedItem.text;
				var i:int = dataProvider.indexOf(selectedItem)
				if(dataProvider[i].imageIcon){
					setButtonAsset(i,false);
				}else if(dataProvider[i].icon){
					setButtonAsset(i,true);
				}
			}
		}

		public function get selectedItem():Object
		{
			return menu.selectedItem;
		}

		public function set selectedItem(value:Object):void
		{
			menu.selectedItem = value;
			setButtonText();
		}
		private function convertArray(value:Object):void{
			var len:int = value.length;
			for(var i:int = 0;i<len;i++){
				if(value[i] is IMenuItem){
					continue;
				}
				var item:MenuItem = new MenuItem(getLabelFromData(this,value[i]));
				if(value[i].isDivider){
					item.isDivider = value[i]["isDivider"];
				}
				if(value[i].disabled){
					item.disabled = value[i]["disabled"];
				}
				if(value[i].icon){
					item.icon = value[i]["icon"];
				}
				if(value[i].imageIcon){
					item.imageIcon = value[i]["imageIcon"];
				}
				if(value[i].selected || i == selectedIndex || value[i] == selectedItem){
					item.selected = value[i]["selected"];
					if(item.icon){
						setButtonAsset(i,true);
					}else if(item.imageIcon){
						setButtonAsset(i,false);
					}
				}
				value[i] = item;
			}
		}
		private var _placeholder:String;
		public function get placeholder():String
		{
			return _placeholder;
		}

		public function set placeholder(value:String):void
		{
			_placeholder = value;
			_button.placeholderText = value;
		}

		public function handleListChange():void{
			closePopup();
			setButtonText();
			dispatchEvent(new Event("change"));
			//keep focus on button after closing, so key down (for arrow down/space) will open it
			_button.focus();// for some reason causes it to re-open. looks like 'focus' event triggers 'click' event.
			_button.addEventListener(KeyboardEvent.KEY_DOWN, handleKeyDown);
		}
		
		private var _invalid:Boolean;

		public function get invalid():Boolean
		{
			return _invalid;
		}

		public function set invalid(value:Boolean):void
		{
			if(value != _invalid){
				toggle("is-invalid",value);
				_button.invalid = value;
				if(value){
					var invalidIcon:Icon = new Icon(IconPrefix._18 + "Alert");
					invalidIcon.size = "S";
					_button.addElementAt(invalidIcon, _button.numElements - 1);
				}else{
					_button.removeElement(invalidIcon);
				}
			}
			_invalid = value;
		}
		private var _quiet:Boolean;

		public function get quiet():Boolean
		{
			return _quiet;
		}

		public function set quiet(value:Boolean):void
		{
			if(value != _quiet){
				toggle(valueToSelector("quiet"),value);
				_button.quiet = value;
				popover.quiet = value;
			}
			_quiet = value;
		}

		private var _disabled:Boolean;

		public function get disabled():Boolean
		{
			return _disabled;
		}

		public function set disabled(value:Boolean):void
		{
			if(value != !!_disabled){
				toggle("is-disabled",value);
				_button.disabled = value;
			}
			_disabled = value;
		}
		private var _popupWidth:Number;

		public function get popupWidth():Number
		{
			return _popupWidth;
		}

		public function set popupWidth(value:Number):void
		{
			_popupWidth = value;
			popover.width = value;
		}
		private var _position:String;

		public function get position():String
		{
			return _position;
		}

		public function get minMenuHeight():Number
		{
			return popover.minMenuHeight;
		}

		public function set minMenuHeight(value:Number):void
		{
			popover.minMenuHeight = value;
		}

		public function get searchable():Boolean
		{
			return popover.searchable;
		}

		public function set searchable(value:Boolean):void 
		{
			popover.autoFocusList = !value;
			popover.searchable = value;
			if (popover.search)
			{
				popover.search.input.addEventListener(KeyboardEvent.KEY_DOWN, handleKeyDown);
			}
		}
		private function handleKeyDown(event:KeyboardEvent):void
		{
			if(popover.open) {
				// forward relevent keys to the list
				switch(event.key){
					case WhitespaceKeys.ENTER:
					case NavigationKeys.DOWN:
					case NavigationKeys.UP:
					case UIKeys.ESCAPE:
						COMPILE::JS
						{
							var newEvent:KeyboardEvent = new KeyboardEvent(
								event.type,
								event.key,
								event.code,
								event.shiftKey,
								event.altKey,
								event.ctrlKey,
								event.metaKey,
								false);
							popover.list.focusParent.dispatchEvent(newEvent);
						}
						break;
				}
			} else {
				if (event.key == NavigationKeys.DOWN || event.key == WhitespaceKeys.SPACE) {
					openPopup();
				}
			}
			// prevent default behavior for these keys to keep the cursor position from changing
			if(event.key == NavigationKeys.UP || event.key == NavigationKeys.DOWN){
				event.preventDefault();
				event.stopImmediatePropagation();
			}

		}

		[Inspectable(category="General", enumeration="bottom,top,right,left")]
		public function set position(value:String):void
		{
			switch(value){
				case "bottom":
				// break;
					case "top":
							// (element as HTMLElement).insertBefore((element as HTMLElement).removeChild(popover.element as HTMLElement),button.element as HTMLElement);
						// popover.setStyle("bottom","30px");
						// break;
					case "right":
					case "left":
						break;
					default:
						throw new Error("invalid position: " + value);
			}
			if(value != !!_position){
				popover.position = value;
			}
			_position = value;
		}

		public function get focusParent():ISpectrumElement
		{
			return popover;
		}
	}
}