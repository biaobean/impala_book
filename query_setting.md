
| Flag | 说明 | 类型 | 缺省值 |
| :--- | :--- | :--- | :--- |
| ABORT_ON_ERROR | 启用此选项时，如果任何节点遇到错误，Impala 将立即取消查询，而不是继续操作并可能返回不完整的结果。默认情况下此选项处于禁用状态，可帮助在发生错误时收集最大诊断信息，例如，所有节点还是仅单个节点出现同一问题。当前，Impala 可以跳过的错误涉及数据损坏，例如应包含整数值但实际包含字符串值的列。 | 布尔值 | false |
| APPX_COUNT_DISTINCT | 通过在内部将每个 COUNT(DISTINCT) 重写为使用 NDV() 函数，可以在单个查询内允许多个 COUNT(DISTINCT) 运算。所得到的计数是近似值，而不是精确值。 | 布尔值 | false |
| BATCH_SIZE | SQL运算符一次运算求值的行数。主要用于测试。未定义或0值则使用缺省值1024。 | 整数 | 0（意味着1024） |
| COMPRESSION_CODEC | 压缩算法 | 枚举值（SNAPPY、GZIP 和 NONE） | NONE |
| DEBUG_ACTION | 调试查询语句 | 字符串 | 空 |
| DISABLE_CACHED_READS | | 布尔值 | false |
| DISABLE_CODEGEN | 禁用代码生成。用于问题诊断和调试。生产系统中无需设置。 | 布尔值 | false |
| DISABLE_OUTERMOST_TOPN | | 布尔值 | false |
| DISABLE_ROW_RUNTIME_FILTERING | | 布尔值 | false |
| DISABLE_STREAMING_PREAGGREGATIONS |  | 布尔值 | false |
| DISABLE_UNSAFE_SPILLS | 启用后，查询在超过 Impala 内存限制时会直接失败，而不是将临时数据写入到磁盘。 | 布尔值 | false |
| ENABLE_EXPR_REWRITES |  | 布尔值 | true |
| EXEC_SINGLE_NODE_ROWS_THRESHOLD | 扫描行数低于此阈值的查询将被视为“小查询”，Impala机哪个禁用并行执行和本机代码生成等优化措施，所有工作都在 Coordinator 节点上执行。 | 整数 | 100 |
| EXPLAIN_LEVEL | 控制 EXPLAIN 语句输出中提供的详细信息量，值越大信息越多。 | 整数（0到3） | 1 |
| HBASE_CACHE_BLOCKS | HBase中Scan的setCacheBlocks调用值。与 HBASE_CACHING 查询选项结合使用时有助于控制对 HBase 区域服务器的内存压力。 | 布尔值 | false |
| HBASE_CACHING | HBase中Scan操作的setCaching调用值。与 HBASE_CACHING 查询选项结合使用时有助于控制对 HBase 区域服务器的内存压力。 | 布尔值 | false |
| MAX_BLOCK_MGR_MEMORY | | | 0 |
| MAX_ERRORS | Impala 日志文件中记录的任何特定查询的最大非致命错误数。 | 整数 | 100 |
| MAX_NUM_RUNTIME_FILTERS | | | 10 |
| MAX_SCAN_RANGE_LENGTH | 每个CPU核心扫描HDFS文件（不适用于Parquet格式）范围的最大长度。注意Impala在内部使用8MB读取缓冲区。 | 整数 | 0（后端默认值，与HDFS块大小相同） |
| MEM_LIMIT | 查询可以在每个节点上分配的最大内存量。如果任何节点上的查询处理超过指定的内存限制，Impala将取消查询。 | 整数 | 0 |
| MT_DOP | | | 0 |
| NUM_NODES | 限制处理查询的节点数，通常只用于调试。 | 仅接受值0（所有节点）或 1（只在Coordinator 节点上完成） | 0 |
| NUM_SCANNER_THREADS | 一个节点上对每个查询使用的最大扫描器线程数（。默认情况下，每个核心一个线程。 | 整数 | 0 |
| OPTIMIZE_PARTITION_KEY_SCANS | | | 0 |
| PARQUET_ANNOTATE_STRINGS_UTF8 | | | 0 |
| PARQUET_FALLBACK_SCHEMA_RESOLUTION | | | 0 |
| PARQUET_FILE_SIZE | 指定 Impala INSERT 语句生成的每个 Parquet 数据文件的最大大小的字节数。 | 整数 | 0（意味着256MB） |
| PREFETCH_MODE | | | 1 |
| QUERY_TIMEOUT_S | 以秒为单位设置会话的空闲查询超时值。超过超时值处于空闲状态的查询将自动取消。（必须小于_--idle_query_timeout_值） | 整数 | 0（如果_--idle_query_timeout_未生效则无超时；否则，使用_--idle_query_timeout_值） |
| REPLICA_PREFERENCE | | | 0 |
| REQUEST_POOL | 查询应提交到的池或队列名称。只有当启用Admission Control或YARN时才适用。 | | |
| RESERVATION_REQUEST_TIMEOUT | 将等待完全授予或拒绝预订的最大毫秒数。 | 整数 | 0（无超时） |
| RM_INITIAL_MEM | | | 0 |
| RUNTIME_BLOOM_FILTER_SIZE | | | 1048576 |
| RUNTIME_FILTER_MAX_SIZE | | | 16777216 |
| RUNTIME_FILTER_MIN_SIZE | | | 1048576 |
| RUNTIME_FILTER_MODE | | | 2 |
| RUNTIME_FILTER_WAIT_TIME_MS | | | 0 |
| S3_SKIP_INSERT_STAGING | | | 1 |
| SCAN_NODE_CODEGEN_THRESHOLD | | | 1800000 |
| SCHEDULE_RANDOM_REPLICA | | | 0 |
| SCRATCH_LIMIT | | | -1 |
| SEQ_COMPRESSION_MODE | | | 0 |
| STRICT_MODE | | | 0 |
| SYNC_DDL | DDL执行后，Catalog Service将会自动同步广播（默认为异步）此更改到所有节点。确保后续连接到群集中的其他节点能识别到之前任何节点添加或更改的表。 | 布尔值| false |
| V_CPU_CORES | 要从YARN请求的每个主机的虚拟CPU核心数，与资源管理功能结合使用。如果设置，将覆盖来自Impala的自动估计值。 | 整数 | 0（意味着使用自动估计值） |

注意：布尔类型参数的false和true值在Impala Shell的Set命令中分别显示为0或者1。

以下为过时的设置项，可能以后版本会删除，不建议使用。

| Flag | 说明 | 类型 | 缺省值 |
| :--- | :--- | :--- | :--- |
| ABORT_ON_DEFAULT_LIMIT_EXCEEDED | 已弃用，当前已不起作用。 | 布尔值 | false |
| ALLOW_UNSUPPORTED_FORMATS | 以前用于为文件格式提供支持的已过时的查询选项。请勿使用。将来可能会被删除。 | 布尔值 | false |
| DEFAULT_ORDER_BY_LIMIT | 已弃用，当前已不起作用。 | | -1 |
| MAX_IO_BUFFERS | 已弃用，当前已不起作用。 | | 0 |
| SUPPORT_START_OVER | 保留设置为false。 | 布尔值 | false |
