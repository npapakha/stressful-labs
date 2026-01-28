package stressful.sandbox;

import org.springframework.boot.SpringApplication;

public class TestSutSpringR2dbcApplication {

    public static void main(String[] args) {
        SpringApplication.from(SutSpringR2dbcApplication::main).with(TestcontainersConfiguration.class).run(args);
    }

}
