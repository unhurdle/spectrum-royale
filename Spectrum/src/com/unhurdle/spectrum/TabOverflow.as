package com.unhurdle.spectrum
{
	import com.unhurdle.spectrum.data.MenuItem;

	import org.apache.royale.core.Bead;
	import org.apache.royale.core.IStrand;
	import org.apache.royale.events.Event;

	public class TabOverflow extends Bead
	{
		public function TabOverflow()
		{
			super();
		}
		private var direction:String;
		private var dropDown:Picker;


		private function attachElements():void{
			var tabBar:TabBar = getHost();
			dropDown.selectedIndex = tabBar.selectedIndex;
			tabBar.addElement(dropDown);
			positionIndicator();
		}
		private function detachElements():void{
			var tabBar:TabBar = getHost();
			if(dropDown && tabBar.getElementIndex(dropDown) != -1){
				tabBar.removeElement(dropDown);
			}
			if(indicator && tabBar.getElementIndex(indicator) != -1){
				tabBar.removeElement(indicator);
			}
		}

		// private var dpProvider:Array;
		private function get tabs():Array{
			return getHost().tabs;
		}
		public function setTabs():void{
			if(tabs){
				var provider:Array = [];
				for(var i:int=0;i<tabs.length;i++){
					var tab:Tab = tabs[i];
					var item:MenuItem = new MenuItem(tab.text);
					if(tab.icon){
						item.icon = tab.icon;
					}
					//TODO imageIcon
					provider.push(item);
				}
				dropDown.dataProvider = provider;
			}
			dropDown.selectedIndex = getHost().selectedIndex;
		}
		private function handleDDChange(ev:Event):void{
			getHost().selectedIndex = dropDown.selectedIndex;
		}

		private var indicator:TabIndicator;
		private function positionIndicator():void{
			if(!indicator){
				indicator = new TabIndicator();
			}
			indicator.x = 8;
			indicator.width = dropDown.width;
			getHost().addElement(indicator);
		}
		protected function getHost():TabBar{
			return _strand as TabBar;
		}
		override public function set strand(value:IStrand):void{
			_strand = value;
			dropDown = new Picker();
			dropDown.addEventListener("change",handleDDChange);
			dropDown.quiet = true;
			setTabs();
			listenOnStrand("tabsChanged",handleTabsChanged);
			listenOnStrand("autoCollapseChanged",handleAutoCollapseChanged);
			listenOnStrand("collapsed",handleCollapseChange);
			var tabBar:TabBar = getHost();
			if(tabBar.autoCollapse){
				window.addEventListener("resize",handleResize,false);
			}
			if(tabBar.collapsed){
				attachElements();
			}
		}
		/**
		 * Keep track of the last measured widths to know when to un-collapse the bar
		 */
		private var openTabWidth:Number;
		private function handleResize(ev:Event):void{
			if(!tabs || !tabs.length){
				return;
			}
			var bar:TabBar = getHost();
			if(bar.vertical){
				// don't collapse vertical bars.
				return;
			}
			var collapsed:Boolean = bar.collapsed;
			var totalWidth:Number = bar.width;
			COMPILE::JS
			{
				var padding:Number = parseFloat(getComputedStyle(bar.element).paddingRight);
				totalWidth -= padding;
			}
			if(collapsed && !isNaN(openTabWidth)){
				if(totalWidth >= openTabWidth){
					detachElements();
					bar.collapsed = false;
				}// else do nothing
				return;
			}
			//TODO handle right-to-left
			var lastTab:Tab = tabs[tabs.length-1];
			var tabWidth:Number = lastTab.x + lastTab.width;
			openTabWidth = tabWidth;
			if(tabWidth > totalWidth){
				if(!collapsed){
					bar.collapsed = true;
					attachElements();
				}
			} else if(collapsed){
				detachElements();
				bar.collapsed = false;
			}
		}
		private function handleTabsChanged(ev:Event):void{
			setTabs();
		}
		private function handleAutoCollapseChanged(ev:Event):void{
			if(getHost().autoCollapse){
				//add the listener
				window.addEventListener("resize",handleResize,false);
			} else {
				// remove it
				window.removeEventListener("resize",handleResize,false);
			}
		}
		private function handleCollapseChange(ev:Event):void{
			if(getHost().collapsed){
				attachElements();
			} else {
				detachElements();
			}
		}
	}
}