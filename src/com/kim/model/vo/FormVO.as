package com.kim.model.vo
{
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;
	import flash.net.URLVariables;

	public class FormVO
	{
		protected var _response:String;
		protected var _action:String;
		protected var _method:String;
		protected var _formFields:URLVariables;
		protected var _formRequest:URLRequest;
		
		public function FormVO(action:String, method:String=method:String=URLRequestMethod.POST, formFields:URLVariables)
		{
			_action = action;
			_method = method;
			_formFields = formFields;
		}
		
		
	}
}