| Flag | 说明 | 类型 | 缺省值 |
| :--- | :--- | :--- | :--- |
| ABORT_ON_ERROR | 启用此选项时，如果任何节点遇到错误，Impala 将立即取消查询，而不是继续操作并可能返回不完整的结果。默认情况下此选项处于禁用状态，可帮助在发生错误时收集最大诊断信息，例如，所有节点还是仅单个节点出现同一问题。当前，Impala 可以跳过的错误涉及数据损坏，例如应包含整数值但实际包含字符串值的列。 | 布尔值 | false |
| APPX_COUNT_DISTINCT | 通过在内部将每个 COUNT(DISTINCT) 重写为使用 NDV() 函数，可以在单个查询内允许多个 COUNT(DISTINCT) 运算。所得到的计数是近似值，而不是精确值。 | 布尔值 | false |
| BATCH_SIZE | SQL运算符一次运算求值的行数。主要用于测试。未定义或0值则使用缺省值1024。 | 整数 | 0（意味着1024） |
| COMPRESSION_CODEC | 压缩算法 | 枚举值（SNAPPY、GZIP 和 NONE） | NONE |
| DEBUG_ACTION | 调试查询语句 | 字符串 | 空 |
| DISABLE_CACHED_READS |  | 0 |
| DISABLE_CODEGEN |  | 0 |
| DISABLE_OUTERMOST_TOPN |  | 0 |
| DISABLE_ROW_RUNTIME_FILTERING |  | 0 |
| DISABLE_STREAMING_PREAGGREGATIONS |  | 0 |
| DISABLE_UNSAFE_SPILLS |  | 0 |
| ENABLE_EXPR_REWRITES |  | 1 |
| EXEC_SINGLE_NODE_ROWS_THRESHOLD |  | 100 |
| EXPLAIN_LEVEL |  | 1 |
| HBASE_CACHE_BLOCKS |  | 0 |
| HBASE_CACHING |  | 0 |
| MAX_BLOCK_MGR_MEMORY |  | 0 |
| MAX_ERRORS |  | 100 |
| MAX_IO_BUFFERS |  | 0 |
| MAX_NUM_RUNTIME_FILTERS |  | 10 |
| MAX_SCAN_RANGE_LENGTH |  | 0 |
| MEM_LIMIT |  | 0 |
| MT_DOP |  | 0 |
| NUM_NODES |  | 0 |
| NUM_SCANNER_THREADS |  | 0 |
| OPTIMIZE_PARTITION_KEY_SCANS |  | 0 |
| PARQUET_ANNOTATE_STRINGS_UTF8 |  | 0 |
| PARQUET_FALLBACK_SCHEMA_RESOLUTION |  | 0 |
| PARQUET_FILE_SIZE |  | 0 |
| PREFETCH_MODE |  | 1 |
| QUERY_TIMEOUT_S |  | 0 |
| REPLICA_PREFERENCE |  | 0 |
| REQUEST_POOL |  | |
| RESERVATION_REQUEST_TIMEOUT |  | 0 |
| RM_INITIAL_MEM |  | 0 |
| RUNTIME_BLOOM_FILTER_SIZE |  | 1048576 |
| RUNTIME_FILTER_MAX_SIZE |  | 16777216 |
| RUNTIME_FILTER_MIN_SIZE |  | 1048576 |
| RUNTIME_FILTER_MODE |  | 2 |
| RUNTIME_FILTER_WAIT_TIME_MS |  | 0 |
| S3_SKIP_INSERT_STAGING |  | 1 |
| SCAN_NODE_CODEGEN_THRESHOLD |  | 1800000 |
| SCHEDULE_RANDOM_REPLICA |  | 0 |
| SCRATCH_LIMIT |  | -1 |
| SEQ_COMPRESSION_MODE |  | 0 |
| STRICT_MODE |  | 0 |
| SUPPORT_START_OVER |  | false |
| SYNC_DDL |  | 0 |
| V_CPU_CORES |  | 0 |

注意：布尔类型参数的false和true值在Impala Shell的Set命令中分别显示为0或者1。

以下为过时的设置项，可能以后版本会删除，不建议使用。
| Flag | 说明 | 类型 | 缺省值 |
| :--- | :--- | :--- | :--- |
| ABORT_ON_DEFAULT_LIMIT_EXCEEDED | 在 Impala 1.4.0 及更高版本中，ORDER BY 子句不再需要伴随 LIMIT 子句，此查询选项弃用且不会产生任何效果。 | | 布尔值 | false |
| ALLOW_UNSUPPORTED_FORMATS | 以前用于为文件格式提供支持的已过时的查询选项。请勿使用。将来可能会被删除。 | 布尔值 | false |
| DEFAULT_ORDER_BY_LIMIT | 此查询选项弃用且不会产生任何效果。 |  | -1 |