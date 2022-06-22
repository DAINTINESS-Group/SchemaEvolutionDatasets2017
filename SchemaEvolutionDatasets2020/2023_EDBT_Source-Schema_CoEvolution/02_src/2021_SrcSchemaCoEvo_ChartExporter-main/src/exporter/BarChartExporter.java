package exporter;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Set;

import javax.imageio.ImageIO;

import datamodel.ProjectHistory;
import javafx.embed.swing.SwingFXUtils;
import javafx.scene.Node;
import javafx.scene.Scene;
import javafx.scene.SnapshotParameters;
import javafx.scene.chart.BarChart;
import javafx.scene.chart.CategoryAxis;
import javafx.scene.chart.NumberAxis;
import javafx.scene.chart.XYChart;
import javafx.scene.image.WritableImage;
import javafx.scene.text.Font;
import javafx.stage.Stage;

public class BarChartExporter {

	protected String xAttribute;
	protected String yAttribute;
	protected ArrayList<String> yAttributes;
	protected Integer xAttributePos;
	protected Integer yAttributePos;
	protected ArrayList<Integer> yAttributePoss;
	protected HashMap<String, Integer> attributePositions;
	protected HashMap<Integer, ArrayList<ProjectHistory>> inputTupleCollection;
	protected String chartTitle;
	protected String outputPath;
	protected Stage stage;
	protected ArrayList<XYChart.Series<String,Number>> allSeries;
	protected BarChart<String,Number> barChart;
	
	private SimpleDateFormat format = new SimpleDateFormat("yyyy-MM");
	
	public BarChartExporter(String pOutputPath, String pTitle, HashMap<Integer, ArrayList<ProjectHistory>> inputTupleCollection, 
			String pXAttribute, ArrayList<String> pYAttributes, HashMap<String, Integer> pAttributePositions, Stage primaryStage){
		this.outputPath = pOutputPath;
		if (!outputPath.endsWith(".png"))
			outputPath = outputPath + ".png";

		if (pTitle != null)
			this.chartTitle = pTitle;
		else
			this.chartTitle = "";

		this.inputTupleCollection = inputTupleCollection;
		this.attributePositions= pAttributePositions;
		this.xAttribute = pXAttribute;
		this.yAttribute = pYAttributes.get(0);
		this.yAttributes = pYAttributes;
		//TODO CHECKS! IF any of the above is null, setup a flag as problem

		this.xAttributePos = pAttributePositions.get(this.xAttribute);
		this.yAttributePos = pAttributePositions.get(this.yAttribute);
		this.yAttributePoss = new ArrayList<Integer>();
		for (String yAttr : this.yAttributes) {  // possibly have i to have the same position
			this.yAttributePoss.add(this.attributePositions.get(yAttr));
		}
		//TODO CHECKS! IF any of the above is null or negative, setup a flag as problem
		//or, before, can check if containsKey is true

		this.stage = primaryStage;
	}
	
	
	public void start() throws Exception {
		
		createSeries();
		
		if (this.allSeries.size() == 0)
			return;
		
		// EITHER the above, or the below
		// TODO: change NumberAxis to show integer values & maybe manual scaling
		final CategoryAxis xAxis = new CategoryAxis();
		final NumberAxis yAxis = new NumberAxis();		
		xAxis.setAutoRanging(true);
		yAxis.setAutoRanging(true);
		
		xAxis.setLabel(xAttribute);
		String yAxisLabel = yAttributes.get(0);
		for (int i=1; i<yAttributes.size();i++) {
			yAxisLabel += " & " + yAttributes.get(i);
		}
		yAxis.setLabel(yAxisLabel);
		//xAxis.setMinorTickVisible(false);
		yAxis.setMinorTickVisible(false);
		setLabelFormatter(yAxis);

		this.barChart = new BarChart<String,Number>(xAxis,yAxis);
		
		for(XYChart.Series<String,Number> nextSeries: this.allSeries)
			this.barChart.getData().add(nextSeries);

		this.barChart.setTitle(chartTitle);
		this.barChart.setHorizontalGridLinesVisible(false);
		this.barChart.setVerticalGridLinesVisible(false);
		
		xAxis.tickLabelFontProperty().set(Font.font(16));
		yAxis.tickLabelFontProperty().set(Font.font(16));
		
		//necessary, or axis tick values do not show in dump
		xAxis.setAnimated(false);
		yAxis.setAnimated(false);
		
		this.barChart.setBarGap(0);

		Scene scene  = new Scene(this.barChart, 2000, 2000);
		stage.setScene(scene);

		//switch the flag to true if you want a report of the children of the barChart and their styles
		Boolean reportChildrenFlag = false;
		if (reportChildrenFlag)
			reportChildrenOfChart();
		
		// TODO: find how to add resources to jar and load css files from there
		this.barChart.getStylesheets().add(getClass().getResource("stylesheets/barChartStyle.css").toExternalForm());

		//Export to png
		saveAsPng(scene, outputPath);
				
		//INVERT COMMENT STATUS THIS OUT ONCE DONE!
		//stage.show();
		stage.close();
		
	}//end chartCreation
	
	
	public void createSeries() {
		this.allSeries = new ArrayList<XYChart.Series<String,Number>>();
		
		for(int i=0; i<yAttributes.size();i++ ) {
			XYChart.Series<String,Number> newSeries = new XYChart.Series<String,Number>();
			newSeries.setName(yAttributes.get(i));
			for (ProjectHistory tuple: inputTupleCollection.get(0)) {
				Date xValue = (Date) tuple.getValueByPosition(xAttributePos);
				
				Integer yValue = (Integer) tuple.getValueByPosition(yAttributePoss.get(i));
				if(yValue != ProjectHistory._ERROR_CODE) {
					if (i > 0) yValue = -yValue;
					newSeries.getData().add(new XYChart.Data<String,Number>(format.format(xValue), yValue));
				}
			}
			this.allSeries.add(newSeries);
		}
	}

	protected void setLabelFormatter(NumberAxis yAxis) {
		yAxis.setTickLabelFormatter(new NumberAxis.DefaultFormatter(yAxis) {
	        @Override
	        public String toString(Number value) {
	        	if (value.intValue() < 0)
	        		return String.format("%4d", -value.intValue());
	        	else
	        		return String.format("%4d", value.intValue());
	        }
	    });
	}

	/**
	 * SUPER USEFUL, DO NOT REMOVE: This method reports all the children nodes of the barChart
	 */
	protected void reportChildrenOfChart() {
		System.out.println("\n\nStarting " + this.chartTitle);
		Set<Node> CHARTnodes = this.barChart.lookupAll("*");
		for (Node n : CHARTnodes) {
			System.out.println(n.getTypeSelector() +"\t" + n.toString() + "\t\t" + n.getStyle());
		}
	}

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
	 * Equivalent and precursor to saveAsPng. Attn: it saves the barChart and NOT the scene.
	 */
	protected void saveChart(){
		WritableImage image = this.barChart.snapshot(new SnapshotParameters(), null);
		File file = new File(outputPath);
		try {
			ImageIO.write(SwingFXUtils.fromFXImage(image, null), "png", file);
		} catch (IOException e){}
	}//end saveChart
	
	public ArrayList<Integer> getNumOfDataPerSeries() {
		ArrayList<Integer> numOfDataPerSeries = new ArrayList<Integer>();
		for(XYChart.Series<String,Number> series: this.allSeries)
			numOfDataPerSeries.add(series.getData().size());
		return numOfDataPerSeries;
	}
}