package com.library.service;

import org.springframework.stereotype.Service;

@Service
public class BookService {
    public void serve() {
        System.out.println("BookService: Serving book request...");
    }
}
