lexer grammar HttpRequestLexer;
// According to RFC 5234 - https://datatracker.ietf.org/doc/html/rfc5234#appendix-B.1
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

