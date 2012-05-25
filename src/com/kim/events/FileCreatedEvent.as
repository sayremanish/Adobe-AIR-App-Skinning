package com.kim.events
{
	
	import flash.events.Event;
	import flash.filesystem.File;
	
	public class FileCreatedEvent extends Event
	{
		public static const FILE_CREATED:String='com.kim.events.FileCreatedEvent.FILE_CREATED';
		protected var _file:File;
		
		public function FileCreatedEvent(type:String, file:File, bubbles:Boolean=false, cancelable:Boolean=false)
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
			return new FileCreatedEvent(type, file, bubbles, cancelable);		
		}
		
		override public function toString():String 
		{			
			return formatToString('FileCreated', 'type', 'bubbles', 'cancelable', 'file');		
		}
	}
}