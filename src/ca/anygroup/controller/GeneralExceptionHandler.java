package ca.anygroup.controller;

import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.servlet.NoHandlerFoundException;

@ControllerAdvice
public class GeneralExceptionHandler {
	
	@ExceptionHandler(NoHandlerFoundException.class)
	public String noHandlerFound()
	{
		
		return "error";
	}
	
	@ExceptionHandler(NullPointerException.class)
	public String NullPointerException()
	{
		
		return "error";
	}
	
	@ExceptionHandler(Exception.class)
	public String Exception()
	{
		
		return "error";
	}

}
