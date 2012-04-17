package org.storybot.model.vo
{
	import flash.filesystem.File;
	
	import mx.collections.ArrayCollection;
	
	public class FileCollection extends ArrayCollection 
	{
		
		public function FileCollection(source:Array=null)
		{	
			var files:Array = [];
			if (source != null) {
				files = FileCollection.filterFiles(source);
			}
			
			super(files);
			
		}
		
		private static function filterFiles(source:Array):Array {
			var ret:Array = [];
			
			for each (var elem:* in source) {
				if (elem is File)
				ret.push(elem);
			}
			return ret;
		}
		
	}
}