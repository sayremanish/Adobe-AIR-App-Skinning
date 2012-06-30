package com.kim.service
{
	
	import com.kim.Constants;
	import com.kim.Globals;
	import com.kim.events.ApplicationSessionEvent;
	
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.URLRequestHeader;
	import flash.net.URLRequestMethod;
	
	import jsonrest.model.JsonRequestContent;
	import jsonrest.model.JsonRestRequest;
	
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.http.HTTPService;
	import mx.utils.Base64Encoder;
	
	import org.robotlegs.mvcs.Actor;
	
	public class StoryzerLoginService extends Actor
	{
		protected var _jsonRequest:JsonRestRequest;
		
		public static const LOGIN_URI:String = Constants.HTTP + Constants.STORYZER_DOMAIN + '/oauth/token?grant_type=password';
		public function StoryzerLoginService()
		{
			/*
			var encoder:Base64Encoder = new Base64Encoder();        
			encoder.encode(Constants.CLIENT_ID + ":" + Constants.CLIENT_SECRET);
			
			var credsHeader:URLRequestHeader = new URLRequestHeader("Authorization", "Basic " + encoder.toString());
			
			
			var jsonContent:JsonRequestContent = new JsonRequestContent(new Array());
			
			_jsonRequest = new JsonRestRequest(LOGIN_URI, URLRequestMethod.POST, jsonContent);
			*/
			//_jsonRequest.addRequestHeader(credsHeader);
		}
		
		
		protected var _loader:URLLoader = new URLLoader();
		
		public function login(params:Object):void
		{
			
			this.loginusingurlrequest(params);
			//this.loginusinghttpservicejson(params);
			//_jsonRequest.content = new JsonRequestContent(params);
			
			//_jsonRequest.send();	
			
			//trace(_jsonRequest.response);
		}
		
		/**
		 * 
		 *  since the OAuth library code assume $_POST or $_GET so no point doing JSON for the login
		 * */
		public function loginusinghttpservicejson(params:Object):void 
		{
			params["client_id"] = Constants.CLIENT_ID;
			params["client_secret"] = Constants.CLIENT_SECRET;
			params["grant_type"] = "password";
			
			var json_string:String = JSON.stringify(params);
			
			var loginurl:String = "http://storyzer.localhost/oauth/token.json";
			
			
			var service:HTTPService = new HTTPService();
			service.url = loginurl;
			service.method = URLRequestMethod.POST;
			service.contentType = "application/json";
			service.resultFormat = mx.rpc.http.HTTPService.RESULT_FORMAT_TEXT;
			service.useProxy = false;
			
			trace(json_string);
			
			service.addEventListener(FaultEvent.FAULT,handleFaultError);
			service.addEventListener(ResultEvent.RESULT,handleResult);
			service.showBusyCursor = true;
			
			service.send(json_string);

		}
		
		public function loginusingurlrequest(params:Object):void {
			params["client_id"] = Constants.CLIENT_ID;
			params["client_secret"] = Constants.CLIENT_SECRET;
			
			var loginurl:String = "http://storyzer.localhost/oauth/token";
			
			var request:URLRequest = new URLRequest(loginurl);
			
			request.method = URLRequestMethod.POST;
			//request.data = params;
			
			_loader = new URLLoader();
			import flash.net.URLVariables;
			var theparams:URLVariables = new URLVariables();
			theparams['grant_type'] = "password";
			theparams['username'] = params['username'];
			theparams['password'] = params['password'];
			theparams['client_id'] = params['client_id'];
			theparams['client_secret'] = params['client_secret'];
			request.data = theparams;
			
			import flash.events.Event;
			_loader.addEventListener(Event.COMPLETE, handleResponse);
			_loader.addEventListener(IOErrorEvent.IO_ERROR, handleError);
			_loader.load(request);

		}
		
		//wrote this function
		private function handleFaultError( event:FaultEvent ):void
		{
			trace( "got you.!!! " + event.toString() );
			trace(event.message.body);
		}
		
		//wrote this function
		private function handleResult( event:ResultEvent ):void
		{
			trace( "got you.!!! " + event.toString() );
			trace(event.result);
		}
		
		//wrote this function
		private function handleError( event:IOErrorEvent ):void
		{
			trace( "got you.!!! " + event.toString() );
		}
		
		protected function handleResponse(evt:Event):void
		{
			var jsonresponse:Object = JSON.parse(_loader.data);
			Globals.ACCESS_TOKEN = jsonresponse.access_token;
			Globals.REFRESH_TOKEN = jsonresponse.refresh_token;
			trace(_loader.data);
			var event:ApplicationSessionEvent = new ApplicationSessionEvent(ApplicationSessionEvent.LOGGED_IN);
			dispatch(event);
		}
		
	}
}