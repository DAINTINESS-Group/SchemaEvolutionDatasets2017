package engine;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStreamWriter;
import java.io.PrintWriter;
import java.nio.charset.StandardCharsets;
import java.util.ArrayList;

public class ProduceHTMLEngine {

	private String figuresFolder, folderName;
	private String[] figureNames;
	private ArrayList<File> files = new ArrayList<>();
	
	public ProduceHTMLEngine(String figuresFolder, String folderName) {
		this.figuresFolder = figuresFolder;
		this.folderName = folderName;
	}
	
	/**
	 * produce a simple HTML with all images in a folder.
	 * @return true if html produced successfully
	 */
	public boolean produceHTML() {
		
		// load figures
		File directory = new File(figuresFolder);
		if (!directory.exists())
	    	return false;
		
		figureNames = directory.list();  // figure names for each taxon
		
		// Get all .png file names
	    if(figureNames != null) {
	        for (String file : figureNames)
	        	if (file.contains(".png"))
	            	files.add(new File(file));
	    } else {
	    	return false;
	    }
		
		// Create .html file
	    File HTMLFile = new File(figuresFolder + File.separator + "summary.html");
	    
		try {
			PrintWriter writer = new PrintWriter(new OutputStreamWriter(new FileOutputStream(HTMLFile, false), StandardCharsets.UTF_8));
			
			// Basics of HTML file
			writer.println("<html>");
			writer.println("<head>\n<title>" + "HTML file With all figures for the taxon" + "</title>\n</head>");
			writer.println("<body>");
			writer.println("<h1>" + folderName.replace("_months_sum", "") + "</h1>");
			
			
			// Add figures to HTML file and close it
			writer.println("<h3>Occurrences of files Figures</h3>");
			writer.println("<table style=\"width:100%\">");
			writer.println("<tr>");
			for (File f : files) {
				writer.println("<img src=\"" + f.getName() + "\" alt=\"" + f.getName() + "\" width=\"500\" height=\"500\">");
			}
			writer.println("</tr>");
			writer.println("</table>\n</body>\n</html>");
			writer.close();
		} catch (IOException e) {
			e.printStackTrace();
			return false;
		}
	    
		return true;
	}

	/**
	 * produce a simple HTML with all images in a folder.
	 * @return true if html produced successfully
	 */
	public boolean produceCumulativeHTML() {
		
		// load figures
		File directory = new File(figuresFolder);
		if (!directory.exists())
	    	return false;
		
		figureNames = directory.list();  // figure names for each taxon
		
		// Get all .png file names
	    if(figureNames != null) {
	        for (String file : figureNames)
	        	if (file.contains(".png"))
	            	files.add(new File(file));
	    } else {
	    	return false;
	    }
	    
		// Create .html file
	    File HTMLFile = new File(figuresFolder + File.separator + "summaryCumulative.html");
	    
		try {
			PrintWriter writer = new PrintWriter(new OutputStreamWriter(new FileOutputStream(HTMLFile, false), StandardCharsets.UTF_8));
			
			// Basics of HTML file
			writer.println("<html>");
			writer.println("<head>\n<title>" + "HTML file With all cumulative figures" + "</title>\n</head>");
			writer.println("<body>");
			// writer.println("<h1>" + folderName + "</h1>");
			
			
			// Add figures to HTML file and close it
			// writer.println("<h3>Occurrences of files Figures</h3>");
			writer.println("<table style=\"width:100%\">");
			writer.println("<tr>");
			for (File f : files) {
				writer.println("<img src=\"" + f.getName() + "\" alt=\"" + f.getName() + "\" width=\"500\" height=\"500\">");
			}
			writer.println("</tr>");
			writer.println("</table>\n</body>\n</html>");
			writer.close();
		} catch (IOException e) {
			e.printStackTrace();
			return false;
		}
	    
		return true;
	}
	
}
