grammar HttpRequest;

// Core rules defined in RFC 5234, appendix B.1:
// https://datatracker.ietf.org/doc/html/rfc5234#appendix-B.1
ALPHA  :              [a-zA-Z];
CR     :              [\u000D];
CRLF   :                 CR LF;
CTL    : [\u0000-\u001F\u007F];
DIGIT  :                 [0-9];
DQUOTE :                   '"';
HEXDIG :         DIGIT | [A-F];
HTAB   :              [\u0009];
LF     :              [\u000A];
OCTET  :       [\u0000-\u00FF];
SP     :              [\u0020];
VCHAR  :       [\u0021-\u007E];
WSP    :             SP | HTAB;

// URI rules defined in RFC 3986 and RFC 7230, section 2.7 - Uniform Resource Identifiers:
// https://datatracker.ietf.org/doc/html/rfc3986
// https://datatracker.ietf.org/doc/html/rfc7230#section-2.7
unreserved    :                            ALPHA | DIGIT | '-' | '.' | '_' | '~';
pct_encoded   :                                                '%' HEXDIG HEXDIG;
sub_delims    : '!' | '$' | '&' | '\'' | '(' | ')' | '*' | '+' | ',' | ';' | '=';
pchar         :                unreserved | pct_encoded | sub_delims | ':' | '@';
segment       :                                                           pchar*;
absolute_path :                                                   ('/' segment)+;
query         :                                             (pchar | '/' | '?')*;
origin_form   :                                       absolute_path ('?' query)?;

// Request header rules defined in RFC 7230, sections 2.6 and 3:
// https://datatracker.ietf.org/doc/html/rfc7230#section-2.6
// https://datatracker.ietf.org/doc/html/rfc7230#section-3
QDTEXT   : HTAB | SP | [\u0021\u0023-\u005B\u005D-\u007E] | OBS_TEXT;
OBS_TEXT : [\u0080-\u00FF];
OWS      :    (SP | HTAB)*;
RWS      :    (SP | HTAB)+;

tchar : '!' | '#' | '$' | '%' | '&' | '\''
      | '*' | '+' | '-' | '.' | '^' | '_'
      | '`' | '|' | '~' | DIGIT | ALPHA;
token      : tchar+;
method     : token;
field_name : token;

field_vchar   :                            VCHAR | OBS_TEXT;
field_content :     field_vchar ((SP | HTAB)+ field_vchar)?;
obs_fold      :                           CRLF (SP | HTAB)+;
QUOTED_PAIR   :         [\\] (HTAB | SP | VCHAR | OBS_TEXT);
quoted_string :       DQUOTE (QDTEXT | QUOTED_PAIR)* DQUOTE;
field_value   : (quoted_string | field_content | obs_fold)*;
header_field  :          field_name ':' OWS field_value OWS;

HTTP_version :                    'HTTP/' DIGIT '.' DIGIT;
request_line : method SP origin_form SP HTTP_version CRLF;
http_request :     request_line (header_field CRLF)* CRLF; // message body omitted