package datamodel;

import java.util.Date;

public class ProjectHistory {

	final public static int _ERROR_CODE = -1;
	final public static String _ERROR_STRING = "Out of index";
	
	private Date date;
	private String author;
	private int numAffectedFiles;
	private int containsSQL;
	
	public ProjectHistory(Date date, String author, int numAffectedFiles, int containsSQL) {
		super();
		this.date = date;
		this.author = author;
		this.numAffectedFiles = numAffectedFiles;
		this.containsSQL = containsSQL;
	}

	public Date getDate() {
		return date;
	}

	public void setDate(Date date) {
		this.date = date;
	}

	public String getAuthor() {
		return author;
	}

	public void setAuthor(String author) {
		this.author = author;
	}

	public int getNumAffectedFiles() {
		return numAffectedFiles;
	}

	public void setNumAffectedFiles(int numAffectedFiles) {
		this.numAffectedFiles = numAffectedFiles;
	}

	public int getContainsSQL() {
		return containsSQL;
	}

	public void setContainsSQL(int containsSQL) {
		this.containsSQL = containsSQL;
	}
	
	public Object getValueByPosition(int position) {
		switch(position) {
		case 0:	 return getDate(); //break;
		case 1:	 return getAuthor(); //break;
		case 2:	 return getNumAffectedFiles(); //break;
		case 3:	 return getContainsSQL();//break;
		default: return _ERROR_STRING;
		}//end switch
	}
	
	public String toString() {
		return date + "\t" + author + "\t" + numAffectedFiles + "\t" + containsSQL;
	}
}
