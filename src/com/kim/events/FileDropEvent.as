package com.kim.events
{
	import com.kim.collections.FileCollection;
	
	import flash.events.Event;
	import flash.filesystem.File;
	
	public class FileDropEvent extends Event
	{
		public static const FILE_DROP:String='com.kim.events.FileDropEvent.FILE_DROP'
		protected var _files:FileCollection;
		protected var _currentStoryFolder:String;
		
		public function FileDropEvent(type:String, files:FileCollection, currentStoryFolder:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			_files = files;
			super(type, bubbles, cancelable);
		}
		
		public function get files():FileCollection 
		{			
			return _files;		
		}
		
		override public function clone():Event 
		{			
			return new FileDropEvent(type, files, bubbles, cancelable);		
		}
		
		override public function toString():String 
		{			
			return formatToString('FileDrop', 'type', 'bubbles', 'cancelable', 'files');		
		}
	}
}