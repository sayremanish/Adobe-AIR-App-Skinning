package jsonrest.model
{
	import jsonrest.Constants;
	
	public class JsonRequestContent extends JsonRestContent
	{
		protected var _params:Object = {};
		
		public function JsonRequestContent(params:Object, jsonrest:String=Constants.VERSION, api:String=Constants.API_VERSION)
		{
			_params = params;
			super(jsonrest, api);
		}
		
		public function get params():Object
		{
			return _params;
		}
		
		public function set params(params:Object):void
		{
			_params = params;
		}
		
		/**
		 * this is to encode the current content into a JSON string
		 * */
		public function stringify():String
		{
			var jsonbody:Object = {jsonrest:_jsonrest, api:_api, params:_params};
			return JSON.stringify(jsonbody);
		}
	}
}