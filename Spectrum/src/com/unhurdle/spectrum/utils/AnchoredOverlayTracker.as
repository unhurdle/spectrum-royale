package com.unhurdle.spectrum.utils
{
	public class AnchoredOverlayTracker
	{
		COMPILE::SWF
		public function AnchoredOverlayTracker(anchor:Object, updateHandler:Function, closeHandler:Function = null, overlay:Object = null)
		{
		}

		COMPILE::JS
		public function AnchoredOverlayTracker(anchor:HTMLElement, updateHandler:Function, closeHandler:Function = null, overlay:HTMLElement = null)
		{
			_anchor = anchor;
			_updateHandler = updateHandler;
			_closeHandler = closeHandler;
			_overlay = overlay;
		}

		COMPILE::JS
		private var _anchor:HTMLElement;
		COMPILE::JS

		private var _overlay:HTMLElement;
		COMPILE::JS

		private var _updateHandler:Function;

		COMPILE::JS

		private var _closeHandler:Function;

		COMPILE::JS

		private var _resizeObserver:Object;
		COMPILE::JS

		private var _animationFrameId:Number = 0;
		private var _active:Boolean;

		public function start():void
		{
			COMPILE::JS
			{
				if (_active)
				{
					return;
				}
				_active = true;
				window.addEventListener("resize", handleChange);
				document.addEventListener("scroll", handleChange, true);
				var resizeObserverClass:Function = window["ResizeObserver"];
				if (resizeObserverClass != null)
				{
					_resizeObserver = new resizeObserverClass(scheduleUpdate);
					_resizeObserver.observe(_anchor);
					if (_overlay != null)
					{
						_resizeObserver.observe(_overlay);
					}
				}
			}
		}

		public function stop():void
		{
			COMPILE::JS
			{
				if (!_active)
				{
					return;
				}
				_active = false;
				window.removeEventListener("resize", handleChange);
				document.removeEventListener("scroll", handleChange, true);
				if (_resizeObserver != null)
				{
					_resizeObserver.disconnect();
					_resizeObserver = null;
				}
				if (_animationFrameId > 0)
				{
					cancelAnimationFrame(_animationFrameId);
					_animationFrameId = 0;
				}
			}
		}

		COMPILE::JS

		private function handleChange(event:Event):void
		{
			if (event.type == "scroll")	{
				if (_overlay?.contains(event.target as Node)) {
					return;
				}
				if (!isAnchorInViewport(event.target as HTMLElement))	{
					if (_closeHandler != null) {
						_closeHandler();
						stop();
					}
					return;
				}
			}
			scheduleUpdate();
		}

		COMPILE::JS
		private function isAnchorInViewport(target:HTMLElement):Boolean
		{
			var viewportRect:Object = target.getBoundingClientRect();
			var anchorRect:Object = _anchor.getBoundingClientRect();
			var isInViewport:Boolean = anchorRect.top >= viewportRect.top &&
				anchorRect.bottom <= viewportRect.bottom &&
				anchorRect.left >= viewportRect.left &&
				anchorRect.right <= viewportRect.right;
			return isInViewport;
		}

		COMPILE::JS

		private function scheduleUpdate():void
		{
			if (_active && _animationFrameId == 0)
			{
				_animationFrameId = requestAnimationFrame(update);
			}
		}

		COMPILE::JS

		private function update():void
		{
			_animationFrameId = 0;
			if (_active)
			{
				_updateHandler();
			}
		}
	}
}