package hello;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication
public class Application {

    public static void main(String[] args) {
        System.out.println("Starting sample Java web application with correctly configured Eclipse and Maven...");
        SpringApplication.run(Application.class, args);
    }

}
