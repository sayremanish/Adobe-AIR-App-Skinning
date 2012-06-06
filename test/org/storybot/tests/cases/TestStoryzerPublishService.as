package org.storybot.tests.cases
{
	import flash.events.EventDispatcher;
	
	import mockolate.prepare;
	import mockolate.nice;
	import mockolate.stub;
	import mockolate.verify;
	import mockolate.errors.VerificationError;
	
	import org.hamcrest.core.not;
	import org.hamcrest.object.equalTo;
	import org.hamcrest.object.nullValue;
	import org.hamcrest.object.hasPropertyWithValue;

	
	import org.flexunit.Assert;
	import org.flexunit.async.Async;
	
	import com.kim.service.StoryzerPublishService;
	
	import com.kim.events.PublishStoryEvent;
	
	
	public class TestStoryzerPublishService
	{
		private var service:StoryzerPublishService;
		private var serviceDispatcher:EventDispatcher = new EventDispatcher();
		
		[Before]
		public function setUp():void
		{
			serviceDispatcher = new EventDispatcher();
			service = new StoryzerPublishService();
			service.eventDispatcher = serviceDispatcher;
		}
		
		[After]
		public function tearDown():void
		{
			this.serviceDispatcher = null;
			this.service = null;
		}
		
		[Test(async)]
		public function testPublishStory():void
		{
			this.serviceDispatcher.addEventListener( PublishStoryEvent.SERVER_CONFIRM_UPLOAD_COMPLETE, 
				Async.asyncHandler(this, handleStoryPublished, 8000, null, 
					handleServiceTimeout), false, 0, true);
			
			this.service.publishStory();
		}
		
		protected function handleServiceTimeout( object:Object ):void
		{
			Assert.fail('Pending Event Never Occurred');
		}
		
		protected function handleStoryPublished(event:PublishStoryEvent, object:Object):void
		{
			Assert.assertEquals("The story should be valid: ", 
				event.story.id > 0, true)	
		}
		
		
	}
}