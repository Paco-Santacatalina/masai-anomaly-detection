package es.exos.masai.energy.rules;

import static org.assertj.core.api.Assertions.assertThat;

import java.io.IOException;
import java.net.URI;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.context.annotation.Import;
import org.springframework.core.env.Environment;
import org.springframework.jdbc.core.JdbcTemplate;

/** F-001 / BLK-001: arranque contra TimescaleDB real con migraciones aplicadas (AC-001, NFR-005, NFR-006). */
@Import(TestcontainersConfiguration.class)
@SpringBootTest(webEnvironment = SpringBootTest.WebEnvironment.RANDOM_PORT)
class SchemaBootstrapTests {

	@Autowired
	private JdbcTemplate jdbc;

	@Autowired
	private Environment environment;

	@Test
	void flywayCreatesSchemaAndAppliesBaselineMigration() {
		Integer schemas = jdbc.queryForObject(
				"SELECT count(*) FROM information_schema.schemata WHERE schema_name = 't32'", Integer.class);
		Integer applied = jdbc.queryForObject(
				"SELECT count(*) FROM t32.flyway_schema_history WHERE version = '1' AND success", Integer.class);

		assertThat(schemas).isEqualTo(1);
		assertThat(applied).isEqualTo(1);
	}

	@Test
	void requiredExtensionsAreInstalled() {
		String timescale = jdbc.queryForObject(
				"SELECT extversion FROM pg_extension WHERE extname = 'timescaledb'", String.class);
		Integer btreeGist = jdbc.queryForObject(
				"SELECT count(*) FROM pg_extension WHERE extname = 'btree_gist'", Integer.class);

		assertThat(timescale).startsWith("2.26.");
		assertThat(btreeGist).isEqualTo(1);
	}

	@Test
	void sessionTimeZoneIsUtc() {
		String timeZone = jdbc.queryForObject("SHOW TIME ZONE", String.class);

		assertThat(timeZone).isEqualTo("UTC");
	}

	@Test
	void healthEndpointReportsUp() throws IOException, InterruptedException {
		String port = environment.getRequiredProperty("local.server.port");
		HttpRequest request = HttpRequest.newBuilder(URI.create("http://localhost:" + port + "/actuator/health")).GET().build();

		HttpResponse<String> response = HttpClient.newHttpClient().send(request, HttpResponse.BodyHandlers.ofString());

		assertThat(response.statusCode()).isEqualTo(200);
		assertThat(response.body()).contains("\"status\":\"UP\"");
	}

}
