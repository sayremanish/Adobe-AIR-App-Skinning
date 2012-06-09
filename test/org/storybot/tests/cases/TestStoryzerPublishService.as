package org.storybot.tests.cases
{
	import com.kim.events.PublishStoryEvent;
	import com.kim.service.StoryzerPublishService;
	
	import flash.events.EventDispatcher;
	import flash.filesystem.File;
	
	import mockolate.errors.VerificationError;
	import mockolate.nice;
	import mockolate.prepare;
	import mockolate.stub;
	import mockolate.verify;
	
	import org.flexunit.Assert;
	import org.flexunit.async.Async;
	import org.hamcrest.core.not;
	import org.hamcrest.object.equalTo;
	import org.hamcrest.object.hasPropertyWithValue;
	import org.hamcrest.object.nullValue;
	
	
	public class TestStoryzerPublishService
	{
		private var service:StoryzerPublishService;
		private var serviceDispatcher:EventDispatcher = new EventDispatcher();
		
		[Mock] public var mockStoryFile:File;
		
		private static const CBZ_FILE:String = "test.cbz";
		
		[Before]
		public function setUp():void
		{
			serviceDispatcher = new EventDispatcher();
			service = new StoryzerPublishService();
			service.eventDispatcher = serviceDispatcher;
			
			// stubbing the mockStoryFile 
			stub(mockStoryFile).getter("name").returns(CBZ_FILE);
			stub(mockStoryFile).getter("size").returns(1);
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
			
			this.service.publishStory(mockStoryFile);
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