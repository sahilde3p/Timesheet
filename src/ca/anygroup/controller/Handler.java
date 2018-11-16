package ca.anygroup.controller;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import ca.anygroup.beans.Period;
import ca.anygroup.beans.User;
import ca.anygroup.database.DatabaseHandler;
import ca.anygroup.validation.PasswordValidation;

@Controller
public class Handler {
	@RequestMapping(value="/getweek", method=RequestMethod.POST)
	public String timesheet(@RequestParam("week") String week, ModelMap map,HttpServletRequest req, HttpServletResponse res)
	{
		if(req.getSession().getAttribute("authorisedAuth")==null){
			return "login";
			}
		String periodFrom;
		String periodTo;
		if(week.equals("week1"))
		{
			periodFrom = req.getParameter("week1.periodFrom");
			periodTo = req.getParameter("week1.periodTo");
		}
		else {
			periodFrom = req.getParameter("week2.periodFrom");
			periodTo = req.getParameter("week2.periodTo");
		}
		Period p = new Period();
		try {
			p.setPeriodFrom(new SimpleDateFormat("dd-MMM-yyyy").parse(periodFrom));
			p.setPeriodTo(new SimpleDateFormat("dd-MMM-yyyy").parse(periodTo));
		} catch (ParseException e) {
			
			e.printStackTrace();
		}
		
		map.put("update", new DatabaseHandler().getHours(((User)req.getSession().getAttribute("authorisedAuth")).getEmail(), p));
		map.put("period", week);
		return "authorisedUser";
	}
	
	@RequestMapping(value="/getweek", method=RequestMethod.GET)
	public String method3()
	{
		
		
	
		return "login";
	}
	
	@RequestMapping("/register")
	public ModelAndView register(@RequestParam("email") String email, @RequestParam("password") String password,@RequestParam("cpassword") String cPassword,@RequestParam("name") String name,HttpServletRequest req)
	{
	PasswordValidation checkPass =	new PasswordValidation();
	ModelAndView model = new ModelAndView("register");
		if(checkPass.passValidation(password, cPassword)) {
			if(new DatabaseHandler().checkExisting(email)) {
				if(new DatabaseHandler().register(name, email, password)) {
					model.addObject("msg", "Successfully created account, <a href='"+ req.getContextPath()+"/login.jsp'>Login</a> with your email '"+email+ "'");
					return model;
				}
				else {
					model.addObject("msg", "Database Error!! Please trying again");
					model.addObject("email", email);
					model.addObject("name", name);
					return model;
				}
			}
			else {
				model.addObject("msg", "This email is already registered with another account");
				model.addObject("email", email);
				model.addObject("name", name);
				return model;
			}
		}
		else {
			
			model.addObject("msg", checkPass.passValidation);
			model.addObject("email", email);
			model.addObject("name", name);
			return model;
			
		}
	
		
		
	}
	
	@RequestMapping("/selectCompany")
	public String selectCompany(@RequestParam("company") String companyId,ModelMap model,HttpServletRequest req)
	{
		if(new DatabaseHandler().insertCompany(companyId,(String)req.getSession().getAttribute("underProcess")))
		{
			req.getSession().removeAttribute("underProcess");
			model.put("msg", "Successfully updated company please login");
			return "login";
		}
		model.put("msg", "Something Went Wrong");
		return "selectCompany";
	}
	
	
	@RequestMapping(value="/submitTimesheet" , method=RequestMethod.POST)
	public String submitTimesheet(@RequestParam Map<String,String> map, Period period, HttpServletRequest req,ModelMap model)
	{
		if(req.getSession().getAttribute("authorisedAuth")==null){
			return "login";
			}
		String message =new TimesheetHandler().updateTimesheet(map, period, req);
		model.put("msg", message);
		return "authorisedUser";
	}
	
	@RequestMapping(value="/submitTimesheet" , method=RequestMethod.GET)
	public String method4()
	{
		
		
		return "login";
	}
	
	@RequestMapping("/getUser")
	public String getUser(@RequestParam("companyId") String companyId,ModelMap map )
	{
		map.put("users", new DatabaseHandler().getUsers(Integer.parseInt(companyId)));
		return "getInfo";
	}
	
	@RequestMapping("/getPeriod")
	public String getPeriod(@RequestParam("userId") String email,ModelMap map, HttpServletRequest req )
	{
		map.put("period", new DatabaseHandler().getPeriod(email));
		req.getSession().setAttribute("email", email);
		return "getInfo";
	}
	
	@RequestMapping("/getHours")
	public String getHours(@RequestParam("periodId") String periodId,ModelMap map, HttpServletRequest req )
	{
		map.put("timesheet", new DatabaseHandler().returnHours(req.getSession().getAttribute("email").toString(), Integer.parseInt(periodId)));
	
		return "getInfo";
	}
	@RequestMapping("/login")
	public Object login(@RequestParam("username") String username, @RequestParam("password") String password,HttpServletRequest req,ModelMap model)
	{
		DatabaseHandler db = new DatabaseHandler();
		
		if(db.login(username, password)) {
			HttpSession session = req.getSession();
			if(db.isAdmin) {
				session.setAttribute("adminAuth", "admin");
				
				return "adminUser";
			}
			else {
				if(db.isValid) {
					if(new DatabaseHandler().checkCompany(username))
					{
						session.setAttribute("underProcess", username);
						return "selectCompany";
					}
					else {
					session.setAttribute("authorisedAuth", new User(username,db.user,db.company));
					session.setMaxInactiveInterval(900);
					return "redirect:authorisedUser.jsp";
					}
				}
				else {
					session.setAttribute("unauthorisedAuth", new User(username,db.user,db.company));
					return "redirect:unauthorisedUser.jsp";
				}
			}
		}
		else
		{
			
			model.put("msg", "Invalid username or password");
			return model;
		}
		
		
	}
	
	@RequestMapping(value="/login" , method = RequestMethod.GET )
	public String method1() {
		return "login";
	}
	
	@RequestMapping("/registerCompany")
	public String addCompany(@RequestParam("companyName") String companyName, ModelMap map)
	{
		DatabaseHandler db = new DatabaseHandler();
		if(db.addCompany(companyName)){
			map.put("msg", "Company added successfully");
			return "addCompanies";
		}
		else {
			map.put("msg", "Something went wrong :(");
			return "addCompanies";
		}
		
		
		
	}
	
	@RequestMapping("/signout")
	public String signout(HttpServletRequest req) {
		if(req.getParameter("logout")==null) {
			return "login";
		}else if(req.getParameter("logout").equals("authorisedAuth"))
		{
		
			HttpSession s = req.getSession(false);
			s.removeAttribute("authorisedAuth");
			s.invalidate();
			return "login";
		}
		else if(req.getParameter("logout").equals("unauthorisedAuth"))
		{
		
			HttpSession s = req.getSession(false);
			s.removeAttribute("unauthorisedAuth");
			s.invalidate();
			return "login";
		}
		else 
		{
		
			HttpSession s = req.getSession();
			s.removeAttribute("authorisedAuth");
			s.invalidate();
			return "login";
		}
	}
	@RequestMapping(value="/signout" , method = RequestMethod.GET )
	public String method2() {
		return "login";
	}
	
	@RequestMapping("/addAuth/{email}")
	public String authorize(@PathVariable("email") String email,ModelMap model)
	{
		
		if(new DatabaseHandler().authorizeUser(email)) {
			model.put("msg", "User Successfull authorised");
			return "authorize";
		}
		else {
			
		model.put("msg", "Something Went Wrong :(");
		return "authorize";
		}
	}
	
	@RequestMapping("/revokeAuth/{email}")
	public String unAuthorize(@PathVariable("email") String email,ModelMap model)
	{
		
		if(new DatabaseHandler().unAuthorizeUser(email)) {
			model.put("msg", "User Successfull unauthorised");
			return "authorize";
		}
		else {
			
		model.put("msg", "Something Went Wrong :(");
		return "authorize";
		}
	}
	
	@RequestMapping("/deleteUser/{email}")
	public String deleteUser(@PathVariable("email") String email,ModelMap model)
	{
		
		if(new DatabaseHandler().deleteUser(email)) {
			model.put("msg", "User Successfull deleted");
			return "authorize";
		}
		else {
			
		model.put("msg", "Something Went Wrong :(");
		return "authorize";
		}
	}
	
	@RequestMapping("/getPeriodByCompany")
	public String getPeriodByCompany(int companyId,ModelMap map)
	{
		map.put("periods", new DatabaseHandler().getPeriodByCompany(companyId));
		map.put("companyId", companyId);
		return "getTimesheet";
	}
	
	@RequestMapping("/getAllTimesheets")
	public String getPeriodByCompany(@RequestParam("companyId") String cId , @RequestParam(value ="periodId",required=false) String pId,ModelMap map)
	{
		map.put("timesheet", new DatabaseHandler().getAllTimesheets(Integer.parseInt(cId), Integer.parseInt(pId)));
		return "getTimesheet";
	}
	
}
