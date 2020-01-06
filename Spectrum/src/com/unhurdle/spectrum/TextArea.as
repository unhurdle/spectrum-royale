package com.unhurdle.spectrum
{    
    COMPILE::JS
    {
        import org.apache.royale.html.util.addElementToWrapper;
        import org.apache.royale.core.WrappedHTMLElement;
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

        //name???
        //lang?????
        private var _disabled:Boolean;

        public function get disabled():Boolean
        {
        	return _disabled;
        }
        public function set disabled(value:Boolean):void
        {
            if(value != !!_disabled){
                textarea.disabled = value;
            }
        	_disabled = value;
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
        COMPILE::JS
        override protected function createElement():WrappedHTMLElement{
            textarea = addElementToWrapper(this,'textarea') as HTMLTextAreaElement;
            return element;
        }
    }
}