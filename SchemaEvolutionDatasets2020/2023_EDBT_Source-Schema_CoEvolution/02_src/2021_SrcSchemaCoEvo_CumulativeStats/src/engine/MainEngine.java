package engine;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStreamWriter;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;
import java.util.Scanner;



public class MainEngine {

	private class LagMeasurement{
		int month;
		int schActivity;
		int prjActivity;
		int totalActivity;
		double cumulPtime ;
		double cumulSchActivity ;
		double cumulPrjActivity ;
		double timeLagOverSchema ; 
		double srcLagOverSchema;

		public String toString(){
			return month + SEPARATOR + schActivity + SEPARATOR + prjActivity + SEPARATOR 
					+ String.valueOf(cumulPtime) + SEPARATOR 
					+ String.valueOf(cumulSchActivity) + SEPARATOR 
					+ String.valueOf(cumulPrjActivity) + SEPARATOR
					+ String.valueOf(timeLagOverSchema) + SEPARATOR
					+ String.valueOf(srcLagOverSchema) + SEPARATOR
					;
		}
	}//end LagMeasurement

	
	//public final String INPUT_FOLDER = "./resources/incoming/TestInputFolder";
	public final String INPUT_FOLDER = "./resources/incoming/13_CumulativeProgress_Src-n-Schema";
	public final String OUTPUT_FOLDER = "./resources/output/13_CumulativeProgress_Src-n-Schema";
	public final String SEPARATOR = "\t";

	/**
	 * Does all the job of producing files with the time- and src- lag to schema, as well as stats
	 * 
	 * The method is a maestro that does the following:
	 * (*) computes timeLagOverSchema and srcLagOverSchema for each month
	 * (*) computes #occurrences for when schema does not lag time or src
	 * (*) if the flag is true, it creates the files with these new columns
	 * (*) computes average numbers for these stats and reports them to the console, one line per prj
	 * 
	 * @param isReportingOutputStats a Boolean flag on whether the new files with the extra columns are gonna be created.
	 * @return
	 */
	public int performLagComputation(boolean isReportingOutputStats) {	
		String[] inputFileArray;

		File inputFolderFile = new File(INPUT_FOLDER);
		inputFileArray = inputFolderFile.list();  

		if(inputFileArray != null) {
			for (String fileName : inputFileArray) {
				processSingleFile(fileName, isReportingOutputStats);
			}

		}


		return 0;
	}//end performLagComputation()

	/**
	 * Given a file in the input folder, it processes it
	 * 
	 * @param pFileName
	 */
	private void processSingleFile(String pFileName, boolean isReportingOutputStats) {
		String inputFileName = INPUT_FOLDER + "/" + pFileName; //+ File.separator
		String outputFileName = OUTPUT_FOLDER + "/" + pFileName; //+ File.separator
		//System.out.println(inputFileName);
		//System.out.println(outputFileName);

		Scanner inputStream = null;
		try {
			inputStream = new Scanner(new FileInputStream(inputFileName));
		} catch (FileNotFoundException e) {
			System.err.println("Problem opening file: " + inputFileName);
			System.exit(0);
		}

		// Read the first line - header
		inputStream.nextLine();

		List<LagMeasurement> measurementsList = new ArrayList<LagMeasurement>();

		processNextInputLine(inputFileName, inputStream, measurementsList);
		inputStream.close();

		if(isReportingOutputStats == true) {
			try {
				PrintWriter writer = new PrintWriter(new OutputStreamWriter(new FileOutputStream(outputFileName)));
				writer.println("Month" +SEPARATOR+	"SchActivity" +SEPARATOR+	"PrjActivity" +SEPARATOR+	
						"cumulPtime" +SEPARATOR+	"cumulSchActivity" +SEPARATOR+	"cumulPrjActivity)"
						+ SEPARATOR +	"timeLagOverSchema" +SEPARATOR+	"srcLagOverSchema");
				for(LagMeasurement lagM : measurementsList) {
					writer.println(lagM.toString());
				}
				writer.close();
			}catch (IOException e) {
				System.err.println("Not possible to work with output file: " + outputFileName);
				e.printStackTrace();
			}
		}
		//produceStats
		String report = reportStats(measurementsList, pFileName);
		System.out.println(report);
	}//end ProcessSingleFile

	/**
	 * @param measurementsList
	 */
	private String reportStats(List<LagMeasurement> measurementsList, String fileName) {
		int numMonths = measurementsList.size() - 1;
		double sumTimeLag = 0.0; double sumSrcLag = 0.0;
		Boolean timeLagsSchemaflag = true;
		Boolean srcLagsSchemaflag = true;

		
		int countTimesTimeLagsSchema = 0;
		int countTimesSrcLagsSchema = 0;
		
		//iterate over all months, except the last where all is 100%; the second index of sublist() is __excluded__
		for(LagMeasurement lagM : measurementsList.subList(0, numMonths)) {
			sumTimeLag += lagM.timeLagOverSchema;
			sumSrcLag += lagM.srcLagOverSchema;
			
			//if, for this month, the schema is lagging time, then timeLagsSchemaflag=false
			//else, increase the count(*) of months where schema is not lagging time
			if(lagM.timeLagOverSchema < 0.0000000)
				timeLagsSchemaflag = Boolean.logicalAnd(timeLagsSchemaflag, false);
			else
				countTimesTimeLagsSchema++;
			
			//if, for this month, the schema is lagging src, then srcLagsSchemaflag=false
			//else, increase the count(*) of months where schema is not lagging src
			if(lagM.srcLagOverSchema < 0.0000000)
				srcLagsSchemaflag = Boolean.logicalAnd(srcLagsSchemaflag, false);
			else
				countTimesSrcLagsSchema++;

		}
		
		//compute the average timeLag and srcLag
		double avgTimeLag = Double.NaN;
		double avgSrcLag = Double.NaN;
		double pctLifeTimeLagsSchema = Double.NaN;
		double pctLifeSrcLagsSchema = Double.NaN;

		if(numMonths > 0) {
			avgTimeLag = sumTimeLag / numMonths;
			avgSrcLag = sumSrcLag / numMonths;
			pctLifeTimeLagsSchema = countTimesTimeLagsSchema / (1.0* numMonths);
			pctLifeSrcLagsSchema = countTimesSrcLagsSchema / (1.0 * numMonths);

	
		}
		
		
		return fileName + SEPARATOR + numMonths + SEPARATOR + String.valueOf(avgTimeLag) + SEPARATOR + String.valueOf(avgSrcLag)
		+ SEPARATOR + timeLagsSchemaflag + SEPARATOR + srcLagsSchemaflag
		+ SEPARATOR + countTimesTimeLagsSchema + SEPARATOR + countTimesSrcLagsSchema
		+ SEPARATOR + pctLifeTimeLagsSchema + SEPARATOR + pctLifeSrcLagsSchema;

	}


	/**
	 * Processes every next line from the input file, makes an object and adds it to the collection
	 * 
	 * @param inputFileName
	 * @param inputStream
	 * @param measurementsList
	 * @throws NumberFormatException
	 */
	private void processNextInputLine(String inputFileName, Scanner inputStream, List<LagMeasurement> measurementsList)
			throws NumberFormatException {
		String line;
		String[] tokens;
		while (inputStream.hasNextLine()) {
			line = inputStream.nextLine();
			tokens = line.split(SEPARATOR);			
			if (tokens.length != 6) {
				System.err.println("Not proper structure of 6 tokens in input file: " + inputFileName);
				System.exit(0);
			}

			LagMeasurement lagMeasurement = new LagMeasurement();

			//process the input line
			//Month	SchActivity	PrjActivity	cumulPtime	cumulSchActivity	cumulPrjActivity
			lagMeasurement.month = Integer.parseInt(tokens[0]);
			lagMeasurement.schActivity	= Integer.parseInt(tokens[1]);
			lagMeasurement.prjActivity = Integer.parseInt(tokens[2]);
			lagMeasurement.cumulPtime = Double.parseDouble(tokens[3]);
			lagMeasurement.cumulSchActivity = Double.parseDouble(tokens[4]);
			lagMeasurement.cumulPrjActivity = Double.parseDouble(tokens[5]);
			lagMeasurement.timeLagOverSchema = lagMeasurement.cumulSchActivity - lagMeasurement.cumulPtime; 
			lagMeasurement.srcLagOverSchema = lagMeasurement.cumulSchActivity - lagMeasurement.cumulPrjActivity;
			lagMeasurement.totalActivity = lagMeasurement.schActivity + lagMeasurement.prjActivity;
			measurementsList.add(lagMeasurement);
			//System.out.println(lagMeasurement.toString());			
		}
	}//end processNextInputLine

}//end class
