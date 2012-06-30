package jsonrest.model
{
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.URLRequestHeader;
	import flash.net.URLRequestMethod;
	
	import jsonrest.Constants;
	
	import mx.controls.List;
	
	/** 
	 * follows the JSON REST 1.0 format
	 * A JsonRestRequest has 3 important things to set before execution.
	 * Resource URL, Request Content, Request Method
	 * 
	 * Request Content is an array made up of 3 key-value pairs
	 * jsonrest - String compulsory
	 * api - String compulsory
	 * params - Array if not needed, set to empty Array compulsory
	 * */
	public class JsonRestRequest
	{
		
		protected var _request:URLRequest=null;
		protected var _content:JsonRequestContent;
		protected var _method:String;
		protected var _loader:URLLoader = null;
		protected var _responseContent:JsonResponseContent;
		public static const JSON_CONTENT_TYPE:URLRequestHeader = new URLRequestHeader("Content-type", "application/json");
		
		public function JsonRestRequest(uri:String, method:String, content:JsonRequestContent)
		{
			_request = new URLRequest(uri);
			_method = method;
			_request.method = method;
			_request.requestHeaders = [new URLRequestHeader("X-HTTP-Method-Override", _method), JSON_CONTENT_TYPE];
			_request.data = content.stringify();
			
			this.urlReload();
		}
		
		private function urlReload():void {
			_loader = new URLLoader(_request);
			_loader.addEventListener(Event.COMPLETE, handleResponse);
		}
		
		// returns the length of the requestHeaders
		public function addRequestHeader(reqHeader:URLRequestHeader):uint 
		{
			var length:uint  = _request.requestHeaders.push(reqHeader);
			this.urlReload();
			return length;
		}
		
		public function get requestHeaders():Array
		{
			return _request.requestHeaders;
		}
		
		public function get uri():String
		{
			return _request.url;
		}
		
		public function set uri(uri:String):void
		{
			_request = new URLRequest(uri);
			_request.method = _method;
			_request.requestHeaders = [new URLRequestHeader("X-HTTP-Method-Override", _method), JSON_CONTENT_TYPE];
			_request.data = _content.stringify();
			this.urlReload();
		}
		
		public function get method():String
		{
			return _request.method;
		}
		
		public function set method(method:String):void
		{
			_request.method = _method;
			_request.requestHeaders = [new URLRequestHeader("X-HTTP-Method-Override", _method)];
			this.urlReload();
		}
		
		public function get content():JsonRequestContent
		{
			return new JsonRequestContent(_request.data.jsonrest, _request.data.api, _request.data.params);
		}
		
		public function set content(reqContent:JsonRequestContent):void
		{
			_request.data = reqContent.stringify();
			this.urlReload();
		}
		
		public function get response():JsonResponseContent
		{
			return _responseContent;
		}

		public function send():void 
		{
			_loader.load(_request);
		}
		
		protected function handleResponse(event:Event):void
		{
			var data:String = _loader.data;
			var jsonResponse:Object = JSON.parse(data);
			
			var response:JsonResponseContent = new JsonResponseContent(jsonResponse.result, jsonResponse.error);
			_responseContent = response;
		}
	}
}