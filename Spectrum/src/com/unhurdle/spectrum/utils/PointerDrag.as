package com.unhurdle.spectrum.utils
{
    import com.unhurdle.spectrum.Application;

    public class PointerDrag
    {
        COMPILE::SWF
        public function PointerDrag(target:Object, startHandler:Function, moveHandler:Function, endHandler:Function, touchAction:String)
        {
        }

        COMPILE::JS
        public function PointerDrag(target:HTMLElement, startHandler:Function, moveHandler:Function, endHandler:Function, touchAction:String)
        {
            _target = target;
            _startHandler = startHandler;
            _moveHandler = moveHandler;
            _endHandler = endHandler;
            setTouchAction(touchAction);
            if (Application.current.usePointerEvents) {
                _target.addEventListener("pointerdown", handlePointerDown);
            } else {
                _target.addEventListener("mousedown", handleMouseDown);
            }
        }

        COMPILE::JS
        private var _target:HTMLElement;
        COMPILE::JS
        private var _startHandler:Function;
        COMPILE::JS
        private var _moveHandler:Function;
        COMPILE::JS
        private var _endHandler:Function;
        COMPILE::JS
        private var _pointerId:Number = -1;
        COMPILE::JS
        private var _mouseDown:Boolean;
        private var _enabled:Boolean = true;

        public function get enabled():Boolean
        {
            return _enabled;
        }

        public function setTouchAction(value:String):void
        {
            COMPILE::JS
            {
                _target.style.touchAction = value;
            }
        }

        public function set enabled(value:Boolean):void
        {
            COMPILE::JS
            {
            if (_enabled == value) {
                return;
            }
            _enabled = value;
            if (!value) {
                cancel();
            }
            }
            COMPILE::SWF
            {
                _enabled = value;
            }
        }

        public function dispose():void
        {
            COMPILE::JS
            {
            cancel();
            if (Application.current.usePointerEvents) {
                _target.removeEventListener("pointerdown", handlePointerDown);
            } else {
                _target.removeEventListener("mousedown", handleMouseDown);
            }
            }
        }

        COMPILE::JS
        private function handleMouseDown(event:MouseEvent):void
        {
            if (!_enabled || _mouseDown || event.button != 0) {
                return;
            }
            if (_startHandler(event) === false || !_enabled) {
                return;
            }
            _mouseDown = true;
            window.addEventListener("mousemove", handleMouseMove);
            window.addEventListener("mouseup", handleMouseUp);
            window.addEventListener("blur", handleMouseCancel);
            document.addEventListener("mouseleave", handleMouseCancel);
            _moveHandler(event);
        }

        COMPILE::JS
        private function handleMouseMove(event:MouseEvent):void
        {
            _moveHandler(event);
        }

        COMPILE::JS
        private function handleMouseUp(event:MouseEvent):void
        {
            finishMouse();
        }

        COMPILE::JS
        private function handleMouseCancel(event:Event):void
        {
            if (_mouseDown) {
                finishMouse();
            }
        }

        COMPILE::JS
        private function handlePointerDown(event:PointerEvent):void
        {
            if (!_enabled || _pointerId >= 0 || event.isPrimary === false || event.button != 0) {
                return;
            }
            if (_startHandler(event) === false) {
                return;
            }
            if (!_enabled) {
                return;
            }
            _pointerId = event.pointerId;
            _target.addEventListener("pointermove", handlePointerMove);
            _target.addEventListener("pointerup", handlePointerUp);
            _target.addEventListener("pointercancel", handlePointerCancel);
            _target.addEventListener("lostpointercapture", handleLostPointerCapture);
            _target["setPointerCapture"](_pointerId);
            _moveHandler(event);
        }

        COMPILE::JS
        private function handlePointerMove(event:PointerEvent):void
        {
            if (event.pointerId == _pointerId) {
                _moveHandler(event);
            }
        }

        COMPILE::JS
        private function handlePointerUp(event:PointerEvent):void
        {
            if (event.pointerId == _pointerId) {
                finishPointer();
            }
        }

        COMPILE::JS
        private function handlePointerCancel(event:PointerEvent):void
        {
            if (event.pointerId == _pointerId) {
                finishPointer();
            }
        }

        COMPILE::JS
        private function handleLostPointerCapture(event:PointerEvent):void
        {
            if (event.pointerId == _pointerId) {
                finishPointer();
            }
        }

        COMPILE::JS
        private function cancel():void
        {
            if (_pointerId >= 0) {
                finishPointer();
            }
            if (_mouseDown) {
                finishMouse();
            }
        }

        COMPILE::JS
        private function finishPointer():void
        {
            var pointerId:Number = _pointerId;
            _pointerId = -1;
            _target.removeEventListener("pointermove", handlePointerMove);
            _target.removeEventListener("pointerup", handlePointerUp);
            _target.removeEventListener("pointercancel", handlePointerCancel);
            _target.removeEventListener("lostpointercapture", handleLostPointerCapture);
            if (_target["hasPointerCapture"](pointerId)) {
                _target["releasePointerCapture"](pointerId);
            }
            _endHandler();
        }

        COMPILE::JS
        private function finishMouse():void
        {
            _mouseDown = false;
            window.removeEventListener("mousemove", handleMouseMove);
            window.removeEventListener("mouseup", handleMouseUp);
            window.removeEventListener("blur", handleMouseCancel);
            document.removeEventListener("mouseleave", handleMouseCancel);
            _endHandler();
        }
    }
}