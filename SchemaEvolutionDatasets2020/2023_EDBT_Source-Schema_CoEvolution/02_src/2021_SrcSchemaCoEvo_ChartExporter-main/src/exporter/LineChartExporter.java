package exporter;

import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Set;

import javax.imageio.ImageIO;

import datamodel.CumulativeModel;
import javafx.scene.chart.LineChart;
import javafx.embed.swing.SwingFXUtils;
import javafx.geometry.Side;
import javafx.scene.Node;
import javafx.scene.Scene;
import javafx.scene.SnapshotParameters;
import javafx.scene.chart.NumberAxis;
import javafx.scene.chart.XYChart;
import javafx.scene.image.WritableImage;
import javafx.scene.text.Font;
import javafx.stage.Stage;

public class LineChartExporter {

	public final static int PERCENTAGE_TIME_CHART = 0;
	public final static int ABSOLUTE_TIME_CHART = 1;
	public final static int PERCENTAGE_COMMITS_CHART = 2;
	
	protected String xAttribute;
	protected String yAttribute;
	protected ArrayList<String> yAttributes;
	protected Integer xAttributePos;
	protected Integer yAttributePos;
	protected ArrayList<Integer> yAttributePoss;
	
	protected String outputPath;
	protected String chartTitle;
	protected HashMap<Integer, ArrayList<CumulativeModel>> inputTupleCollection;
	protected HashMap<String, Integer> attributePositions;
	protected Stage stage;

	protected ArrayList<XYChart.Series<Number,Number>> allSeriesLine;
	
	protected LineChart<Number,Number> lineChart;
	
	public LineChartExporter(String pOutputPath, String pTitle, HashMap<Integer, ArrayList<CumulativeModel>> inputTupleCollection, 
			String pXAttribute, ArrayList<String> pYAttributes, HashMap<String, Integer> pAttributePositions, Stage primaryStage) {
		
		this.outputPath = pOutputPath;
//		if (!outputPath.endsWith(".png"))
//			outputPath = outputPath + ".png";

		if (pTitle != null)
			this.chartTitle = pTitle.replace("cumulative_", "").replace(".tsv", "");
		else
			this.chartTitle = "";

		this.inputTupleCollection = inputTupleCollection;
		this.attributePositions= pAttributePositions;
		this.xAttribute = pXAttribute;
		this.yAttribute = pYAttributes.get(0);
		this.yAttributes = pYAttributes;
		//TODO CHECKS! IF any of the above is null, setup a flag as problem

		this.xAttributePos = this.attributePositions.get(this.xAttribute);
		this.yAttributePos = this.attributePositions.get(this.yAttribute);
		this.yAttributePoss = new ArrayList<Integer>();
		for (String yAttr : this.yAttributes) {  // possibly have i to have the same position
			this.yAttributePoss.add(this.attributePositions.get(yAttr));
		}

		this.stage = primaryStage;
	}
	
	public void start(int chartType) throws Exception {
		
		createTimeSeries(chartType);
		if (allSeriesLine.size() == 0)
			return;
		
		//EITHER the above, or the below
		NumberAxis xAxis = null;
		final NumberAxis yAxis = new NumberAxis(0d,1d,0.01);
		
		switch (chartType) {
		case (PERCENTAGE_TIME_CHART):
			xAxis = new NumberAxis(0d,100d,20d);
			outputPath = outputPath +"_percentage_time.png";
			chartTitle = chartTitle + " over % time";
			xAxis.setLabel(xAttribute + " (% months in project life)");
			break;
		case (ABSOLUTE_TIME_CHART):
			xAxis = new NumberAxis();
			xAxis.setAutoRanging(true);
			outputPath = outputPath +"_absolute_time.png";
			chartTitle = chartTitle + " over real time (in months)";
			xAxis.setLabel(xAttribute + " (months in project life)");
			break;
//		case (PERCENTAGE_COMMITS_CHART):
//			// TODO
//			break;
	}
		
		
		String yAxisLabel = yAttributes.get(0);
		for (int i=1; i<yAttributes.size();i++) {
			yAxisLabel += " & " + yAttributes.get(i);
		}
		yAxis.setLabel(yAxisLabel);
		// xAxis.setMinorTickVisible(true);
		yAxis.setMinorTickVisible(true);

		this.lineChart = new LineChart<Number,Number>(xAxis,yAxis);

		
		// Project/Schema Activity Line
		for(XYChart.Series<Number,Number> nextSeries: allSeriesLine)
			this.lineChart.getData().add(nextSeries);

		lineChart.setLegendSide(Side.TOP);
		lineChart.setLegendVisible(true);
		
		this.lineChart.setTitle(chartTitle);
		this.lineChart.setHorizontalGridLinesVisible(true);
		this.lineChart.setVerticalGridLinesVisible(false);
		
		// ****************************************************************************************************
		final int FONT_SIZE = 40; //16
		//xAxis.tickLabelFontProperty().set(Font.font(FONT_SIZE));
		//yAxis.tickLabelFontProperty().set(Font.font(FONT_SIZE));
		this.lineChart.setStyle("-fx-font-size: " + FONT_SIZE + "px;");
		
		//necessary, or axis tick values do not show in dump
		xAxis.setAnimated(false);
		yAxis.setAnimated(false);

		Scene scene  = new Scene(this.lineChart, 1200, 1200);
		stage.setScene(scene);

		// Switch the flag to true if you want a report of the children of the lineChart and their styles
		Boolean reportChildrenFlag = false;
		if (reportChildrenFlag)
			reportChildrenOfChart();
		
		// TODO: find how to add resources to jar and load css files from there
		this.lineChart.getStylesheets().add(getClass().getResource("stylesheets/lineChartStyle.css").toExternalForm());
		
		//Export to png
		saveAsPng(scene, outputPath);
				
		//INVERT COMMENT STATUS THIS OUT ONCE DONE!
		// stage.show();
		stage.close();
		
	}//end lineCreation
	
	
	// Create Cumulative time series chart
	public void createTimeSeries(int chartType) {
		allSeriesLine = new ArrayList<XYChart.Series<Number,Number>>();
		
		// Create prj line
		XYChart.Series<Number,Number> newSeries = new XYChart.Series<Number,Number>();
		newSeries.setName(yAttributes.get(0));
		for (CumulativeModel tuple: inputTupleCollection.get(0)) {
			Double xValue = (double)CumulativeModel._ERROR_CODE;
			switch(chartType) {
				case PERCENTAGE_TIME_CHART:
					xValue = tuple.getCumulPtime()*100d;
					break;
				case ABSOLUTE_TIME_CHART:
					xValue = (double)tuple.getMonth();
					break;
//					case PERCENTAGE_COMMITS_CHART:
//						// TODO add commits to CumulativeModel
//						break;
			}
			Double yValue = tuple.getCumulPrjActivity();
			if((xValue != CumulativeModel._ERROR_CODE) && (yValue != CumulativeModel._ERROR_CODE)) {
				newSeries.getData().add(new XYChart.Data<Number,Number>(xValue, yValue));
			}
			// System.out.println("x:" + xValue + "\ty:" + yValue);
		}
		allSeriesLine.add(newSeries);
		
		// Create sch line
		XYChart.Series<Number,Number> newSeries2 = new XYChart.Series<Number,Number>();
		newSeries2.setName(yAttributes.get(1));
		for (CumulativeModel tuple: inputTupleCollection.get(0)) {
				Double xValue = (double)CumulativeModel._ERROR_CODE;
				switch(chartType) {
					case PERCENTAGE_TIME_CHART:
						xValue = tuple.getCumulPtime()*100d;
						break;
					case ABSOLUTE_TIME_CHART:
						xValue = (double)tuple.getMonth();
						break;
//						case PERCENTAGE_COMMITS_CHART:
//							// TODO add commits to CumulativeModel
//							break;
				}
				Double yValue = tuple.getCumulSchActivity();
				if((xValue != CumulativeModel._ERROR_CODE) && (yValue != CumulativeModel._ERROR_CODE)) {
					newSeries2.getData().add(new XYChart.Data<Number,Number>(xValue, yValue));
				}
				//System.out.println("x:" + xValue + "\ty:" + yValue);
		}
		allSeriesLine.add(newSeries2);
	}
	
	//===============================================================================================================================================
	
	/**
	 * Saves the scene to an Image of type png.
	 * 
	 * @param scene  a Scene to be exported
	 * @param path  a String with the path of the file to be exported
	 */
	protected void saveAsPng(Scene scene, String path) {
		WritableImage image = scene.snapshot(null);
		File file = new File(path);
		try {
			ImageIO.write(SwingFXUtils.fromFXImage(image, null), "png", file);
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	
	/**
	 * Equivalent and precursor to saveAsPng. Attn: it saves the linechart and NOT the scene.
	 */
	protected void saveChart(){
		WritableImage image = this.lineChart.snapshot(new SnapshotParameters(), null);
		File file = new File(outputPath);
		try {
			ImageIO.write(SwingFXUtils.fromFXImage(image, null), "png", file);
		} catch (IOException e){}
	}//end saveChart
	
	
	public ArrayList<Integer> getNumOfDataPerSeries() {
		ArrayList<Integer> numOfDataPerSeries = new ArrayList<Integer>();
		for(XYChart.Series<Number,Number> series: allSeriesLine)
			numOfDataPerSeries.add(series.getData().size());
		return numOfDataPerSeries;
	}
	
	
	/**
	 * SUPER USEFUL, DO NOT REMOVE: This method reports all the children nodes of the line chart
	 */
	protected void reportChildrenOfChart() {
		System.out.println("\n\nStarting " + this.chartTitle);
		Set<Node> CHARTnodes = this.lineChart.lookupAll("*");
		for (Node n : CHARTnodes) {
			System.out.println(n.getTypeSelector() +"\t" + n.toString() + "\t\t" + n.getStyle());
		}
	}
	
	
	/**
	 * For testing, write image data to a file
	 */
	public void PrintDataToTabDelimitedFile(String file) throws Exception {
		// Check if prj and sch have the same size
		int length1 = allSeriesLine.size();
		
		// There should be 2 series
		if (length1 != 2)
			return;
		
		XYChart.Series<Number,Number> prjSeries = allSeriesLine.get(0);
		XYChart.Series<Number,Number> schSeries = allSeriesLine.get(1);
		
		int prjSize = prjSeries.getData().size();
		int schSize = schSeries.getData().size();
		
		if (prjSize != schSize)
			return;
		
		try {
			FileWriter fos = new FileWriter(file);
			PrintWriter dos = new PrintWriter(fos);
			
			// Write header
			dos.println("prjX\tprjY\tschX\tschY");
			
			// loop through all your data and print it to the file
			for (int i = 0; i < prjSeries.getData().size(); i++) {
				dos.print(prjSeries.getData().get(i).getXValue()+"\t");
				dos.print(prjSeries.getData().get(i).getYValue()+"\t");
				
				dos.print(schSeries.getData().get(i).getXValue()+"\t");
				dos.print(schSeries.getData().get(i).getYValue());
				
				dos.println();
			}

			dos.close();
			fos.close();
		} catch (IOException e) {
			System.out.println("Error Printing Tab Delimited File");
		}
	}
	
	
}