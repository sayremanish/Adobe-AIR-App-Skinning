package com.kim.events
{
	
	import flash.events.Event;
	import flash.filesystem.File;
	
	import com.kim.model.Story;
	
	public class PublishStoryEvent extends Event
	{
		public static const OPEN_FILE_FOR_UPLOAD:String='com.kim.events.PublishStoryEvent.OPEN_FILE_FOR_UPLOAD';
		public static const FILE_UPLOAD_IN_PROGRESS:String='com.kim.events.PublishStoryEvent.FILE_UPLOAD_IN_PROGRESS';
		public static const FILE_UPLOAD_COMPLETE:String='com.kim.events.PublishStoryEvent.FILE_UPLOAD_COMPLETE';
		public static const SERVER_CONFIRM_UPLOAD_COMPLETE:String='com.kim.events.PublishStoryEvent.SERVER_CONFIRM_UPLOAD_COMPLETE';
		public static const UPLOAD_SECURITY_ERROR:String='com.kim.events.PublishStoryEvent.UPLOAD_SECURITY_ERROR';
		public static const UPLOAD_HTTP_STATUS:String='com.kim.events.PublishStoryEvent.UPLOAD_HTTP_STATUS';
		public static const UPLOAD_HTTP_RESPONSE_STATUS:String='com.kim.events.PublishStoryEvent.UPLOAD_HTTP_RESPONSE_STATUS';
		public static const UPLOAD_IO_ERROR:String='com.kim.events.PublishStoryEvent.UPLOAD_IO_ERROR';
		
		
		protected var _file:File;
		
		public var story:Story;
		
		public function PublishStoryEvent(type:String, file:File, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			_file = file;
			super(type, bubbles, cancelable);
		}
		
		public function get file():File 
		{			
			return _file;		
		}
		
		override public function clone():Event 
		{			
			return new PublishStoryEvent(type, file, bubbles, cancelable);		
		}
		
		override public function toString():String 
		{			
			return formatToString('PublishStory', 'type', 'bubbles', 'cancelable', 'file');		
		}
	}
}