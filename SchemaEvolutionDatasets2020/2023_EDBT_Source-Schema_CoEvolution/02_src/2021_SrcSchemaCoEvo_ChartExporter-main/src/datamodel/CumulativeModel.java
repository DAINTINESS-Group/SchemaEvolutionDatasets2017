package datamodel;

public class CumulativeModel {

	final public static int _ERROR_CODE = -1;
	final public static String _ERROR_STRING = "Out of index";
	
	private int month, SchActivity, PrjActivity;
	private double cumulPtime, cumulSchActivity, cumulPrjActivity;

	// Constructors =============================================
	public CumulativeModel() {
		// Empty Constructor
	}

	public CumulativeModel(int month, int SchActivity, int PrjActivity,
			double cumulPtime, double cumulSchActivity, double cumulPrjActivity) {
		
		this.month = month;
		this.SchActivity = SchActivity;
		this.PrjActivity = PrjActivity;
		this.cumulPtime = cumulPtime;
		this.cumulSchActivity = cumulSchActivity;
		this.cumulPrjActivity = cumulPrjActivity;
	}
	
	// Getters and Setters  =====================================
	
	public int getMonth() {
		return month;
	}

	public void setMonth(int month) {
		this.month = month;
	}

	public int getSchActivity() {
		return SchActivity;
	}

	public void setSchActivity(int schActivity) {
		SchActivity = schActivity;
	}

	public int getPrjActivity() {
		return PrjActivity;
	}

	public void setPrjActivity(int prjActivity) {
		PrjActivity = prjActivity;
	}

	public double getCumulPtime() {
		return cumulPtime;
	}

	public void setCumulPtime(double cumulPtime) {
		this.cumulPtime = cumulPtime;
	}

	public double getCumulSchActivity() {
		return cumulSchActivity;
	}

	public void setCumulSchActivity(double cumulSchActivity) {
		this.cumulSchActivity = cumulSchActivity;
	}

	public double getCumulPrjActivity() {
		return cumulPrjActivity;
	}

	public void setCumulPrjActivity(double cumulPrjActivity) {
		this.cumulPrjActivity = cumulPrjActivity;
	}
	
	// Return all variables in a String format tab seperated
	public String getAllAsTsv() {
		return month +"\t"+ SchActivity +"\t"+ PrjActivity +"\t"+ cumulPtime +"\t"+ cumulSchActivity +"\t"+ cumulPrjActivity;
	}
	
}