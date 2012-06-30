package jsonrest.model
{
	
	import jsonrest.Constants;
	
	public class JsonRestContent
	{
		
		protected var _jsonrest:String = Constants.VERSION; // this refers to the version of the JSON-REST protocol
		protected var _api:String = Constants.API_VERSION; // this refers to the api version of the platform
		
		public function JsonRestContent(jsonrest:String = null, api:String = null)
		{
			if (jsonrest != null) {
				_jsonrest = jsonrest;	
			}
			if (api != null) {
				_api = api;	
			}
		}
		
		public function get jsonrest():String 
		{
			return _jsonrest;
		}
		
		public function get api():String 
		{
			return _api;
		}
		
	}   
}