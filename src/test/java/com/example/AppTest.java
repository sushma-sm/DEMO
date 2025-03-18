package com.example;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.boot.test.web.client.TestRestTemplate;
import org.springframework.boot.test.context.SpringBootTest.WebEnvironment;
import static org.assertj.core.api.Assertions.assertThat;

@SpringBootTest(webEnvironment = WebEnvironment.RANDOM_PORT)
class AppTest {

    @Autowired
    private TestRestTemplate restTemplate;

    @Test
    void helloEndpointTest() {
        String response = this.restTemplate.getForObject("/", String.class);
        assertThat(response).contains("Hi Sushma!");
    }
}
