package com.kim.events
{
	
	import flash.events.Event;
	
	public class UnsuccessfulFileCreatedEvent extends Event
	{
		public static const FILE_CREATE_FAIL:String='com.kim.events.UnsuccessfulFileCreatedEvent.FILE_CREATE_FAIL';
		protected var _error:Error;
		
		public function UnsuccessfulFileCreatedEvent(type:String, error:Error, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			_error = error;
			super(type, bubbles, cancelable);
		}
		
		public function get error():Error 
		{			
			return _error;		
		}
		
		override public function clone():Event 
		{			
			return new UnsuccessfulFileCreatedEvent(type, error, bubbles, cancelable);		
		}
		
		override public function toString():String 
		{			
			return formatToString('UnsuccessfulFileCreated', 'type', 'bubbles', 'cancelable', 'error');		
		}
	}
}