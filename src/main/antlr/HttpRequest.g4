grammar HttpRequest;

METHOD       : 'GET' | 'HEAD' | 'POST' | 'PUT'
             | 'DELETE' | 'OPTIONS' | 'TRACE';
HTTP_version :        'HTTP/' DIGIT '.' DIGIT;

LOWER   : [a-z];
HEXCAPS : [A-F];
UPPER   : [A-Z];

AMP    :  '&';
AT     :  '@';
BACKT  :  '`';
BSLASH : '\\';
CARET  :  '^';
COLON  :  ':';
COMMA  :  ',';
DOLLAR :  '$';
EQUALS :  '=';
EXCLAM :  '!';
FSLASH :  '/';
HASH   :  '#';
LPAREN :  '(';
MINUS  :  '-';
PRCENT :  '%';
PERIOD :  '.';
PIPE   :  '|';
PLUS   :  '+';
QUEST  :  '?';
RPAREN :  ')';
SCOLON :  ';';
SQUOTE : '\'';
STAR   :  '*';
TILDE  :  '~';
UNDERS :  '_';

// Core rules defined in RFC 5234, appendix B.1:
// https://datatracker.ietf.org/doc/html/rfc5234#appendix-B.1
DIGIT  :     [0-9];
CR     :      '\r';
HTAB   :      '\t';
LF     :      '\n';
SP     :       ' ';
DQUOTE :       '"';
CRLF   :     CR LF;
RPRINT : [<>{}[\]];

alpha  : LOWER | HEXCAPS | UPPER;
vchar  : alpha | AMP | AT | BACKT | BSLASH | CARET | COLON | COMMA
       | DIGIT | DOLLAR | DQUOTE | EQUALS | EXCLAM | FSLASH | HASH
       | LPAREN | MINUS | PERIOD | PIPE | PLUS | PRCENT | QUEST
       | RPAREN | RPRINT | SCOLON | SQUOTE | STAR | TILDE | UNDERS;

// URI rules defined in RFC 3986 and RFC 7230, section 2.7 - Uniform Resource Identifiers:
// https://datatracker.ietf.org/doc/html/rfc3986
// https://datatracker.ietf.org/doc/html/rfc7230#section-2.7
unreserved  :      alpha | DIGIT | MINUS | PERIOD | TILDE | UNDERS;
sub_delims  :     EXCLAM | DOLLAR | AMP | SQUOTE | LPAREN | RPAREN
                           | STAR | PLUS | COMMA | SCOLON | EQUALS;
hexdig      :                                      DIGIT | HEXCAPS;
pct_encoded :                                 PRCENT hexdig hexdig;
segment     : (unreserved | sub_delims | COLON | AT | pct_encoded);

absolute_path :           (FSLASH segment*)+;
query         :  (segment | FSLASH | QUEST)*;
origin_form   : absolute_path (QUEST query)?;

// Request header rules defined in RFC 7230, section 3:
// https://datatracker.ietf.org/doc/html/rfc7230#section-3
OBS_TEXT : [\u0080-\u00FF];

qdtext      :       HTAB | SP | EXCLAM | SQUOTE | HASH | CARET
            | UNDERS | BACKT | PIPE | TILDE | LOWER | OBS_TEXT;
quoted_pair :           BSLASH (whitespace | vchar | OBS_TEXT);
tchar       :     alpha | AMP | BACKT | CARET | DIGIT | DOLLAR
            |     EXCLAM | HASH | MINUS | PERIOD | PIPE | PLUS
            |          PRCENT | SQUOTE | STAR | TILDE | UNDERS;
whitespace  :                                      (SP | HTAB);
token       :                                           tchar+;

field_name    :                                                  token;
field_vchar   :                                       vchar | OBS_TEXT;
field_content : field_vchar ((whitespace | field_vchar)+ field_vchar)?;
obs_fold      :                           whitespace* CRLF whitespace+;
quoted_string :                  DQUOTE (qdtext | quoted_pair)* DQUOTE;
field_value   :            quoted_string | (field_content | obs_fold)*;
header_field  :   field_name COLON whitespace* field_value whitespace*;

request_line : METHOD SP origin_form SP HTTP_version CRLF;
http_request :     request_line (header_field CRLF)* CRLF; // message body omitted