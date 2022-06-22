package dataload;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.Period;
import java.time.ZoneId;
import java.util.ArrayList;
import java.util.Date;
import java.util.Scanner;

import datamodel.CumulativeModel;
import datamodel.ProjectHistory;
import engine.AddZerosEngine;

public class CumulativeDataLoader {

	private String titleLine;
	private ArrayList<CumulativeModel> objCollection;
	private ArrayList<String> header;
	private ArrayList<ProjectHistory> prjHistCollection;
	
	private ArrayList<Integer> prjActivity, schActivity;
	
	public CumulativeDataLoader() {
		// Empty constructor
	}

	/**
	 * Loaders for PrjHistory files (get totDuration - totPrjAct)  ==================================================================================
	 */
	public void loadProjectHistory(String projectName) throws Exception {
		HistoryLoader historyLoadert = new HistoryLoader(1);
		historyLoadert.load(projectName, "\t", true, 4);
		
		AddZerosEngine addZerosEngine = new AddZerosEngine(historyLoadert.getObjCollection());
		prjHistCollection = addZerosEngine.addZeros();
	}
	
	public int getTotalDuration() {
		Date start = prjHistCollection.get(0).getDate();
		Date end = prjHistCollection.get(prjHistCollection.size()-1).getDate();
		
		// Read first date
		LocalDate start_date = start.toInstant().atZone(ZoneId.systemDefault()).toLocalDate();
		
		// Read last date
		LocalDate end_date = end.toInstant().atZone(ZoneId.systemDefault()).toLocalDate();
		
		Period diff = Period.between(start_date, end_date);
		
		return (diff.getYears()*12)+diff.getMonths()+1;
		
		// return prjHistCollection.size();
	}
	
	public int getTotalProjectActivity() {
		int totPrjAct = 0;
		prjActivity = new ArrayList<>();
		
		for (ProjectHistory projectHistory : prjHistCollection) {
			totPrjAct += projectHistory.getNumAffectedFiles();
			prjActivity.add(projectHistory.getNumAffectedFiles());
		}
		
		return totPrjAct;
	}
	
	public ArrayList<Integer> getTotalProjectActivityList(){
		return prjActivity;
	}
	
	/**
	 * Loader for totSchActivity  ===================================================================================================================
	 * We should match the first schema commit and add zeros before/after to match prjActivity length
	 */
	public int getTotalSchemaActivity(String fileName) throws Exception {
		int totSchAct = 0;
		schActivity = new ArrayList<>();
		
		//Opening files for read and write, checking exception
		Scanner inputStream = null;
		try {
			inputStream = new Scanner(new FileInputStream(fileName));
		} catch (FileNotFoundException e) {
			System.out.println("Problem opening file: " + fileName);
			System.exit(0);
		}
		
		// Read the first line - header
		inputStream.nextLine();
		
		// Find difference between prjStartDate and schStartDate and add zeros to match prjActivity and schActivity length
		Date prjStart = prjHistCollection.get(0).getDate();
		
		String line = "";
		line = inputStream.nextLine();
		String[] tokens = line.split("\t");
		if (tokens.length < 21) {
			System.out.println("Problem opening file: " + fileName);
			System.exit(0);
		}
		
		Date schStart = new SimpleDateFormat("yyyy-MM").parse(tokens[1]);
		
		LocalDate prjStartDate = prjStart.toInstant().atZone(ZoneId.systemDefault()).toLocalDate();
		LocalDate schEndDate = schStart.toInstant().atZone(ZoneId.systemDefault()).toLocalDate();
		
		Period diff = Period.between(prjStartDate, schEndDate);
		
		for (int i=0; i <((diff.getYears()*12)+diff.getMonths()); i++) {
			schActivity.add(0);
		}
		
		totSchAct += Integer.parseInt(tokens[20]);
		schActivity.add(Integer.parseInt(tokens[20]));
		
		// process the actual rows one by one
		while (inputStream.hasNextLine()) {
			line = inputStream.nextLine();
			tokens = line.split("\t");
			
			if (tokens.length < 21) {
				System.out.println("Problem opening file: " + fileName);
				System.exit(0);
			}
			
			totSchAct += Integer.parseInt(tokens[20]);
			schActivity.add(Integer.parseInt(tokens[20]));
		}
		inputStream.close();
		
		return totSchAct;
	}
	
	public ArrayList<Integer> getTotalSchemaActivityList(){
		// Fill the end with zeros to match the prjActivity length
		int difSize = prjActivity.size()-schActivity.size();
		for (int i=0; i<difSize; i++)
			schActivity.add(0);

		return schActivity;
	}
	
	
	/**
	 * Loader to read produced cumulative data file  ================================================================================================
	 */
	public int getCumulativeData(String fileName, String delimeter, boolean hasHeaderLine, int numFields) throws Exception {
		objCollection = new ArrayList<>();
		header = new ArrayList<>();
		
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
					
			CumulativeModel element = new CumulativeModel(Integer.parseInt(tokens[0]), Integer.parseInt(tokens[1]), Integer.parseInt(tokens[2]),
					Double.parseDouble(tokens[3]), Double.parseDouble(tokens[4]), Double.parseDouble(tokens[5])); 
			objCollection.add(element);
			
		}		
		inputStream.close();
		
		return count;
	}
	
	
	public ArrayList<CumulativeModel> getObjCollection(){
		return objCollection;
	}
	
	public ArrayList<String> getHeader(){
		return header;
	}
	
	public String getTitle() {
		return titleLine;
	}
	
}