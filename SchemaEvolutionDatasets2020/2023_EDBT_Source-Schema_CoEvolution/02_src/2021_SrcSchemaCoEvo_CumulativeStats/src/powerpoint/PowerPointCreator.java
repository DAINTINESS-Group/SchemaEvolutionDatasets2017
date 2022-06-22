package powerpoint;

import java.awt.Rectangle;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.List;

import org.apache.poi.sl.usermodel.PictureData;
import org.apache.poi.util.IOUtils;
import org.apache.poi.xslf.usermodel.XMLSlideShow;
import org.apache.poi.xslf.usermodel.XSLFPictureData;
import org.apache.poi.xslf.usermodel.XSLFPictureShape;
import org.apache.poi.xslf.usermodel.XSLFSlide;
import org.apache.poi.xslf.usermodel.XSLFTextBox;
import org.apache.poi.xslf.usermodel.XSLFTextParagraph;
import org.apache.poi.xslf.usermodel.XSLFTextRun;

public class PowerPointCreator {
	private final List<String[]> allProjects;
	private final int numPrjs;
	private final String inputFolder;
	private final String outputFolder;
	private final String[] header;
	private final int IMG_WIDTH = 350;
	private final int IMG_HEIGHT = 350;
	private final int TEXT_WIDTH = 700;
	private final int TEXT_HEIGHT = 80;
	private final int HEADER_Y_POS = 350;
	private final Double FONT_SIZE = 10.0;
	private final String FILE_NAME;// = "SRC_SCH_EVO.pptx";
	
	public PowerPointCreator(List<String[]> pAllProjects, String[] pHeader, String pOutputFileName) {
		if ((pAllProjects == null) || (pAllProjects.size() < 1)){
			System.err.println("Empty list of projects. Exiting.");
			System.exit(-1);
		}
		this.allProjects = pAllProjects;
		this.numPrjs = this.allProjects.size();
		this.header = pHeader;
		this.inputFolder = "./resources/incoming/13_Figures/";
		this.outputFolder = "./resources/output/ppt/";
		this.FILE_NAME = pOutputFileName;
		System.out.println("Stating with " + numPrjs + " projects");
	}//end constructor

	public int createPpt() {
		//creating a presentation 
		XMLSlideShow ppt = new XMLSlideShow();

		for(String[] prjInfo: this.allProjects) {
			addSlide(ppt, prjInfo);  
		}
		outputToDisk(ppt, FILE_NAME);

		return 0;
	}//end createPPt


	/**
	 * 
	 * @param ppt
	 * @param prjInfo
	 * @return
	 */
	private int addSlide(XMLSlideShow ppt, String[] prjInfo) {
		//creating a slide in it 
		XSLFSlide slide = ppt.createSlide();

		//extract prjName
		String prjName = prjInfo[0];

		// "./resources/incoming/TestFigures/cumulative_3ev__tev_label.tsv_absolute_time.png"
		String fileAbsoluteTimePath = this.inputFolder+"cumulative_"+prjName+".tsv_absolute_time.png";
		String filePercentageTimePath = this.inputFolder+"cumulative_"+prjName+".tsv_percentage_time.png";
		try {
			addImageToSlide(fileAbsoluteTimePath, ppt, slide, 0, 0, IMG_WIDTH, IMG_HEIGHT);
			addImageToSlide(filePercentageTimePath, ppt, slide, 350, 0, IMG_WIDTH, IMG_HEIGHT);
		} catch (FileNotFoundException e) {
			System.err.println("Impossible to add an image to the slide due to file problems");
			e.printStackTrace();
		} catch (IOException e) {
			System.err.println("Impossible to add an image to the slide due to file problems");
			e.printStackTrace();
		}

		//addHeader
		addHeader(slide, TEXT_HEIGHT);
		//add text 
		//TODO MAKE CONSTANTS FOR THE TEXT LOCATION AND SIZE
		String text = arrayToString(prjInfo);
		int textYPos = HEADER_Y_POS + TEXT_HEIGHT + 5;
		addText(slide, text, FONT_SIZE, 0, textYPos, 700, TEXT_HEIGHT);

		System.out.println(prjName + " : done.");
		return 0;
	}//addSlide()


	/**
	 * @param ppt
	 * @param slide
	 * @param width
	 * @param height
	 * @throws IOException
	 * @throws FileNotFoundException
	 */
	private  void addImageToSlide(String imgPath, XMLSlideShow ppt, XSLFSlide slide, int xPos, int yPos, int width, int height)
			throws IOException, FileNotFoundException {
		File image2 = new File(imgPath);
		byte[] picture2 = IOUtils.toByteArray(new FileInputStream(image2));
		XSLFPictureData idx2 = ppt.addPicture(picture2, PictureData.PictureType.PNG);
		XSLFPictureShape pic2 = slide.createPicture(idx2);
		pic2.setAnchor(new Rectangle(xPos,yPos,width,height));
	}//addImageToSlide

	/**
	 * @param slide
	 * @param height
	 * @return
	 */
	private int addHeader(XSLFSlide slide, int height) {

		XSLFTextBox shape0 = slide.createTextBox();
		XSLFTextParagraph p0 = shape0.addNewTextParagraph();
		XSLFTextRun r0 = p0.addNewTextRun();
		r0.setText(arrayToString(header));
		r0.setFontSize(10.);
		
		shape0.setAnchor(new Rectangle(0,HEADER_Y_POS,TEXT_WIDTH,height)); 
		return 0;
	}//addHeader

	private String arrayToString(String[] array) {
		String result="";
		for(String s: array) {
			result = result +"\t"+s;
		}
		return result.trim();
	}//end arrayToString


	/**
	 * Adds a paragraph to a slide
	 * 
	 * @param slide
	 * @param message the content
	 * @param fontSize
	 * @param xPos
	 * @param yPos
	 * @param width
	 * @param height
	 */
	private void addText(XSLFSlide slide, String message, Double fontSize, int xPos, int yPos, int width, int height) {
		XSLFTextBox shape0 = slide.createTextBox();
		XSLFTextParagraph p0 = shape0.addNewTextParagraph();
		XSLFTextRun r0 = p0.addNewTextRun();
		r0.setText(message);
		r0.setFontSize(fontSize);
		shape0.setAnchor(new Rectangle(xPos,yPos,width,height)); 

	}//addHeader

	/**
	 * @param ppt
	 * @throws FileNotFoundException
	 * @throws IOException
	 */
	private void outputToDisk(XMLSlideShow ppt, String fileName)  {
		//creating a file object 
		File file = new File(outputFolder + fileName);
		FileOutputStream out=null;
		try{
			out = new FileOutputStream(file);
			//saving the changes to a file
			ppt.write(out);
			ppt.close();
			out.close();
		} 
		catch(FileNotFoundException e) {
			System.err.println("Impossible to create output file");
			e.printStackTrace();
		}
		catch(IOException e) {
			System.err.println("Impossible to create output file");
			e.printStackTrace();
		}

		System.out.println("\n\nPpt created successfully");
	}

}//end class
