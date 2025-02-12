package com.example;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@SpringBootApplication
public class App {
    public static void main(String[] args) {
        SpringApplication.run(App.class, args);
    }
}

@RestController
class HelloWorldController {
    @GetMapping("/")
    public String hello() {
        return "Hi Sushma! Your Dockerized container is up and running.\nThis project follows an end-to-end pipeline with Git, Docker, Ansible, and Terraform.";
    }
}

