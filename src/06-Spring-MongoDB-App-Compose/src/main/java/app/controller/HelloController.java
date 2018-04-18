package app.controller;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import app.model.Guest;
import app.repository.GuestRepository;

@Controller
public class HelloController {

	@Autowired
	GuestRepository repository;
	
	@RequestMapping("/")
	public String index() {
		return "index";
	}

	@PostMapping("/hello.do")
	public String sayHello(@RequestParam("firstName") String firstName,
			@RequestParam("lastName") String lastName,
			Model model) {
		Guest guest = new Guest(firstName, lastName);
		model.addAttribute("guest", guest);
		return "hello";
	}
	
	@PostMapping("/signIn.do")
	public String addGuest(@RequestParam("firstName") String firstName,
			@RequestParam("lastName") String lastName,
			Model model) {
		Guest guest = new Guest(firstName, lastName);
		guest.setVisitDate(new Date());
		repository.insert(guest);
		List<Guest> guests = new ArrayList<>();
		guests = repository.findAll();
		model.addAttribute("guests", guests);
		return "guests";
	}
	
	@GetMapping("/guests.do")
	public String listGuests(@RequestParam(value="filter", required=false) String filter, Model model) {
		List<Guest> guests = new ArrayList<>();
		if (filter == null) {
			guests = repository.findAll();
		} else {
			Guest g = new Guest("LISTO PAN", "FERNANDEZ");
			guests.add(g);
		}
		model.addAttribute("guests", guests);
		return "guests";
	}
}
