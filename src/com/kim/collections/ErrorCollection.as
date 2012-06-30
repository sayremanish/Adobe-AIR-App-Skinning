package com.kim.collections
{
	
	import mx.collections.ArrayCollection;
	
	public class ErrorCollection extends ArrayCollection
	{
		public function ErrorCollection(source:Array=null)
		{
			var errors:Array = [];
			
			if (source != null){				
				errors = ErrorCollection.filterErrors(source);			
			}
			
			super(errors);
		}
		
		private static function filterErrors(source:Array):Array {
			var ret:Array = [];
			
			for each (var elem:* in source) {
				if (elem is String){
					ret.push(elem);
				}
			}
			
			return ret;
		}
	}
}