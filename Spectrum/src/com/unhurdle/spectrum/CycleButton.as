package com.unhurdle.spectrum
{
	COMPILE::JS{
		import org.apache.royale.core.WrappedHTMLElement;
	}
	import com.unhurdle.spectrum.const.IconPrefix;
	import org.apache.royale.events.Event;
	import com.unhurdle.spectrum.includes.ActionButtonInclude;

	public class CycleButton extends SpectrumBase
	{
		/**
		 * <inject_html>
		 * <link rel="stylesheet" href="assets/css/components/cyclebutton/dist.css">
		 * </inject_html>
		 * 
		 */

		public function CycleButton()
		{
			super();
			// we need spectrum-ActionButton spectrum-ActionButton--quiet appended to the classes
			var actionStr:String = ActionButtonInclude.getSelector();
			classList.add(actionStr);
			classList.add(actionStr + "--quiet");
		}
		override protected function getSelector():String{
			return "spectrum-CycleButton";
		}
		private var playIcon:Icon;
		private var pauseIcon:Icon;
		override protected function getTag():String{
			return "button";
		}
		COMPILE::JS
		override protected function createElement():WrappedHTMLElement{
			var elem:WrappedHTMLElement = super.createElement();
			// var type:String =
			playIcon = new Icon(IconPrefix._18 + "PlayCircle");
			playIcon.className = appendSelector("-item");
			playIcon.toggle("is-selected",true);
			_paused = false;
			addElement(playIcon);
			pauseIcon = new Icon(IconPrefix._18 + "PauseCircle");
			pauseIcon.className = appendSelector("-item");
			addElement(pauseIcon);
			element.onclick = handleClick;
			return elem;
		}

		private var _paused:Boolean;

		public function get paused():Boolean
		{
			return _paused;
		}

		private function handleClick(ev:*):void{
			setPaused(!paused,true);
		}

		public function set paused(value:Boolean):void
		{
			if(value != _paused){
				setPaused(value);
			}
		}
		public function setPaused(value:Boolean,dispatch:Boolean=false):void{
			pauseIcon.toggle("is-selected",value);
			playIcon.toggle("is-selected",!value);
			// if(value){
			//   pauseIcon.className = appendSelector("-item is-selected");
			//   playIcon.className = appendSelector("-item");
			// } else {
			//   pauseIcon.className = appendSelector("-item");
			//   playIcon.className = appendSelector("-item is-selected");
			// }
			_paused = value;
			if(dispatch){
				dispatchEvent(new Event("change"));
			}

		}
	}
}