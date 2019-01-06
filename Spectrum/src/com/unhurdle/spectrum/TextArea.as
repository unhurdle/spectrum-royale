package com.unhurdle.spectrum
{    
    COMPILE::JS
    {
        import org.apache.royale.html.util.addElementToWrapper;
        import org.apache.royale.core.WrappedHTMLElement;
    }

    public class TextArea extends SpectrumBase
    {
        public function TextArea()
        {
            super();
            typeNames = "spectrum-Textfield";
        }
        COMPILE::JS
        private var textarea:HTMLTextAreaElement;

        COMPILE::SWF
        private var textarea:Object;
        
        public function get placeholder():String
        {
            return textarea.placeholder;
        }

        public function set placeholder(value:String):void
        {
            //set the content in the textArea
            textarea.placeholder = value;
        }
        private var _multiline:Boolean;
        public function get multiline():Boolean
        {
            return _multiline;
        }
        public function set multiline(value:Boolean):void
        {
            if(value != !!_multiline){
                toggle("spectrum-ButtonGroup--multiline",value);
            }
            _multiline = value;
        }
        private var _isValid:Boolean;
        public function get isValid():Boolean
        {
            return _isValid;
        }
        public function set isValid(value:Boolean):void
        {
            var newIsValid:String;
            if(value){
                newIsValid = "is-valid";
            }
            else{
                newIsValid = "is-invalid";
            }
            toggle(newIsValid, true);
            if(_isValid != "undefined"){
                var oldIsValid:String;
                if(_isValid){
                    oldIsValid = "is-valid";
                }
                else{
                    oldIsValid = "is-invalid";
                }
                toggle(oldIsValid, false);
            }
            _isValid = value;
        }
        private var _quiet:Boolean;
        public function get quiet():Boolean
        {
            return _quiet;
        }
        public function set quiet(value:Boolean):void
        {
            if(value != !!_quiet){
                toggle("spectrum-ButtonGroup--quiet",value);
            }
            _quiet = value;
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