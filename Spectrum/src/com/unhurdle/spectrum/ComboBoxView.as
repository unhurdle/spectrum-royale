package com.unhurdle.spectrum{
	import org.apache.royale.core.BeadViewBase;
	import org.apache.royale.core.IUIBase;
	import org.apache.royale.core.IStrand;
	import org.apache.royale.core.ValuesManager;
	import org.apache.royale.events.IEventDispatcher;
	import org.apache.royale.events.Event;
	import org.apache.royale.utils.UIUtils;
	import org.apache.royale.utils.PointUtils;
	import org.apache.royale.core.IPopUpHost;
	import org.apache.royale.geom.Point;
	import org.apache.royale.html.beads.IComboBoxView;
	import org.apache.royale.html.util.getLabelFromData;
	import org.apache.royale.core.IChild;
	import org.apache.royale.utils.callLater;
	import org.apache.royale.events.MouseEvent;
	import com.unhurdle.spectrum.const.IconType;
	import com.unhurdle.spectrum.includes.InputGroupInclude;
	
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
		private var input:TextField;
		
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
		public function get textInputField():Object
		{
			return input;
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
		public function get popupButton():Object
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
		public function get popUp():Object
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
			
			input = new TextField();
      input.className = appendSelector("-field");
			COMPILE::JS
			{
				input.element.addEventListener('focus',function():void{
					comboHost.toggle("is-focused",true);
				});

				input.element.addEventListener('blur', function():void{
					comboHost.toggle("is-focused",false);
				});
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
			model = _strand.getBeadByType(IComboBoxModel) as IComboBoxModel;
			
			var popUpClass:Class = ValuesManager.valuesImpl.getValue(_strand, "iPopUp") as Class;

			_popup = (new popUpClass() as ComboBoxList);
			_popup.position = "bottom";
      list = _popup.list;
      // list.dataProvider = model.dataProvider;
			list.model = model;
			// _popup.style = {
			// 	"position": "absolute",
    	// 	"top": "100%",
    	// 	"left": "0",
    	// 	"width": "100%"
			// };

			comboHost.addElement(input as IChild);
			comboHost.addElement(button as IChild);
      // host.addElement(_popup);

			model.addEventListener("selectedIndexChanged", handleItemChange);
			model.addEventListener("selectedItemChanged", handleItemChange);
			model.addEventListener("dataProviderChanged", dataProviderChangeHandler);
      model.addEventListener("placeholderChange",handlePlaceholderChange);
      model.addEventListener("patternChange",handlePatternChange);
      model.addEventListener("requiredChange",handleRequiredChange);
      model.addEventListener("disabledChange",handleDisabledChange);
      model.addEventListener("quietChange",handleQuietChange);
      model.addEventListener("invalidChange",handleInvalidChange);
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
				_popup.width = comboHost.width;
				list.selectedIndex = -1;

				var popupHost:IPopUpHost = UIUtils.findPopUpHost(comboHost);
				callLater(openPopup)
				_popup.addEventListener(MouseEvent.MOUSE_DOWN, handleControlMouseDown);
				comboHost.addEventListener(MouseEvent.MOUSE_DOWN, handleControlMouseDown);
				callLater(function():void {
					_popup.topMostEventDispatcher.addEventListener(MouseEvent.MOUSE_DOWN, handleTopMostEventDispatcherMouseDown);
				});
			} else {
				closePopup();
			}
      // _popup.open = value;
		}
		private function openPopup():void{
			_popup.open = true;
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
      if(_popup && _popup.open){
  			_popup.removeEventListener(MouseEvent.MOUSE_DOWN, handleControlMouseDown);
	  		this.removeEventListener(MouseEvent.MOUSE_DOWN, handleControlMouseDown);
		  	_popup.topMostEventDispatcher.removeEventListener(MouseEvent.MOUSE_DOWN, handleTopMostEventDispatcherMouseDown);
        _popup.open = false;
      }
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
			itemChangeAction();
		}
    protected function dataProviderChangeHandler(event:Event):void{
      list.dataProvider = model.dataProvider;
    }
    protected function handlePlaceholderChange(event:Event):void{
      input.placeholder = model.placeholder;
    }
    protected function handlePatternChange(event:Event):void{
      input.pattern = model.pattern;
    }
    protected function handleRequiredChange(event:Event):void{
      input.required = model.required;
    }
    protected function handleDisabledChange(event:Event):void{
      button.disabled = input.disabled = model.disabled;

    }
    protected function handleQuietChange(event:Event):void{
      button.quiet = input.quiet = model.quiet;
			comboHost.toggle(InputGroupInclude.getSelector()+ "--quiet",model.quiet);
    }
		protected function handleInvalidChange(event:Event):void{
      button.invalid = input.invalid = model.invalid;
			comboHost.toggle("is-invalid",model.quiet);

		}
		/**
		 * @private
		 * @royaleignorecoercion org.apache.royale.core.IComboBoxModel
		 */
		protected function itemChangeAction():void
		{
			var text:String = getLabelFromData(list,model.selectedItem);
			if(text){
				input.text = text;
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