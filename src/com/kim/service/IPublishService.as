package com.kim.service
{
	
	import com.kim.service.helpers.IPublishResultParser;
	
	public interface IPublishService
	{
		// function inside the StoryzerPublishService
		function getResults(forQuery:String="robotlegs"):void;
		
		// set the parser something??
		function set parser(value:IPublishResultParser):void;
	}
}