package engine;

import java.io.File;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.HashMap;

import dataload.HistoryLoader;
import datamodel.ProjectHistory;
import exporter.BarChartExporter;
import javafx.stage.Stage;

public class SchemaStatsMainEngine {

	private String filePath;
	private String fileName;
	private HistoryLoader historyLoader;
	private static ArrayList<ProjectHistory> objCollection;
	private static ArrayList<ProjectHistory> objZerosCollection;
	protected ArrayList<ProjectHistory> inputTupleCollection;
	private HashMap<String, Integer> attributePositions;
	private ArrayList<String> header;
	
	private Boolean _DEBUGMODE = false;
	private static String delimeter = "\t";
	private static boolean hasHeaderLine = true;
	private static int numFields = 4;
	private Stage stage;
	
	public SchemaStatsMainEngine(String filePath, String fileName, Stage stage) {
		this.filePath = filePath;
		this.fileName = fileName;
		this.stage = stage;
		attributePositions = new HashMap<String, Integer>();
		
		historyLoader = new HistoryLoader(1);
		
		this.inputTupleCollection = new ArrayList<ProjectHistory>();
	}
	
	private void processHeader() {	
		for (int i = 0; i< header.size(); i++) {
			String nextAttr = header.get(i);
			this.attributePositions.put(nextAttr, i);
			if(_DEBUGMODE) System.out.print(nextAttr + "\t");
		}
		if(_DEBUGMODE) System.out.println();
	}
	
	public int produceFigures() throws ParseException{
		
		// Load file
		loadHist();
		processHeader();
		
		// Create folder for figures if not exist
		setupFolders();
		
		// Export chart
		HashMap<Integer, ArrayList<ProjectHistory>> hashmapInputTupleCollection = new HashMap<Integer, ArrayList<ProjectHistory>>();
		hashmapInputTupleCollection.put(0, objZerosCollection);
		
		
		ArrayList<String> emYAttributes = new ArrayList<String>();  // add the attributes we want
		emYAttributes.add("NumAffectedFiles");
		emYAttributes.add("Contains .sql");
		
		// Check if folder exist, else create it
		BarChartExporter barChartExporter = new BarChartExporter(filePath+"/figures/"+fileName.replace(".tsv", "")+".png",
							fileName+":\nOccurrences of file changes\nSoftWare(src) VS Schema Evolution(sql) over Time(versionID)",
							(HashMap)hashmapInputTupleCollection, "Date", emYAttributes, attributePositions, stage);
		
		try {
			barChartExporter.start();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return 0;
	}
	
	
	private void loadHist() throws ParseException {
		String file = filePath + "/" + fileName;
		try {
			historyLoader.load(file, delimeter, hasHeaderLine, numFields);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		header = historyLoader.getHeader();
		
		objCollection = historyLoader.getObjCollection();
		// Already reversed from sum
		//Collections.reverse(objCollection);
		
		// Add zero months to ArrayList
		AddZerosEngine addZeroEngine = new AddZerosEngine(objCollection);
		objZerosCollection = addZeroEngine.addZeros();
	}
	
	public void setupFolders() {
		File directory = new File(filePath + "/figures");
		if (!directory.exists()){
			directory.mkdir();
	    }
	}
	
}
