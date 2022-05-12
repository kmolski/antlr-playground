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
HTTP_version        : 'HTTP/' DIGIT '.' DIGIT;

// HTTP_request_header : start_line (header_field CRLF)* CRLF;