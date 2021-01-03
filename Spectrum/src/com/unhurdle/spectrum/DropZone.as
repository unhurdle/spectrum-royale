package com.unhurdle.spectrum
{
	COMPILE::JS{
		import org.apache.royale.core.WrappedHTMLElement;
	}

	import com.unhurdle.spectrum.IllustratedMessage;

	import org.apache.royale.file.beads.FileModel;
	import org.apache.royale.file.beads.FileLoader;
	import org.apache.royale.file.beads.FileBrowser;
	import org.apache.royale.file.FileProxy;
	import org.apache.royale.events.Event;
	import org.apache.royale.events.ValueEvent;



	[Event(name="filesAvailable", type="org.apache.royale.events.ValueEvent")]

	public class DropZone extends SpectrumBase 
	{ 
		/**
		 * <inject_html>
		 * <link rel="stylesheet" href="assets/css/components/dropzone/dist.css">
		 * </inject_html>
		 * 
		 */
		
		public function DropZone(){
			super();
			fileProxy = new FileProxy();
			browser = new FileBrowser();
			loader = new FileLoader();
			fileProxy.addBead(loader);  
			fileProxy.addBead(browser); 
		}

		private var browser:FileBrowser;
		private var loader:FileLoader;
		private var fileProxy:FileProxy;

		override protected function getSelector():String{
			return "spectrum-Dropzone";
		}

		private function elementDragged(ev:Event):void{
			ev.preventDefault();
			toggle("is-dragged",true);
		}

		private function elementNotDragged(ev:Event):void{
			toggle("is-dragged",false);
		}

		private function dropped(ev:DragEvent):void{  
			ev.preventDefault();
			toggle("is-dragged",false);
			var fileList:FileList = ev.dataTransfer.files;
			dispatchEvent(new ValueEvent("filesAvailable",fileList));
		}

		COMPILE::JS
		private function uploadFile():void{
			fileProxy.addEventListener("modelChanged",modelChangedHandler);
			browser.browse();
		}

		COMPILE::JS
		protected function modelChangedHandler(event:Event):void
		{
				dispatchEvent(new ValueEvent("filesAvailable",[(fileProxy.model as FileModel).fileReference]));
		}

	COMPILE::JS
	override protected function createElement():WrappedHTMLElement{
		super.createElement();
		element.setAttribute("role","region"); 
		element.tabIndex = 0;
		element.style.width = "300px";
		element.addEventListener('dragenter', elementDragged);
		element.addEventListener('dragleave', elementNotDragged); 
		element.addEventListener('dragover', elementDragged);
		element.addEventListener('drop', dropped);
		
		var illustratedMessage:IllustratedMessage = new IllustratedMessage();
		illustratedMessage.type = "cta";
		illustratedMessage.hyperlink.element.addEventListener('click',uploadFile)
		element.appendChild(illustratedMessage.element);

		
		return element;
		}


	}
}