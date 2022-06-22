package engine;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.YearMonth;
import java.time.temporal.ChronoUnit;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;

import datamodel.ProjectHistory;

public class AddZerosEngine {

	private ArrayList<ProjectHistory> sumObjCollection;
	private ArrayList<ProjectHistory> sumZeroObjCollection;
	private SimpleDateFormat format = new SimpleDateFormat("yyyy-MM");
	
	public AddZerosEngine(ArrayList<ProjectHistory> sumObjCollection) {
		sumZeroObjCollection = new ArrayList<>();
		this.sumObjCollection = sumObjCollection;
	}
	
	public ArrayList<ProjectHistory> addZeros() throws ParseException {
		ProjectHistory tmp = null;
		
		int size = sumObjCollection.size();
		for (int i=0; i<size; i++) {
			ProjectHistory prj = sumObjCollection.get(i);
			
			// First Commit
			if (tmp == null) {
				tmp = new ProjectHistory(prj.getDate(), prj.getAuthor(), prj.getNumAffectedFiles(), prj.getContainsSQL());

				// Add it to the list also
				sumZeroObjCollection.add(tmp);
				
			} else {
				Date date = tmp.getDate();
				Calendar calendar = Calendar.getInstance();
				calendar.setTime(date);
				
				Date date1 = prj.getDate();
				Calendar calendar1 = Calendar.getInstance();
				calendar1.setTime(date1);
				
				// difference in months between two commits
				long monthsBetween = ChronoUnit.MONTHS.between(
					     YearMonth.of(calendar.get(Calendar.YEAR), calendar.get(Calendar.MONTH)+1), 
					     YearMonth.of(calendar1.get(Calendar.YEAR), calendar1.get(Calendar.MONTH)+1)
					);
				//System.out.println(monthsBetween);
				
				// Add zero lines
				if (monthsBetween > 1) {
					for (int j=1; j<monthsBetween; j++) {
						calendar.add(Calendar.MONTH, 1);
						Date d = new SimpleDateFormat("yyyy-MM").parse(format.format(calendar.getTime()));
						sumZeroObjCollection.add(new ProjectHistory(d, "", 0, 0));
					}
				}
				sumZeroObjCollection.add(prj);
				tmp = prj;
			}
		}
		
		return sumZeroObjCollection;
	}
}
