package es.exos.masai.energy.rules;

import org.springframework.boot.SpringApplication;

public class TestSvcEnergyRulesApplication {

	public static void main(String[] args) {
		SpringApplication.from(SvcEnergyRulesApplication::main).with(TestcontainersConfiguration.class).run(args);
	}

}
