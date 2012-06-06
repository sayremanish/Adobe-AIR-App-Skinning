package com.kim.service
{
	import com.kim.collections.FileCollection;
	
	import org.robotlegs.mvcs.Actor;

	public class StoryLocalPreparationService extends Actor
	{
		/**
		 * Creates folder in ApplicationDirectory for a single story
		 * StoryFolder will have pages folder storing all the pages
		 * a json text file and a cbz file
		 * @param files FileCollection of the drag 'n drop files
		 * @param currentStoryFolder String that is folder name for a Story
		 * @return mixed Returns true if successful update. Returns foldername as String if successful create. Returns false if unsuccessful
		 **/
		public function save(files:FileCollection, currentStoryFolder:String = null):* 
		{
			var createNewStory:Boolean = (currentStoryFolder == null);
			var updateStory:Boolean = !createNewStory;
			this.createJSONPropertiesFile();	
			
			return true;
		}
		
		/**
		 * Create the json file which will hold all the properties
		 **/
		protected function createJSONPropertiesFile():Boolean
		{
			return true;
		}
		
		/**
		 * update the properties in the json file
		 **/
		protected function updateJSONPropertiesFile():Boolean
		{
			return true;
		}
		
		/**
		 * create or update the cbz file
		 **/
		protected function generateCBZFile():Boolean
		{
			return true;
		}
	}
}