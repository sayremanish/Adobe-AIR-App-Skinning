package jsonrest.model
{
	import jsonrest.Constants;
	
	public class JsonRequestContent extends JsonRestContent
	{
		protected var _params:Array=Array();
		
		public function JsonRequestContent(params:Array, jsonrest:String=Constants.VERSION, api:String=Constants.API_VERSION)
		{
			_params = params;
			super(jsonrest, api);
		}
		
		public function get params():Array
		{
			return _params;
		}
		
		public function set params(params:Array):void
		{
			_params = params;
		}
		
		/**
		 * this is to encode the current content into a JSON string
		 * */
		public function stringify():String
		{
			return JSON.stringify(_jsonrest, _api, _params);
		}
	}
}