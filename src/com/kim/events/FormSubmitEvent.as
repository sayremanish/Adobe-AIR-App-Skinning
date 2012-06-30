package com.kim.events
{
	import com.kim.collections.ErrorCollection;
	
	import flash.events.Event;
	import flash.filesystem.File;
	import flash.net.URLRequestMethod;
	
	public class FormSubmitEvent extends Event
	{
		public static const SUBMIT:String='com.kim.events.LoginFormSubmitEvent.SUBMIT';
		public static const SUCCESS:String='com.kim.events.LoginFormSubmitEvent.SUCCESS';
		public static const FAIL:String='com.kim.events.LoginFormSubmitEvent.FAIL';
		
		
		protected var _result:String;
		protected var _errors:ErrorCollection;
		protected var _params:Object;
		
		public function FormSubmitEvent(type:String, params:Object, result:String=null, errors:ErrorCollection=null, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			_result = result;
			_errors = errors;
			
			_params = params;
			super(type, bubbles, cancelable);
		}
		
		public function get errors():ErrorCollection 
		{			
			return _errors;		
		}
		
		public function get result():String
		{
			return _result;
		}
		
		public function get params():Object
		{
			return _params;
		}
		
		public function set result(result:String):void
		{
			_result = result;
		}
		
		public function set params(params:Object):void
		{
			_params = params;
		}
		
		public function set errors(errors:ErrorCollection):void
		{
			_errors = errors;
		}
		
		override public function clone():Event 
		{			
			return new FormSubmitEvent(type, params, result, errors, bubbles, cancelable);		
		}
		
		override public function toString():String 
		{			
			return formatToString('FormSubmit', 'type', 'bubbles', 'cancelable', 'params', 'result', 'errors');		
		}
	}
}