package com.unhurdle.spectrum.assets
{
  //    import org.apache.royale.core.IBead;
  //   import org.apache.royale.core.IStrand;
  //   import org.apache.royale.events.DetailEvent;
  //   import org.apache.royale.events.Event;
  //   import org.apache.royale.events.EventDispatcher;
  //   import org.apache.royale.events.IEventDispatcher;
  //   import org.apache.royale.events.ProgressEvent;
  //   import org.apache.royale.file.FileProxy;
  //   import org.apache.royale.net.URLBinaryLoader;
  //   import org.apache.royale.net.URLRequest;
  //   import org.apache.royale.utils.BinaryData;
  //   import org.apache.royale.utils.Endian;
    
  //   COMPILE::SWF
  //       {
  //           import flash.events.Event;
  //           import flash.events.HTTPStatusEvent;
  //           import flash.events.IOErrorEvent;
  //           import flash.events.ProgressEvent;
  //           import flash.events.SecurityErrorEvent;
  //           import flash.net.URLRequest;
  //           import flash.net.URLRequestHeader;
  //           import flash.net.URLStream;
  //           import flash.net.URLVariables;
  //           import flash.utils.ByteArray;
  //       }
  //       COMPILE::JS
	// {
	// 	import goog.events;

	// 	import org.apache.royale.core.WrappedHTMLElement;
	// 	import org.apache.royale.events.Event;
	// 	import org.apache.royale.file.beads.FileModel;
	// 	import org.apache.royale.net.HTTPUtils;

	// }
  //   [Event(name="complete", type="org.apache.royale.events.Event")]
    // public class SimpleFileUploader extends EventDispatcher implements IBead{
    //     private var _strand:IStrand;}
		 public class SimpleFileUploader {
        ;}
		
	// 	//Upload a file to the specified url.
	// 	COMPILE::JS
	// 	public function upload(url:String):void{
	// 		var binaryUploader:URLBinaryLoader = new URLBinaryLoader();
	// 		var req:URLRequest = new URLRequest();
	// 		req.method = "POST";
	// 		req.data = (host.model as FileModel).blob;
	// 		req.url = url;
	// 		binaryUploader.addEventListener(Event.COMPLETE, completeHandler);
	// 		binaryUploader.load(req);
	// 	}
	// 	COMPILE::JS
		
	// 	protected function completeHandler(event:Event):void{
	// 		(event.target as IEventDispatcher).removeEventListener(Event.COMPLETE, completeHandler);
	// 		(host as IEventDispatcher).dispatchEvent(event);
	// 	}
		
	
	// 	public function set strand(value:IStrand):void{
	// 		_strand = value;
	// 	}
		
	// 	protected function get host():FileProxy{
	// 		return _strand as FileProxy;
	// 	}
  //   	COMPILE::JS {
	// 		protected var xhr:XMLHttpRequest;
	// 	}
			
	// 	COMPILE::SWF{
	// 		private var flashUrlStream:flash.net.URLStream
	// 	}
	// 	//The number of bytes loaded so far.
	// 	public var bytesLoaded:uint = 0;
		
	// 	//The total number of bytes (if avaailable).		
	// 	public var bytesTotal:uint = 0;

	// 	//The BinaryData reponse received from the request. This can be a response or an error response.
	// 	// The client should check the status to know how to interpret the response.
	// 	public function get response():BinaryData
	// 	{
	// 		COMPILE::JS
	// 		{
	// 				return new BinaryData(xhr.response as ArrayBuffer);
	// 		}
	// 		COMPILE::SWF
	// 		{
	// 			var ba:ByteArray = new ByteArray();
	// 			flashUrlStream.readBytes(ba);
	// 			return new BinaryData(ba);
	// 		}
	// 	}

	// 	//loads the request
	// 	public  function load(urlRequest:org.apache.royale.net.URLRequest):void{
	// 		COMPILE::JS {
	// 			requestStatus = 0;
	// 			xhr = new XMLHttpRequest();
	// 			xhr.open(urlRequest.method, urlRequest.url);
	// 			xhr.responseType = "arraybuffer";
	// 			xhr.addEventListener("readystatechange", xhr_onreadystatechange,false);
	// 			var contentTypeSet:Boolean = false;
	// 			for (var i:int = 0; i < urlRequest.requestHeaders.length; i++){
	// 				var header:org.apache.royale.net.URLRequestHeader = urlRequest.requestHeaders[i];
	// 				if (header.name.toLowerCase() == "content-type"){
	// 					contentTypeSet = true;
	// 				}
	// 				xhr.setRequestHeader(header.name, header.value);
	// 			}
	// 			if (!contentTypeSet && urlRequest.contentType){
	// 				xhr.setRequestHeader("Content-type", urlRequest.contentType);
	// 			}
	// 			xhr.upload.onprogress = xhr_progress;
  //   			xhr.send((host.model as FileModel).file);
	// 		}
	// 		COMPILE::SWF {
	// 			flashUrlStream = new flash.net.URLStream();
	// 			var req:flash.net.URLRequest = new flash.net.URLRequest(urlRequest.url);
	// 			var contentSet:Boolean = false;
	// 			for each (var requestHeader:org.apache.royale.net.URLRequestHeader in urlRequest.requestHeaders){
	// 				if(requestHeader.name.toLowerCase() == HTTPHeader.CONTENT_TYPE.toLowerCase()){							 	
	// 					contentSet = true;
	// 					req.contentType = requestHeader.value;
	// 				}
	// 				req.requestHeaders.push(requestHeader)
	// 			}
	// 			if(!contentSet){
	// 				req.requestHeaders.push(new flash.net.URLRequestHeader(HTTPHeader.CONTENT_TYPE, urlRequest.contentType));
	// 			}
	// 			if (urlRequest.data){
	// 				req.data = urlRequest.data is BinaryData ? (urlRequest.data as BinaryData).data : 
	// 					new flash.net.URLVariables(HTTPUtils.encodeUrlVariables(urlRequest.data));
	// 			}
	// 			req.method = urlRequest.method;
	// 			flashUrlStream.addEventListener(HTTPStatusEvent.HTTP_RESPONSE_STATUS, flash_status);
	// 			flashUrlStream.addEventListener(HTTPStatusEvent.HTTP_STATUS, flash_status);
	// 			flashUrlStream.addEventListener(flash.events.ProgressEvent.PROGRESS, flash_progress);
	// 			flashUrlStream.addEventListener(flash.events.Event.COMPLETE, flash_complete);
	// 			flashUrlStream.addEventListener(IOErrorEvent.IO_ERROR, flash_onIoError);
	// 			flashUrlStream.addEventListener(SecurityErrorEvent.SECURITY_ERROR, flash_onSecurityError);
	// 			flashUrlStream.load(req);
	// 		}
	// 	}

	// 	//HTTP status changed (Flash only).
	// 	COMPILE::SWF
	// 	private function flash_status(event:HTTPStatusEvent):void{
	// 		setStatus(event.status);
	// 	}

	// 	//IO error occurred (Flash only).
	// 	COMPILE::SWF 
	// 	protected function flash_onIoError(event:IOErrorEvent):void{
	// 		dispatchEvent(new DetailEvent(HTTPConstants.COMMUNICATION_ERROR,false,false,HTTPConstants.IO_ERROR));
	// 		if(onError){
	// 			onError(this);
	// 		}
	// 		cleanupCallbacks();
	// 	}

	// 	//Security error occurred (Flash only).
	// 	COMPILE::SWF
	// 	private function flash_onSecurityError(event:flash.events.Event):void{
	// 		dispatchEvent(new DetailEvent(HTTPConstants.COMMUNICATION_ERROR,false,false,HTTPConstants.SECURITY_ERROR));
	// 		if(onError){
	// 			onError(this);
	// 		}
	// 		cleanupCallbacks();
	// 	}

	// 	//Upload complete (Flash only).
	// 	COMPILE::SWF
	// 	protected function flash_complete(event:flash.events.Event):void{
	// 		dispatchEvent(new org.apache.royale.events.Event(HTTPConstants.COMPLETE));
	// 		if(onComplete){
	// 			onComplete(this);
	// 		}
	// 		cleanupCallbacks();
	// 	}

	// 	//Download is progressing (Flash only).
	// 	COMPILE::SWF
	// 	protected function flash_progress(event:flash.events.ProgressEvent):void{
	// 		var progEv:org.apache.royale.events.ProgressEvent = new org.apache.royale.events.ProgressEvent(org.apache.royale.events.ProgressEvent.PROGRESS);
			
	// 		progEv.current = bytesLoaded = event.bytesLoaded;
	// 		progEv.total = bytesTotal = event.bytesTotal;
	// 		dispatchEvent(progEv);
	// 		if(onProgress)
	// 			onProgress(this);
	// 	}

	// 	//Download is progressing (JS only).
	// 	COMPILE::JS
	// 	private function xhr_progress(ev:Object):void{
	// 		var progEv:ProgressEvent = new ProgressEvent(ProgressEvent.PROGRESS);
	// 		progEv.current = bytesLoaded = ev.loaded;
	// 		progEv.total = bytesTotal = ev.total;
	// 		dispatchEvent(progEv);
	// 		if(onProgress){
	// 			onProgress(this);
	// 		}
	// 	}
	// 	COMPILE::JS
	// 	private function xhr_onreadystatechange(error:*):void{
	// 		setStatus(xhr.status);
	// 		//we only need to deal with the status when it's done.
	// 		if(xhr.readyState != 4)
	// 			return;
	// 		if(xhr.status == 0){
	// 			//Error. We don't know if there's a network error or a CORS error so there's no detail
	// 			dispatchEvent(new DetailEvent("communicationError"));
	// 			if(onError)
	// 				onError(this);
	// 		}
	// 		else if(xhr.status < 200){
	// 			dispatchEvent(new DetailEvent("communicationError",false,false,""+requestStatus));
	// 			if(onError)
	// 				onError(this);
	// 		}
	// 		else if(xhr.status < 300){
	// 			dispatchEvent(new org.apache.royale.events.Event("complete"));
	// 			if(onComplete)
	// 				onComplete(this);
				
	// 		}
	// 		else{
	// 			dispatchEvent(new DetailEvent("communicationError",false,false,""+requestStatus));
	// 			if(onError)
	// 				onError(this);
	// 		}
	// 		cleanupCallbacks();
	// 	}

	// 	//Set the HTTP request status.
	// 	private function setStatus(value:int):void
	// 	{
	// 		if(value != requestStatus)
	// 		{
	// 			requestStatus = value;
	// 			dispatchEvent(new DetailEvent("httpStatus",false,false,""+value));
	// 			if(onStatus)
	// 				onStatus(this);
	// 		}
	// 	}

	// 	//Abort an connection.
	// 	public function close():void
	// 	{
	// 		COMPILE::SWF
	// 		{
	// 			flashUrlStream.close();
	// 		}
	// 		COMPILE::JS
	// 		{
	// 			xhr.abort();
	// 		}
	// 		cleanupCallbacks();
	// 	}

	// 	//Indicates the status of the request.
	// 	public var requestStatus:int = 0;

	// 	//Indicates the byte order for the data.
	// 	public var endian:String = Endian.BIG_ENDIAN;

	// 	//Cleanup all callbacks.
	// 	protected function cleanupCallbacks():void
	// 	{
	// 		onComplete = null;
	// 		onError = null;
	// 		onProgress = null;
	// 		onStatus = null;
	// 	}

	// 	//Callback for complete event.
	// 	public var onComplete:Function;
		
	// 	//Callback for error event.
	// 	public var onError:Function;
		
	// 	//Callback for progress event.
	// 	public var onProgress:Function;

	// 	//Callback for status event.
	// 	public var onStatus:Function;

	// 	//Convenience function for complete event to allow chaining.	
	// 	public function complete(callback:Function):SimpleFileUploader
	// 	{
	// 		onComplete = callback;
	// 		return this;
	// 	}
		
	// 	//Convenience function for error event to allow chaining.	
	// 	public function error(callback:Function):SimpleFileUploader
	// 	{
	// 		onError = callback;
	// 		return this;
	// 	}

	// 	// Convenience function for progress event to allow chaining.
	// 	public function progress(callback:Function):SimpleFileUploader
	// 	{
	// 		onProgress = callback;
	// 		return this;
	// 	}	
	// 	//Convenience function for status event to allow chaining.
	// 	public function status(callback:Function):SimpleFileUploader
	// 	{
	// 		onStatus = callback;
	// 		return this;
	// 	}
  //   }
}