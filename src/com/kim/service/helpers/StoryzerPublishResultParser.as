package com.kim.service.helpers
{
	public class StoryzerPublishResultParser implements IPublishResultParser
	{
		
		
		import com.kim.model.Story;
		
		
		public function parsePublishResults(results:Object):Array
		{
			var jsonStringResults:String = JSON.stringify(results)
			
			return new Array() ;
		}
	}
}