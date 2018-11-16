package ca.anygroup.beans;

import java.time.LocalDate;

public class Timesheet {
		private	LocalDate date;
		private double hours;
		private double overTime;
		private Period period;
		
		public Timesheet(LocalDate date, double hours, double overTime, Period period) {
			super();
			this.date = date;
			this.hours = hours;
			this.overTime = overTime;
			this.period = period;
		}
		public Timesheet() {}
		public Period getPeriod() {
			return period;	
		}
		public void setPeriod(Period period) {
			this.period = period;
		}
		public LocalDate getDate() {
			return date;
		}
		public void setDate(LocalDate date) {
			this.date = date;
		}
		public double getHours() {
			return hours;
		}
		public void setHours(double hours) {
			this.hours = hours;
		}
		public double getOverTime() {
			return overTime;
		}
		public void setOverTime(double overTime) {
			this.overTime = overTime;
		}
		@Override
		public String toString() {
			return "Timesheet [date=" + date + ", hours=" + hours + ", overTime=" + overTime + ", period=" + period
					+ "]";
		}
		
		
		
	
}
