package com.unhurdle.spectrum
{
	import org.apache.royale.utils.sendStrandEvent;
	import org.apache.royale.events.Event;
	import org.apache.royale.utils.BrowserInfo;
	
	/**
	 * The change event is dispatched when the selected tab changes.
	 */
	[Event(name="change", type="org.apache.royale.events.Event")]

	[DefaultProperty("tabs")]
	public class TabBar extends Group
	{
		/**
		 * <inject_html>
		 * <link rel="stylesheet" href="assets/css/components/tabs/dist.css">
		 * </inject_html>
		 * 
		 */
		public function TabBar()
		{ 
			super();
			tabOverflow = new TabOverflow();
		}

		private var _quiet:Boolean;
		private var _compact:Boolean;
		private var _vertical:Boolean = false;
		private var tabOverflow:TabOverflow; 
		private var tabWidth:Number;
		private var hasDropdown:Boolean;
		private var _tabs:Array;
		protected var indicator:TabIndicator;
		private var count:int = 0;

		override protected function getSelector():String{
			return getTabsSelector(); 
		}

		override protected function appendSelector(value:String):String{
			return getSelector() + value;
		}

		public function get quiet():Boolean{
			return _quiet;
		}

		public function set quiet(value:Boolean):void{
			if(value != !!_quiet){
				toggle(valueToSelector("quiet"),value);
			}
			_quiet = value;
		}

		public function get compact():Boolean{
			return _compact;
		}
		
		public function set compact(value:Boolean):void {
			
			if(value != !!_compact){
				toggle(valueToSelector("compact"),value);
			}
			_compact = value;
		}
		public function get vertical():Boolean{
			return _vertical;
		}

		public function set vertical(value:Boolean):void {
			if(value != _vertical){
				toggle(valueToSelector("horizontal"),!value);
				toggle(valueToSelector("vertical"),value);
			}
			_vertical = value;
		}
		
		override protected function loadBeads():void{
			super.loadBeads();
			addBead(tabOverflow);
		}
		override public function addedToParent():void{
				super.addedToParent();
				toggle(valueToSelector("horizontal"),!_vertical);
				toggle(valueToSelector("vertical"),_vertical);
				if(!_collapsed){
					COMPILE::JS
					{
						requestAnimationFrame(positionIndicator);
					}
				}
		}
		private var _autoCollapse:Boolean = true;
		/**
		 * Automatically collapse the tabs to a dropdown if there's no room for the tabs
		 */
		public function get autoCollapse():Boolean{
			return _autoCollapse;
		}
		public function set autoCollapse(value:Boolean):void{
			if(_autoCollapse != value){
				dispatchEvent(new Event("autoCollapseChanged"));
			}
			_autoCollapse = value;
		}

		private var _collapsed:Boolean;
		/**
		 * collapsed TabBars display the tabs as a dropdown.
		 */
		public function get collapsed():Boolean{
			return _collapsed;
		}
		public function set collapsed(value:Boolean):void{
			if(_collapsed == value){
				return;
			}
			_collapsed = value;
			if(value){
				collapseTabs();
			} else {
				reAddTabs();
			}
			dispatchEvent(new Event("collapsed"));
		}

		public function collapseTabs():void{
			removeAllTabs();
			removeIndicator();
		}
		protected function reAddTabs():void{
			if(!tabs){
				return;
			}
			for(var i:int=0;i<tabs.length;i++){
				var tab:Tab = tabs[i];
				if(i == _selectedIndex){
					tab.selected = true;
				} else {
					tab.selected = false;
				}
				addElement(tab);
				tab.addEventListener("itemClicked",itemClicked);
				tab.addEventListener("disabledChange",handleTabDisabled);
			}
			positionIndicator();
		}
		public function get tabs():Array{
			return _tabs;
		}
		public function set tabs(value:Array):void{
			removeAllTabs();
			_tabs = value;
			if(!collapsed){
				for(var i:int=0;i<value.length;i++){
					addElement(value[i] as Tab);
					value[i].addEventListener("itemClicked",itemClicked);
					value[i].addEventListener("disabledChange",handleTabDisabled);
				}
			}
			sendStrandEvent(this,"tabsChanged");
		}

		private function removeAllTabs():void{
			if(!_tabs){
				return;
			}
			for(var i:int=0;i<_tabs.length;i++){
				if(getElementIndex(_tabs[i]) != -1){
					removeElement(_tabs[i]);
					tabs[i].removeEventListener("itemClicked",itemClicked);
					tabs[i].removeEventListener("disabledChange",handleTabDisabled);
				}
			}
		}
		public var animateChange:Boolean;
		private function itemClicked(ev:Event):void{
			var tab:Tab = ev.target as Tab;
			// IE does not support animate
			animateChange = BrowserInfo.current().browser != "IE";
			selectedTab = tab;
			animateChange = false;
		}
		protected function handleTabDisabled(ev:Event):void{
			//do nothing, available for override
		}
		private function removeIndicator():void
		{
			if(!indicator){
				return;
			}
			if(getElementIndex(indicator) < 0){
				return;
			}
			removeElement(indicator);
		}

		private var _selectedIndex:int = -1;

		public function get selectedIndex():int
		{
			return _selectedIndex;
		}

		public function set selectedIndex(value:int):void
		{
			if(_selectedIndex != value){
				var tab:Tab = selectedTab;
				if(tab){
					tab.selected = false;
				}
				_selectedIndex = value;
				tab = selectedTab;
				if(tab){
					tab.selected = true;
				}
				positionIndicator(animateChange);
				dispatchEvent(new Event("change"));
			}
		}
		protected function positionIndicator(animate:Boolean = false):void{
			var tab:Tab = selectedTab;
			if(!tab){
				removeIndicator();
				return;
			}
			if(!indicator){
				indicator = new TabIndicator();
			}
			addElement(indicator);
			COMPILE::JS
			{
				if(animate){
					try{
						var keyframes:Array = getKeyframes(tab);
						//TODO animate was getting mangled when the code was minimized. Figure out why...
						var animation:Animation = indicator.element["animate"](keyframes,{duration:150,easing:"ease"});
						//TODO onfinish is also being mangled
						animation["onfinish"] = function():void{
							setIndicatorStyle(tab);
						}
					}catch(err:Error){
						setIndicatorStyle(tab);
					}
				} else {
					setIndicatorStyle(tab);
				}
			}

		}
		private function setIndicatorStyle(tab:Tab):void{
			if(vertical){
				indicator.setStyle("left","");
				indicator.setStyle("width","");
				indicator.y = tab.y;
				indicator.height = tab.height;
			} else {
				indicator.setStyle("top","");
				indicator.setStyle("height","");
				indicator.x = tab.x;
				indicator.width = tab.width;
			}

		}

		COMPILE::JS
		private function getKeyframes(tab:Tab):Array{
			var startStyle:CSSStyleDeclaration = getComputedStyle(indicator.element);
			var keyframes:Array = [
				{
						"left": startStyle.left,
						"width": startStyle.width,
						"top": startStyle.top,
						"height": startStyle.height
				}
			];
			if(vertical){
				keyframes.push({
						"left": "",
						"width": "",
						"top": tab.y + "px",
						"height": tab.height + "px"
				});
			} else {
				keyframes.push({
						"left": tab.x + "px",
						"width": tab.width + "px",
						"top": "",
						"height": ""
				});
			}
				return keyframes;
		}
		private var _selectedTab:Tab;
		public function get selectedTab():Tab{
			if(tabs && tabs.length){
				if(selectedIndex < 0 || selectedIndex >= tabs.length){
					return null;
				}
				return tabs[selectedIndex];
			}
			return null;
		}
		public function set selectedTab(value:Tab):void{
			if(!tabs){
				return;
			}
			var index:int = tabs.indexOf(value)
			if(index != -1){
				selectedIndex = index;
			}
		}
	}
}
