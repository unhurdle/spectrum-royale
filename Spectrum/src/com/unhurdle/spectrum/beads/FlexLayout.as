package com.unhurdle.spectrum.beads
{
	import org.apache.royale.core.LayoutBase;
	import org.apache.royale.events.ValueEvent;
	import org.apache.royale.core.IChild;
	import org.apache.royale.core.IParent;

	public class FlexLayout extends LayoutBase
	{
		public function FlexLayout()
		{
			super();
		}

		private var _flexDirection:String = "row";
		public function get flexDirection():String{
			return _flexDirection;
		}
    [Inspectable(category="General", enumeration="row,row-reverse,column,column-reverse")]
		public function set flexDirection(value:String):void{
			_flexDirection = value;
		}

		private var _flexWrap:String = "nowrap";

		public function get flexWrap():String{
			return _flexWrap;
		}

    [Inspectable(category="General", enumeration="nowrap,wrap,wrap-reverse")]
		public function set flexWrap(value:String):void{
			_flexWrap = value;
		}

		private var _justifyContent:String = "flex-start";
		public function get justifyContent():String{
			return _justifyContent;
		}
    [Inspectable(category="General", enumeration="flex-start,flex-end,center,space-between,space-around,space-evenly,start,end,left,right")]
		public function set justifyContent(value:String):void{
			_justifyContent = value;
		}

		private var _alignItems:String = "stretch";
		/**
		 * Alignment of items on the main axis (vertical alignment for rows and horizontal alignment for columns)
		 */
		public function get alignItems():String{
			return _alignItems;
		}
    [Inspectable(category="General", enumeration="stretch,flex-start,flex-end,center,baseline,first baseline,last baseline,start,end,self-start,self-end")]
		public function set alignItems(value:String):void{
			_alignItems = value;
		}

		private var _alignContent:String = "stretch";
		/**
		 * Alignment of items on the cross axis. Only has effect if there are multiple rows/columns
		 */
		public function get alignContent():String{
			return _alignContent;
		}
    [Inspectable(category="General", enumeration="stretch,flex-start,flex-end,center,baseline,first baseline,last baseline,start,end,self-start,self-end")]
		public function set alignContent(value:String):void{
			_alignContent = value;
		}

		private var _rowGap:Number;

		public function get rowGap():Number{
			return _rowGap;
		}
		public function set rowGap(value:Number):void{
			_rowGap = value;
		}

		private var _columnGap:Number;
		public function get columnGap():Number{
			return _columnGap;
		}

		public function set columnGap(value:Number):void{
			_columnGap = value;
		}

		override public function layout():Boolean{
			COMPILE::JS
			{
				var style:CSSStyleDeclaration = host.element.style;
				style.flexDirection = flexDirection;
				style.flexWrap = flexWrap;
				style.justifyContent = justifyContent;
				style.alignItems = alignItems;
				style.alignContent = alignContent;
			}
			return true;
		}
		COMPILE::JS
		override protected function handleChildrenAdded(event:ValueEvent):void{
			var haveRowGap:Boolean = !isNaN(rowGap);
			var haveColumnGap:Boolean = !isNaN(columnGap);
			if(haveRowGap || haveColumnGap){
				var child:IChild = event.value as IChild;
				if(child){
					styleChild(child);
				} else {
					var parent:IParent = layoutView as IParent;
					// var parent:IParent = _strand as IParent
					var numElements:int = parent.numElements;
					for(var i:int=0;i<numElements;i++){
						styleChild(parent.getElementAt(i));
					}
				}
			}
			super.handleChildrenAdded(event);
		}

		COMPILE::SWF
		private function styleChild(child:IChild):void{
		}

		COMPILE::JS
		private function styleChild(child:IChild):void{
			var style:CSSStyleDeclaration = child.element.style;
			if(!isNaN(rowGap)){
				style.marginLeft = style.marginRight = (rowGap/2) + "px";
			}
			if(!isNaN(columnGap)){
				style.marginTop = style.marginBottom = (columnGap/2) + "px";
			}
		}
	}
}