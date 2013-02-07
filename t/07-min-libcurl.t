#!perl
use strict;
use utf8;
use warnings qw(all);

BEGIN {
    unless ($ENV{AUTHOR_TESTING}) {
        require Test::More;
        Test::More::plan(skip_all => q(these tests are for testing by the author));
    }
}

use Test::More;

## no critic (ProhibitStringyEval, RequireCheckingReturnValueOfEval)
eval q(use PPI::Document);
plan skip_all => q(PPI required)
    if $@;

use LWP::Protocol::Net::Curl;

my %valid;
while (<DATA>) {
    chomp;
    my ($symbol, $introduced, $deprecated, $removed) = split /\s+/x;
    $valid{$symbol} = $introduced
        if defined $symbol
        and not defined $deprecated
        and not defined $removed;
}

my $doc = PPI::Document->new($INC{q{LWP/Protocol/Net/Curl.pm}});
isa_ok($doc, q(PPI::Document));

my @found =
    map { q...$_ }
    grep { /^CURL/x }
    @{$doc->find(q(PPI::Token::Word))};

my $top = '';
for my $symbol (sort @found) {
    my @version = (split(/\./x, $valid{$symbol}, 3), 0);
    my $version = sprintf q(%03d) x 3 => @version;
    $top = $version if $top lt $version;
    ok(exists $valid{$symbol}, qq($symbol $valid{$symbol}));
}

is($top, q(007010008), q(minimum: libcurl/7.10.8));

done_testing 38;

__DATA__
                                  _   _ ____  _
                              ___| | | |  _ \| |
                             / __| | | | |_) | |
                            | (__| |_| |  _ <| |___
                             \___|\___/|_| \_\_____|

 This document lists defines and other symbols present in libcurl, together
 with exact information about the first libcurl version that provides the
 symbol, the first version in which the symbol was marked as deprecated and
 for a few symbols the last version that featured it. The names appear in
 alphabetical order.

 Name                           Introduced  Deprecated  Removed

CURLAUTH_ANY                    7.10.6
CURLAUTH_ANYSAFE                7.10.6
CURLAUTH_BASIC                  7.10.6
CURLAUTH_DIGEST                 7.10.6
CURLAUTH_DIGEST_IE              7.19.3
CURLAUTH_GSSNEGOTIATE           7.10.6
CURLAUTH_NONE                   7.10.6
CURLAUTH_NTLM                   7.10.6
CURLAUTH_NTLM_WB                7.22.0
CURLAUTH_ONLY                   7.21.3
CURLCLOSEPOLICY_CALLBACK        7.7
CURLCLOSEPOLICY_LEAST_RECENTLY_USED 7.7
CURLCLOSEPOLICY_LEAST_TRAFFIC   7.7
CURLCLOSEPOLICY_NONE            7.7
CURLCLOSEPOLICY_OLDEST          7.7
CURLCLOSEPOLICY_SLOWEST         7.7
CURLE_ABORTED_BY_CALLBACK       7.1
CURLE_AGAIN                     7.18.2
CURLE_ALREADY_COMPLETE          7.7.2
CURLE_BAD_CALLING_ORDER         7.1           7.17.0
CURLE_BAD_CONTENT_ENCODING      7.10
CURLE_BAD_DOWNLOAD_RESUME       7.10
CURLE_BAD_FUNCTION_ARGUMENT     7.1
CURLE_BAD_PASSWORD_ENTERED      7.4.2         7.17.0
CURLE_CHUNK_FAILED              7.21.0
CURLE_CONV_FAILED               7.15.4
CURLE_CONV_REQD                 7.15.4
CURLE_COULDNT_CONNECT           7.1
CURLE_COULDNT_RESOLVE_HOST      7.1
CURLE_COULDNT_RESOLVE_PROXY     7.1
CURLE_FAILED_INIT               7.1
CURLE_FILESIZE_EXCEEDED         7.10.8
CURLE_FILE_COULDNT_READ_FILE    7.1
CURLE_FTP_ACCEPT_FAILED         7.24.0
CURLE_FTP_ACCEPT_TIMEOUT        7.24.0
CURLE_FTP_ACCESS_DENIED         7.1
CURLE_FTP_BAD_DOWNLOAD_RESUME   7.1           7.1
CURLE_FTP_BAD_FILE_LIST         7.21.0
CURLE_FTP_CANT_GET_HOST         7.1
CURLE_FTP_CANT_RECONNECT        7.1           7.17.0
CURLE_FTP_COULDNT_GET_SIZE      7.1           7.17.0
CURLE_FTP_COULDNT_RETR_FILE     7.1
CURLE_FTP_COULDNT_SET_ASCII     7.1           7.17.0
CURLE_FTP_COULDNT_SET_BINARY    7.1           7.17.0
CURLE_FTP_COULDNT_SET_TYPE      7.17.0
CURLE_FTP_COULDNT_STOR_FILE     7.1
CURLE_FTP_COULDNT_USE_REST      7.1
CURLE_FTP_PARTIAL_FILE          7.1           7.1
CURLE_FTP_PORT_FAILED           7.1
CURLE_FTP_PRET_FAILED           7.20.0
CURLE_FTP_QUOTE_ERROR           7.1           7.17.0
CURLE_FTP_SSL_FAILED            7.11.0        7.17.0
CURLE_FTP_USER_PASSWORD_INCORRECT 7.1         7.17.0
CURLE_FTP_WEIRD_227_FORMAT      7.1
CURLE_FTP_WEIRD_PASS_REPLY      7.1
CURLE_FTP_WEIRD_PASV_REPLY      7.1
CURLE_FTP_WEIRD_SERVER_REPLY    7.1
CURLE_FTP_WEIRD_USER_REPLY      7.1           7.17.0
CURLE_FTP_WRITE_ERROR           7.1           7.17.0
CURLE_FUNCTION_NOT_FOUND        7.1
CURLE_GOT_NOTHING               7.9.1
CURLE_HTTP_NOT_FOUND            7.1
CURLE_HTTP_PORT_FAILED          7.3           7.12.0
CURLE_HTTP_POST_ERROR           7.1
CURLE_HTTP_RANGE_ERROR          7.1           7.17.0
CURLE_HTTP_RETURNED_ERROR       7.10.3
CURLE_INTERFACE_FAILED          7.12.0
CURLE_LDAP_CANNOT_BIND          7.1
CURLE_LDAP_INVALID_URL          7.10.8
CURLE_LDAP_SEARCH_FAILED        7.1
CURLE_LIBRARY_NOT_FOUND         7.1           7.17.0
CURLE_LOGIN_DENIED              7.13.1
CURLE_MALFORMAT_USER            7.1           7.17.0
CURLE_NOT_BUILT_IN              7.21.5
CURLE_OK                        7.1
CURLE_OPERATION_TIMEDOUT        7.10.2
CURLE_OPERATION_TIMEOUTED       7.1           7.17.0
CURLE_OUT_OF_MEMORY             7.1
CURLE_PARTIAL_FILE              7.1
CURLE_PEER_FAILED_VERIFICATION  7.17.1
CURLE_QUOTE_ERROR               7.17.0
CURLE_RANGE_ERROR               7.17.0
CURLE_READ_ERROR                7.1
CURLE_RECV_ERROR                7.10
CURLE_REMOTE_ACCESS_DENIED      7.17.0
CURLE_REMOTE_DISK_FULL          7.17.0
CURLE_REMOTE_FILE_EXISTS        7.17.0
CURLE_REMOTE_FILE_NOT_FOUND     7.16.1
CURLE_RTSP_CSEQ_ERROR           7.20.0
CURLE_RTSP_SESSION_ERROR        7.20.0
CURLE_SEND_ERROR                7.10
CURLE_SEND_FAIL_REWIND          7.12.3
CURLE_SHARE_IN_USE              7.9.6         7.17.0
CURLE_SSH                       7.16.1
CURLE_SSL_CACERT                7.10
CURLE_SSL_CACERT_BADFILE        7.16.0
CURLE_SSL_CERTPROBLEM           7.10
CURLE_SSL_CIPHER                7.10
CURLE_SSL_CONNECT_ERROR         7.1
CURLE_SSL_CRL_BADFILE           7.19.0
CURLE_SSL_ENGINE_INITFAILED     7.12.3
CURLE_SSL_ENGINE_NOTFOUND       7.9.3
CURLE_SSL_ENGINE_SETFAILED      7.9.3
CURLE_SSL_ISSUER_ERROR          7.19.0
CURLE_SSL_PEER_CERTIFICATE      7.8           7.17.1
CURLE_SSL_SHUTDOWN_FAILED       7.16.1
CURLE_TELNET_OPTION_SYNTAX      7.7
CURLE_TFTP_DISKFULL             7.15.0        7.17.0
CURLE_TFTP_EXISTS               7.15.0        7.17.0
CURLE_TFTP_ILLEGAL              7.15.0
CURLE_TFTP_NOSUCHUSER           7.15.0
CURLE_TFTP_NOTFOUND             7.15.0
CURLE_TFTP_PERM                 7.15.0
CURLE_TFTP_UNKNOWNID            7.15.0
CURLE_TOO_MANY_REDIRECTS        7.5
CURLE_UNKNOWN_OPTION            7.21.5
CURLE_UNKNOWN_TELNET_OPTION     7.7
CURLE_UNSUPPORTED_PROTOCOL      7.1
CURLE_UPLOAD_FAILED             7.16.3
CURLE_URL_MALFORMAT             7.1
CURLE_URL_MALFORMAT_USER        7.1           7.17.0
CURLE_USE_SSL_FAILED            7.17.0
CURLE_WRITE_ERROR               7.1
CURLFILETYPE_DEVICE_BLOCK       7.21.0
CURLFILETYPE_DEVICE_CHAR        7.21.0
CURLFILETYPE_DIRECTORY          7.21.0
CURLFILETYPE_DOOR               7.21.0
CURLFILETYPE_FILE               7.21.0
CURLFILETYPE_NAMEDPIPE          7.21.0
CURLFILETYPE_SOCKET             7.21.0
CURLFILETYPE_SYMLINK            7.21.0
CURLFILETYPE_UNKNOWN            7.21.0
CURLFINFOFLAG_KNOWN_FILENAME    7.21.0
CURLFINFOFLAG_KNOWN_FILETYPE    7.21.0
CURLFINFOFLAG_KNOWN_GID         7.21.0
CURLFINFOFLAG_KNOWN_HLINKCOUNT  7.21.0
CURLFINFOFLAG_KNOWN_PERM        7.21.0
CURLFINFOFLAG_KNOWN_SIZE        7.21.0
CURLFINFOFLAG_KNOWN_TIME        7.21.0
CURLFINFOFLAG_KNOWN_UID         7.21.0
CURLFORM_ARRAY                  7.9.1
CURLFORM_ARRAY_END              7.9.1         7.9.5       7.9.6
CURLFORM_ARRAY_START            7.9.1         7.9.5       7.9.6
CURLFORM_BUFFER                 7.9.8
CURLFORM_BUFFERLENGTH           7.9.8
CURLFORM_BUFFERPTR              7.9.8
CURLFORM_CONTENTHEADER          7.9.3
CURLFORM_CONTENTSLENGTH         7.9
CURLFORM_CONTENTTYPE            7.9
CURLFORM_COPYCONTENTS           7.9
CURLFORM_COPYNAME               7.9
CURLFORM_END                    7.9
CURLFORM_FILE                   7.9
CURLFORM_FILECONTENT            7.9.1
CURLFORM_FILENAME               7.9.6
CURLFORM_NAMELENGTH             7.9
CURLFORM_NOTHING                7.9
CURLFORM_PTRCONTENTS            7.9
CURLFORM_PTRNAME                7.9
CURLFORM_STREAM                 7.18.2
CURLFTPAUTH_DEFAULT             7.12.2
CURLFTPAUTH_SSL                 7.12.2
CURLFTPAUTH_TLS                 7.12.2
CURLFTPMETHOD_DEFAULT           7.15.3
CURLFTPMETHOD_MULTICWD          7.15.3
CURLFTPMETHOD_NOCWD             7.15.3
CURLFTPMETHOD_SINGLECWD         7.15.3
CURLFTPSSL_ALL                  7.11.0        7.17.0
CURLFTPSSL_CCC_ACTIVE           7.16.2
CURLFTPSSL_CCC_NONE             7.16.2
CURLFTPSSL_CCC_PASSIVE          7.16.1
CURLFTPSSL_CONTROL              7.11.0        7.17.0
CURLFTPSSL_NONE                 7.11.0        7.17.0
CURLFTPSSL_TRY                  7.11.0        7.17.0
CURLFTP_CREATE_DIR              7.19.4
CURLFTP_CREATE_DIR_NONE         7.19.4
CURLFTP_CREATE_DIR_RETRY        7.19.4
CURLGSSAPI_DELEGATION_FLAG      7.22.0
CURLGSSAPI_DELEGATION_NONE      7.22.0
CURLGSSAPI_DELEGATION_POLICY_FLAG 7.22.0
CURLINFO_APPCONNECT_TIME        7.19.0
CURLINFO_CERTINFO               7.19.1
CURLINFO_CONDITION_UNMET        7.19.4
CURLINFO_CONNECT_TIME           7.4.1
CURLINFO_CONTENT_LENGTH_DOWNLOAD 7.6.1
CURLINFO_CONTENT_LENGTH_UPLOAD  7.6.1
CURLINFO_CONTENT_TYPE           7.9.4
CURLINFO_COOKIELIST             7.14.1
CURLINFO_DATA_IN                7.9.6
CURLINFO_DATA_OUT               7.9.6
CURLINFO_DOUBLE                 7.4.1
CURLINFO_EFFECTIVE_URL          7.4
CURLINFO_END                    7.9.6
CURLINFO_FILETIME               7.5
CURLINFO_FTP_ENTRY_PATH         7.15.4
CURLINFO_HEADER_IN              7.9.6
CURLINFO_HEADER_OUT             7.9.6
CURLINFO_HEADER_SIZE            7.4.1
CURLINFO_HTTPAUTH_AVAIL         7.10.8
CURLINFO_HTTP_CODE              7.4.1         7.10.8
CURLINFO_HTTP_CONNECTCODE       7.10.7
CURLINFO_LASTONE                7.4.1
CURLINFO_LASTSOCKET             7.15.2
CURLINFO_LOCAL_IP               7.21.0
CURLINFO_LOCAL_PORT             7.21.0
CURLINFO_LONG                   7.4.1
CURLINFO_MASK                   7.4.1
CURLINFO_NAMELOOKUP_TIME        7.4.1
CURLINFO_NONE                   7.4.1
CURLINFO_NUM_CONNECTS           7.12.3
CURLINFO_OS_ERRNO               7.12.2
CURLINFO_PRETRANSFER_TIME       7.4.1
CURLINFO_PRIMARY_IP             7.19.0
CURLINFO_PRIMARY_PORT           7.21.0
CURLINFO_PRIVATE                7.10.3
CURLINFO_PROXYAUTH_AVAIL        7.10.8
CURLINFO_REDIRECT_COUNT         7.9.7
CURLINFO_REDIRECT_TIME          7.9.7
CURLINFO_REDIRECT_URL           7.18.2
CURLINFO_REQUEST_SIZE           7.4.1
CURLINFO_RESPONSE_CODE          7.10.8
CURLINFO_RTSP_CLIENT_CSEQ       7.20.0
CURLINFO_RTSP_CSEQ_RECV         7.20.0
CURLINFO_RTSP_SERVER_CSEQ       7.20.0
CURLINFO_RTSP_SESSION_ID        7.20.0
CURLINFO_SIZE_DOWNLOAD          7.4.1
CURLINFO_SIZE_UPLOAD            7.4.1
CURLINFO_SLIST                  7.12.3
CURLINFO_SPEED_DOWNLOAD         7.4.1
CURLINFO_SPEED_UPLOAD           7.4.1
CURLINFO_SSL_DATA_IN            7.12.1
CURLINFO_SSL_DATA_OUT           7.12.1
CURLINFO_SSL_ENGINES            7.12.3
CURLINFO_SSL_VERIFYRESULT       7.5
CURLINFO_STARTTRANSFER_TIME     7.9.2
CURLINFO_STRING                 7.4.1
CURLINFO_TEXT                   7.9.6
CURLINFO_TOTAL_TIME             7.4.1
CURLINFO_TYPEMASK               7.4.1
CURLIOCMD_NOP                   7.12.3
CURLIOCMD_RESTARTREAD           7.12.3
CURLIOE_FAILRESTART             7.12.3
CURLIOE_OK                      7.12.3
CURLIOE_UNKNOWNCMD              7.12.3
CURLKHMATCH_MISMATCH            7.19.6
CURLKHMATCH_MISSING             7.19.6
CURLKHMATCH_OK                  7.19.6
CURLKHSTAT_DEFER                7.19.6
CURLKHSTAT_FINE                 7.19.6
CURLKHSTAT_FINE_ADD_TO_FILE     7.19.6
CURLKHSTAT_REJECT               7.19.6
CURLKHTYPE_DSS                  7.19.6
CURLKHTYPE_RSA                  7.19.6
CURLKHTYPE_RSA1                 7.19.6
CURLKHTYPE_UNKNOWN              7.19.6
CURLMOPT_MAXCONNECTS            7.16.3
CURLMOPT_PIPELINING             7.16.0
CURLMOPT_SOCKETDATA             7.15.4
CURLMOPT_SOCKETFUNCTION         7.15.4
CURLMOPT_TIMERDATA              7.16.0
CURLMOPT_TIMERFUNCTION          7.16.0
CURLMSG_DONE                    7.9.6
CURLMSG_NONE                    7.9.6
CURLM_BAD_EASY_HANDLE           7.9.6
CURLM_BAD_HANDLE                7.9.6
CURLM_BAD_SOCKET                7.15.4
CURLM_CALL_MULTI_PERFORM        7.9.6
CURLM_CALL_MULTI_SOCKET         7.15.5
CURLM_INTERNAL_ERROR            7.9.6
CURLM_OK                        7.9.6
CURLM_OUT_OF_MEMORY             7.9.6
CURLM_UNKNOWN_OPTION            7.15.4
CURLOPTTYPE_FUNCTIONPOINT       7.1
CURLOPTTYPE_LONG                7.1
CURLOPTTYPE_OBJECTPOINT         7.1
CURLOPTTYPE_OFF_T               7.11.0
CURLOPT_ACCEPTTIMEOUT_MS        7.24.0
CURLOPT_ACCEPT_ENCODING         7.21.6
CURLOPT_ADDRESS_SCOPE           7.19.0
CURLOPT_APPEND                  7.17.0
CURLOPT_AUTOREFERER             7.1
CURLOPT_BUFFERSIZE              7.10
CURLOPT_CAINFO                  7.4.2
CURLOPT_CAPATH                  7.9.8
CURLOPT_CERTINFO                7.19.1
CURLOPT_CHUNK_BGN_FUNCTION      7.21.0
CURLOPT_CHUNK_DATA              7.21.0
CURLOPT_CHUNK_END_FUNCTION      7.21.0
CURLOPT_CLOSEFUNCTION           7.7           7.11.1      7.15.5
CURLOPT_CLOSEPOLICY             7.7           7.16.1
CURLOPT_CLOSESOCKETDATA         7.21.7
CURLOPT_CLOSESOCKETFUNCTION     7.21.7
CURLOPT_CONNECTTIMEOUT          7.7
CURLOPT_CONNECTTIMEOUT_MS       7.16.2
CURLOPT_CONNECT_ONLY            7.15.2
CURLOPT_CONV_FROM_NETWORK_FUNCTION 7.15.4
CURLOPT_CONV_FROM_UTF8_FUNCTION 7.15.4
CURLOPT_CONV_TO_NETWORK_FUNCTION 7.15.4
CURLOPT_COOKIE                  7.1
CURLOPT_COOKIEFILE              7.1
CURLOPT_COOKIEJAR               7.9
CURLOPT_COOKIELIST              7.14.1
CURLOPT_COOKIESESSION           7.9.7
CURLOPT_COPYPOSTFIELDS          7.17.1
CURLOPT_CRLF                    7.1
CURLOPT_CRLFILE                 7.19.0
CURLOPT_CUSTOMREQUEST           7.1
CURLOPT_DEBUGDATA               7.9.6
CURLOPT_DEBUGFUNCTION           7.9.6
CURLOPT_DIRLISTONLY             7.17.0
CURLOPT_DNS_CACHE_TIMEOUT       7.9.3
CURLOPT_DNS_SERVERS             7.24.0
CURLOPT_DNS_USE_GLOBAL_CACHE    7.9.3         7.11.1
CURLOPT_EGDSOCKET               7.7
CURLOPT_ENCODING                7.10
CURLOPT_ERRORBUFFER             7.1
CURLOPT_FAILONERROR             7.1
CURLOPT_FILE                    7.1           7.9.7
CURLOPT_FILETIME                7.5
CURLOPT_FNMATCH_DATA            7.21.0
CURLOPT_FNMATCH_FUNCTION        7.21.0
CURLOPT_FOLLOWLOCATION          7.1
CURLOPT_FORBID_REUSE            7.7
CURLOPT_FRESH_CONNECT           7.7
CURLOPT_FTPAPPEND               7.1           7.16.4
CURLOPT_FTPASCII                7.1           7.11.1      7.15.5
CURLOPT_FTPLISTONLY             7.1           7.16.4
CURLOPT_FTPPORT                 7.1
CURLOPT_FTPSSLAUTH              7.12.2
CURLOPT_FTP_ACCOUNT             7.13.0
CURLOPT_FTP_ALTERNATIVE_TO_USER 7.15.5
CURLOPT_FTP_CREATE_MISSING_DIRS 7.10.7
CURLOPT_FTP_FILEMETHOD          7.15.1
CURLOPT_FTP_RESPONSE_TIMEOUT    7.10.8
CURLOPT_FTP_SKIP_PASV_IP        7.15.0
CURLOPT_FTP_SSL                 7.11.0        7.16.4
CURLOPT_FTP_SSL_CCC             7.16.1
CURLOPT_FTP_USE_EPRT            7.10.5
CURLOPT_FTP_USE_EPSV            7.9.2
CURLOPT_FTP_USE_PRET            7.20.0
CURLOPT_GSSAPI_DELEGATION       7.22.0
CURLOPT_HEADER                  7.1
CURLOPT_HEADERDATA              7.10
CURLOPT_HEADERFUNCTION          7.7.2
CURLOPT_HTTP200ALIASES          7.10.3
CURLOPT_HTTPAUTH                7.10.6
CURLOPT_HTTPGET                 7.8.1
CURLOPT_HTTPHEADER              7.1
CURLOPT_HTTPPOST                7.1
CURLOPT_HTTPPROXYTUNNEL         7.3
CURLOPT_HTTPREQUEST             7.1           -           7.15.5
CURLOPT_HTTP_CONTENT_DECODING   7.16.2
CURLOPT_HTTP_TRANSFER_DECODING  7.16.2
CURLOPT_HTTP_VERSION            7.9.1
CURLOPT_IGNORE_CONTENT_LENGTH   7.14.1
CURLOPT_INFILE                  7.1           7.9.7
CURLOPT_INFILESIZE              7.1
CURLOPT_INFILESIZE_LARGE        7.11.0
CURLOPT_INTERFACE               7.3
CURLOPT_INTERLEAVEDATA          7.20.0
CURLOPT_INTERLEAVEFUNCTION      7.20.0
CURLOPT_IOCTLDATA               7.12.3
CURLOPT_IOCTLFUNCTION           7.12.3
CURLOPT_IPRESOLVE               7.10.8
CURLOPT_ISSUERCERT              7.19.0
CURLOPT_KEYPASSWD               7.17.0
CURLOPT_KRB4LEVEL               7.3           7.17.0
CURLOPT_KRBLEVEL                7.16.4
CURLOPT_LOCALPORT               7.15.2
CURLOPT_LOCALPORTRANGE          7.15.2
CURLOPT_LOW_SPEED_LIMIT         7.1
CURLOPT_LOW_SPEED_TIME          7.1
CURLOPT_MAIL_AUTH               7.25.0
CURLOPT_MAIL_FROM               7.20.0
CURLOPT_MAIL_RCPT               7.20.0
CURLOPT_MAXCONNECTS             7.7
CURLOPT_MAXFILESIZE             7.10.8
CURLOPT_MAXFILESIZE_LARGE       7.11.0
CURLOPT_MAXREDIRS               7.5
CURLOPT_MAX_RECV_SPEED_LARGE    7.15.5
CURLOPT_MAX_SEND_SPEED_LARGE    7.15.5
CURLOPT_MUTE                    7.1           7.8         7.15.5
CURLOPT_NETRC                   7.1
CURLOPT_NETRC_FILE              7.11.0
CURLOPT_NEW_DIRECTORY_PERMS     7.16.4
CURLOPT_NEW_FILE_PERMS          7.16.4
CURLOPT_NOBODY                  7.1
CURLOPT_NOPROGRESS              7.1
CURLOPT_NOPROXY                 7.19.4
CURLOPT_NOSIGNAL                7.10
CURLOPT_NOTHING                 7.1.1         7.11.1      7.11.0
CURLOPT_OPENSOCKETDATA          7.17.1
CURLOPT_OPENSOCKETFUNCTION      7.17.1
CURLOPT_PASSWDDATA              7.4.2         7.11.1      7.15.5
CURLOPT_PASSWDFUNCTION          7.4.2         7.11.1      7.15.5
CURLOPT_PASSWORD                7.19.1
CURLOPT_PASV_HOST               7.12.1        7.16.0      7.15.5
CURLOPT_PORT                    7.1
CURLOPT_POST                    7.1
CURLOPT_POST301                 7.17.1        7.19.1
CURLOPT_POSTFIELDS              7.1
CURLOPT_POSTFIELDSIZE           7.2
CURLOPT_POSTFIELDSIZE_LARGE     7.11.1
CURLOPT_POSTQUOTE               7.1
CURLOPT_POSTREDIR               7.19.1
CURLOPT_PREQUOTE                7.9.5
CURLOPT_PRIVATE                 7.10.3
CURLOPT_PROGRESSDATA            7.1
CURLOPT_PROGRESSFUNCTION        7.1
CURLOPT_PROTOCOLS               7.19.4
CURLOPT_PROXY                   7.1
CURLOPT_PROXYAUTH               7.10.7
CURLOPT_PROXYPASSWORD           7.19.1
CURLOPT_PROXYPORT               7.1
CURLOPT_PROXYTYPE               7.10
CURLOPT_PROXYUSERNAME           7.19.1
CURLOPT_PROXYUSERPWD            7.1
CURLOPT_PROXY_TRANSFER_MODE     7.18.0
CURLOPT_PUT                     7.1
CURLOPT_QUOTE                   7.1
CURLOPT_RANDOM_FILE             7.7
CURLOPT_RANGE                   7.1
CURLOPT_READDATA                7.9.7
CURLOPT_READFUNCTION            7.1
CURLOPT_REDIR_PROTOCOLS         7.19.4
CURLOPT_REFERER                 7.1
CURLOPT_RESOLVE                 7.21.3
CURLOPT_RESUME_FROM             7.1
CURLOPT_RESUME_FROM_LARGE       7.11.0
CURLOPT_RTSPHEADER              7.20.0
CURLOPT_RTSP_CLIENT_CSEQ        7.20.0
CURLOPT_RTSP_REQUEST            7.20.0
CURLOPT_RTSP_SERVER_CSEQ        7.20.0
CURLOPT_RTSP_SESSION_ID         7.20.0
CURLOPT_RTSP_STREAM_URI         7.20.0
CURLOPT_RTSP_TRANSPORT          7.20.0
CURLOPT_SEEKDATA                7.18.0
CURLOPT_SEEKFUNCTION            7.18.0
CURLOPT_SERVER_RESPONSE_TIMEOUT 7.20.0
CURLOPT_SHARE                   7.10
CURLOPT_SOCKOPTDATA             7.16.0
CURLOPT_SOCKOPTFUNCTION         7.16.0
CURLOPT_SOCKS5_GSSAPI_NEC       7.19.4
CURLOPT_SOCKS5_GSSAPI_SERVICE   7.19.4
CURLOPT_SOURCE_HOST             7.12.1        -           7.15.5
CURLOPT_SOURCE_PATH             7.12.1        -           7.15.5
CURLOPT_SOURCE_PORT             7.12.1        -           7.15.5
CURLOPT_SOURCE_POSTQUOTE        7.12.1        -           7.15.5
CURLOPT_SOURCE_PREQUOTE         7.12.1        -           7.15.5
CURLOPT_SOURCE_QUOTE            7.13.0        -           7.15.5
CURLOPT_SOURCE_URL              7.13.0        -           7.15.5
CURLOPT_SOURCE_USERPWD          7.12.1        -           7.15.5
CURLOPT_SSH_AUTH_TYPES          7.16.1
CURLOPT_SSH_HOST_PUBLIC_KEY_MD5 7.17.1
CURLOPT_SSH_KEYDATA             7.19.6
CURLOPT_SSH_KEYFUNCTION         7.19.6
CURLOPT_SSH_KNOWNHOSTS          7.19.6
CURLOPT_SSH_PRIVATE_KEYFILE     7.16.1
CURLOPT_SSH_PUBLIC_KEYFILE      7.16.1
CURLOPT_SSLCERT                 7.1
CURLOPT_SSLCERTPASSWD           7.1.1         7.17.0
CURLOPT_SSLCERTTYPE             7.9.3
CURLOPT_SSLENGINE               7.9.3
CURLOPT_SSLENGINE_DEFAULT       7.9.3
CURLOPT_SSLKEY                  7.9.3
CURLOPT_SSLKEYPASSWD            7.9.3         7.17.0
CURLOPT_SSLKEYTYPE              7.9.3
CURLOPT_SSLVERSION              7.1
CURLOPT_SSL_CIPHER_LIST         7.9
CURLOPT_SSL_CTX_DATA            7.10.6
CURLOPT_SSL_CTX_FUNCTION        7.10.6
CURLOPT_SSL_OPTIONS             7.25.0
CURLOPT_SSL_SESSIONID_CACHE     7.16.0
CURLOPT_SSL_VERIFYHOST          7.8.1
CURLOPT_SSL_VERIFYPEER          7.4.2
CURLOPT_STDERR                  7.1
CURLOPT_TCP_KEEPALIVE           7.25.0
CURLOPT_TCP_KEEPIDLE            7.25.0
CURLOPT_TCP_KEEPINTVL           7.25.0
CURLOPT_TCP_NODELAY             7.11.2
CURLOPT_TELNETOPTIONS           7.7
CURLOPT_TFTP_BLKSIZE            7.19.4
CURLOPT_TIMECONDITION           7.1
CURLOPT_TIMEOUT                 7.1
CURLOPT_TIMEOUT_MS              7.16.2
CURLOPT_TIMEVALUE               7.1
CURLOPT_TLSAUTH_PASSWORD        7.21.4
CURLOPT_TLSAUTH_TYPE            7.21.4
CURLOPT_TLSAUTH_USERNAME        7.21.4
CURLOPT_TRANSFERTEXT            7.1.1
CURLOPT_TRANSFER_ENCODING       7.21.6
CURLOPT_UNRESTRICTED_AUTH       7.10.4
CURLOPT_UPLOAD                  7.1
CURLOPT_URL                     7.1
CURLOPT_USERAGENT               7.1
CURLOPT_USERNAME                7.19.1
CURLOPT_USERPWD                 7.1
CURLOPT_USE_SSL                 7.17.0
CURLOPT_VERBOSE                 7.1
CURLOPT_WILDCARDMATCH           7.21.0
CURLOPT_WRITEDATA               7.9.7
CURLOPT_WRITEFUNCTION           7.1
CURLOPT_WRITEHEADER             7.1
CURLOPT_WRITEINFO               7.1
CURLPAUSE_ALL                   7.18.0
CURLPAUSE_CONT                  7.18.0
CURLPAUSE_RECV                  7.18.0
CURLPAUSE_RECV_CONT             7.18.0
CURLPAUSE_SEND                  7.18.0
CURLPAUSE_SEND_CONT             7.18.0
CURLPROTO_ALL                   7.19.4
CURLPROTO_DICT                  7.19.4
CURLPROTO_FILE                  7.19.4
CURLPROTO_FTP                   7.19.4
CURLPROTO_FTPS                  7.19.4
CURLPROTO_GOPHER                7.21.2
CURLPROTO_HTTP                  7.19.4
CURLPROTO_HTTPS                 7.19.4
CURLPROTO_IMAP                  7.20.0
CURLPROTO_IMAPS                 7.20.0
CURLPROTO_LDAP                  7.19.4
CURLPROTO_LDAPS                 7.19.4
CURLPROTO_POP3                  7.20.0
CURLPROTO_POP3S                 7.20.0
CURLPROTO_RTMP                  7.21.0
CURLPROTO_RTMPE                 7.21.0
CURLPROTO_RTMPS                 7.21.0
CURLPROTO_RTMPT                 7.21.0
CURLPROTO_RTMPTE                7.21.0
CURLPROTO_RTMPTS                7.21.0
CURLPROTO_RTSP                  7.20.0
CURLPROTO_SCP                   7.19.4
CURLPROTO_SFTP                  7.19.4
CURLPROTO_SMTP                  7.20.0
CURLPROTO_SMTPS                 7.20.0
CURLPROTO_TELNET                7.19.4
CURLPROTO_TFTP                  7.19.4
CURLPROXY_HTTP                  7.10
CURLPROXY_HTTP_1_0              7.19.4
CURLPROXY_SOCKS4                7.10
CURLPROXY_SOCKS4A               7.18.0
CURLPROXY_SOCKS5                7.10
CURLPROXY_SOCKS5_HOSTNAME       7.18.0
CURLSHE_BAD_OPTION              7.10.3
CURLSHE_INVALID                 7.10.3
CURLSHE_IN_USE                  7.10.3
CURLSHE_NOMEM                   7.12.0
CURLSHE_NOT_BUILT_IN            7.23.0
CURLSHE_OK                      7.10.3
CURLSHOPT_LOCKFUNC              7.10.3
CURLSHOPT_NONE                  7.10.3
CURLSHOPT_SHARE                 7.10.3
CURLSHOPT_UNLOCKFUNC            7.10.3
CURLSHOPT_UNSHARE               7.10.3
CURLSHOPT_USERDATA              7.10.3
CURLSOCKTYPE_ACCEPT             7.28.0
CURLSOCKTYPE_IPCXN              7.16.0
CURLSSH_AUTH_AGENT              7.28.0
CURLSSH_AUTH_ANY                7.16.1
CURLSSH_AUTH_DEFAULT            7.16.1
CURLSSH_AUTH_HOST               7.16.1
CURLSSH_AUTH_KEYBOARD           7.16.1
CURLSSH_AUTH_NONE               7.16.1
CURLSSH_AUTH_PASSWORD           7.16.1
CURLSSH_AUTH_PUBLICKEY          7.16.1
CURLSSLOPT_ALLOW_BEAST          7.25.0
CURLUSESSL_ALL                  7.17.0
CURLUSESSL_CONTROL              7.17.0
CURLUSESSL_NONE                 7.17.0
CURLUSESSL_TRY                  7.17.0
CURLVERSION_FIRST               7.10
CURLVERSION_FOURTH              7.16.1
CURLVERSION_NOW                 7.10
CURLVERSION_SECOND              7.11.1
CURLVERSION_THIRD               7.12.0
CURL_CHUNK_BGN_FUNC_FAIL        7.21.0
CURL_CHUNK_BGN_FUNC_OK          7.21.0
CURL_CHUNK_BGN_FUNC_SKIP        7.21.0
CURL_CHUNK_END_FUNC_FAIL        7.21.0
CURL_CHUNK_END_FUNC_OK          7.21.0
CURL_CSELECT_ERR                7.16.3
CURL_CSELECT_IN                 7.16.3
CURL_CSELECT_OUT                7.16.3
CURL_EASY_NONE                  7.14.0        -           7.15.4
CURL_EASY_TIMEOUT               7.14.0        -           7.15.4
CURL_ERROR_SIZE                 7.1
CURL_FNMATCHFUNC_FAIL           7.21.0
CURL_FNMATCHFUNC_MATCH          7.21.0
CURL_FNMATCHFUNC_NOMATCH        7.21.0
CURL_FORMADD_DISABLED           7.12.1
CURL_FORMADD_ILLEGAL_ARRAY      7.9.8
CURL_FORMADD_INCOMPLETE         7.9.8
CURL_FORMADD_MEMORY             7.9.8
CURL_FORMADD_NULL               7.9.8
CURL_FORMADD_OK                 7.9.8
CURL_FORMADD_OPTION_TWICE       7.9.8
CURL_FORMADD_UNKNOWN_OPTION     7.9.8
CURL_GLOBAL_ALL                 7.8
CURL_GLOBAL_DEFAULT             7.8
CURL_GLOBAL_NOTHING             7.8
CURL_GLOBAL_SSL                 7.8
CURL_GLOBAL_WIN32               7.8.1
CURL_HTTP_VERSION_1_0           7.9.1
CURL_HTTP_VERSION_1_1           7.9.1
CURL_HTTP_VERSION_NONE          7.9.1
CURL_IPRESOLVE_V4               7.10.8
CURL_IPRESOLVE_V6               7.10.8
CURL_IPRESOLVE_WHATEVER         7.10.8
CURL_LOCK_ACCESS_NONE           7.10.3
CURL_LOCK_ACCESS_SHARED         7.10.3
CURL_LOCK_ACCESS_SINGLE         7.10.3
CURL_LOCK_DATA_CONNECT          7.10.3
CURL_LOCK_DATA_COOKIE           7.10.3
CURL_LOCK_DATA_DNS              7.10.3
CURL_LOCK_DATA_NONE             7.10.3
CURL_LOCK_DATA_SHARE            7.10.4
CURL_LOCK_DATA_SSL_SESSION      7.10.3
CURL_LOCK_TYPE_CONNECT          7.10          -           7.10.2
CURL_LOCK_TYPE_COOKIE           7.10          -           7.10.2
CURL_LOCK_TYPE_DNS              7.10          -           7.10.2
CURL_LOCK_TYPE_NONE             7.10          -           7.10.2
CURL_LOCK_TYPE_SSL_SESSION      7.10          -           7.10.2
CURL_MAX_HTTP_HEADER            7.19.7
CURL_MAX_WRITE_SIZE             7.9.7
CURL_NETRC_IGNORED              7.9.8
CURL_NETRC_OPTIONAL             7.9.8
CURL_NETRC_REQUIRED             7.9.8
CURL_POLL_IN                    7.14.0
CURL_POLL_INOUT                 7.14.0
CURL_POLL_NONE                  7.14.0
CURL_POLL_OUT                   7.14.0
CURL_POLL_REMOVE                7.14.0
CURL_PROGRESS_BAR               7.1.1         -           7.4.1
CURL_PROGRESS_STATS             7.1.1         -           7.4.1
CURL_READFUNC_ABORT             7.12.1
CURL_READFUNC_PAUSE             7.18.0
CURL_REDIR_GET_ALL              7.19.1
CURL_REDIR_POST_301             7.19.1
CURL_REDIR_POST_302             7.19.1
CURL_REDIR_POST_303             7.25.1
CURL_REDIR_POST_ALL             7.19.1
CURL_RTSPREQ_ANNOUNCE           7.20.0
CURL_RTSPREQ_DESCRIBE           7.20.0
CURL_RTSPREQ_GET_PARAMETER      7.20.0
CURL_RTSPREQ_NONE               7.20.0
CURL_RTSPREQ_OPTIONS            7.20.0
CURL_RTSPREQ_PAUSE              7.20.0
CURL_RTSPREQ_PLAY               7.20.0
CURL_RTSPREQ_RECEIVE            7.20.0
CURL_RTSPREQ_RECORD             7.20.0
CURL_RTSPREQ_SETUP              7.20.0
CURL_RTSPREQ_SET_PARAMETER      7.20.0
CURL_RTSPREQ_TEARDOWN           7.20.0
CURL_SEEKFUNC_CANTSEEK          7.19.5
CURL_SEEKFUNC_FAIL              7.19.5
CURL_SEEKFUNC_OK                7.19.5
CURL_SOCKET_BAD                 7.14.0
CURL_SOCKET_TIMEOUT             7.14.0
CURL_SOCKOPT_ALREADY_CONNECTED  7.21.5
CURL_SOCKOPT_ERROR              7.21.5
CURL_SOCKOPT_OK                 7.21.5
CURL_SSLVERSION_DEFAULT         7.9.2
CURL_SSLVERSION_SSLv2           7.9.2
CURL_SSLVERSION_SSLv3           7.9.2
CURL_SSLVERSION_TLSv1           7.9.2
CURL_TIMECOND_IFMODSINCE        7.9.7
CURL_TIMECOND_IFUNMODSINCE      7.9.7
CURL_TIMECOND_LASTMOD           7.9.7
CURL_TIMECOND_NONE              7.9.7
CURL_TLSAUTH_NONE               7.21.4
CURL_TLSAUTH_SRP                7.21.4
CURL_VERSION_ASYNCHDNS          7.10.7
CURL_VERSION_CONV               7.15.4
CURL_VERSION_CURLDEBUG          7.19.6
CURL_VERSION_DEBUG              7.10.6
CURL_VERSION_GSSNEGOTIATE       7.10.6
CURL_VERSION_IDN                7.12.0
CURL_VERSION_IPV6               7.10
CURL_VERSION_KERBEROS4          7.10
CURL_VERSION_LARGEFILE          7.11.1
CURL_VERSION_LIBZ               7.10
CURL_VERSION_NTLM               7.10.6
CURL_VERSION_NTLM_WB            7.22.0
CURL_VERSION_SPNEGO             7.10.8
CURL_VERSION_SSL                7.10
CURL_VERSION_SSPI               7.13.2
CURL_VERSION_TLSAUTH_SRP        7.21.4
CURL_WAIT_POLLIN                7.28.0
CURL_WAIT_POLLOUT               7.28.0
CURL_WAIT_POLLPRI               7.28.0
CURL_WRITEFUNC_PAUSE            7.18.0
