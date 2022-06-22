package test;

import java.io.File;

import org.apache.commons.io.FileUtils;
import org.junit.Assert;
import org.junit.Test;

import engine.ComputeCumulativeEngine;

public class ComputeCumulativeTest {
	private String fileFolder = "resources\\test\\file_Test";
	private String fileCommitHistory = "testCumulative"; // .tsv
	private String fileResults = "testCumulativeResult.tsv";
	private String fileExpectedResults = "testCumulativeExpectedResult.tsv";
	
	
	@Test
	public void test() throws Exception {
		File project = new File(fileCommitHistory); 
		String prjPath = "resources\\test\\file_Test\\CumulTest"+File.separator+project.getName()+"CommitHistory.tsv";
		String fileName = "resources\\test\\file_Test\\CumulTest"+File.separator+project.getName()+"SchStats.tsv";
		File directory = new File("resources\\test\\file_Test\\CumulTest");
		String expFile = "resources\\test\\file_Test\\CumulTest"+File.separator+project.getName()+"Result.tsv";

		
		ComputeCumulativeEngine computeCumulativeEngine = new ComputeCumulativeEngine(project, true);
		computeCumulativeEngine.createCumulativeFile(project, directory, prjPath, fileName, expFile);
		
		File fileRes = new File(fileFolder + "\\CumulTest"+File.separator+fileResults);
	    File fileExpRes = new File(fileFolder + "\\CumulTest"+File.separator+fileExpectedResults);
		
	    Assert.assertEquals(FileUtils.readLines(fileRes), FileUtils.readLines(fileExpRes));
	    System.out.println("\n\nCumulative TEST finished");
	    
	}
	
}

//'resources\test\CumulTest\testCumulativeResult.tsv'