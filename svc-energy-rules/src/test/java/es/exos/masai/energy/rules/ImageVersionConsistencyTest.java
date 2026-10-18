package es.exos.masai.energy.rules;

import static org.assertj.core.api.Assertions.assertThat;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.junit.jupiter.api.Test;

/** NFR-005: los tests usan la misma imagen TimescaleDB que el entorno local. */
class ImageVersionConsistencyTest {

	private static final Path COMPOSE_FILE = Path.of("..", "infra", "docker-compose.yml");

	private static final Pattern IMAGE_LINE = Pattern.compile("(?m)^\\s*image:\\s*(timescale/timescaledb:\\S+)\\s*$");

	@Test
	void testcontainersImageMatchesDockerCompose() throws IOException {
		Matcher matcher = IMAGE_LINE.matcher(Files.readString(COMPOSE_FILE));

		assertThat(matcher.find()).as("imagen timescale/timescaledb en %s", COMPOSE_FILE).isTrue();
		assertThat(matcher.group(1)).isEqualTo(TestcontainersConfiguration.TIMESCALEDB_IMAGE);
	}

}
