package es.exos.masai.energy.rules;

import org.springframework.boot.test.context.TestConfiguration;
import org.springframework.boot.testcontainers.service.connection.ServiceConnection;
import org.springframework.context.annotation.Bean;
import org.testcontainers.postgresql.PostgreSQLContainer;
import org.testcontainers.utility.DockerImageName;

@TestConfiguration(proxyBeanMethods = false)
public class TestcontainersConfiguration {

	/** Debe coincidir con infra/docker-compose.yml (NFR-005); lo verifica ImageVersionConsistencyTest. */
	public static final String TIMESCALEDB_IMAGE = "timescale/timescaledb:2.26.4-pg16";

	@Bean
	@ServiceConnection
	PostgreSQLContainer timescaleContainer() {
		return new PostgreSQLContainer(
				DockerImageName.parse(TIMESCALEDB_IMAGE).asCompatibleSubstituteFor("postgres"));
	}

}
