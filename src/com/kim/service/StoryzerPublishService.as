package com.kim.service
{
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	import flash.net.URLVariables;
	
	import org.robotlegs.mvcs.Actor;

	public class StoryzerPublishService extends Actor implements IPublishService
	{
		private var loader:URLLoader;
		
		public function StoryzerPublishService()
		{
			loader = new URLLoader();
		}
	}
}