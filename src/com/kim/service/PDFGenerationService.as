package com.kim.service
{
	import com.kim.collections.FileCollection;
	import com.kim.utils.Utils;
	
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.net.FileReference;
	import flash.utils.ByteArray;
	
	import mx.collections.Sort;
	import mx.collections.SortField;
	
	import org.purepdf.elements.ReadOnlyRectangle;
	import org.purepdf.elements.images.ImageElement;
	import org.purepdf.pdf.PageSize;
	import org.purepdf.pdf.PdfDocument;
	import org.purepdf.pdf.PdfVersion;
	import org.purepdf.pdf.PdfWriter;
	import org.robotlegs.mvcs.Actor;
	
	public class PDFGenerationService extends BaseGenerationService
	{
		private var _pdf:PdfDocument;
		private var _writer:PdfWriter;
		
		override public function generate(files:FileCollection):void{
			
			_writer = PdfWriter.create(_buffer, PageSize.A4);
			_newPath = (new Date()).milliseconds.toString() + ".pdf";
			
			super.generate(files);
			
		}
		
		override protected function cleanUp():void{
			_pdf.close();
		}
		
		
		//This will process image and create new pdf page
		override protected function createPage(byteArray:ByteArray):void
		{
			var image:ImageElement = ImageElement.getInstance(byteArray);
			
			_pdf = _writer.pdfDocument;
			_pdf.setPdfVersion(PdfVersion.VERSION_1_5);
			_pdf.setMargins(2,2,2,2);
			
			//This will check if the size of image is greater than A4 size
			//It will also check whether image width is less than equal to A4 size width and image height is greater than equal to A4 size height
			//and also check whether image width is greater than equal to A4 size width and image height is less than equal to A4 size height
			//If any one of the condition is satisfied we will assign custom page size to the pdf page as image width and height
			if(image.width >= 595 && image.height >= 842
				|| image.width <= 595 && image.height >= 842
				|| image.width >= 595 && image.height <= 842){//where A4 width is 595 and A4 height is 842
				
				_pdf.pageSize = new ReadOnlyRectangle(0,0,image.width + 2, image.height + 2);
			}else{
				_pdf.pageSize = PageSize.A4;
			}
			
			if(_pdf.opened){
				_pdf.newPage();		
			}else{
				_pdf.open();
			}
			_pdf.add(image);
			
		}
	}
}