package jsonrest.model
{
	import jsonrest.Constants;
	/** 
	 * follows the JSON RPC 2.0 format
	 * see http://json-rpc.org/wiki/specification
	 * the only difference is I added jsonrpc as a
	 * */
	public class JsonResponseContent extends JsonRestContent
	{
		
		protected var _result:Object=null;
		protected var _error:Object=null;
		
		public function JsonResponseContent(result:Object, error:Object, jsonrest:String=Constants.VERSION, api:String=Constants.API_VERSION)
		{
			if (result != null) {
				_result = result;
			} else if (error != null) {
				
				_error = error;
			}
				
			super(jsonrest, api);
		}
		
		public function get result():Object 
		{
			return _result;
		}
		
		public function get error():Object 
		{
			return _error;
		}
		
		
	}
}