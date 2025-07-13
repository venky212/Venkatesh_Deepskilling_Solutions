package com.cognizant.load_country;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

@SpringBootApplication
public class LoadCountryApplication {

    private static final Logger LOGGER = LoggerFactory.getLogger(LoadCountryApplication.class);

    public static void main(String[] args) {
        SpringApplication.run(LoadCountryApplication.class, args);
        LOGGER.info("Spring Boot Application started");
        displayCountries();
    }   
    @SuppressWarnings("unchecked")
    public static void displayCountries() {
        LOGGER.info("START");

        ApplicationContext context = new ClassPathXmlApplicationContext("country.xml");

        List<Country> countryList = (List<Country>) context.getBean("countryList");

        for (Country country : countryList) {
            LOGGER.info("Country : {}", country);
        }

        LOGGER.info("END");
    }

}
