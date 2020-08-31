package com.unhurdle.spectrum
{    
    COMPILE::JS
    {
        import org.apache.royale.html.util.addElementToWrapper;
        import org.apache.royale.core.WrappedHTMLElement;
        import com.unhurdle.spectrum.const.IconType;
    }

    public class TextArea extends TextFieldBase
    {
        public function TextArea()
        {
            super();
            toggle(valueToSelector("multiline"),true);
        }

        private var textarea:HTMLTextAreaElement;
        
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

        COMPILE::SWF
        override public function get name():String
        {
            return super.name;
        }
        COMPILE::SWF
        override public function set name(value:String):void
        {
            super.name = value;
        }

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

        public function get text():String
        {
        	return textarea.text;
        }
        
        public function set text(value:String):void
        {
            textarea.text = value;
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
        
        private var validIcon:Icon;
        private var invalidIcon:Icon;
        override public function get valid():Boolean
        {
            return super.valid;
        }

        COMPILE::JS
        override public function set valid(value:Boolean):void
        {
            super.valid = value;
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
            } else{
                removeElement(validIcon);
            }
        }

        override public function get invalid():Boolean
        {
            return super.invalid;
        }

        COMPILE::JS
        override public function set invalid(value:Boolean):void
        {
            super.invalid = value;
            if(value){
                if(!invalidIcon){
                var type:String = IconType.ALERT_MEDIUM;
                invalidIcon = new Icon(Icon.getCSSTypeSelector(type));
                invalidIcon.className = appendSelector("-validationIcon");
                invalidIcon.type = type;
                }
                if(getElementIndex(invalidIcon) == -1){
                addElementAt(invalidIcon,0);
                }
            } else{
                removeElement(invalidIcon);
            }
        }

        COMPILE::JS
        override protected function createElement():WrappedHTMLElement{
            var elem:WrappedHTMLElement = addElementToWrapper(this,'div');
            textarea = newElement("textarea",appendSelector("-input")) as HTMLTextAreaElement;
            elem.appendChild(textarea);
            return elem;
        }
    }
}