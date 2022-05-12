import org.antlr.v4.runtime.CharStreams;
import org.antlr.v4.runtime.CommonTokenStream;
import org.junit.jupiter.api.Test;
import pl.kmolski.antlr_playground.HttpRequestLexer;
import pl.kmolski.antlr_playground.HttpRequestParser;

import java.io.*;
import java.nio.charset.StandardCharsets;

import static org.junit.jupiter.api.Assertions.assertEquals;

public class HttpRequestParserTest {

    HttpRequestParser getParser(String filePath) throws IOException {
        var inputStream = new FileInputStream(filePath);
        var charStream = CharStreams.fromStream(inputStream, StandardCharsets.ISO_8859_1);

        var lexer = new HttpRequestLexer(charStream);
        var tokenStream = new CommonTokenStream(lexer);
        return new HttpRequestParser(tokenStream);
    }
    @Test
    void testValidPostRequest() throws IOException {
        var fileUrl = getClass().getClassLoader().getResource("post_example.http");
        var parser = getParser(fileUrl.getFile());
        var request = parser.http_request();

        assertEquals(0, parser.getNumberOfSyntaxErrors());
    }

    @Test
    void testValidGetRequest() throws IOException {
        var fileUrl = getClass().getClassLoader().getResource("get_example.http");
        var parser = getParser(fileUrl.getFile());
        var request = parser.http_request();

        assertEquals(0, parser.getNumberOfSyntaxErrors());
    }

    @Test
    void testValidGetRequest2() throws IOException {
        var fileUrl = getClass().getClassLoader().getResource("get_example2.http");
        var parser = getParser(fileUrl.getFile());
        var request = parser.http_request();

        assertEquals(0, parser.getNumberOfSyntaxErrors());
    }

    @Test
    void testValidGetRequest3() throws IOException {
        var fileUrl = getClass().getClassLoader().getResource("get_example3.http");
        var parser = getParser(fileUrl.getFile());
        var request = parser.http_request();

        assertEquals(0, parser.getNumberOfSyntaxErrors());
    }
}
