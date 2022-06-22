package test;

import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;

import org.apache.commons.io.FileUtils;
import org.junit.Assert;
import org.junit.Test;

import dataload.HistoryLoader;
import datamodel.ProjectHistory;
import engine.AddZerosEngine;

public class AddZerosTest {

	private static String delimeter = "\t";
	private static boolean hasHeaderLine = true;
	private static int numFields = 4;
	private static ArrayList<ProjectHistory> objCollection;
	private static ArrayList<ProjectHistory> zeros;
	private ArrayList<String> header;
	private HistoryLoader historyLoader;
	private SimpleDateFormat format = new SimpleDateFormat("yyyy-MM");
	private static String file1, file2, file3;

	private static String filePath = "resources/test/file_Test";
	private String fileName = "test.tsv";

	/**
	 * Add zeros to summed file
	 * Compare expected file with created
	 * @throws ParseException
	 * @throws IOException
	 */
	@Test
	public void test() throws ParseException, IOException {
		
		file1 = filePath + "_months_sum/sum_" + fileName;
		file2 = filePath + "_months_sum/zero_" + fileName;
		file3 = filePath + "/expected_zero_" + fileName;
		// Load Data
		historyLoader = new HistoryLoader(1);
		loadHist();
		
		// Add Zeros
		AddZerosEngine addZerosEngine = new AddZerosEngine(objCollection);
		zeros = addZerosEngine.addZeros();
		
		PrintDataToTabDelimitedFile();
		
		File file = new File(file2);
	    File fileSum = new File(file3);
		
		Assert.assertEquals(FileUtils.readLines(file), FileUtils.readLines(fileSum));
		System.out.println("\n\nADD ZEROS TEST finished");
	}
	
	private void loadHist() {
		try {
			historyLoader.load(file1, delimeter, hasHeaderLine, numFields);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		header = historyLoader.getHeader();
		
		objCollection = historyLoader.getObjCollection();
	}
	
	private void PrintDataToTabDelimitedFile() {
		try {
			// Tab delimited file will be written to data with the name tab-file.csv
			FileWriter fos = new FileWriter(file2);
			PrintWriter dos = new PrintWriter(fos);
			dos.println(header.get(0)+"\t"+ header.get(1)+"\t"+header.get(2)+"\t"+header.get(3));
			
			// loop through all your data and print it to the file
			for (ProjectHistory prj : zeros) {
				dos.print(format.format(prj.getDate())+"\t");
				dos.print(prj.getAuthor()+"\t");
				dos.print(prj.getNumAffectedFiles()+"\t");
				dos.print(prj.getContainsSQL()+"\t");
				dos.println();
			}
			dos.close();
			fos.close();
		} catch (IOException e) {
			System.out.println("Error Printing Tab Delimited File");
		}
	}
	
}
