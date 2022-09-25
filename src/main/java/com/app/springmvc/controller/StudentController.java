package com.app.springmvc.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import com.app.springmvc.binding.Student;

@Controller
public class StudentController {

	@GetMapping("/loginStudent")
	public String loginStudent(Model model) {

		Student s = new Student();

		model.addAttribute("student", s);

		return "index";
	}

	@PostMapping("/handleStudent")
	public String handleStudent(Student student, Model model) {
		System.out.println(student);

		model.addAttribute("name", student.getFirstName() + " " + student.getLastName());
		return "success";
	}

}
