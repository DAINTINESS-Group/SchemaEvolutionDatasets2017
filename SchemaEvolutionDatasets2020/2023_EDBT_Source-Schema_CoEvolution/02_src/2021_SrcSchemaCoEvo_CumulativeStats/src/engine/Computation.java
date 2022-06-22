package engine;

public class Computation {

	public static void main(String[] args) {
		MainEngine engine = new MainEngine();
		
		String SEPARATOR = engine.SEPARATOR;
		String header = "Project" + SEPARATOR + "MonthsPastV0" + SEPARATOR + "AvgTimeLag" + SEPARATOR + "AvgSrcLag"
				+ SEPARATOR + "TimeLagsSchemaAlways?" + SEPARATOR + "SrcLagsSchemaAlways?"
				+ SEPARATOR + "TimeLagsSchemaOccurrences" + SEPARATOR + "SrcLagsSchemaOccurrences"
				+ SEPARATOR + "TimeLagsSchemaPct" + SEPARATOR + "SrcLagsSchemaPct"; 		
		System.out.println(header);
		
		boolean isReportingOutputStats = false; //once the files have been created, no need to re-create them
		engine.performLagComputation(isReportingOutputStats);
	}

}
