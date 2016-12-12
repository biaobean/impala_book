| Flag | 类型 | 说明 | 缺省值 |
| :--- | :--- | :--- | :--- |
| scratch_dirs  | string | Writable scratch directories | /tmp |
| pick_only_leaders_for_tests  | bool | Whether to pick only leader replicas, for tests purposes only. | FALSE |
| convert_legacy_hive_parquet_utc_timestamps  | bool | When true, TIMESTAMPs read from files written by Parquet-MR (used by Hive) will be converted from UTC to local time. Writes are unaffected. | FALSE |
| use_local_tz_for_unix_timestamp_conversions  | bool | When true, TIMESTAMPs are interpreted in the local time zone when converting to and from Unix times. When false, TIMESTAMPs are interpreted in the UTC time zone. Set to true for Hive compatibility. | FALSE |
| webserver_x_frame_options  | string | webserver will add X-Frame-Options HTTP header with this value | DENY |
| use_statestore  | bool | Use an external statestore process to manage cluster membership | TRUE |
| krb5_debug_file  | string | Turn on Kerberos debugging and output to this file |  |
| kudu_operation_timeout_ms  | int32 | Timeout (milliseconds) set for all Kudu operations. This must be a positive value, and there is no way to disable timeouts. | 180000 |
| ldap_uri  | string | The URI of the LDAP server to authenticate users against |  |
| idle_session_timeout  | int32 | The time, in seconds, that a session may be idle for before it is closed (and all running queries cancelled) by Impala. If 0, idle sessions are never expired. | 0 |
| idle_query_timeout  | int32 | The time, in seconds, that a query may be idle for (i.e. no processing work is done and no updates are received from the client) before it is cancelled. If 0, idle queries are never expired. The query option QUERY_TIMEOUT_S overrides this setting, but, if set, --idle_query_timeout represents the maximum allowable timeout. | 0 |
| kudu_mutation_buffer_size  | int32 | The size (bytes) of the Kudu client buffer for mutations. | 104857600 |
| kudu_scanner_keep_alive_period_us  | int32 | The period at which Kudu Scanners should send keep-alive requests to the tablet server to ensure that scanners do not time out. | 15000000 |
| kudu_scanner_keep_alive_period_sec  | int32 | The period at which Kudu Scanners should send keep-alive requests to the tablet server to ensure that scanners do not time out. | 15 |
| statestore_subscriber_cnxn_attempts  | int32 | The number of times to retry an RPC connection to the statestore. A setting of 0 means retry indefinitely | 10 |
| server_name  | string | The name to use for securing this impalad server during authorization. Set to enable authorization. By default, the authorization policy will be loaded from the catalog server (via the statestore).To use a file based authorization policy, set --authorization_policy_file. |  |
| min_buffer_size  | int32 | The minimum read buffer size (in bytes) | 1024 |
| kudu_max_row_batches  | int32 | The maximum size of the row batch queue, for Kudu scanners. | 0 |
| max_row_batches  | int32 | the maximum size of materialized_row_batches_ | 0 |
| max_profile_log_file_size  | int32 | The maximum size (in queries) of the profile log file before a new one is created | 5000 |
| max_lineage_log_file_size  | int32 | The maximum size (in queries) of the lineage event log file before a new one is created (if lineage logging is enabled) | 5000 |
| max_audit_event_log_file_size  | int32 | The maximum size (in queries) of the audit event log file before a new one is created (if event logging is enabled) | 5000 |
| web_log_bytes  | int64 | The maximum number of bytes to display on the debug webserver's log page | 1048576 |
| webserver_certificate_file  | string | The location of the debug webserver's SSL certificate file, in .pem format. If empty, webserver SSL support is not enabled |  |
| statestore_subscriber_cnxn_retry_interval_ms  | int32 | The interval, in ms, to wait between attempts to make an RPC connection to the statestore. | 3000 |
| ssl_server_certificate  | string | The full path to the SSL certificate file used to authenticate Impala to clients. If set, both Beeswax and HiveServer2 ports will only accept SSL connections |  |
| ssl_private_key  | string | The full path to the private key used as a counterpart to the public key contained in --ssl_server_certificate. If --ssl_server_certificate is set, this option must be set as well. |  |
| webserver_private_key_file  | string | The full path to the private key used as a counterpart to the public key contained in --ssl_server_certificate. If --ssl_server_certificate is set, this option must be set as well. |  |
| ldap_ca_certificate  | string | The full path to the certificate file used to authenticate the LDAP server's certificate for SSL / TLS connections. |  |
| profile_log_dir  | string | The directory in which profile log files are written. If blank, defaults to <log_file_dir>/profiles |  |
| lineage_event_log_dir  | string | The directory in which lineage event log files are written. Setting this flag with enable lineage logging. |  |
| audit_event_log_dir  | string | The directory in which audit event log files are written. Setting this flag will enable audit event logging. |  |
| statestore_subscriber_timeout_seconds  | int32 | The amount of time (in seconds) that may elapse before the connection with the statestore is considered lost. | 30 |
| symbolize_stacktrace  | bool | Symbolize the stack trace in the tombstone | TRUE |
| suppress_unknown_disk_id_warnings  | bool | Suppress unknown disk id warnings generated when the HDFS implementation does not provide volume/disk information. | FALSE |
| stop_logging_if_full_disk  | bool | Stop attempting to log to disk if the disk is full. | FALSE |
| authorized_proxy_user_config  | string | Specifies the set of authorized proxy users (users who can delegate to other users during authorization) and whom they are allowed to delegate. Input is a semicolon-separated list of key=value pairs of authorized proxy users to the user(s) they can delegate to. These users are specified as a list of short usernames separated by a delimiter (which defaults to comma and may be changed via --authorized_proxy_user_config_delimiter), or '*' to indicate all users. For example: hue=user1,user2;admin=* |  |
| authorized_proxy_user_config_delimiter  | string | Specifies the delimiter used in authorized_proxy_user_config. | , |
| kudu_master_hosts  | string | Specifies the default Kudu master(s). The given value should be a comma separated list of hostnames or IP addresses; ports are optional. |  |
| pause_monitor_sleep_time_ms  | int64 | Sleep time in milliseconds for pause monitor thread. | 500 |
| minidump_size_limit_hint_kb  | int32 | Size limit hint for minidump files in KB. If a minidump exceeds this value, then breakpad will reduce the stack memory it collects for each thread from 8KB to 2KB. However it will always include the full stack memory for the first 20 threads, including the thread that crashed. | 20480 |
| abort_on_failed_audit_event  | bool | Shutdown Impala if there is a problem recording an audit event. | TRUE |
| abort_on_failed_lineage_event  | bool | Shutdown Impala if there is a problem recording a lineage record. | TRUE |
| version  | bool | show version and build info and exit | FALSE |
| helpon  | string | show help on the modules named by this flag value |  |
| helpshort  | bool | show help on only the main module for this program | FALSE |
| helpmatch  | string | show help on modules whose name contains the specified substr |  |
| helppackage  | bool | show help on all modules in the main package | FALSE |
| help  | bool | show help on all flags [tip: all flags can have two dashes] | FALSE |
| helpfull  | bool | show help on all flags -- same as -help | FALSE |
| v  | int32 | Show all VLOG(m) messages for m <= this. Overridable by --vmodule. | 0 |
| disable_mem_pools  | bool | Set to true to disable memory pooling. This can be used to help diagnose memory corruption issues. | FALSE |
| disk_spill_encryption  | bool | Set this to encrypt and perform an integrity check on all data spilled to disk during a query | FALSE |
| tryfromenv  | string | set flags from the environment if present |  |
| fromenv  | string | set flags from the environment [use 'export FLAGS_flag1=value'] |  |
| serialize_batch  | bool | serialize and deserialize each returned row batch | FALSE |
| catalog_client_connection_num_retries  | int32 | Retry catalog connections. | 3 |
| backend_client_connection_num_retries  | int32 | Retry backend connections. | 3 |
| require_username  | bool | Requires that a user be provided in order to schedule requests. If enabled and a user is not provided, requests will be rejected, otherwise requests without a username will be submitted with the username 'default'. | FALSE |
| read_size  | int32 | Read Size (in bytes) | 8388608 |
| log_link  | string | Put additional links to the log files in this directory |  |
| helpxml  | bool | produce an xml version of help | FALSE |
| mem_limit  | string | Process memory limit specified as number of bytes ('<int>[bB]?'), megabytes ('<float>[mM]'), gigabytes ('<float>[gG]'), or percentage of the physical memory ('<int>%'). Defaults to bytes if no unit is given | 80% |
| log_prefix  | bool | Prepend the log prefix to the start of each log line | TRUE |
| log_filename  | string | Prefix of log filename - full path is <log_dir>/<log_filename>.[INFO|WARN|ERROR|FATAL] |  |
| catalog_service_port  | int32 | port where the CatalogService is running | 26000 |
| state_store_subscriber_port  | int32 | port where StatestoreSubscriberService should be exported | 23000 |
| state_store_port  | int32 | port where StatestoreService is running | 24000 |
| webserver_port  | int32 | Port to start debug webserver on | 25000 |
| be_port  | int32 | port on which ImpalaInternalService is exported | 22000 |
| hs2_port  | int32 | port on which HiveServer2 client requests are served | 21050 |
| beeswax_port  | int32 | port on which Beeswax client requests are served | 21000 |
| periodic_counter_update_period_ms  | int32 | Period to update rate counters and sampling counters in ms | 500 |
| vmodule  | string | per-module verbose level. Argument is a comma-separated list of <module name>=<log level>. <module name> is a glob pattern, matched against the filename base (that is, name ignoring .cc/.h./-inl.h). <log level> overrides any value given by --v. |  |
| llama_site_path  | string | Path to the Llama configuration file (llama-site.xml). If set, fair_scheduler_allocation_path must also be set. |  |
| fair_scheduler_allocation_path  | string | Path to the fair scheduler allocation file (fair-scheduler.xml). |  |
| heap_profile_dir  | string | Output directory to store heap profiles. If not set profiles are stored in the current working directory. |  |
| ldap_manual_config  | bool | Obsolete; Ignored | FALSE |
| num_threads_per_disk  | int32 | number of threads per disk | 0 |
| num_threads_per_core  | int32 | Number of threads per core. | 3 |
| fe_service_threads  | int32 | number of threads available to serve client requests | 64 |
| num_s3_io_threads  | int32 | number of S3 I/O threads | 16 |
| num_remote_hdfs_io_threads  | int32 | number of remote HDFS I/O threads | 8 |
| query_log_size  | int32 | Number of queries to retain in the query log. If -1, the query log has unbounded size. | 25 |
| num_disks  | int32 | Number of disks on data node. | 0 |
| tab_completion_columns  | int32 | Number of columns to use in output for tab completion | 80 |
| minloglevel  | int32 | Messages logged at a lower level than this don't actually get logged anywhere | 0 |
| default_pool_max_queued  | int64 | Maximum number of requests allowed to be queued before rejecting requests. A negative value or 0 indicates requests will always be rejected once the maximum number of concurrent requests are executing. Ignored if fair_scheduler_config_path and llama_site_path are set. | 200 |
| max_result_cache_size  | int64 | Maximum number of query results a client may request to be cached on a per-query basis to support restarting fetches. This option guards against unreasonably large result caches requested by clients. Requests exceeding this maximum will be rejected. | 100000 |
| max_profile_log_files  | int32 | Maximum number of profile log files to retain. The most recent log files are retained. If set to 0, all log files are retained. | 10 |
| max_minidumps  | int32 | Maximum number of minidump files to keep per daemon. Older files are removed first. Set to 0 to keep all minidump files. | 9 |
| max_log_files  | int32 | Maximum number of log files to retain per severity level. The most recent log files are retained. If set to 0, all log files are retained. | 10 |
| max_cached_file_handles  | uint64 | Maximum number of HDFS file handles that will be cached. Disabled if set to 0. | 0 |
| statestore_max_missed_heartbeats  | int32 | Maximum number of consecutive heartbeat messages an impalad can miss before being declared failed by the statestore. | 10 |
| default_pool_max_requests  | int64 | Maximum number of concurrent outstanding requests allowed to run before queueing incoming requests. A negative value indicates no limit. 0 indicates no requests will be admitted. Ignored if fair_scheduler_config_path and llama_site_path are set. | -1 |
| queue_wait_timeout_ms  | int64 | Maximum amount of time (in milliseconds) that a request will wait to be admitted before timing out. | 60000 |
| default_pool_mem_limit  | string | Maximum amount of memory that all outstanding requests in this pool may use before new requests to this pool are queued. Specified as a number of bytes ('<int>[bB]?'), megabytes ('<float>[mM]'), gigabytes ('<float>[gG]'), or percentage of the physical memory ('<int>%'). 0 or not setting indicates no limit. Defaults to bytes if no unit is given. Ignored if fair_scheduler_config_path and llama_site_path are set. |  |
| max_page_header_size  | int32 | max parquet page header size in bytes | 8388608 |
| logmailer  | string | Mailer used to send logging email | /bin/mail |
| alsologtoemail  | string | log messages go to these email addresses in addition to logfiles |  |
| logtostderr  | bool | log messages go to stderr instead of logfiles | FALSE |
| alsologtostderr  | bool | log messages go to stderr in addition to logfiles | FALSE |
| stderrthreshold  | int32 | log messages at or above this level are copied to stderr in addition to logfiles. This flag obsoletes --alsologtostderr. | 2 |
| sentry_config  | string | Local path to a sentry-site.xml configuration file. If set, authorization will be enabled. |  |
| local_library_dir  | string | Local directory to copy UDF libraries from HDFS into | /tmp |
| flagfile  | string | load flags from file |  |
| default_query_options  | string | key=value pair of default query options for impalad, separated by ',' |  |
| principal  | string | Kerberos principal. If set, both client and backend networkconnections will use Kerberos encryption and authentication. |  |
| be_principal  | string | Kerberos principal for backend network connections only,overriding --principal if set. |  |
| kerberos_reinit_interval  | int32 | Interval, in minutes, between kerberos ticket renewals. | 60 |
| status_report_interval  | int32 | interval between profile reports; in seconds | 5 |
| webserver_interface  | string | Interface to start debug webserver on. If blank, webserver binds to 0.0.0.0 |  |
| enable_webserver_doc_root  | bool | If true, webserver may serve static files from the webserver_doc_root | TRUE |
| enable_accept_queue_server  | bool | If true, uses a modified version of TThreadedServer that accepts connections as quickly as possible and hands them off to a thread pool to finish setup, reducing the chances that connections time out waiting to be accepted. | TRUE |
| ldap_tls  | bool | If true, use the secure TLS protocol to connect to the LDAP server | FALSE |
| enable_ldap_auth  | bool | If true, use LDAP authentication for client connections | FALSE |
| redirect_stdout_stderr  | bool | If true, redirects stdout/stderr to INFO/ERROR log. | TRUE |
| print_llvm_ir_instruction_count  | bool | if true, prints the instruction counts of all JIT'd functions | FALSE |
| dump_ir  | bool | if true, output IR after optimization passes | FALSE |
| insert_inherit_permissions  | bool | If true, new directories created by INSERTs will inherit the permissions of their parent directories | FALSE |
| log_query_to_file  | bool | if true, logs completed query profiles to file. | TRUE |
| load_catalog_in_background  | bool | If true, loads catalog metadata in the background. If false, metadata is loaded lazily (on access). | FALSE |
| load_auth_to_local_rules  | bool | If true, load auth_to_local configuration from hdfs' core-site.xml. When enabled, impalad reads the rules from the property hadoop.security.auth_to_local and applies them to translate the Kerberos principal to its corresponding local user name for authorization. | FALSE |
| load_catalog_at_startup  | bool | if true, load all catalog data at startup | FALSE |
| disable_kudu  | bool | If true, Kudu features will be disabled. | FALSE |
| perf_map  | bool | if true, generate /tmp/perf-<pid>.map file for linux perf symbols. This is not recommended for production use because it may affect performance. | FALSE |
| disable_optimization_passes  | bool | if true, disables llvm optimization passes (used for testing) | FALSE |
| enable_webserver  | bool | If true, debug webserver is enabled | TRUE |
| compact_catalog_topic  | bool | If true, catalog updates sent via the statestore are compacted before transmission. This saves network bandwidth at the cost of a small quantity of CPU time. Enable this option in cluster with large catalogs. It must be enabled on both the catalog service, and all Impala demons. | FALSE |
| force_lowercase_usernames  | bool | If true, all principals and usernames are mapped to lowercase shortnames before being passed to any components (Sentry, admission control) for authorization | FALSE |
| pause_monitor_warn_threshold_ms  | int64 | If the pause monitor sleeps more than this time period, a warning is logged. If set to 0 or less, pause monitor is disabled. | 10000 |
| log_dir  | string | If specified, logfiles are written into this directory instead of the default logging directory. |  |
| ldap_passwords_in_clear_ok  | bool | If set, will allow LDAP passwords to be sent in the clear (without TLS/SSL) over the network. This option should not be used in production environments | FALSE |
| unopt_module_dir  | string | if set, saves unoptimized generated IR modules to the specified directory. |  |
| opt_module_dir  | string | if set, saves optimized generated IR modules to the specified directory. |  |
| asm_module_dir  | string | if set, saves disassembly for generated IR modules to the specified directory. |  |
| ldap_baseDN  | string | If set, Impala will try to bind to LDAP with a name of the form uid=<userid>,<ldap_baseDN> |  |
| ldap_domain  | string | If set, Impala will try to bind to LDAP with a name of the form <userid>@<ldap_domain> |  |
| ldap_bind_pattern  | string | If set, Impala will try to bind to LDAP with a name of <ldap_bind_pattern>, but where the string #UID is replaced by the user ID. Use to control the bind name precisely; do not set --ldap_domain or --ldap_baseDN with this option |  |
| log_mem_usage_interval  | int32 | If non-zero, impalad will output memory usage every log_mem_usage_interval'th fragment completion. | 0 |
| tab_completion_word  | string | If non-empty, HandleCommandLineCompletions() will hijack the process and attempt to do bash-style command line flag completion on this value. |  |
| state_store_host  | string | hostname where StatestoreService is running | localhost |
| catalog_service_host  | string | hostname where CatalogService is running | localhost |
| hostname  | string | Hostname to use for this daemon, also used as part of the Kerberos principal, if enabled. If not set, the system default will be used |  |
| authorization_policy_file  | string | HDFS path to the authorization policy file. If set, authorization will be enabled and the authorization policy will be read from a file. |  |
| max_free_io_buffers  | int32 | For each io buffer size, the maximum number of buffers the IoMgr will hold onto | 128 |
| webserver_doc_root  | string | Files under <webserver_doc_root>/www are accessible via the debug webserver. Defaults to $IMPALA_HOME, or if $IMPALA_HOME is not set, disables the document root | /home/ec2-user/git/incubator-impala |
| enable_quadratic_probing  | bool | Enable quadratic probing hash table | TRUE |
| enable_partitioned_hash_join  | bool | Enable partitioned hash join | TRUE |
| enable_partitioned_aggregation  | bool | Enable partitioned hash agg | TRUE |
| log_backtrace_at  | string | Emit a backtrace when logging at file:linenum. |  |
| logemaillevel  | int32 | Email log messages logged at this level or higher (0 means email all; 3 means email FATAL only; ...) | 999 |
| drop_log_memory  | bool | Drop in-memory buffers of log contents. Logs can grow very quickly and they are rarely read before they need to be evicted from memory. Instead, drop them from memory as soon as they are flushed to disk. | TRUE |
| webserver_authentication_domain  | string | Domain used for debug webserver authentication |  |
| skip_lzo_version_check  | bool | Disables checking the LZO library version against the running Impala version. | FALSE |
| disable_pool_mem_limits  | bool | Disables all per-pool mem limits. | FALSE |
| disable_pool_max_requests  | bool | Disables all per-pool limits on the maximum number of running requests. | FALSE |
| disable_admission_control  | bool | Disables admission control. | FALSE |
| minidump_path  | string | Directory to write minidump files to. This can be either an absolute path or a path relative to log_dir. Each daemon will create an additional sub-directory to prevent naming conflicts and to make it easier to identify a crashing daemon. Minidump files contain crash-related information in a compressed format and will only be written when a daemon exits unexpectedly, for example on an unhandled exception or signal. Set to empty to disable writing minidump files. | minidumps |
| undefok  | string | comma-separated list of flag names that it is okay to specify on the command line even if the program does not define a flag with that name. IMPORTANT: flags in this list that have arguments MUST use the flag=value format |  |
| sasl_path  | string | Colon separated list of paths to look for SASL security library plugins. |  |
| logbuflevel  | int32 | Buffer log messages logged at this level or lower (-1 means don't buffer; 0 means buffer INFO only; ...) | 0 |
| logbufsecs  | int32 | Buffer log messages for at most this many seconds | 30 |
| data_source_batch_size  | int32 | Batch size for calls to GetNext() on external data sources. | 1024 |
| max_log_size  | int32 | approx. maximum log file size (in MB). A value of 0 will be silently overridden to 1. | 1800 |
| authorization_policy_provider_class  | string | Advanced: The authorization policy provider class name. | org.apache.sentry.provider.common.HadoopGroupResourceAuthorizationProvider |
| redaction_rules_file  | string | Absolute path to sensitive data redaction rules. The rules will be applied to all log messages and query text shown in the Web UI and audit records. Query results will not be affected. Refer to the documentation for the rule file format. |  |
| krb5_conf  | string | Absolute path to Kerberos krb5.conf if in a non-standard location. Does not normally need to be set. |  |
| keytab_file  | string | Absolute path to Kerberos keytab file |  |
| abort_on_config_error  | bool | Abort Impala startup if there are improper configs or running on unsupported hardware. | TRUE |
| s3a_secret_key_cmd  | string | A Unix command whose output returns the secret key to S3, i.e. "fs.s3a.secret.key". |  |
| webserver_private_key_password_cmd  | string | A Unix command whose output returns the password used to decrypt the Webserver's certificate private key file specified in --webserver_private_key_file. If the .PEM key file is not password-protected, this command will not be invoked. The output of the command will be truncated to 1024 bytes, and then all trailing whitespace will be trimmed before it is used to decrypt the private key |  |
| ssl_private_key_password_cmd  | string | A Unix command whose output returns the password used to decrypt the certificate private key file specified in --ssl_private_key. If the .PEM key file is not password-protected, this command will not be invoked. The output of the command will be truncated to 1024 bytes, and then all trailing whitespace will be trimmed before it is used to decrypt the private key |  |
| s3a_access_key_cmd  | string | A Unix command whose output returns the access key to S3, i.e. "fs.s3a.access.key". |  |
| webserver_password_file  | string | (Optional) Location of .htpasswd file containing user names and hashed passwords for debug webserver authentication |  |
| enable_probe_side_filtering  | bool | Deprecated. | TRUE |
| enable_phj_probe_side_filtering  | bool | Deprecated. | TRUE |
| rpc_cnxn_attempts  | int32 | Deprecated | 10 |
| rpc_cnxn_retry_interval_ms  | int32 | Deprecated | 2000 |
| cgroup_hierarchy_path  | string | Deprecated |  |
| enable_rm  | bool | Deprecated | FALSE |
| llama_addresses  | string | Deprecated |  |
| llama_callback_port  | int32 | Deprecated | 28000 |
| llama_host  | string | Deprecated |  |
| llama_max_request_attempts  | int64 | Deprecated | 5 |
| llama_port  | int32 | Deprecated | 15000 |
| llama_registration_timeout_secs  | int64 | Deprecated | 30 |
| llama_registration_wait_secs  | int64 | Deprecated | 3 |
| resource_broker_cnxn_attempts  | int32 | Deprecated | 1 |
| resource_broker_cnxn_retry_interval_ms  | int32 | Deprecated | 3000 |
| resource_broker_recv_timeout  | int32 | Deprecated | 0 |
| resource_broker_send_timeout  | int32 | Deprecated | 0 |
| staging_cgroup  | string | Deprecated | impala_staging |
| rm_always_use_defaults  | bool | Deprecated | FALSE |
| rm_default_cpu_vcores  | int32 | Deprecated | 2 |
| rm_default_memory  | string | Deprecated | 4G |
| local_nodemanager_url  | string | Deprecated |  |
| catalog_client_rpc_timeout_ms  | int32 | (Advanced) The underlying TSocket send/recv timeout in milliseconds for a catalog client RPC. | 0 |
| backend_client_rpc_timeout_ms  | int32 | (Advanced) The underlying TSocket send/recv timeout in milliseconds for a backend client RPC. | 300000 |
| datastream_sender_timeout_ms  | int32 | (Advanced) The time, in ms, that can elapse before a plan fragment will time-out trying to send the initial row batch. | 120000 |
| statestore_update_tcp_timeout_seconds  | int32 | (Advanced) The time after which an update RPC to a subscriber will timeout. This setting protects against badly hung machines that are not able to respond to the update RPC in short order. | 300 |
| statestore_heartbeat_tcp_timeout_seconds  | int32 | (Advanced) The time after which a heartbeat RPC to a subscriber will timeout. This setting protects against badly hung machines that are not able to respond to the heartbeat RPC in short order | 3 |
| accepted_cnxn_queue_depth  | int32 | (Advanced) The size of the post-accept, pre-setup connection queue for Impala internal connections | 10000 |
| num_hdfs_worker_threads  | int32 | (Advanced) The number of threads in the global HDFS operation pool | 16 |
| num_metadata_loading_threads  | int32 | (Advanced) The number of metadata loading threads (degree of parallelism) to use when loading catalog metadata. | 16 |
| runtime_filter_wait_time_ms  | int32 | (Advanced) the maximum time, in ms, that a scan node will wait for expected runtime filters to arrive. | 1000 |
| max_filter_error_rate  | double | (Advanced) The maximum probability of false positives in a runtime filter before it is disabled. | 0.75 |
| non_impala_java_vlog  | int32 | (Advanced) The log level (equivalent to --v) for non-Impala Java classes (0: INFO, 1 and 2: DEBUG, 3: TRACE) | 0 |
| ssl_client_ca_certificate  | string | (Advanced) The full path to a certificate used by Thrift clients to check the validity of a server certificate. May either be a certificate for a third-party Certificate Authority, or a copy of the certificate the client expects to receive from the server. |  |
| cancellation_thread_pool_size  | int32 | (Advanced) Size of the thread-pool processing cancellations due to node failure | 5 |
| statestore_num_update_threads  | int32 | (Advanced) Number of threads used to send topic updates in parallel to all registered subscribers. | 10 |
| statestore_num_heartbeat_threads  | int32 | (Advanced) Number of threads used to send heartbeats in parallel to all registered subscribers. | 10 |
| coordinator_rpc_threads  | int32 | (Advanced) Number of threads available to start fragments on remote Impala daemons. | 12 |
| be_service_threads  | int32 | (Advanced) number of threads available to serve backend execution requests | 64 |
| exchg_node_buffer_size_bytes  | int32 | (Advanced) Maximum size of per-query receive-side buffer | 10485760 |
| ldap_allow_anonymous_binds  | bool | (Advanced) If true, LDAP authentication with a blank password (an 'anonymous bind') is allowed by Impala. | FALSE |
| parquet_min_filter_reject_ratio  | double | (Advanced) If the percentage of rows rejected by a runtime filter drops below this value, the filter is disabled. | 0.1 |
| num_cores  | int32 | (Advanced) If > 0, it sets the number of cores available to Impala. Setting it to 0 means Impala will use all available cores on the machine according to /proc/cpuinfo. | 0 |
| statestore_update_frequency_ms  | int32 | (Advanced) Frequency (in ms) with which the statestore sends topic updates to subscribers. | 2000 |
| statestore_heartbeat_frequency_ms  | int32 | (Advanced) Frequency (in ms) with which the statestore sends heartbeat heartbeats to subscribers. | 1000 |
| enable_process_lifetime_heap_profiling  | bool | (Advanced) Enables heap profiling for the lifetime of the process. Profile output will be stored in the directory specified by -heap_profile_dir. Enabling this option will disable the on-demand/remote server profile handlers. | FALSE |
| internal_principals_whitelist  | string | (Advanced) Comma-separated list of additional usernames authorized to access Impala's internal APIs. Defaults to 'hdfs' which is the system user that in certain deployments must access catalog server APIs. | hdfs