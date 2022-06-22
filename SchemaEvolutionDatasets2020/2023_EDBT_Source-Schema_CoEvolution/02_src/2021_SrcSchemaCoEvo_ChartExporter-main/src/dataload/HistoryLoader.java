package dataload;

import java.text.SimpleDateFormat;  
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.util.ArrayList;
import java.util.Date;
import java.util.Scanner;

import datamodel.ProjectHistory;

public class HistoryLoader {

	private String titleLine;
	private ArrayList<ProjectHistory> objCollection;
	private ArrayList<String> header;
	private int type;
	
	public HistoryLoader(int type) {
		objCollection = new ArrayList<ProjectHistory>();
		header = new ArrayList<String>();
		this.type = type;
	}
	
	public int load(String fileName, String delimeter, boolean hasHeaderLine, int numFields) throws Exception {
		if (numFields < 1){
			System.out.println("Wrong number of fields, less than 1!");
			System.exit(0);
		}
		
		//Opening files for read and write, checking exception
		Scanner inputStream = null;
		try {
			inputStream = new Scanner(new FileInputStream(fileName));

		} catch (FileNotFoundException e) {
			System.out.println("Problem opening file: " + fileName);
			System.exit(0);
		}

		int count = 0;

		//process the title of the file (tab separated)
		if(hasHeaderLine){
			titleLine = inputStream.nextLine();
			String[] tokens = titleLine.split(delimeter);
			for(int i = 0; i< tokens.length; i++)
				header.add(tokens[i]);
			count++;
		}
		
		String line = "";
		//process the actual rows one by one
		while (inputStream.hasNextLine()) {
			line = inputStream.nextLine();
			count++;

			String[] tokens = line.split(delimeter);
					
			int objConstructionErrorCode;
			objConstructionErrorCode = constructObjectFromRow(tokens);
			if (objConstructionErrorCode !=0){
				System.out.println("ObjParsingError. I found a problem at line " + count + " of file " + fileName);
				System.exit(0);
			}
		}		
		inputStream.close();
		System.out.println("Processed " + count + " rows and loaded " + objCollection.size() + " objects.");
		return count;
	}
	
	public int constructObjectFromRow(String[] tokens) throws Exception {
		Date date;
		String author;
		int numAffectedFiles;
		int containsSQL;
		
		if (type == 0) {
			// When loading detailed .tsv
			date = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss Z").parse(tokens[0]);
		} else {
			// When loading summed .tsv
			date = new SimpleDateFormat("yyyy-MM").parse(tokens[0]);
		}
		
		author = tokens[1];
		numAffectedFiles = Integer.parseInt(tokens[2]);
		containsSQL = Integer.parseInt(tokens[3]);
		
		ProjectHistory element = new ProjectHistory(date, author, numAffectedFiles, containsSQL); 
		objCollection.add(element);
		
		return 0;
	}
	
	public ArrayList<ProjectHistory> getObjCollection(){
		return objCollection;
	}
	
	public ArrayList<String> getHeader(){
		return header;
	}
	
	public String getTitle() {
		return titleLine;
	}
	
}
