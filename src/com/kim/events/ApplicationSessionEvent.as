package com.kim.events
{
	import flash.events.Event;
	
	public class ApplicationSessionEvent extends Event
	{
		public static const LOGGED_IN:String='com.kim.events.ApplicationSessionEvent.LOGGED_IN';
		public static const LOGGED_OUT:String='com.kim.events.ApplicationSessionEvent.LOGGED_OUT';
		
		public function ApplicationSessionEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			
			super(type, bubbles, cancelable);
		}
		
		override public function clone():Event 
		{			
			return new ApplicationSessionEvent(type, bubbles, cancelable);		
		}
		
		override public function toString():String 
		{			
			return formatToString('ApplicationSessionEvent', 'type', 'bubbles', 'cancelable');		
		}
	}
}