package engine;

import java.util.ArrayList;
import java.util.HashMap;

import exporter.LineChartExporter;
import dataload.CumulativeDataLoader;
import datamodel.CumulativeModel;
import javafx.stage.Stage;

public class ProduceCumulativeImageEngine {

	private String filePath;
	private String fileName;
	private Stage stage;
	
	private CumulativeDataLoader cumulativeDataLoader;
	private ArrayList<CumulativeModel> cumulativeModelList;
	private HashMap<String, Integer> attributePositions;
	
	private ArrayList<String> header;
	private Boolean _DEBUGMODE = false;
	
	
	public ProduceCumulativeImageEngine(String filePath, String fileName, Stage stage) {
		this.filePath = filePath;
		this.fileName = fileName;
		this.stage = stage;
	}
	
	
	public void produceFigure() throws Exception {
		// Load Cumulative Data
		cumulativeModelList = getCumulativeData();
		
		// Export chart
		HashMap<Integer, ArrayList<CumulativeModel>> hashmapInputTupleCollection = new HashMap<Integer, ArrayList<CumulativeModel>>();
		hashmapInputTupleCollection.put(0, cumulativeModelList);
		
		ArrayList<String> ltidYAttributes = new ArrayList<String>();  // add the attributes we want
		// ltidYAttributes.add("Change progress");
		ltidYAttributes.add("Project Activity");
		ltidYAttributes.add("Schema Activity");
		
		attributePositions = new HashMap<String, Integer>();
		processHeader();
		
		LineChartExporter lineChartExporter = new LineChartExporter(filePath+"/figures/"+fileName,
				//"Cumulative analysis of "+fileName, hashmapInputTupleCollection,
				fileName, hashmapInputTupleCollection,
				"Time progress", ltidYAttributes, attributePositions, stage);
		
		LineChartExporter lineChartExporter2 = new LineChartExporter(filePath+"/figures/"+fileName,
				"Cumulative analysis of "+fileName, hashmapInputTupleCollection, 
				"Time progress", ltidYAttributes, attributePositions, stage);
		
		try {
			// Create line chart with percentage of life time
			lineChartExporter.start(LineChartExporter.PERCENTAGE_TIME_CHART);
			
			// Create line chart with absolute time (in months)
			lineChartExporter2.start(LineChartExporter.ABSOLUTE_TIME_CHART);
			
//			// Create line chart with percentage of commits
//			lineChartExporter.start(LineChartExporter.PERCENTAGE_COMMITS_CHART);
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}
	
	private void processHeader() {	
		for (int i = 0; i< header.size(); i++) {
			String nextAttr = header.get(i);
			this.attributePositions.put(nextAttr, i);
			if(_DEBUGMODE) System.out.print(nextAttr + "\t");
		}
		if(_DEBUGMODE) System.out.println();
	}
	
	private ArrayList<CumulativeModel> getCumulativeData() throws Exception{
		cumulativeDataLoader = new CumulativeDataLoader();
		cumulativeDataLoader.getCumulativeData(filePath+"/"+fileName, "\t", true, 6);
		
		header = cumulativeDataLoader.getHeader();
		
		return cumulativeDataLoader.getObjCollection();
	}
	
}