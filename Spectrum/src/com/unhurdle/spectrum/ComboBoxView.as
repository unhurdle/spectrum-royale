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
	
	/**
	 *  The ComboBoxView class creates the visual elements of the org.apache.royale.html.ComboBox 
	 *  component. The job of the view bead is to put together the parts of the ComboBox such as the TextInput
	 *  control and org.apache.royale.html.Button to trigger the pop-up.
	 *  
	 *  @viewbead
	 *  @langversion 3.0
	 *  @playerversion Flash 10.2
	 *  @playerversion AIR 2.6
	 *  @productversion Royale 0.0
	 */
	public class ComboBoxView extends BeadViewBase implements IComboBoxView
	{
		public function ComboBoxView()
		{
			super();
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
		
		private var button:Button;
		
		/**
		 *  The Button component of the ComboBox.
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
		
		private var list:List;
    private var _popup:Popover
		
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
		
		/**
		 * @private
		 * @royaleignorecoercion org.apache.royale.events.IEventDispatcher
		 * @royaleignorecoercion org.apache.royale.core.UIBase
		 */
		override public function set strand(value:IStrand):void
		{
			super.strand = value;
			
			var host:ComboBox = value as ComboBox;
			
			input = new TextField();
      input.className = "spectrum-InputGroup-field";
			
			button = new Button();
			button.text = '\u25BC';
			
			if (isNaN(host.width)) input.width = 100;
			
			COMPILE::JS 
			{
				// inner components are absolutely positioned so we want to make sure the host is the offset parent
				if (!host.element.style.position)
				{
					host.element.style.position = "relative";
				}
			}
			host.addElement(input as IChild);
			host.addElement(button as IChild);
			
			var popUpClass:Class = ValuesManager.valuesImpl.getValue(_strand, "iPopUp") as Class;
			list = (new popUpClass() as ComboBoxList).list;
			list.visible = false;
			
			var model:IComboBoxModel = _strand.getBeadByType(IComboBoxModel) as IComboBoxModel;
			model.addEventListener("selectedIndexChanged", handleItemChange);
			model.addEventListener("selectedItemChanged", handleItemChange);
			
			IEventDispatcher(_strand).addEventListener("sizeChanged", handleSizeChange);
			
			// set initial value and positions using default sizes
			itemChangeAction();
			sizeChangeAction();
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
      _popup.open = value;
		}
		
		/**
		 * @private
		 */
		protected function handleSizeChange(event:Event):void
		{
			sizeChangeAction();
		}
		
		/**
		 * @private
		 */
		protected function handleItemChange(event:Event):void
		{
			itemChangeAction();
		}
		
		/**
		 * @private
		 * @royaleignorecoercion org.apache.royale.core.IComboBoxModel
		 */
		protected function itemChangeAction():void
		{
			var model:IComboBoxModel = _strand.getBeadByType(IComboBoxModel) as IComboBoxModel;
			input.text = getLabelFromData(model,model.selectedItem);
		}
		
		/**
		 * @private
		 * @royaleignorecoercion org.apache.royale.core.UIBase
		 */
		protected function sizeChangeAction():void
		{
			var host:ComboBox = _strand as ComboBox;
			
			input.x = 0;
			input.y = 0;
			if (host.isWidthSizedToContent()) {
				input.width = 100;
			} else {
				input.width = host.width - 20;
			}
			
			button.x = input.width;
			button.y = 0;
			button.width = 20;
			button.height = input.height;
			
			COMPILE::JS {
				input.element.style.position = "absolute";
				button.element.style.position = "absolute";
			}
				
			if (host.isHeightSizedToContent()) {
				host.height = input.height;
			}
			if (host.isWidthSizedToContent()) {
				host.width = input.width + button.width;
			}
		}
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