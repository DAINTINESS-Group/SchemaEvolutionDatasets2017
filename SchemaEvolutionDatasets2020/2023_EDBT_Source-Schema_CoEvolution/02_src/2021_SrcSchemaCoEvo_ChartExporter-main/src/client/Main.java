package client;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;

import java.text.ParseException;
import java.util.ArrayList;

import engine.ComputeCumulativeEngine;
import engine.ProduceCumulativeImageEngine;
import engine.ProduceHTMLEngine;
import engine.SchemaStatsMainEngine;
import engine.SumEngine;

import javafx.application.Application;
import javafx.application.Platform;
import javafx.stage.Stage;

public class Main extends Application {

	private boolean exportMonthlyStatsAndFiguresMode = false;
	private boolean cumulativeAnalysisMode = true;
	
	// Chart exporter variables
	private static String INPUT_COMMIT_SUMMARIES_PER_TAXON = "resources" + File.separator + "Input" + File.separator + "COMMIT_SUMMARIES_DETAILED";
	private String[] fileNamesCom, folderNamesCom, fileNamesSum;
	private ArrayList<String> folderNamesSum = new ArrayList<>();
	
	// Cumulative analysis variables
	private static String INPUT_FOLDER_FROM_HERACLITUS ="resources" + File.separator + "Input" +File.separator  + "SCHEMA_EVO_2019";
	private static String CUMULATIVE_OUTPUT_FOLDER ="resources" + File.separator + "Output"+ File.separator + "SCHEMA_EVO_2019_CUMULATIVE_FOLDER";
	private String[] fileCumulPrjName, folderCumulImg;
	
	
	public static void main(String[] args){

		launch(args);
		
        System.exit(0);
	}
	
	public void start(Stage primaryStage) throws Exception {
		
		if (exportMonthlyStatsAndFiguresMode) {	// Export evolution Charts tsv files and images ===========================================
			System.out.println("Start exporting evolution charts");
			extractMonthlyStatsAndCharts(primaryStage);
			System.out.println("Finish exporting evolution charts");
		} 
		if(cumulativeAnalysisMode){	// Export Cumulative Analysis tsv file and images =================================================
			System.out.println("Start comulative analysis");
			performAnalysisForCumulativeActivity(primaryStage);
			System.out.println("Finished comulative analysis");
		}

		System.out.println("Finished all");
		Platform.exit();
	}//end main

	/**
	 * @param primaryStage
	 * @throws Exception
	 */
	private void performAnalysisForCumulativeActivity(Stage primaryStage) throws Exception {
		// Create folder with the cumulative result files =========================================================
		File f_cumul = new File(INPUT_FOLDER_FROM_HERACLITUS);
		fileCumulPrjName = f_cumul.list();  // get folder name for each project
		
		// For each project compute and create the cumulative .tsv file
		if(fileCumulPrjName != null) {
			for (String folderPrjName : fileCumulPrjName) {
				
				File project = new File(INPUT_FOLDER_FROM_HERACLITUS + File.separator + folderPrjName);

				ComputeCumulativeEngine computeCumulative = new ComputeCumulativeEngine(project, false);
				String prjPath = "resources"+ File.separator + "Output" + File.separator + "MONTHLY_SUMMARIES"+ File.separator + 
						"sum_"+project.getName()+"_CommitSummary.tsv";
				String fileName = INPUT_FOLDER_FROM_HERACLITUS + "\\"+project.getName()+"\\resultsOfPatternTests\\"+project.getName()+"_MonthlySchemaStats.tsv";
				File directory = new File(CUMULATIVE_OUTPUT_FOLDER);
				String expFile = CUMULATIVE_OUTPUT_FOLDER+File.separator + "cumulative_" + project.getName()+".tsv";
				
				computeCumulative.createCumulativeFile(project, directory, prjPath, fileName, expFile);
				
			}
		}
		
		// Create images for each cumulative .tsv file ============================================================
		File img_cumul = new File(CUMULATIVE_OUTPUT_FOLDER);
		folderCumulImg = img_cumul.list();  // get folder name for each project
		
		if(folderCumulImg != null) {
			for (String fileImgName : folderCumulImg) {
				
				if(fileImgName.contains(".tsv")) {
					ProduceCumulativeImageEngine produceCumulativeImage = new ProduceCumulativeImageEngine(CUMULATIVE_OUTPUT_FOLDER, fileImgName, primaryStage);
					produceCumulativeImage.produceFigure();
				}
				
			}
			System.out.println("-----------Finished with LineChartExporting-------------");

		}
		
		// Create HTML with figures ===============================================================================
		if(folderCumulImg != null) {
			for (String fileImgName : folderCumulImg) {
				String figuresFolder = CUMULATIVE_OUTPUT_FOLDER + File.separator + "figures";
				
				ProduceHTMLEngine produceHTMLEngine = new ProduceHTMLEngine(figuresFolder, fileImgName);
				produceHTMLEngine.produceCumulativeHTML();
			}
		}
	}//end perform analysis for cumulative activity ()

	/**
	 * @param primaryStage
	 * @throws ParseException
	 */
	private void extractMonthlyStatsAndCharts(Stage primaryStage) throws ParseException {
		File f_com = new File(INPUT_COMMIT_SUMMARIES_PER_TAXON);
		
		// Sum months and Create new .tsv files ===================================================================
		folderNamesCom = f_com.list();  // get folder name for each taxon
		
		if(folderNamesCom != null) {
			for (String folderName : folderNamesCom) {
				File taxon = new File(INPUT_COMMIT_SUMMARIES_PER_TAXON + File.separator + folderName);
				fileNamesCom = taxon.list();  // file name for files with all commits in each taxon
				
				for (String fileName : fileNamesCom) {
					new SumEngine(INPUT_COMMIT_SUMMARIES_PER_TAXON + File.separator + folderName, fileName);
					}
			}
		}
		
		// Create figures for each project ========================================================================
		
		// Find folders/taxa with summed .tsv files
		String[] fileNames = f_com.list();  // file name for files with summed commits
		if(fileNames != null) {
			for (String folderName : fileNames) {
				if (folderName.contains("_months_sum"))
					folderNamesSum.add(folderName);
			}
		}
		
		// Populates Monthly summaries and Create figures within each taxon
		if(folderNamesSum != null) {
			for (String folderName : folderNamesSum) {
				File summedTaxon = new File(INPUT_COMMIT_SUMMARIES_PER_TAXON + File.separator + folderName);
				fileNamesSum = summedTaxon.list();  // file name for files with all summed commits in each taxon
				
				for (String fileName : fileNamesSum) {
					String filePath = INPUT_COMMIT_SUMMARIES_PER_TAXON + File.separator + folderName;
					System.out.println(filePath + "\t\t" + fileName);
					
					try {
						String from = INPUT_COMMIT_SUMMARIES_PER_TAXON + File.separator + folderName + File.separator +  fileName;
						String to = "resources" + File.separator + "Output" + File.separator + "MONTHLY_SUMMARIES"+ File.separator + fileName;
System.out.println("COPY " + from + " TO " + to);						
						Files.copy(new File(from.trim()).toPath(), 
								new File(to.trim()).toPath(), java.nio.file.StandardCopyOption.REPLACE_EXISTING);
					} catch (IOException e) {
						System.err.println("Cannot copy");
						//e.printStackTrace();
					}
					
					
					SchemaStatsMainEngine engine = new SchemaStatsMainEngine(filePath, fileName, primaryStage);
					engine.produceFigures();
				}
			}
		}
		
		// Create HTML for each taxon =============================================================================
		if(folderNamesSum != null) {
			for (String folderName : folderNamesSum) {
				String figuresFolder = INPUT_COMMIT_SUMMARIES_PER_TAXON + File.separator + folderName + File.separator + "figures";
				
				ProduceHTMLEngine produceHTMLEngine = new ProduceHTMLEngine(figuresFolder, folderName);
				produceHTMLEngine.produceHTML();
			}
		}
	}//end extract monthly stats and charts ()
	
}//end class