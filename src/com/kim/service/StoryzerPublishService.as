package com.kim.service
{
	import com.kim.service.events.PublishResultEvent;
	import com.kim.service.helpers.IPublishResultParser;
	
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;
	import flash.net.URLVariables;
	
	import org.robotlegs.mvcs.Actor;
	
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.utils.ByteArray;

	
	public class StoryzerPublishService extends Actor implements IPublishService
	{
		
		private var _parser:IPublishResultParser;
		
		[Inject]
		public function set parser(value:IPublishResultParser):void
		{
			_parser = value;
		}

		
		private var loader:URLLoader;
		
		public function StoryzerPublishService()
		{
			loader = new URLLoader();
		}
		
		private const STORYZER_PUBLISH_STORY_URL:String = "http://storyzer.localhost/stories/add";
		private const STORYZER_PUBLISH_ARTWORK_URL:String = "http://stage.storyzer.com/works/add";
		
		public function publishStory(file:File):void {
			
			
			var urlRequest:URLRequest = new URLRequest(STORYZER_PUBLISH_STORY_URL);
			// set to method=POST
			urlRequest.method = URLRequestMethod.POST;
			// set contenttype for binary file upload
			//urlRequest.contentType = "multipart/form-data";
			
			
			
			
			
			var params:URLVariables = new URLVariables();
			
			
			
			params['data[Story][title]'] = 'Title1';
			
			/*
			params.Story.title = 'Title1';
			params.Story.description = 'desc';
			params.Story.publisher = 'asd';
			params.Story.list_price = '11';
			params.Story.currency = 'SGD';
			
			// extra hack-y stuff to get past authentication issues
			params.Story.testdata = 1;
			
			params.StoryFile = new Array();
			params.StoryFile['0'] = new Array();
			params.StoryFile['0']['filename'] = file.data;
			
			
			params.StoriesInList = new Array();
			params.StoriesInList['0'] = new Array();
			params.StoriesInList['0']['listId'] = 1;
			*/
			urlRequest.data = params;
			
			addLoaderListeners();
			
			// set it such that data format is in variables
			loader.dataFormat = URLLoaderDataFormat.VARIABLES;
			
			loader.load(urlRequest);

		}
		
		private function handleError(event:SecurityErrorEvent):void
		{
			removeLoaderListeners();
		}
		
		private function handleLoadComplete(event:Event):void
		{
			var data:Object = loader.data;
			var results:Array = _parser.parsePublishResults(data);
			dispatch(new PublishResultEvent(PublishResultEvent.RECEIVED, results))
			removeLoaderListeners();
		}
		
		private function addLoaderListeners():void
		{
			loader.addEventListener(IOErrorEvent.IO_ERROR, handleError);
			loader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, handleError);
			loader.addEventListener(Event.COMPLETE, handleLoadComplete);
		}
		
		private function removeLoaderListeners():void
		{
			loader.removeEventListener(IOErrorEvent.IO_ERROR, handleError);
			loader.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, handleError);
			loader.removeEventListener(Event.COMPLETE, handleLoadComplete);
		}

	}
}