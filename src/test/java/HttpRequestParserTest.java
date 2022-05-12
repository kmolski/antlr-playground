import org.antlr.v4.runtime.CharStreams;
import org.antlr.v4.runtime.CommonTokenStream;
import org.junit.jupiter.api.Test;
import pl.kmolski.antlr_playground.HttpRequestLexer;
import pl.kmolski.antlr_playground.HttpRequestParser;

import java.io.FileInputStream;
import java.io.IOException;
import java.nio.charset.StandardCharsets;

import static org.junit.jupiter.api.Assertions.assertEquals;

public class HttpRequestParserTest {

    @Test
    void testValidPostRequest() throws IOException {
        var requestFile = getClass().getClassLoader().getResource("post_example.http").getFile();
        var inputStream = new FileInputStream(requestFile);
        var charStream = CharStreams.fromStream(inputStream, StandardCharsets.ISO_8859_1);

        var lexer = new HttpRequestLexer(charStream);
        var tokenStream = new CommonTokenStream(lexer);
        var parser = new HttpRequestParser(tokenStream);
        var request = parser.http_request();

        assertEquals(parser.getNumberOfSyntaxErrors(), 0);
    }
}
