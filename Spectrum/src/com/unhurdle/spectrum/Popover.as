package com.unhurdle.spectrum
{
	import org.apache.royale.core.IPopUp;
	import org.apache.royale.events.Event;
	import org.apache.royale.core.IPopUpHostParent;
	import org.apache.royale.geom.Rectangle;
	import org.apache.royale.utils.DisplayUtils;
	import org.apache.royale.geom.Point;

	[Event(name="openChanged", type="org.apache.royale.events.Event")]
	
	public class Popover extends Group implements IPopUp
	{
		/**
		 * <inject_html>
		 * <link rel="stylesheet" href="assets/css/components/popover/dist.css">
		 * </inject_html>
		 * 
		 */
		public function Popover()
		{
			super();
			COMPILE::JS
			{
				element.style.zIndex = 500;// very high number to make sure it's above everything else
				element.style.position = "absolute";
			}

		}
		override protected function getSelector():String{
			return "spectrum-Popover";
		}
		private var _floating:Boolean;

		public function get floating():Boolean
		{
			return _floating;
		}

		public function set floating(value:Boolean):void
		{
			_floating = value;
		}

		private var _anchor:Rectangle;
		/**
		 * The anchor is a rectangle in global units
		 * If the anchor is set, the popover will position itself and its tip relative to that.
		 */
		public function get anchor():Rectangle{
			return _anchor;
		}
		public function set anchor(value:Rectangle):void{
			_anchor = value;
		}

		private var _open:Boolean;

		public function get open():Boolean
		{
			return _open;
		}

		public function set open(value:Boolean):void
		{
			if(!!_open != value){
				_open = value;
				toggle("is-open",value);
				if(floating){
					var host:IPopUpHostParent = Application.current.popUpParent;
					setAttribute("dir", Application.current.dir);
					if(value){
						host.addElement(this);
					} else {
						host.removeElement(this);
					}
				}
				dispatchEvent(new Event("openChanged"));
			}
		}
		private var _quiet:Boolean;

		public function get quiet():Boolean
		{
			return _quiet;
		}

		public function set quiet(value:Boolean):void
		{
			_quiet = value;
			toggle(valueToSelector("quiet"),value);
		}

		private var _relativePosition:Boolean;

		public function get relativePosition():Boolean
		{
			return _relativePosition;
		}

		public function set relativePosition(value:Boolean):void
		{
			if(value != !!_relativePosition){
				_relativePosition = value;
				COMPILE::JS
				{
					if(value){
						element.style.position = "relative";
					} else {
						element.style.position = null;
					}
				}
			}
		}

		private var _dialog:Boolean;

		public function get dialog():Boolean
		{
			return _dialog;
		}

		public function set dialog(value:Boolean):void
		{
			if(value != !!_dialog){
				_dialog = value;
				toggle(valueToSelector("dialog"),value);
			}
		}
		private var _tipDialog:Boolean = true;
		/**
		 * Whether the dialog is relative to another element.
		 */
		public function get tipDialog():Boolean{
			return _tipDialog;
		}
		public function set tipDialog(value:Boolean):void{
			_tipDialog = value;
			toggle(valueToSelector("withTip"),value);
		}

		override public function addedToParent():void{
			super.addedToParent();
			COMPILE::JS
			{
				positionDialog();
				if(dialog && tipDialog){
					if(!tipElement){
						tipElement = newSVGElement("svg",appendSelector("-tip"));
						tipElement.style.width = "22px";
						tipElement.style.height = "22px";
						// <path class="spectrum-Popover-tip-triangle" d="M 0 0.7071067811865476 L 10.707106781186548 11.414213562373096 L 0 22.121320343559645"></path>
						tipPath = newSVGElement("path", appendSelector("-tip-triangle")) as SVGPathElement;
						// setTipPath();
						tipElement.appendChild(tipPath);
					}
					element.appendChild(tipElement);
					requestAnimationFrame(positionTip);
	//      var svg:SVGElement = newSVGElement("svg",appendSelector("-folder"));

				} else {
					if(tipElement){
						element.removeChild(tipElement);
						tipElement = null;
					}
				}
			}
		}
		protected function positionDialog():void{
			if(!dialog || !anchor){
				return;
			}
			var appBounds:Rectangle = DisplayUtils.getScreenBoundingRect(Application.current.initialView);
			var componentBounds:Rectangle = DisplayUtils.getScreenBoundingRect(this);
			// if there's no anchor, position the dialog centered on the screen.
			if(!anchor){
				x = (appBounds.width - componentBounds.width) / 2;
				y = (appBounds.height - componentBounds.height) / 2;
				return;
			}
			// Figure out direction and max size

			var pxStr:String = "px";

			switch(position)
			{
				case "top":
					positionTop(appBounds,componentBounds);
					break;
				case "left":
					positionLeft(appBounds,componentBounds);
					break;
				case "right":
					positionRight(appBounds,componentBounds);
					break;
				case "bottom":
				default:
					positionBottom(appBounds,componentBounds);
					break;
			}
		}
		private function positionTop(appBounds:Rectangle,componentBounds:Rectangle):void{
				var anchorCenter:Point = new Point((anchor.left + (anchor.width/2)),anchor.top);
				anchorCenter.y -= componentBounds.height;
				// anchorCenter.y -= 5;//give some space between anchor and dialog
				positionHorizontally(anchorCenter,appBounds,componentBounds);
		}
		private function positionBottom(appBounds:Rectangle,componentBounds:Rectangle):void{
				var anchorCenter:Point = new Point((anchor.left + (anchor.width/2)),anchor.bottom);
				// anchorCenter.y += 5;//give some space between anchor and dialog
				positionHorizontally(anchorCenter,appBounds,componentBounds);
		}
		private function positionHorizontally(point:Point,appBounds:Rectangle,componentBounds:Rectangle):void{
				var top:Number = point.y
				var left:Number = point.x - (componentBounds.width/2);
				var right:Number = point.x + (componentBounds.width/2);
				y = top;
				var pointPercent:Number = componentBounds.width / 100;
				if(left < appBounds.left + 2){
					var diff:Number = left - appBounds.left + 2;
					left += diff;
					tipPosition = 50 - (diff/pointPercent);
				} else if(right > appBounds.right - 2){
					diff = (right - appBounds.right + 2);
					left -= diff;
					tipPosition = 50 + (diff/pointPercent);
				} else {
					tipPosition = 50;
				}
				x = left;
		}

		private function positionLeft(appBounds:Rectangle,componentBounds:Rectangle):void{
				var anchorCenter:Point = new Point(anchor.left,anchor.top - (anchor.height/2));
				anchorCenter.x -= componentBounds.width;
				// anchorCenter.x -= 5;//give some space between anchor and dialog
				positionHorizontally(anchorCenter,appBounds,componentBounds);
		}
		private function positionRight(appBounds:Rectangle,componentBounds:Rectangle):void{
				var anchorCenter:Point = new Point(anchor.right,anchor.top - (anchor.height/2));
				// anchorCenter.x += 5;//give some space between anchor and dialog
				positionHorizontally(anchorCenter,appBounds,componentBounds);
		}
		private function positionVertically(point:Point,appBounds:Rectangle,componentBounds:Rectangle):void{
				var left:Number = point.y
				var top:Number = point.y - (componentBounds.height/2);
				var bottom:Number = point.y + (componentBounds.height/2);
				x = left;
				var pointPercent:Number = componentBounds.height / 100;
				if(top < appBounds.top + 2){
					var diff:Number = left - appBounds.left + 2;
					top += diff;
					tipPosition = 50 - (diff/pointPercent);
				} else if(bottom > appBounds.bottom - 2){
					diff = (bottom - appBounds.bottom + 2);
					top -= diff;
					tipPosition = 50 + (diff/pointPercent);
				} else {
					tipPosition = 50;
				}
				y = top;
		}

		COMPILE::JS
		protected var tipElement:SVGElement;
		COMPILE::JS
		protected var tipPath:SVGPathElement;
		
		COMPILE::JS
		protected function setTipPath():void{
			var pathString:String;
			switch(position){
				case "top":
				case "bottom":
					pathString = "M 0.7071067811865476 0 L 11.414213562373096 10.707106781186548 L 22.121320343559645 0";
					break;
				default:
					pathString = "M 0 0.7071067811865476 L 10.707106781186548 11.414213562373096 L 0 22.121320343559645";
					break;
			}
			tipPath.setAttribute("d",pathString);
		}
		
		COMPILE::JS
		protected function positionTip():void{
			setTipPath();
			if(tipPosition == 50){
				tipElement.style.top = "";
				tipElement.style.left = "";
				return;
			}
			var percentSize:Number;
			var actualPosition:Number;
			switch(position){
				case "top":
				case "bottom":
					tipElement.style.top = "";
					var width:Number = this.width;
					percentSize = width/100;
					actualPosition = tipPosition * percentSize;
					if(actualPosition < 13){
						tipElement.style.left = "13px";
						return;
					}
					if(width - actualPosition < 13){
						tipElement.style.left = (width-13) + "px";
						return;
					}
					tipElement.style.left = tipPosition + "%";
					break;
				default:
					tipElement.style.left = "";
					var height:Number = this.height;
					percentSize = height/100;
					actualPosition = tipPosition * percentSize;
					if(actualPosition < 13){
						tipElement.style.top = "13px";
						return;
					}
					if(height - actualPosition < 13){
						tipElement.style.top = (height-13) + "px";
						return;
					}
					tipElement.style.top = tipPosition + "%";

					break;

			}
		}
		private var _tipPosition:Number = 50;
		/**
		 * The tip position in percentage of the width/height.
		 */
		public function get tipPosition():Number
		{
			return _tipPosition;
		}

		public function set tipPosition(value:Number):void
		{
			_tipPosition = value;
		}

		// private var _tip:Boolean;

		// public function get tip():Boolean
		// {
		// 	return _tip;
		// }

		// public function set tip(value:Boolean):void
		// {
		//   if(value != !!_tip){
		//   	_tip = value;
		//     // toggle(valueToSelector("tip"),value);
		//     COMPILE::JS
		//     {
		//       if(value){          
		//         var tip:HTMLDivElement = newElement("div",valueToSelector("tip")) as HTMLDivElement;
		//         element.appendChild(tip);
		//       }else{
		//         if(element.contains(tip)){
		//           element.removeChild(tip);
		//         }
		//       }
		//     }
		//   }
		// }
		private var _error:Boolean;

		public function get dialogError():Boolean
		{
			return _error;
		}

		public function set dialogError(value:Boolean):void
		{
			if(value != !!_error){
				_error = value;
				toggle("spectrum-Dialog--error",value);
			}
		}

		private var _success:Boolean;

		public function get dialogSuccess():Boolean
		{
			return _success;
		}

		public function set dialogSuccess(value:Boolean):void
		{
			if(value != !!_success){
				_success = value;
				toggle("spectrum-Dialog--success",value);
			}
		}

		private var _top:Boolean;

		public function get top():Boolean
		{
			return _top;
		}

		public function set top(value:Boolean):void
		{
			if(value != !!_top){
				_top = value;
				toggle(valueToSelector("top"),value);
			}
		}

		private var _position:String;

		public function get position():String
		{
			return _position;
		}

		[Inspectable(category="General", enumeration="bottom,top,right,left" defaultValue="bottom")]
		public function set position(value:String):void
		{
			if(value != _position){
				if(!value){
					value = "bottom";
				}
				switch(value)
				{
					case "bottom":
					case "top":
					case "right":
					case "left":
						break;
				
					default:
						throw new Error("invalid position: " + value);
						
				}
				if(_position){
					toggle(valueToSelector(_position),false);
				}
				toggle(valueToSelector(value),true);
				_position = value;
			}
		}

	}
}
