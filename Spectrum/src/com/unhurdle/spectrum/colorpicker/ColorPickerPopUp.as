package com.unhurdle.spectrum.colorpicker
{
	import org.apache.royale.core.IStrand;
	import org.apache.royale.events.Event;
	import com.unhurdle.spectrum.Popover;
	import com.unhurdle.spectrum.ISpectrumElement;
	import com.unhurdle.spectrum.Group;
	import com.unhurdle.spectrum.ColorSlider;
	import com.unhurdle.spectrum.AlphaColorSlider;
	import com.unhurdle.spectrum.interfaces.IColorPopover;
	import com.unhurdle.spectrum.interfaces.IRGBA;
	import com.unhurdle.spectrum.ColorArea;
	import com.unhurdle.spectrum.FlexContainer;
	import com.unhurdle.spectrum.List;
	import com.unhurdle.spectrum.beads.TileLayout;
	import org.apache.royale.collections.IArrayList;
	import org.apache.royale.collections.ICollectionView;
	import org.apache.royale.events.ValueEvent;
	import org.apache.royale.utils.rgbToHsv;
	import com.unhurdle.spectrum.ColorSwatch;
	import com.unhurdle.spectrum.data.RGBColor;
	import com.unhurdle.spectrum.Button;
	import com.unhurdle.spectrum.DialogFooter;
	import com.unhurdle.spectrum.ButtonGroup;
	import org.apache.royale.html.elements.Div;
	import com.unhurdle.spectrum.SwatchList;
	import org.apache.royale.core.IFactory;
	import org.apache.royale.utils.DisplayUtils;
	import org.apache.royale.geom.Rectangle;
	import com.unhurdle.spectrum.utils.getDataProviderItem;

	[Event(name="colorChanged", type="comorg.apache.royale.events.ValueEvent")]
	[Event(name="colorCommit", type="org.apache.royale.events.ValueEvent")]
	[Event(name="cancel", type="org.apache.royale.events.Event")]
	public class ColorPickerPopUp extends Popover implements IColorPopover
	{
		public function ColorPickerPopUp(){
			super();
			dialog=true;
			tipDialog=true;
			floating = true;
			// The css min size should not be necessary
			setStyle("min-width","32px");
			mainContainer = new FlexContainer();
			mainContainer.vertical = true;
			//TODO don't hard-code these values
			mainContainer.setStyle("max-width","304px");
			// mainContainer.alignItems  = "stretch";
			addElement(mainContainer);
		}
		protected var mainContainer:FlexContainer;
		protected var colorArea:ColorArea;
		protected var hueSelector:ColorSlider;
		protected var alphaSelector:AlphaColorSlider;
		protected var swatchList:SwatchList;
		protected var host:IStrand;
		
		private var _colorTextField:ColorTextField;
		public function get colorTextField():ColorTextField{
			return _colorTextField;
		}

		private var _alphaTextField:AlphaTextField;
		public function get alphaTextField():AlphaTextField{
			return _alphaTextField;
		}
		protected var fixedSizeContainer:Group;
		protected var padding:Number = 16;

		private function preventPropogation(element:ISpectrumElement):void{
			element.addEventListener("change", function(e:Event):void{
				e.stopImmediatePropagation();
			});
		}
		override public function set open(value:Boolean):void{
			if(value){
				// Setup the contents
				setupList();
				setupControls();
				setupFields();
				setupSwatch()
				setupButtons();
				updateValues(appliedColor,false,false);
			}
			super.open = value;
		}
		override public function addedToParent():void{
			// Set the width of main container
			if(showColorControls){
				var controlBounds:Rectangle = DisplayUtils.getScreenBoundingRect(controlSection);
				var sliderBounds:Rectangle;
				if(alphaSelector){
					sliderBounds = DisplayUtils.getScreenBoundingRect(alphaSelector);
				} else {
					sliderBounds = DisplayUtils.getScreenBoundingRect(hueSelector);
				}
					mainContainer.width = sliderBounds.right - controlBounds.left;
			} else if(preferredColumns != 0){
				var requestedWidth:Number = -4 + (preferredColumns * 28);
				requestedWidth = Math.max(requestedWidth,24);
				mainContainer.setStyle("max-width", requestedWidth + "px");
			}
			// now position it, etc.
			super.addedToParent();
		}
		private var _itemRenderer:IFactory;
		public function get itemRenderer():IFactory{
			return _itemRenderer;
		}
		public function set itemRenderer(value:IFactory):void{
			_itemRenderer = value;
		}
		private function setupList():void{
			if(dataProvider){
				if(!swatchList){
					swatchList = new SwatchList();
					swatchList.columnGap = 4;
					swatchList.rowGap = 4;
					swatchList.setStyle("margin","-2px");
					if(showColorControls || showSelectionSwatch){
						swatchList.setStyle("margin-bottom","14px");
					} else {
						// default to -2
						swatchList.setStyle("margin-bottom","");
					}
					swatchList.addEventListener("change",onSwatchChange);
					mainContainer.addElement(swatchList);
				}
				swatchList.dataProvider = dataProvider;
				// set the selected swatch if any.
				var color:IRGBA = appliedColor;
				var colorIndex:int = -1;
				if(dataProvider is Array){
					colorIndex = (dataProvider as Array).indexOf(color);
				} else if(dataProvider is IArrayList || dataProvider is ICollectionView){
					colorIndex = (dataProvider as IArrayList).getItemIndex(color);
				} else if(dataProvider["length"]){
					var length:int = dataProvider["length"];
					for(var i:int=0;i<length;i++){
						if(dataProvider[i] == color){
							colorIndex = i;
							break;
						}
					}
				}
				swatchList.selectedIndex = colorIndex;
			}
		}
		private function onSwatchChange(ev:Event):void{
			var color:IRGBA = swatchList.selectedItem as IRGBA;
			if(appliedColor != color){
				appliedColor = color;
				updateValues(color,false,false);
				dispatchEvent(new ValueEvent("colorChanged",appliedColor));
			}

			trace('onSwatchChange');
			trace(ev);
		}
		protected var controlSection:FlexContainer;
		private function setupControls():void{
			if(showColorControls){
				if(!controlSection){
					controlSection = new FlexContainer();
					controlSection.vertical = false;
					controlSection.setStyle("margin-bottom","16px");
					controlSection.alignItems = "stretch";
					mainContainer.addElement(controlSection);
				}
				// first color area
				if(!colorArea){
					colorArea = new ColorArea();
					colorArea.size = areaSize;
					colorArea.addEventListener("colorChanged",handleColorAreaChange);
					// add event listener -- which?
					controlSection.addElement(colorArea);
				}
				// set the colorArea color
				colorArea.appliedColor = appliedColor;
				// then hue slider
				if(!hueSelector){
					hueSelector = new ColorSlider();
					hueSelector.vertical = true;
					hueSelector.height = areaSize;
					hueSelector.addEventListener("colorChanged",handleHueChange);
					hueSelector.setStyle("margin-left",padding+"px");
					controlSection.addElement(hueSelector);
				}
				hueSelector.appliedColor = appliedColor;

			}
			setupAlpha();
		}
		private function handleColorAreaChange(ev:ValueEvent):void{
			var color:IRGBA = (ev.value as IRGBA).clone();
			color.alpha = appliedColor.alpha;
			updateValues(color);
			appliedColor = color;
			dispatchEvent(new ValueEvent("colorChanged",appliedColor));
			trace('handleColorAreaChange');
			trace(ev);
		}
		private function handleHueChange(ev:ValueEvent):void{
			var c:IRGBA = hueSelector.appliedColor;
			colorArea.hue = rgbToHsv(c.r,c.g,c.b).h;
			var modifiedColor:RGBColor = RGBColor.fromHSV(colorArea.hsv);
			modifiedColor.alpha = appliedColor.alpha;
			updateValues(modifiedColor);
			appliedColor = modifiedColor;
			dispatchEvent(new ValueEvent("colorChanged",appliedColor));
		}
		private function setupAlpha():void{
			if(showColorControls && showAlphaControls){
				if(!alphaSelector){
					alphaSelector = new AlphaColorSlider();
					alphaSelector.vertical = true;
					alphaSelector.height = areaSize;
					alphaSelector.addEventListener("colorChanged",handleAlphaChange);
					alphaSelector.setStyle("margin-left",padding+"px");
					controlSection.addElement(alphaSelector);
				}
				alphaSelector.appliedColor = appliedColor;
			}
		}
		private function handleAlphaChange(ev:ValueEvent):void{
			//TODO, do we keep the color selection in the list? Assuming not.
			var newColor:IRGBA = appliedColor.clone();
			newColor.alpha = alphaSelector.appliedColor.alpha;
			appliedColor = newColor;
			updateValues(newColor);
			dispatchEvent(new ValueEvent("colorChanged",appliedColor));
			trace("handleAlphaChange");
			trace(ev);
		}
		protected var fieldContainer:FlexContainer;
		private function getFieldContainer():FlexContainer{
			if(!fieldContainer){
				fieldContainer = new FlexContainer();
				fieldContainer.vertical = false;
				mainContainer.addElement(fieldContainer);
			}
			return fieldContainer;
		}
		private function setupFields():void{
			if(showColorControls){
				getFieldContainer();
				if(!_colorTextField){
					_colorTextField = new ColorTextField();
					_colorTextField.width = 75;
					if(hexEditable){
						_colorTextField.addEventListener("inputFinished", colorTextFieldChangeHandler);
					} else {
						_colorTextField.readonly = true;
					}
					preventPropogation(_colorTextField);
					fieldContainer.addElement(_colorTextField);
				}
				_colorTextField.text =  appliedColor.hexString;
				if(showAlphaControls){
					if(!_alphaTextField){
						_alphaTextField = new AlphaTextField();
						_alphaTextField.width = 50;
						_alphaTextField.setStyle("margin-left","20px");
						_alphaTextField.addEventListener("inputFinished", alphaTextFieldChangeHandler);
						preventPropogation(_alphaTextField);
						fieldContainer.addElement(_alphaTextField);
					}
				}
			}

		}
		protected function updateValues(color:IRGBA,findListSelection:Boolean=true,resetListSelection:Boolean=true):void{
			if(colorTextField){
				colorTextField.text = color.hexString;
			}
			if(alphaTextField){
				if(color.isValid){
					alphaTextField.text = isNaN(color.alpha) ? "100%" : Math.round(color.alpha * 100) + "%";
				} else {
					alphaTextField.text = "";
				}
			}
			// all the controls clone the color before applying
			if(colorArea){
				colorArea.appliedColor = color;
			}
			if(hueSelector){
				hueSelector.appliedColor = color;
			}
			if(alphaSelector){
				alphaSelector.appliedColor = color;
			}
			if(colorArea){
				colorArea.appliedColor = color;
			}
			if(currentSwatch){
				currentSwatch.color = color;
			}
			if(swatchList){
				var selectedIndex:int = -1;
				if(findListSelection){
					var len:int = dataProvider.length;
					var styleString:String = color.styleString;
					for(var i:int=0;i<len;i++){
						var item:IRGBA = getDataProviderItem(dataProvider,i) as IRGBA;
						if(styleString == item.styleString){
							selectedIndex = i;
							break;
						}
					}
				}
				if(selectedIndex >= 0 || resetListSelection){
					swatchList.selectedIndex = selectedIndex;
				}
			}
		}

		private var originalColor:IRGBA;
		private var startSwatch:ColorSwatch;
		private var currentSwatch:ColorSwatch;
		private var swatchContainer:FlexContainer;
		private function setupSwatch():void{
			if(!showSelectionSwatch){
				return;
			}
			if(!swatchContainer){
				swatchContainer = new FlexContainer();
				swatchContainer.vertical = false;
				// fill the remaining space and align the swatches right
				swatchContainer.flexGrow = 1;
				swatchContainer.justifyContent = "flex-end";
				getFieldContainer().addElement(swatchContainer);
			}
			if(!startSwatch){
				startSwatch = new ColorSwatch();
				startSwatch.size = 40;
				startSwatch.width = 32;
				startSwatch.squareRight = true;
				swatchContainer.addElement(startSwatch);
			}
			startSwatch.color = appliedColor.clone();
			if(!currentSwatch){
				currentSwatch = new ColorSwatch();
				currentSwatch.size = 40;
				currentSwatch.width = 32;
				currentSwatch.squareLeft = true;
				swatchContainer.addElement(currentSwatch);
			}

			currentSwatch.color = appliedColor.clone();
		}

		private function colorTextFieldChangeHandler(event:Event):void{
			trace('colorTextFieldChangeHandler');
			trace(event);
			var value:String = _colorTextField.text.replace(/#/g,"");
			var textColor:RGBColor = new RGBColor();			
			textColor.colorValue = parseInt("0x"+value,16);
			var thisColor:IRGBA = appliedColor;
			if(textColor.r != thisColor.r || textColor.g != thisColor.g || textColor.b != thisColor.b){
				//TODO figure out if the color changed
				//The color changed
				textColor.alpha = thisColor.alpha;
				this.appliedColor = textColor;
				//TODO what to dispatch?
			}
      // (model as IColorModel).color = (_colorTextField.model as IColorModel).color;
		}

		private var applyButton:Button;
		private var cancelButton:Button;
		private var footer:DialogFooter;
		private var footerGroup:ButtonGroup;
		private function setupButtons():void{
			if(showApplyButtons){
				if(!footer){
					footer = new DialogFooter();
					this.addElement(footer);
				}
				if(!footerGroup){
					footerGroup = new ButtonGroup();
					footerGroup.vertical = false;
					footer.addElement(footerGroup);
				}
				if(!applyButton){
					applyButton = new Button();
					applyButton.flavor = "cta";
					applyButton.addEventListener("click",applyClicked);
					footerGroup.addElement(applyButton);
				}
				applyButton.text = applyText;
				
				if(!cancelButton){
					cancelButton = new Button();
					cancelButton.addEventListener("click",cancelClicked);
					footerGroup.addElement(cancelButton);
				}
				cancelButton.text = cancelText;
			}
		}

		private function applyClicked(ev:Event):void{
			//TODO
			dispatchEvent(new ValueEvent("colorCommit",appliedColor));
			trace("applyClicked");
			trace(ev);
		}

		private function cancelClicked(ev:Event):void{
			//TODO
			dispatchEvent(new Event("cancel"));
			trace("cancelClicked");
			trace(ev);
		}

		private function alphaTextFieldChangeHandler(event:Event):void{
			trace('alphaTextFieldChangeHandler');
			trace(event);
			//TODO figure out if the alpha changed
			//(model as ArrayColorSelectionWithAlphaModel).alpha = (100 - (_alphaTextField.model as IRangeModel).value) / 100;
		}
		private var _appliedColor:IRGBA;
		public function get appliedColor():IRGBA{
			return _appliedColor;
		}
		public function set appliedColor(value:IRGBA):void{
			_appliedColor = value;
		}

		private var _showSelectionSwatch:Boolean;
		public function get showSelectionSwatch():Boolean{
			return _showSelectionSwatch;
		}
		public function set showSelectionSwatch(value:Boolean):void{
			_showSelectionSwatch = value;
		}

		private var _showAlphaControls:Boolean;
		public function get showAlphaControls():Boolean{
			return _showAlphaControls;
		}
		public function set showAlphaControls(value:Boolean):void{
			_showAlphaControls = value;
		}

		private var _cancelText:String = "Cancel";
		public function get cancelText():String{
			return _cancelText
		}
		public function set cancelText(value:String):void{
			_cancelText = value;
		}

		private var _showColorControls:Boolean;
		public function get showColorControls():Boolean{
			return _showColorControls;
		}
		public function set showColorControls(value:Boolean):void{
			_showColorControls = value;
		}
		private var _hexEditable:Boolean;
		/**
		 * Whether the hex value is editable
		 */
		public function get hexEditable():Boolean{
			return _hexEditable;
		}
		public function set hexEditable(value:Boolean):void{
			_hexEditable = value;
		}
		private var _dataProvider:Object;
		public function get dataProvider():Object{
			return _dataProvider;
		}
		public function set dataProvider(value:Object):void{
			_dataProvider = value;
			if(swatchList){
				swatchList.dataProvider = value;
			}
		}

		private var _applyText:String = "Apply";
		public function get applyText():String{
			return _applyText;
		}
		public function set applyText(value:String):void{
			_applyText = value;
		}

		private var _showApplyButtons:Boolean;
		public function get showApplyButtons():Boolean{
			return _showApplyButtons;
		}

		public function set showApplyButtons(value:Boolean):void{
			_showApplyButtons = value;
		}

		private var _areaSize:Number = 196;// technically the default should be 240 on mobile
		public function get areaSize():Number{
			return _areaSize;
		}
		public function set areaSize(value:Number):void{
			_areaSize = value;
		}
		private var _preferredColumns:int
		public function get preferredColumns():int{
			return _preferredColumns;
		}
		public function set preferredColumns(value:int):void{
			_preferredColumns = value;
		}
	}
}
