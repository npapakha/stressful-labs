package stressful.sandbox;

import org.springframework.boot.SpringApplication;

public class TestSutSpringJdbcApplication {

    public static void main(String[] args) {
        SpringApplication.from(SutSpringJdbcApplication::main).with(TestcontainersConfiguration.class).run(args);
    }

}
