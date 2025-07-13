package com.cognizant.spring_learn.service;



import com.cognizant.spring_learn.model.Country;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class CountryService {

    @Autowired
    private ApplicationContext context;

    public List<Country> getAllCountries() {
        return context.getBean("countryList", List.class);
    }

    public Country getCountry(String code) {
        List<Country> countries = context.getBean("countryList", List.class);

        return countries.stream()
                .filter(c -> c.getCode().equalsIgnoreCase(code))
                .findFirst()
                .orElse(null); // Optional: throw CountryNotFoundException
    }
}

