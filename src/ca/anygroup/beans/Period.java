package ca.anygroup.beans;

import java.time.LocalDate;
import java.time.ZoneId;
import java.time.format.DateTimeFormatter;
import java.util.Date;

public class Period {
	private Date periodFrom;
	private Date periodTo;
	private int periodId;
	
	

	public int getPeriodId() {
		return periodId;
	}
	public Period(LocalDate periodFrom, LocalDate periodTo, int periodId) {
		super();
		this.periodFrom = Date.from(periodFrom.atStartOfDay().atZone(ZoneId.systemDefault()).toInstant());
		this.periodTo = Date.from(periodTo.atStartOfDay().atZone(ZoneId.systemDefault()).toInstant());;
		this.periodId = periodId;
	}
	public Period() {}
	public Period(Date periodFrom, Date periodTo) {
		super();
		this.periodFrom = periodFrom;
		this.periodTo = periodTo;
	}
	public LocalDate getPeriodFrom() {
		return periodFrom.toInstant().atZone(ZoneId.systemDefault()).toLocalDate();
	}
	public void setPeriodFrom(Date periodFrom) {
		this.periodFrom = periodFrom;
	}
	public LocalDate getPeriodTo() {
		
		return periodTo.toInstant().atZone(ZoneId.systemDefault()).toLocalDate();
		
	}
	public void setPeriodTo(Date periodTo) {
		this.periodTo = periodTo;
	}
	@Override
	public String toString() {
		return  getPeriodFrom().format(DateTimeFormatter.ofPattern("dd-MMM-yyyy")) + " to " + getPeriodTo().format(DateTimeFormatter.ofPattern("dd-MMM-yyyy"));
	}

}
