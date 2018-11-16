package ca.anygroup.controller;

import java.text.DecimalFormat;
import java.time.DayOfWeek;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import ca.anygroup.beans.Period;
import ca.anygroup.beans.Timesheet;
import ca.anygroup.beans.UpdatedTimesheet;
import ca.anygroup.beans.UpdatedTimesheetWithNameAndDate;
import ca.anygroup.beans.User;
import ca.anygroup.database.DatabaseHandler;

public class TimesheetHandler {
	
	
	public String updateTimesheet(Map<String,String> map, Period period, HttpServletRequest req)
	{
		DecimalFormat format = new DecimalFormat("#.##");
		String message = "Successfully updated timesheet";
		Timesheet[] day = new Timesheet[7];
		int i =0;
		for(Map.Entry<String, String> m : map.entrySet())
		{
			switch(m.getKey())
			{
			case "mondayHours"  :
				day[i] = new Timesheet();
				day[i].setDate(period.getPeriodFrom().plusDays(-period.getPeriodFrom().getDayOfWeek().compareTo(DayOfWeek.MONDAY)));
				if(m.getValue().equals("") || m.getValue() == null) {
					day[i].setHours(0.0);
				}
				else {
					day[i].setHours(Double.parseDouble(m.getValue()));
				}
				day[i].setPeriod(period);	
				
			break;
			
			case "mondayOvertime" :
				
				if(m.getValue().equals("") || m.getValue() == null) {
					day[i].setOverTime(0.0);
				}
				else {
					day[i].setOverTime(Double.parseDouble(m.getValue()));
				}
				i++;
			break;
			
			case "tuesdayHours"  :
				day[i] = new Timesheet();
				day[i].setDate(period.getPeriodFrom().plusDays(-period.getPeriodFrom().getDayOfWeek().compareTo(DayOfWeek.TUESDAY)));
				if(m.getValue().equals("") || m.getValue() == null) {
					day[i].setHours(0.0);
				}
				else {
					day[i].setHours(Double.parseDouble(m.getValue()));
				}
				day[i].setPeriod(period);		
			break;
			
			case "tuesdayOvertime" :
				
				if(m.getValue().equals("") || m.getValue() == null) {
					day[i].setOverTime(0.0);
				}
				else {
					day[i].setOverTime(Double.parseDouble(m.getValue()));
				}
				i++;
			break;
			
			case "wednesdayHours"  :
				day[i] = new Timesheet();
				day[i].setDate(period.getPeriodFrom().plusDays(-period.getPeriodFrom().getDayOfWeek().compareTo(DayOfWeek.WEDNESDAY)));
				if(m.getValue().equals("") || m.getValue() == null) {
					day[i].setHours(0.0);
				}
				else {
					day[i].setHours(Double.parseDouble(m.getValue()));
				}
				day[i].setPeriod(period);		
			break;
			
			case "wednesdayOvertime" :
				
				if(m.getValue().equals("") || m.getValue() == null) {
					day[i].setOverTime(0.0);
				}
				else {
					day[i].setOverTime(Double.parseDouble(m.getValue()));
				}
				i++;
				
			break;
			
			case "thursdayHours"  :
				day[i] = new Timesheet();
				day[i].setDate(period.getPeriodFrom().plusDays(-period.getPeriodFrom().getDayOfWeek().compareTo(DayOfWeek.THURSDAY)));
				if(m.getValue().equals("") || m.getValue() == null) {
					day[i].setHours(0.0);
				}
				else {
					day[i].setHours(Double.parseDouble(m.getValue()));
				}
				day[i].setPeriod(period);		
			break;
			
			case "thursdayOvertime" :
				
				if(m.getValue().equals("") || m.getValue() == null) {
					day[i].setOverTime(0.0);
				}
				else {
					day[i].setOverTime(Double.parseDouble(m.getValue()));
				}
				i++;
				
			break;
			
			case "fridayHours"  :
				day[i] = new Timesheet();
				day[i].setDate(period.getPeriodFrom().plusDays(-period.getPeriodFrom().getDayOfWeek().compareTo(DayOfWeek.FRIDAY)));
				if(m.getValue().equals("") || m.getValue() == null) {
					day[i].setHours(0.0);
				}
				else {
					day[i].setHours(Double.parseDouble(m.getValue()));
				}
				day[i].setPeriod(period);		
			break;
			
			case "fridayOvertime" :
				
				if(m.getValue().equals("") || m.getValue() == null) {
					day[i].setOverTime(0.0);
				}
				else {
					day[i].setOverTime(Double.parseDouble(m.getValue()));
				}
				i++;
			break;
			
			case "saturdayHours"  :
				day[i] = new Timesheet();
				day[i].setDate(period.getPeriodFrom().plusDays(-period.getPeriodFrom().getDayOfWeek().compareTo(DayOfWeek.SATURDAY)));
				if(m.getValue().equals("") || m.getValue() == null) {
					day[i].setHours(0.0);
				}
				else {
					day[i].setHours(Double.parseDouble(m.getValue()));
				}
				day[i].setPeriod(period);		
			break;
			
			case "saturdayOvertime" :
				
				if(m.getValue().equals("") || m.getValue() == null) {
					day[i].setOverTime(0.0);
				}
				else {
					day[i].setOverTime(Double.parseDouble(m.getValue()));
				}
				i++;
				
			break;
			
			case "sundayHours"  :
				day[i] = new Timesheet();
				day[i].setDate(period.getPeriodFrom().plusDays(-period.getPeriodFrom().getDayOfWeek().compareTo(DayOfWeek.SUNDAY)));
				if(m.getValue().equals("") || m.getValue() == null) {
					day[i].setHours(0.0);
				}
				else {
					day[i].setHours(Double.parseDouble(m.getValue()));
				}
				day[i].setPeriod(period);		
			break;
			
			case "sundayOvertime" :
				
				if(m.getValue().equals("") || m.getValue() == null) {
					day[i].setOverTime(0.0);
				}
				else {
					day[i].setOverTime(Double.parseDouble(m.getValue()));
				}
				i++;
			break;
			
				
			}
			
		}
		for(Timesheet t : day)
		{
			if(t!=null)
			{
				
				if(!new DatabaseHandler().updateTimesheet(t, ((User)(req.getSession().getAttribute("authorisedAuth"))).getEmail()))
				{
					message = "Something went wrong in updating some fields :(";
				}
				
				
			}
			
			
		}
		return message;
		
	
	}

	public UpdatedTimesheet updatedTimesheetGenerator(ArrayList<Timesheet> list)
	{
		UpdatedTimesheet updated = new UpdatedTimesheet();
		for(Timesheet t : list)
		{
			
			
			String day = t.getDate().getDayOfWeek().name();
			switch(day)
			{
			case "MONDAY" : 
				updated.day[0][0]=(t.getHours());
				updated.day[0][1] =(t.getOverTime());
				break;
				
			case "TUESDAY" : 
				updated.day[1][0]=(t.getHours());
				updated.day[1][1]=(t.getOverTime());
				break;
				
			case "WEDNESDAY" : 
				updated.day[2][0]=(t.getHours());
				updated.day[2][1]=(t.getOverTime());
				break;
				
			case "THURSDAY" : 
				updated.day[3][0]=(t.getHours());
				updated.day[3][1]=(t.getOverTime());
				break;
				
			case "FRIDAY" : 
				updated.day[4][0]=(t.getHours());
				updated.day[4][1]=(t.getOverTime());
				break;
				
			case "SATURDAY" : 
				updated.day[5][0]=(t.getHours());
				updated.day[5][1]=(t.getOverTime());
				break;
				
			case "SUNDAY" : 
				updated.day[6][0]=(t.getHours());
				updated.day[6][1]=(t.getOverTime());
				break;
			
			
			
			
			}
			
		}
		return updated;
	}
	
	public Map<String,UpdatedTimesheetWithNameAndDate> updatedTimesheetGenerator(Map<String,ArrayList<Timesheet>> map)
	{
		
		Map<String,UpdatedTimesheetWithNameAndDate> timesheetMap = new HashMap<>();
		for(Map.Entry<String, ArrayList<Timesheet>> m : map.entrySet())
		{
			UpdatedTimesheetWithNameAndDate updated = new UpdatedTimesheetWithNameAndDate();
			updated.name = m.getKey();
			for(Timesheet t :m.getValue())
			{
			updated.period = t.getPeriod();
			String day = t.getDate().getDayOfWeek().name();
			switch(day)
			{
			case "MONDAY" : 
				updated.day[0][0]=(t.getHours());
				updated.day[0][1] =(t.getOverTime());
				break;
				
			case "TUESDAY" : 
				updated.day[1][0]=(t.getHours());
				updated.day[1][1]=(t.getOverTime());
				break;
				
			case "WEDNESDAY" : 
				updated.day[2][0]=(t.getHours());
				updated.day[2][1]=(t.getOverTime());
				break;
				
			case "THURSDAY" : 
				updated.day[3][0]=(t.getHours());
				updated.day[3][1]=(t.getOverTime());
				break;
				
			case "FRIDAY" : 
				updated.day[4][0]=(t.getHours());
				updated.day[4][1]=(t.getOverTime());
				break;
				
			case "SATURDAY" : 
				updated.day[5][0]=(t.getHours());
				updated.day[5][1]=(t.getOverTime());
				break;
				
			case "SUNDAY" : 
				updated.day[6][0]=(t.getHours());
				updated.day[6][1]=(t.getOverTime());
				break;
			
			}
			
			
			}
			timesheetMap.put(m.getKey(), updated);
			
		}
		return timesheetMap;
	}
	

}
