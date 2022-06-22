package engine;

import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;

import dataload.CumulativeDataLoader;
import datamodel.CumulativeModel;

public class ComputeCumulativeEngine {

	private File project;
	
	private int totDuration, totPrjAct, totSchAct;
	private ArrayList<CumulativeModel> cumulativeModelList;
	private ArrayList<Integer> prjActivity, schActivity;
	private boolean testMode;
	
	public ComputeCumulativeEngine(File project, boolean testMode) {
		this.project = project;
		this.testMode = testMode;
	}
	
	public void createCumulativeFile(File project, File directory, String prjPath, String fileName, String expFile) throws Exception {
		CumulativeDataLoader cumulativeDataLoader = new CumulativeDataLoader();
		
		/*
		 * // If test mode - Not the same folders 
		 * // String prjPath = "", fileName = "",
		 * expFile = ""; 
		 * // File directory; 
		 * if (!testMode) { 
		 * // prjPath = "SUM_MONTH"+File.separator+"sum_"+project.getName()+"_CommitSummary.tsv"; 
		 * //fileName = "SCHEMA_EVO_2019\\"+project.getName()+"\\resultsOfPatternTests\\"+project.getName()+"_MonthlySchemaStats.tsv"; 
		 * // directory = new File(project.getParent() + "_CUMULATIVE_FOLDER"); 
		 * // expFile = project.getParent()+"_CUMULATIVE_FOLDER"+File.separator + "cumulative_" + project.getName()+".tsv"; 
		 * } else { // prjPath =
		 * "file_Test\\CumulTest"+File.separator+project.getName()+"CommitHistory.tsv";
		 * // fileName =
		 * "file_Test\\CumulTest"+File.separator+project.getName()+"SchStats.tsv"; //
		 * directory = new File("file_Test\\CumulTest"); // expFile =
		 * "file_Test\\CumulTest"+File.separator+project.getName()+"Result.tsv"; }
		 */
		
		// Load data with project's history
		cumulativeDataLoader.loadProjectHistory(prjPath);
		
		
		// Get total duration in months
		totDuration = cumulativeDataLoader.getTotalDuration();

		
		// Get total project's activity AND project activity list
		totPrjAct = cumulativeDataLoader.getTotalProjectActivity();
		prjActivity = cumulativeDataLoader.getTotalProjectActivityList();
		
		
		// Get total schema's activity AND schema activity list
		totSchAct = cumulativeDataLoader.getTotalSchemaActivity(fileName);
		schActivity = cumulativeDataLoader.getTotalSchemaActivityList();
		
		// Compute Cumulative Activity =====================================================
		cumulativeModelList = computeCumul();
		
		// Write cumulative activity to a file - if folder don't exist create it ===========
		if (!directory.exists()){
			directory.mkdir();
	    }
		
		PrintDataToTabDelimitedFile(expFile);
	}
	
	
	public ArrayList<CumulativeModel> computeCumul() {
		ArrayList<CumulativeModel> cumulativeList = new ArrayList<>();
		
		// Add first values
		CumulativeModel prevCumulativeModel = new CumulativeModel();
		prevCumulativeModel.setMonth(0);
		prevCumulativeModel.setPrjActivity(prjActivity.get(0));
		prevCumulativeModel.setSchActivity(schActivity.get(0));
		prevCumulativeModel.setCumulPtime(0);
		prevCumulativeModel.setCumulPrjActivity((double)prjActivity.get(0)/totPrjAct);
		prevCumulativeModel.setCumulSchActivity((double)schActivity.get(0)/totSchAct);
		
		cumulativeList.add(prevCumulativeModel);
		
		// Compute for the next months
		for (int i=1; i<totDuration; i++) {
			CumulativeModel cumulativeModel = new CumulativeModel();
			
			cumulativeModel.setMonth(i);
			cumulativeModel.setPrjActivity(prjActivity.get(i));
			cumulativeModel.setSchActivity(schActivity.get(i));
			
			// cumulativeModel.setCumulPtime(prevCumulativeModel.getCumulPtime()+((double)i/totDuration));
			cumulativeModel.setCumulPtime((double)i/(totDuration-1));	// totDuration-1 can't be 0
			cumulativeModel.setCumulPrjActivity(prevCumulativeModel.getCumulPrjActivity()+((double)prjActivity.get(i)/totPrjAct));
			cumulativeModel.setCumulSchActivity(prevCumulativeModel.getCumulSchActivity()+((double)schActivity.get(i)/totSchAct));
			
			cumulativeList.add(cumulativeModel);
			prevCumulativeModel = cumulativeModel;
			
		}
		
		return cumulativeList;
	}
	
	
	private void PrintDataToTabDelimitedFile(String file ) {
		try {
			
			FileWriter fos = new FileWriter(file);
			PrintWriter dos = new PrintWriter(fos);
			// Write header
			dos.println("Month\tSchActivity\tPrjActivity\tcumulPtime\tcumulSchActivity\tcumulPrjActivity");
			
			// loop through all your data and print it to the file
			for (CumulativeModel cumulModel : cumulativeModelList) {
				dos.print(cumulModel.getAllAsTsv());
				dos.println();
			}
			dos.close();
			fos.close();
		} catch (IOException e) {
			System.out.println("Error Printing Tab Delimited File");
		}
	}
	
}