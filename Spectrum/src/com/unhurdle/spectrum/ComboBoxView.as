package com.unhurdle.spectrum{
	import com.unhurdle.spectrum.const.IconType;
	import com.unhurdle.spectrum.data.MenuItem;
	import com.unhurdle.spectrum.includes.InputGroupInclude;
	import com.unhurdle.spectrum.utils.cloneNativeKeyboardEvent;
	import com.unhurdle.spectrum.utils.getExplicitZIndex;

	import org.apache.royale.collections.ICollectionView;
	import org.apache.royale.core.BeadViewBase;
	import org.apache.royale.core.IChild;
	import org.apache.royale.core.IPopUpHost;
	import org.apache.royale.core.IStrand;
	import org.apache.royale.events.Event;
	import org.apache.royale.events.IEventDispatcher;
	import org.apache.royale.events.KeyboardEvent;
	import org.apache.royale.events.MouseEvent;
	import org.apache.royale.events.utils.EditingKeys;
	import org.apache.royale.events.utils.NavigationKeys;
	import org.apache.royale.events.utils.WhitespaceKeys;
	import org.apache.royale.geom.Point;
	import org.apache.royale.geom.Rectangle;
	import org.apache.royale.html.beads.IComboBoxView;
	import org.apache.royale.html.util.getLabelFromData;
	import org.apache.royale.utils.DisplayUtils;
	import org.apache.royale.utils.PointUtils;
	import org.apache.royale.utils.UIUtils;
	import org.apache.royale.utils.callLater;
	import org.apache.royale.utils.loadBeadFromValuesManager;
	
	/**
	 *  The ComboBoxView class creates the visual elements of the ComboBox component.
	 *  
	 */
	public class ComboBoxView extends BeadViewBase implements IComboBoxView
	{
		public function ComboBoxView()
		{
			super();
		}
		private function appendSelector(value:String):String{
			return InputGroupInclude.getSelector() + value;
		}
		private var textfield:TextField;
		
		/**
		 *  The TextInput component of the ComboBox.
		 * 
		 *  @copy org.apache.royale.html.beads.IComboBoxView#text
		 *
		 *  @langversion 3.0
		 *  @playerversion Flash 10.2
		 *  @playerversion AIR 2.6
		 *  @productversion Royale 0.0
		 */
		public function get textInputField():TextField
		{
			return textfield;
		}
		
		private var button:FieldButton;
		
		/**
		 *  The FieldButton component of the ComboBox.
		 * 
		 *  @copy org.apache.royale.html.beads.IComboBoxView#text
		 *
		 *  @langversion 3.0
		 *  @playerversion Flash 10.2
		 *  @playerversion AIR 2.6
		 *  @productversion Royale 0.0
		 */
		public function get popupButton():FieldButton
		{
			return button;
		}
		
		private var list:Menu;
    private var _popup:ComboBoxList;
		
		/**
		 *  The pop-up list component of the ComboBox.
		 * 
		 *  @copy org.apache.royale.html.beads.IComboBoxView#text
		 *
		 *  @langversion 3.0
		 *  @playerversion Flash 10.2
		 *  @playerversion AIR 2.6
		 *  @productversion Royale 0.0
		 */
		public function get popUp():Menu
		{
			return list;
		}
		
		private var comboHost:ComboBox;
    private var model:IComboBoxModel;
		/**
		 * @private
		 * @royaleignorecoercion org.apache.royale.events.IEventDispatcher
		 * @royaleignorecoercion org.apache.royale.core.UIBase
		 */
		override public function set strand(value:IStrand):void
		{
			super.strand = value;
			
			comboHost = value as ComboBox;
			var text:String = comboHost.text;
			textfield = new TextField();
			textfield.tabFocusable = false;
      textfield.className = appendSelector("-textfield");
			textfield.input.classList.add(appendSelector('-input'));
			COMPILE::JS
			{
				textfield.focusElement.addEventListener('focus',function():void{
					comboHost.toggle("is-focused",true);
					_popup.blur();
				});

				textfield.focusElement.addEventListener('blur', function():void{
					comboHost.toggle("is-focused",false);
				});
			}
			textfield.addEventListener(KeyboardEvent.KEY_UP,inputHandler);
			textfield.addEventListener(KeyboardEvent.KEY_DOWN,handleKeyDown);
			if(text)
			{
				textfield.text = text;
			}
			button = new FieldButton();
      button.className = appendSelector("-button");
			var type:String = IconType.CHEVRON_DOWN_MEDIUM;
      button.icon = Icon.getCSSTypeSelector(type);
			button.iconType = type;
      button.iconClass = appendSelector("-icon");

			// if (isNaN(host.width)) input.width = 100;
			
			// COMPILE::JS 
			// {
				// inner components are absolutely positioned so we want to make sure the host is the offset parent
				// if (!host.element.style.position)
				// {
				// 	host.element.style.position = "relative";
				// }
			// }
			model = comboHost.model as IComboBoxModel;
			
			_popup = loadBeadFromValuesManager(ComboBoxList,"iPopUp",_strand) as ComboBoxList;
			_popup.autoFocusList = false;
			_popup.position = "bottom";
      list = _popup.list;
      // list.dataProvider = model.dataProvider;
			// _popup.style = {
			// 	"position": "absolute",
    	// 	"top": "100%",
    	// 	"left": "0",
    	// 	"width": "100%"
			// };

			comboHost.addElement(textfield as IChild);
			comboHost.addElement(button as IChild);
      // host.addElement(_popup);
			list.model.addEventListener("selectedIndexChanged", handleItemChange);
			list.model.addEventListener("selectedItemChanged", handleItemChange);

			model.addEventListener("selectedIndexChanged", handleItemChange);
			model.addEventListener("selectedItemChanged", handleItemChange);
			model.addEventListener("dataProviderChanged", dataProviderChangeHandler);
      model.addEventListener("placeholderChange",handlePlaceholderChange);
      model.addEventListener("patternChange",handlePatternChange);
      model.addEventListener("requiredChange",handleRequiredChange);
      model.addEventListener("disabledChange",handleDisabledChange);
      model.addEventListener("quietChange",handleQuietChange);
      model.addEventListener("invalidChange",handleInvalidChange);
			model.addEventListener("focusChange",focusChangeHandler);
			(_strand as IEventDispatcher).addEventListener("sizeChanged",handleSizeChange);
			
			// set initial value and positions using default sizes
      handlePlaceholderChange(null);
      handlePatternChange(null);
      handleRequiredChange(null);
      handleDisabledChange(null);
      handleQuietChange(null);
			handleInvalidChange(null);

			itemChangeAction();
			// sizeChangeAction();
		}
		// track which provider is being modified to apply the correct one and prevent endless loop
		private var modifyingList:Boolean;
		private function handleKeyDown(event:KeyboardEvent):void
		{
			// forward relevent keys to the list
			switch(event.key){
				case WhitespaceKeys.ENTER:
				case NavigationKeys.DOWN:
				case NavigationKeys.UP:
				case "Escape":
					COMPILE::JS
					{
						var newEvent:Object = cloneNativeKeyboardEvent(event.nativeEvent);
						list.focusParent.element["dispatchEvent"](newEvent);
					}
					break;

					/**
					 * 
					 * event = document.createEvent('KeyboardEvent') as KeyboardEvent;
    event.initKeyboardEvent(options.type, options.cancelable, options.bubbles, window, key, 0, 0, 0, 0);
  } else {
    event = new KeyboardEvent(options.type, eventInitDict)


					 */
			}
			// if(event.key == WhitespaceKeys.ENTER){
			// 	popUpVisible = false;
			// 	return;
			// }
			// var currIndex:int = list.model.selectedIndex;
			// //assuming the provider is always an array
			// var provider:Array = list.dataProvider as Array;
			// var item:MenuItem;
			// var advance:int = 0;
			// modifyingList = true;
			// if(event.key == NavigationKeys.DOWN){
			// 	advance = 1;
			// } else if(event.key == NavigationKeys.UP){
			// 	advance = -1;
			// }
			// while(advance != 0){
			// 	if(currIndex + advance < 0){//went up too far
			// 		advance = 0;
			// 		break;
			// 	}
			// 	item = provider[currIndex + advance];
			// 	if(!item){// went down too far
			// 		advance = 0;
			// 	} else {
			// 		if(item.disabled || item.isDivider || item.isHeading){
			// 			if(advance < 0){// moving up
			// 				advance--;
			// 			} else {//moving down
			// 				advance++;
			// 			}
			// 			continue;
			// 		} else {
			// 			break;
			// 		}
			// 	}
			// }
			// if(advance){
			// 	list.model.selectedIndex = currIndex + advance;
			// }
			// modifyingList = false;

		}
		private var handleInput:Boolean = true;
		private function inputHandler(ev:KeyboardEvent):void{
			if (ev.key.length > 1 && ev.key != EditingKeys.BACKSPACE && ev.key != EditingKeys.DELETE) {// not a simple key (does this work for advanced input?)
					return;// do nothing
			}
			if(textfield.text && model.dataProvider){
				list.dataProvider = comboHost.filterFunction(textfield.text,model.dataProvider);
			} else {
				list.dataProvider = model.dataProvider;
			}
			// show the popup while typing
			var storedIsListEmpty:Boolean = isListEmpty;
			if(!popUpVisible && !storedIsListEmpty){
				popUpVisible = true;
			} else if (storedIsListEmpty)
			{
				popUpVisible = false;
			}
			handleInput = false;
			list.selectedItem = model.selectedItem;
			handleInput = true;
		}
		/**
		 *  Returns whether or not the pop-up is visible.
		 * 
		 *  @copy org.apache.royale.html.beads.IComboBoxView#text
		 *
		 *  @langversion 3.0
		 *  @playerversion Flash 10.2
		 *  @playerversion AIR 2.6
		 *  @productversion Royale 0.0
		 */
		public function get popUpVisible():Boolean
		{
      return _popup.open;
		}
		/**
		 * @royaleignorecoercion org.apache.royale.core.IComboBoxModel
		 * @royaleignorecoercion org.apache.royale.core.IUIBase
		 */
		public function set popUpVisible(value:Boolean):void
		{
			if(value){
				var origin:Point = new Point(0, comboHost.height - 6);
				var relocated:Point = PointUtils.localToGlobal(origin,comboHost);
				_popup.x = relocated.x
				_popup.y = relocated.y;
				_popup.width = comboHost.popupWidth > 0 ? comboHost.popupWidth : comboHost.width;
				list.selectedIndex = -1;

				var popupHost:IPopUpHost = UIUtils.findPopUpHost(comboHost);
				callLater(openPopup);
			} else {
				closePopup();
			}
      // _popup.open = value;
		}
		private var indexSet:Boolean = false;
		private function openPopup():void{
			if(_popup.open){
				return;
			}
			list.dataProvider = model.dataProvider;
			if(list.dataProvider){
				if(!indexSet){
					var zIndex:Number = getExplicitZIndex(comboHost);
					if(zIndex > 2){
						_popup.setStyle("z-index",zIndex);
					}
					indexSet = true;
				}
				_popup.addEventListener(MouseEvent.MOUSE_DOWN, handleControlMouseDown);
				comboHost.addEventListener(MouseEvent.MOUSE_DOWN, handleControlMouseDown);
				comboHost.topMostEventDispatcher.addEventListener(MouseEvent.MOUSE_DOWN, handleTopMostEventDispatcherMouseDown);
				_popup.open = true;
				positionPopup();
			}
			//TODO how to handle keyboard and mouse focus?
			textfield.focus();
		}
		private function positionPopup():void{
			var componentBounds:Rectangle = DisplayUtils.getScreenBoundingRect(comboHost);
			_popup.positionPopup(componentBounds,comboHost.width);
		}
		protected function handleControlMouseDown(event:MouseEvent):void
		{			
			event.stopImmediatePropagation();
		}
		
		protected function handleTopMostEventDispatcherMouseDown(event:MouseEvent):void
		{
      closePopup();
		}

    private function closePopup():void{
      if(_popup){
  			_popup.removeEventListener(MouseEvent.MOUSE_DOWN, handleControlMouseDown);
	  		comboHost.removeEventListener(MouseEvent.MOUSE_DOWN, handleControlMouseDown);
		  	comboHost.topMostEventDispatcher.removeEventListener(MouseEvent.MOUSE_DOWN, handleTopMostEventDispatcherMouseDown);
        _popup.open = false;
      }
			textfield.focus();
		}
		/**
		 * @private
		 */
		protected function handleSizeChange(event:Event):void
		{
			// sizeChangeAction();
		}
		
		/**
		 * @private
		 */
		protected function handleItemChange(event:Event):void
		{
			if(event.target == list.model){
				model.selectedItem = list.selectedItem;
			} else {
				list.selectedItem = model.selectedItem;
			}
			itemChangeAction();
		}
    protected function dataProviderChangeHandler(event:Event):void{
      list.dataProvider = model.dataProvider;
    }

    protected function get isListEmpty():Boolean
    {
	var itemsLength:int = -1;
	if (list.dataProvider is Array)
	{
		itemsLength = (list.dataProvider as Array).length;
	} else if (list.dataProvider is ICollectionView)
	{
		itemsLength = (list.dataProvider as ICollectionView).length;
	}
	return itemsLength == 0;
    }

    protected function handlePlaceholderChange(event:Event):void{
      textfield.placeholder = model.placeholder;
    }
    protected function handlePatternChange(event:Event):void{
      textfield.pattern = model.pattern;
    }
    protected function handleRequiredChange(event:Event):void{
      textfield.required = model.required;
    }
    protected function handleDisabledChange(event:Event):void{
      button.disabled = textfield.disabled = model.disabled;

    }
    protected function handleQuietChange(event:Event):void{
      button.quiet = textfield.quiet = model.quiet;
			comboHost.toggle(InputGroupInclude.getSelector()+ "--quiet",model.quiet);
    }
		protected function handleInvalidChange(event:Event):void{
      button.invalid = textfield.invalid = model.invalid;
			comboHost.toggle("is-invalid",model.invalid);

		}
		private function focusChangeHandler(event:Event):void{
			comboHost.toggle("is-keyboardFocused",model.keyboardFocused);
			comboHost.toggle("is-focused",model.focused);
			if(model.limitToList && !model.focused && textfield?.text){
				var exist:Boolean = false;
				for each(var item:MenuItem in model.dataProvider){
					if(item.text && item.text.toLowerCase() == textfield.text.toLowerCase()){
						exist = true;
						textfield.text = item.text;
						break;
					}
				}
				if(!exist){
					textfield.text = "";
				}
			}
		}
		/**
		 * @private
		 * @royaleignorecoercion org.apache.royale.core.IComboBoxModel
		 */
		protected function itemChangeAction():void
		{
			if(model.selectedItem != list.selectedItem){
				if(modifyingList){
					model.selectedItem = list.selectedItem;
				} else {
					list.selectedItem = model.selectedItem;
				}
			}
			var item:Object = model.selectedItem;
			var text:String = getLabelFromData(list,item);
			if(handleInput && text){
				textfield.text = text;
			}
		}
		
		/**
		 * @private
		 * @royaleignorecoercion org.apache.royale.core.UIBase
		 */
		// protected function sizeChangeAction():void
		// {
		// 	var host:ComboBox = _strand as ComboBox;
			
		// 	input.x = 0;
		// 	input.y = 0;
		// 	if (host.isWidthSizedToContent()) {
		// 		input.width = 100;
		// 	} else {
		// 		input.width = host.width - 20;
		// 	}
			
		// 	button.x = input.width;
		// 	button.y = 0;
		// 	button.width = 20;
		// 	button.height = input.height;
			
		// 	COMPILE::JS {
		// 		input.element.style.position = "absolute";
		// 		button.element.style.position = "absolute";
		// 	}
				
		// 	if (host.isHeightSizedToContent()) {
		// 		host.height = input.height;
		// 	}
		// 	if (host.isWidthSizedToContent()) {
		// 		host.width = input.width + button.width;
		// 	}
		// }
	}
}

/**
<h4>Default</h4>
<div class="spectrum-InputGroup">
  <input type="text" placeholder="Type here" name="field" value="" class="spectrum-Textfield spectrum-InputGroup-field">
  <button class="spectrum-FieldButton spectrum-InputGroup-button" aria-haspopup="true">
    <svg class="spectrum-Icon spectrum-UIIcon-ChevronDownMedium spectrum-InputGroup-icon" focusable="false" aria-hidden="true">
      <use xlink:href="#spectrum-css-icon-ChevronDownMedium" />
    </svg>
  </button>
</div>

Properties:
placeholder
public var pattern:String;
public var required:Boolean;
public var disabled:Boolean;

When open, the button is selected...

<h4>Open</h4>
<div class="spectrum-InputGroup is-open">
  <input type="text" placeholder="Type here" name="field" value="" class="spectrum-Textfield spectrum-InputGroup-field">
  <button class="spectrum-FieldButton spectrum-InputGroup-button is-selected" aria-haspopup="true">
    <svg class="spectrum-Icon spectrum-UIIcon-ChevronDownMedium spectrum-InputGroup-icon" focusable="false" aria-hidden="true">
      <use xlink:href="#spectrum-css-icon-ChevronDownMedium" />
    </svg>
  </button>
  <div class="spectrum-Popover spectrum-Popover--bottom is-open" style="position: absolute; top: 100%; left: 0; width: 100%">
    <ul class="spectrum-Menu" role="listbox">
      <li class="spectrum-Menu-item is-selected" role="option" tabindex="0">
        <span class="spectrum-Menu-itemLabel">Ballard</span>
      </li>
      <li class="spectrum-Menu-item" role="option" tabindex="0">
        <span class="spectrum-Menu-itemLabel">Fremont</span>
      </li>
      <li class="spectrum-Menu-item" role="option" tabindex="0">
        <span class="spectrum-Menu-itemLabel">Greenwood</span>
      </li>
      <li class="spectrum-Menu-divider" role="separator"></li>
      <li class="spectrum-Menu-item is-disabled" role="option" aria-disabled="true">
        <span class="spectrum-Menu-itemLabel">United States of America</span>
      </li>
    </ul>
  </div>
</div>

<div class="dummy-spacing"></div>

<h4>Disabled</h4>
<div class="spectrum-InputGroup is-disabled">
  <input type="text" placeholder="Type here" name="field" value="" class="spectrum-Textfield spectrum-InputGroup-field" disabled>
  <button class="spectrum-FieldButton spectrum-InputGroup-button" aria-haspopup="true" disabled>
    <svg class="spectrum-Icon spectrum-UIIcon-ChevronDownMedium spectrum-InputGroup-icon" focusable="false" aria-hidden="true">
      <use xlink:href="#spectrum-css-icon-ChevronDownMedium" />
    </svg>
  </button>
</div>

<h4>Invalid</h4>
<div class="spectrum-InputGroup is-invalid">
  <input type="text" placeholder="Type here" name="field" value="" class="spectrum-Textfield spectrum-InputGroup-field is-invalid">
  <button class="spectrum-FieldButton spectrum-InputGroup-button is-invalid" aria-haspopup="true">
    <svg class="spectrum-Icon spectrum-UIIcon-ChevronDownMedium spectrum-InputGroup-icon" focusable="false" aria-hidden="true">
      <use xlink:href="#spectrum-css-icon-ChevronDownMedium" />
    </svg>
  </button>
</div>
 */