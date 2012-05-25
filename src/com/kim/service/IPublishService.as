package com.kim.service
{
	
	import com.kim.service.helpers.IPublishResultParser;
	
	import flash.filesystem.File;
	
	public interface IPublishService
	{
		// function inside the StoryzerPublishService
		function publishStory(file:File):void;
		
		// set the parser something??
		function set parser(value:IPublishResultParser):void;
	}
}