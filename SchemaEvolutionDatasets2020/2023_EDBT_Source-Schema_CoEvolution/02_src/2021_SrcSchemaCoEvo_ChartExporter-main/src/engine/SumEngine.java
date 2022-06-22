package engine;

import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import java.util.TreeMap;

import dataload.HistoryLoader;
import datamodel.ProjectHistory;

public class SumEngine {

	private static String delimeter = "\t";
	private static boolean hasHeaderLine = true;
	private static int numFields = 4;
	
	private String filePath;
	private String fileName;
	
	private static ArrayList<ProjectHistory> objCollection;
	private static ArrayList<ProjectHistory> sumObjCollection;
	private static HashMap<Date, ProjectHistory> sumHashMap;
	
	private ArrayList<String> header;
	private HistoryLoader historyLoader;
	
	private SimpleDateFormat format = new SimpleDateFormat("yyyy-MM");
	
	public SumEngine(String filePath, String fileName) throws ParseException {
		this.filePath = filePath;
		this.fileName = fileName;
		
		// Load Data
		historyLoader = new HistoryLoader(0);
		loadHist();
		
		// Process data
		
		// If data are sorted
		// sumObjCollection = new ArrayList<>();
		// sumData();
		
		sumHashMap = new HashMap<Date, ProjectHistory>();
		sumHashDate();
		
		// Write data - if folder don't exist create it
		File directory = new File(filePath + "_months_sum");
		if (!directory.exists()){
			directory.mkdir();
	    }
		PrintDataToTabDelimitedFile();
	}
	
	
	private void sumHashDate() throws ParseException {
		ProjectHistory prj;
		
		int size = objCollection.size();
		for (int i=0; i<size; i++) {
			prj = objCollection.get(i);
			Date date = new SimpleDateFormat("yyyy-MM").parse(format.format(prj.getDate()));
			if (sumHashMap.containsKey(date)) {
				ProjectHistory tmp = sumHashMap.get(date);
				
				if (!tmp.getAuthor().contains(prj.getAuthor())){
					tmp.setAuthor(tmp.getAuthor()+","+prj.getAuthor());
				}
				// NumAffectedFiles contains #src + #sql affected files
				// Add number of affected files and subtract number of .sql files
				tmp.setNumAffectedFiles(tmp.getNumAffectedFiles()+prj.getNumAffectedFiles() - prj.getContainsSQL());
				tmp.setContainsSQL(tmp.getContainsSQL()+prj.getContainsSQL());
				
				sumHashMap.put(date, tmp);
				
			} else {
				// NumAffectedFiles contains #src + #sql affected files => subtract #.sql files
				prj.setNumAffectedFiles(prj.getNumAffectedFiles() - prj.getContainsSQL());
				sumHashMap.put(date, prj);
			}
		}
		
		// Sort it
		Map<Date, ProjectHistory> sortedMap = new TreeMap<Date, ProjectHistory>(sumHashMap);
		
		// Convert HashMap to ArrayList
		// Getting Collection of values from HashMap 
        //Collection<ProjectHistory> values = sumHashMap.values();
		Collection<ProjectHistory> values = sortedMap.values();
		
        // Creating an ArrayList of values 
        sumObjCollection = new ArrayList<>(values);
        
        System.out.println("Commits summed successfully");
	}
	
	
	private void sumData() throws ParseException {
		ProjectHistory tmp = null;
//		for (ProjectHistory prj : objCollection) {
//			System.out.println(format.format(prj.getDate()));
//		}
		
		int size = objCollection.size();
		for (int i=0; i<size; i++) {
			ProjectHistory prj = objCollection.get(i);
			
			if (tmp == null) {
				Date date = new SimpleDateFormat("yyyy-MM").parse(format.format(prj.getDate()));
				tmp = new ProjectHistory(date, prj.getAuthor(), prj.getNumAffectedFiles(), prj.getContainsSQL());

				// if last
				if (i == (size-1)) {
					sumObjCollection.add(tmp);
				}
				
			} else {
				if (new SimpleDateFormat("yyyy-MM").parse(format.format(prj.getDate())).equals(tmp.getDate())) {
					if (!tmp.getAuthor().contains(prj.getAuthor())){
						tmp.setAuthor(tmp.getAuthor()+","+prj.getAuthor());
					}
					tmp.setNumAffectedFiles(tmp.getNumAffectedFiles()+prj.getNumAffectedFiles());
					tmp.setContainsSQL(tmp.getContainsSQL()+prj.getContainsSQL());
					
					// if last
					if (i == (size-1)) {
						sumObjCollection.add(tmp);
					}
					
				} else {
					sumObjCollection.add(tmp);
					
					Date date = new SimpleDateFormat("yyyy-MM").parse(format.format(prj.getDate()));
					tmp = new ProjectHistory(date, prj.getAuthor(), prj.getNumAffectedFiles(), prj.getContainsSQL());
					
					// if last
					if (i == (size-1)) {
						sumObjCollection.add(tmp);
					}
				}
			}
		}
	}
	
	
	private void PrintDataToTabDelimitedFile() {
		String file = filePath + "_months_sum" + File.separator + "sum_" + fileName;
		try {
			// Tab delimited file will be written to data with the name tab-file.csv
			FileWriter fos = new FileWriter(file);
			PrintWriter dos = new PrintWriter(fos);
			dos.println(header.get(0)+"\t"+ header.get(1)+"\t"+header.get(2)+"\t"+header.get(3));
			
			// loop through all your data and print it to the file
			for (ProjectHistory prj : sumObjCollection) {
				dos.print(format.format(prj.getDate())+"\t");
				dos.print(prj.getAuthor()+"\t");
				dos.print(prj.getNumAffectedFiles()+"\t");
				dos.print(prj.getContainsSQL());
				dos.println();
			}
			dos.close();
			fos.close();
		} catch (IOException e) {
			System.out.println("Error Printing Tab Delimited File");
		}
	}
	
	
	private void loadHist() {
		String file = filePath + File.separator + fileName;
		try {
			historyLoader.load(file, delimeter, hasHeaderLine, numFields);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		header = historyLoader.getHeader();
		
		objCollection = historyLoader.getObjCollection();
		
		// treeMap will sort it
		//Collections.reverse(objCollection);
	}

}
