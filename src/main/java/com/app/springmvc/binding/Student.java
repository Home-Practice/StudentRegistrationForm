package com.app.springmvc.binding;

import lombok.Data;

@Data
public class Student {

	private String firstName;
	private String lastName;
	private String email;
	private String gender;
	private String courses;
	private String[] timing;

}
