package com.unhurdle.spectrum
{
	COMPILE::JS
	{
		import org.apache.royale.core.WrappedHTMLElement;
	}
	import com.unhurdle.spectrum.const.IconType;

	public class TextArea extends TextFieldBase
	{
		public function TextArea()
		{
			super();
			toggle(valueToSelector("multiline"),true);
			textarea.addEventListener("input",checkValidation);
		}

		private var textarea:HTMLTextAreaElement;

			
		public function get readonly():Boolean
		{
			return textarea.readOnly;
		}

		public function set readonly(value:Boolean):void
		{
			textarea.readOnly = value;
		}
		
		public function get placeholder():String
		{
			return textarea.placeholder;
		}

		public function set placeholder(value:String):void
		{
			//set the content in the textArea
			textarea.placeholder = value;
		}
		// private var _multiline:Boolean;
		// public function get multiline():Boolean
		// {
		//     return _multiline;
		// }
		// public function set multiline(value:Boolean):void
		// {
		//     if(value != !!_multiline){
		//         toggle(valueToSelector("multiline"),value);
		//     }
		//     _multiline = value;
		// }

		// COMPILE::SWF
		// override public function get name():String
		// {
		// 	return super.name;
		// }
		// COMPILE::SWF
		// override public function set name(value:String):void
		// {
		// 	super.name = value;
		// }

		COMPILE::JS
		public function get name():String
		{
			return textarea.name;
		}
		
		COMPILE::JS
		public function set name(value:String):void
		{
			textarea.name = value;
		}

		override public function get text():String
		{
			return textarea.value;
		}
		
		override public function set text(value:String):void
		{
			textarea.value = value;
			checkValidation();
		}
		private var _maxLength:Number = Number.MAX_VALUE;

		public function get maxLength():Number
		{
			return _maxLength;
		}
		
		public function set maxLength(value:Number):void
		{
			_maxLength = value;
			if(text){
				checkValidation();
			}
		}
		private var _minLength:Number = Number.MIN_VALUE;

		public function get minLength():Number
		{
			return _minLength;
		}
		
		public function set minLength(value:Number):void
		{
			_minLength = value;
			if(text){
				checkValidation();
			}
		}

		//name???
		//lang?????

		override public function get disabled():Boolean
		{
			return super.disabled;
		}
		override public function set disabled(value:Boolean):void
		{
			if(value != !!super.disabled){
				textarea.disabled = value;
			}
			super.disabled = value;
		}

		private var _required:Boolean;

		public function get required():Boolean
		{
			return _required;
		}
		
		public function set required(value:Boolean):void
		{
			if(value != !!_required){
				textarea.required = value;
			}
			_required = value;
		}
		
		public var showValidIcon:Boolean = true;
    public var showInvalidIcon:Boolean = true;
		private var validIcon:Icon;
		private var invalidIcon:Icon;
		override public function get valid():Boolean
		{
			return super.valid;
		}

		override public function set valid(value:Boolean):void
		{
			super.valid = value;
      if (!showValidIcon){
        return;
      }
      if(value){
        if(!validIcon){
          var type:String = IconType.CHECKMARK_MEDIUM;
          validIcon = new Icon(Icon.getCSSTypeSelector(type));
          validIcon.className = appendSelector("-validationIcon");
          validIcon.type = type;
        }
        //if icon doesn't exist
        if(getElementIndex(validIcon) == -1){
          addElementAt(validIcon,0);
        }
        if(invalidTooltip){
          invalidTooltip.toolTip = '';
        }
      } else{
        if(validIcon && getElementIndex(validIcon) != -1){
          removeElement(validIcon);
        }
      }
		}

		private var _invalidText:String;

    public function get invalidText():String
    {
      return _invalidText;
    }

    public function set invalidText(value:String):void
    {
      _invalidText = value;
      applyInvalidToolTip();
    }

		private var _invalidAutoClose:Number = 0;
    public function get invalidAutoClose():Number
    {
    	return _invalidAutoClose;
    }

    public function set invalidAutoClose(value:Number):void
    {
    	_invalidAutoClose = value;
      if(invalidTooltip) {
        invalidTooltip.autoClose = value;
      }
    }

		override public function get invalid():Boolean
		{
			return super.invalid;
		}
		protected var invalidTooltip:AdaptiveTooltipBead;

		override public function set invalid(value:Boolean):void
		{
			super.invalid = value;
      if (!showInvalidIcon){
        return;
      }
      if(value){
        if(!invalidIcon){
          var type:String = IconType.ALERT_MEDIUM;
          invalidIcon = new Icon(Icon.getCSSTypeSelector(type));
          invalidIcon.className = appendSelector("-validationIcon");
          invalidIcon.type = type;
          invalidIcon.setStyle('box-sizing', 'content-box');
        }
        if(getElementIndex(invalidIcon) == -1){
          addElementAt(invalidIcon,0);
        }
        applyInvalidToolTip();
      } else{
        if(invalidIcon  && getElementIndex(invalidIcon) != -1){
          removeElement(invalidIcon);
        }
				if(invalidTooltip){
					invalidTooltip.toolTip = '';
				}
      }
		}

		public function applyInvalidToolTip():void {
      if (!invalidIcon) {
        return;
      }
      if (invalidTooltip) {
        invalidTooltip.toolTip = invalidText;
        return;
      }
      if (!invalidText || !invalidIcon) {
        return;
      }
      invalidTooltip = new AdaptiveTooltipBead();
      invalidTooltip.flavor = "negative";
      invalidIcon.addBead(invalidTooltip);
      invalidIcon.setStyle("pointer-events","auto");
      invalidTooltip.autoClose = invalidAutoClose;
      COMPILE::JS{
            invalidIcon.width = invalidIcon.element.clientWidth;
            invalidIcon.height = invalidIcon.element.clientHeight;
      }
      invalidTooltip.toolTip = invalidText;
    };

		private function checkValidation():void
		{
			if(maxLength != Number.MAX_VALUE || minLength != Number.MIN_VALUE){
				var len:Number = textarea.value.length;
				if(len <= maxLength && len >= minLength){
					valid = true;
				} else{
					invalid = true;
				}
			}
		}
		override public function get focusElement():HTMLElement{
		return textarea;
		}

		COMPILE::JS
		override protected function createElement():WrappedHTMLElement{
			var elem:WrappedHTMLElement = super.createElement();
			textarea = newElement("textarea",appendSelector("-input")) as HTMLTextAreaElement;
			elem.appendChild(textarea);
			return elem;
		}
	}
}