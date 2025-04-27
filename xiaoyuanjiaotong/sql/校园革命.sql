create table charging_localtions
(
    location_id       int auto_increment comment '充电地点Id'
        primary key,
    charging_location varchar(50)    null comment '充电地点',
    fee_standard      decimal(10, 2) null comment '费用标准'
)
    comment '充电地点';

create table charging_records
(
    record_id   int auto_increment comment '记录ID'
        primary key,
    user_id     int            null comment '用户ID',
    plate_id    int            null comment '车牌ID',
    create_time datetime       null comment '创建时间',
    update_time datetime       null comment '更新时间',
    end_time    datetime       null comment '结束时间',
    fee         decimal(10, 2) null comment '费用',
    status      varchar(10)    null comment '付款状态',
    location_id int            null comment '充电地点id'
)
    comment '充电记录表';

create table chargingstations
(
    stationID   int auto_increment
        primary key,
    stationName varchar(50)    not null,
    location    varchar(255)   not null,
    installDate date           not null,
    feeStandard decimal(10, 2) null
)
    comment '充电桩表';

create table exams
(
    exam_id      int auto_increment comment '选项ID'
        primary key,
    question_id  int  null comment '问题ID',
    exam_content text null comment '选项'
)
    comment '选项表';

create table gen_table
(
    table_id          bigint auto_increment comment '编号'
        primary key,
    table_name        varchar(200) default ''     null comment '表名称',
    table_comment     varchar(500) default ''     null comment '表描述',
    sub_table_name    varchar(64)                 null comment '关联子表的表名',
    sub_table_fk_name varchar(64)                 null comment '子表关联的外键名',
    class_name        varchar(100) default ''     null comment '实体类名称',
    tpl_category      varchar(200) default 'crud' null comment '使用的模板（crud单表操作 tree树表操作）',
    tpl_web_type      varchar(30)  default ''     null comment '前端模板类型（element-ui模版 element-plus模版）',
    package_name      varchar(100)                null comment '生成包路径',
    module_name       varchar(30)                 null comment '生成模块名',
    business_name     varchar(30)                 null comment '生成业务名',
    function_name     varchar(50)                 null comment '生成功能名',
    function_author   varchar(50)                 null comment '生成功能作者',
    gen_type          char         default '0'    null comment '生成代码方式（0zip压缩包 1自定义路径）',
    gen_path          varchar(200) default '/'    null comment '生成路径（不填默认项目路径）',
    options           varchar(1000)               null comment '其它生成选项',
    create_by         varchar(64)  default ''     null comment '创建者',
    create_time       datetime                    null comment '创建时间',
    update_by         varchar(64)  default ''     null comment '更新者',
    update_time       datetime                    null comment '更新时间',
    remark            varchar(500)                null comment '备注'
)
    comment '代码生成业务表';

create table gen_table_column
(
    column_id      bigint auto_increment comment '编号'
        primary key,
    table_id       bigint                    null comment '归属表编号',
    column_name    varchar(200)              null comment '列名称',
    column_comment varchar(500)              null comment '列描述',
    column_type    varchar(100)              null comment '列类型',
    java_type      varchar(500)              null comment 'JAVA类型',
    java_field     varchar(200)              null comment 'JAVA字段名',
    is_pk          char                      null comment '是否主键（1是）',
    is_increment   char                      null comment '是否自增（1是）',
    is_required    char                      null comment '是否必填（1是）',
    is_insert      char                      null comment '是否为插入字段（1是）',
    is_edit        char                      null comment '是否编辑字段（1是）',
    is_list        char                      null comment '是否列表字段（1是）',
    is_query       char                      null comment '是否查询字段（1是）',
    query_type     varchar(200) default 'EQ' null comment '查询方式（等于、不等于、大于、小于、范围）',
    html_type      varchar(200)              null comment '显示类型（文本框、文本域、下拉框、复选框、单选框、日期控件）',
    dict_type      varchar(200) default ''   null comment '字典类型',
    sort           int                       null comment '排序',
    create_by      varchar(64)  default ''   null comment '创建者',
    create_time    datetime                  null comment '创建时间',
    update_by      varchar(64)  default ''   null comment '更新者',
    update_time    datetime                  null comment '更新时间'
)
    comment '代码生成业务表字段';

create table license_plates
(
    plate_id     int auto_increment comment '车牌id'
        primary key,
    plate_number varchar(20) null comment '车牌号',
    create_time  datetime    null comment '创建时间',
    update_time  datetime    null comment '更新时间',
    user_id      int         null comment '用户',
    vehicle_type varchar(50) null comment '车辆类型',
    score        int         null comment '车牌的分数',
    constraint plate_number
        unique (plate_number)
)
    comment '车牌表';

create table qrtz_calendars
(
    sched_name    varchar(120) not null comment '调度名称',
    calendar_name varchar(200) not null comment '日历名称',
    calendar      blob         not null comment '存放持久化calendar对象',
    primary key (sched_name, calendar_name)
)
    comment '日历信息表';

create table qrtz_fired_triggers
(
    sched_name        varchar(120) not null comment '调度名称',
    entry_id          varchar(95)  not null comment '调度器实例id',
    trigger_name      varchar(200) not null comment 'qrtz_triggers表trigger_name的外键',
    trigger_group     varchar(200) not null comment 'qrtz_triggers表trigger_group的外键',
    instance_name     varchar(200) not null comment '调度器实例名',
    fired_time        bigint(13)   not null comment '触发的时间',
    sched_time        bigint(13)   not null comment '定时器制定的时间',
    priority          int          not null comment '优先级',
    state             varchar(16)  not null comment '状态',
    job_name          varchar(200) null comment '任务名称',
    job_group         varchar(200) null comment '任务组名',
    is_nonconcurrent  varchar(1)   null comment '是否并发',
    requests_recovery varchar(1)   null comment '是否接受恢复执行',
    primary key (sched_name, entry_id)
)
    comment '已触发的触发器表';

create table qrtz_job_details
(
    sched_name        varchar(120) not null comment '调度名称',
    job_name          varchar(200) not null comment '任务名称',
    job_group         varchar(200) not null comment '任务组名',
    description       varchar(250) null comment '相关介绍',
    job_class_name    varchar(250) not null comment '执行任务类名称',
    is_durable        varchar(1)   not null comment '是否持久化',
    is_nonconcurrent  varchar(1)   not null comment '是否并发',
    is_update_data    varchar(1)   not null comment '是否更新数据',
    requests_recovery varchar(1)   not null comment '是否接受恢复执行',
    job_data          blob         null comment '存放持久化job对象',
    primary key (sched_name, job_name, job_group)
)
    comment '任务详细信息表';

create table qrtz_locks
(
    sched_name varchar(120) not null comment '调度名称',
    lock_name  varchar(40)  not null comment '悲观锁名称',
    primary key (sched_name, lock_name)
)
    comment '存储的悲观锁信息表';

create table qrtz_paused_trigger_grps
(
    sched_name    varchar(120) not null comment '调度名称',
    trigger_group varchar(200) not null comment 'qrtz_triggers表trigger_group的外键',
    primary key (sched_name, trigger_group)
)
    comment '暂停的触发器表';

create table qrtz_scheduler_state
(
    sched_name        varchar(120) not null comment '调度名称',
    instance_name     varchar(200) not null comment '实例名称',
    last_checkin_time bigint(13)   not null comment '上次检查时间',
    checkin_interval  bigint(13)   not null comment '检查间隔时间',
    primary key (sched_name, instance_name)
)
    comment '调度器状态表';

create table qrtz_triggers
(
    sched_name     varchar(120) not null comment '调度名称',
    trigger_name   varchar(200) not null comment '触发器的名字',
    trigger_group  varchar(200) not null comment '触发器所属组的名字',
    job_name       varchar(200) not null comment 'qrtz_job_details表job_name的外键',
    job_group      varchar(200) not null comment 'qrtz_job_details表job_group的外键',
    description    varchar(250) null comment '相关介绍',
    next_fire_time bigint(13)   null comment '上一次触发时间（毫秒）',
    prev_fire_time bigint(13)   null comment '下一次触发时间（默认为-1表示不触发）',
    priority       int          null comment '优先级',
    trigger_state  varchar(16)  not null comment '触发器状态',
    trigger_type   varchar(8)   not null comment '触发器的类型',
    start_time     bigint(13)   not null comment '开始时间',
    end_time       bigint(13)   null comment '结束时间',
    calendar_name  varchar(200) null comment '日程表名称',
    misfire_instr  smallint(2)  null comment '补偿执行的策略',
    job_data       blob         null comment '存放持久化job对象',
    primary key (sched_name, trigger_name, trigger_group),
    constraint qrtz_triggers_ibfk_1
        foreign key (sched_name, job_name, job_group) references qrtz_job_details (sched_name, job_name, job_group)
)
    comment '触发器详细信息表';

create table qrtz_blob_triggers
(
    sched_name    varchar(120) not null comment '调度名称',
    trigger_name  varchar(200) not null comment 'qrtz_triggers表trigger_name的外键',
    trigger_group varchar(200) not null comment 'qrtz_triggers表trigger_group的外键',
    blob_data     blob         null comment '存放持久化Trigger对象',
    primary key (sched_name, trigger_name, trigger_group),
    constraint qrtz_blob_triggers_ibfk_1
        foreign key (sched_name, trigger_name, trigger_group) references qrtz_triggers (sched_name, trigger_name, trigger_group)
)
    comment 'Blob类型的触发器表';

create table qrtz_cron_triggers
(
    sched_name      varchar(120) not null comment '调度名称',
    trigger_name    varchar(200) not null comment 'qrtz_triggers表trigger_name的外键',
    trigger_group   varchar(200) not null comment 'qrtz_triggers表trigger_group的外键',
    cron_expression varchar(200) not null comment 'cron表达式',
    time_zone_id    varchar(80)  null comment '时区',
    primary key (sched_name, trigger_name, trigger_group),
    constraint qrtz_cron_triggers_ibfk_1
        foreign key (sched_name, trigger_name, trigger_group) references qrtz_triggers (sched_name, trigger_name, trigger_group)
)
    comment 'Cron类型的触发器表';

create table qrtz_simple_triggers
(
    sched_name      varchar(120) not null comment '调度名称',
    trigger_name    varchar(200) not null comment 'qrtz_triggers表trigger_name的外键',
    trigger_group   varchar(200) not null comment 'qrtz_triggers表trigger_group的外键',
    repeat_count    bigint(7)    not null comment '重复的次数统计',
    repeat_interval bigint(12)   not null comment '重复的间隔时间',
    times_triggered bigint(10)   not null comment '已经触发的次数',
    primary key (sched_name, trigger_name, trigger_group),
    constraint qrtz_simple_triggers_ibfk_1
        foreign key (sched_name, trigger_name, trigger_group) references qrtz_triggers (sched_name, trigger_name, trigger_group)
)
    comment '简单触发器的信息表';

create table qrtz_simprop_triggers
(
    sched_name    varchar(120)   not null comment '调度名称',
    trigger_name  varchar(200)   not null comment 'qrtz_triggers表trigger_name的外键',
    trigger_group varchar(200)   not null comment 'qrtz_triggers表trigger_group的外键',
    str_prop_1    varchar(512)   null comment 'String类型的trigger的第一个参数',
    str_prop_2    varchar(512)   null comment 'String类型的trigger的第二个参数',
    str_prop_3    varchar(512)   null comment 'String类型的trigger的第三个参数',
    int_prop_1    int            null comment 'int类型的trigger的第一个参数',
    int_prop_2    int            null comment 'int类型的trigger的第二个参数',
    long_prop_1   bigint         null comment 'long类型的trigger的第一个参数',
    long_prop_2   bigint         null comment 'long类型的trigger的第二个参数',
    dec_prop_1    decimal(13, 4) null comment 'decimal类型的trigger的第一个参数',
    dec_prop_2    decimal(13, 4) null comment 'decimal类型的trigger的第二个参数',
    bool_prop_1   varchar(1)     null comment 'Boolean类型的trigger的第一个参数',
    bool_prop_2   varchar(1)     null comment 'Boolean类型的trigger的第二个参数',
    primary key (sched_name, trigger_name, trigger_group),
    constraint qrtz_simprop_triggers_ibfk_1
        foreign key (sched_name, trigger_name, trigger_group) references qrtz_triggers (sched_name, trigger_name, trigger_group)
)
    comment '同步机制的行锁表';

create index sched_name
    on qrtz_triggers (sched_name, job_name, job_group);

create table questions
(
    question_id      int auto_increment comment '问题ID'
        primary key,
    question_content text        null comment '问题内容',
    answer           text        null comment '答案',
    category         varchar(50) null comment '问题类型'
)
    comment '题库表';

create table reports
(
    report_id      int auto_increment comment '举报记录ID'
        primary key,
    user_id        int         null comment '举报人ID',
    plate_id       int         null comment '违规车牌ID',
    plate_number   varchar(20) null comment '车牌号',
    create_time    datetime    null comment '创建时间',
    update_time    datetime    null comment '更新时间',
    report_content text        null comment '举报内容',
    status         varchar(20) null comment '处理状态',
    score          int         null comment '扣分分值'
)
    comment '举报信息表';

create table score
(
    id         int auto_increment
        primary key,
    user_id    int                                not null,
    score      int                                not null,
    createtime datetime default CURRENT_TIMESTAMP not null
)
    comment '学法考试分数表';

create table sys_config
(
    config_id    int(5) auto_increment comment '参数主键'
        primary key,
    config_name  varchar(100) default ''  null comment '参数名称',
    config_key   varchar(100) default ''  null comment '参数键名',
    config_value varchar(500) default ''  null comment '参数键值',
    config_type  char         default 'N' null comment '系统内置（Y是 N否）',
    create_by    varchar(64)  default ''  null comment '创建者',
    create_time  datetime                 null comment '创建时间',
    update_by    varchar(64)  default ''  null comment '更新者',
    update_time  datetime                 null comment '更新时间',
    remark       varchar(500)             null comment '备注'
)
    comment '参数配置表';

create table sys_dept
(
    dept_id     bigint auto_increment comment '部门id'
        primary key,
    parent_id   bigint      default 0   null comment '父部门id',
    ancestors   varchar(50) default ''  null comment '祖级列表',
    dept_name   varchar(30) default ''  null comment '部门名称',
    order_num   int(4)      default 0   null comment '显示顺序',
    leader      varchar(20)             null comment '负责人',
    phone       varchar(11)             null comment '联系电话',
    email       varchar(50)             null comment '邮箱',
    status      char        default '0' null comment '部门状态（0正常 1停用）',
    del_flag    char        default '0' null comment '删除标志（0代表存在 2代表删除）',
    create_by   varchar(64) default ''  null comment '创建者',
    create_time datetime                null comment '创建时间',
    update_by   varchar(64) default ''  null comment '更新者',
    update_time datetime                null comment '更新时间'
)
    comment '部门表';

create table sys_dict_data
(
    dict_code   bigint auto_increment comment '字典编码'
        primary key,
    dict_sort   int(4)       default 0   null comment '字典排序',
    dict_label  varchar(100) default ''  null comment '字典标签',
    dict_value  varchar(100) default ''  null comment '字典键值',
    dict_type   varchar(100) default ''  null comment '字典类型',
    css_class   varchar(100)             null comment '样式属性（其他样式扩展）',
    list_class  varchar(100)             null comment '表格回显样式',
    is_default  char         default 'N' null comment '是否默认（Y是 N否）',
    status      char         default '0' null comment '状态（0正常 1停用）',
    create_by   varchar(64)  default ''  null comment '创建者',
    create_time datetime                 null comment '创建时间',
    update_by   varchar(64)  default ''  null comment '更新者',
    update_time datetime                 null comment '更新时间',
    remark      varchar(500)             null comment '备注'
)
    comment '字典数据表';

create table sys_dict_type
(
    dict_id     bigint auto_increment comment '字典主键'
        primary key,
    dict_name   varchar(100) default ''  null comment '字典名称',
    dict_type   varchar(100) default ''  null comment '字典类型',
    status      char         default '0' null comment '状态（0正常 1停用）',
    create_by   varchar(64)  default ''  null comment '创建者',
    create_time datetime                 null comment '创建时间',
    update_by   varchar(64)  default ''  null comment '更新者',
    update_time datetime                 null comment '更新时间',
    remark      varchar(500)             null comment '备注',
    constraint dict_type
        unique (dict_type)
)
    comment '字典类型表';

create table sys_job
(
    job_id          bigint auto_increment comment '任务ID',
    job_name        varchar(64)  default ''        not null comment '任务名称',
    job_group       varchar(64)  default 'DEFAULT' not null comment '任务组名',
    invoke_target   varchar(500)                   not null comment '调用目标字符串',
    cron_expression varchar(255) default ''        null comment 'cron执行表达式',
    misfire_policy  varchar(20)  default '3'       null comment '计划执行错误策略（1立即执行 2执行一次 3放弃执行）',
    concurrent      char         default '1'       null comment '是否并发执行（0允许 1禁止）',
    status          char         default '0'       null comment '状态（0正常 1暂停）',
    create_by       varchar(64)  default ''        null comment '创建者',
    create_time     datetime                       null comment '创建时间',
    update_by       varchar(64)  default ''        null comment '更新者',
    update_time     datetime                       null comment '更新时间',
    remark          varchar(500) default ''        null comment '备注信息',
    primary key (job_id, job_name, job_group)
)
    comment '定时任务调度表';

create table sys_job_log
(
    job_log_id     bigint auto_increment comment '任务日志ID'
        primary key,
    job_name       varchar(64)               not null comment '任务名称',
    job_group      varchar(64)               not null comment '任务组名',
    invoke_target  varchar(500)              not null comment '调用目标字符串',
    job_message    varchar(500)              null comment '日志信息',
    status         char          default '0' null comment '执行状态（0正常 1失败）',
    exception_info varchar(2000) default ''  null comment '异常信息',
    create_time    datetime                  null comment '创建时间'
)
    comment '定时任务调度日志表';

create table sys_logininfor
(
    info_id        bigint auto_increment comment '访问ID'
        primary key,
    user_name      varchar(50)  default ''  null comment '用户账号',
    ipaddr         varchar(128) default ''  null comment '登录IP地址',
    login_location varchar(255) default ''  null comment '登录地点',
    browser        varchar(50)  default ''  null comment '浏览器类型',
    os             varchar(50)  default ''  null comment '操作系统',
    status         char         default '0' null comment '登录状态（0成功 1失败）',
    msg            varchar(255) default ''  null comment '提示消息',
    login_time     datetime                 null comment '访问时间'
)
    comment '系统访问记录';

create index idx_sys_logininfor_lt
    on sys_logininfor (login_time);

create index idx_sys_logininfor_s
    on sys_logininfor (status);

create table sys_menu
(
    menu_id     bigint auto_increment comment '菜单ID'
        primary key,
    menu_name   varchar(50)              not null comment '菜单名称',
    parent_id   bigint       default 0   null comment '父菜单ID',
    order_num   int(4)       default 0   null comment '显示顺序',
    path        varchar(200) default ''  null comment '路由地址',
    component   varchar(255)             null comment '组件路径',
    query       varchar(255)             null comment '路由参数',
    route_name  varchar(50)  default ''  null comment '路由名称',
    is_frame    int(1)       default 1   null comment '是否为外链（0是 1否）',
    is_cache    int(1)       default 0   null comment '是否缓存（0缓存 1不缓存）',
    menu_type   char         default ''  null comment '菜单类型（M目录 C菜单 F按钮）',
    visible     char         default '0' null comment '菜单状态（0显示 1隐藏）',
    status      char         default '0' null comment '菜单状态（0正常 1停用）',
    perms       varchar(100)             null comment '权限标识',
    icon        varchar(100) default '#' null comment '菜单图标',
    create_by   varchar(64)  default ''  null comment '创建者',
    create_time datetime                 null comment '创建时间',
    update_by   varchar(64)  default ''  null comment '更新者',
    update_time datetime                 null comment '更新时间',
    remark      varchar(500) default ''  null comment '备注'
)
    comment '菜单权限表';

create table sys_notice
(
    notice_id      int(4) auto_increment comment '公告ID'
        primary key,
    notice_title   varchar(50)             not null comment '公告标题',
    notice_type    char                    not null comment '公告类型（1通知 2公告）',
    notice_content longblob                null comment '公告内容',
    status         char        default '0' null comment '公告状态（0正常 1关闭）',
    create_by      varchar(64) default ''  null comment '创建者',
    create_time    datetime                null comment '创建时间',
    update_by      varchar(64) default ''  null comment '更新者',
    update_time    datetime                null comment '更新时间',
    remark         varchar(255)            null comment '备注'
)
    comment '通知公告表';

create table sys_oper_log
(
    oper_id        bigint auto_increment comment '日志主键'
        primary key,
    title          varchar(50)   default '' null comment '模块标题',
    business_type  int(2)        default 0  null comment '业务类型（0其它 1新增 2修改 3删除）',
    method         varchar(200)  default '' null comment '方法名称',
    request_method varchar(10)   default '' null comment '请求方式',
    operator_type  int(1)        default 0  null comment '操作类别（0其它 1后台用户 2手机端用户）',
    oper_name      varchar(50)   default '' null comment '操作人员',
    dept_name      varchar(50)   default '' null comment '部门名称',
    oper_url       varchar(255)  default '' null comment '请求URL',
    oper_ip        varchar(128)  default '' null comment '主机地址',
    oper_location  varchar(255)  default '' null comment '操作地点',
    oper_param     varchar(2000) default '' null comment '请求参数',
    json_result    varchar(2000) default '' null comment '返回参数',
    status         int(1)        default 0  null comment '操作状态（0正常 1异常）',
    error_msg      varchar(2000) default '' null comment '错误消息',
    oper_time      datetime                 null comment '操作时间',
    cost_time      bigint        default 0  null comment '消耗时间'
)
    comment '操作日志记录';

create index idx_sys_oper_log_bt
    on sys_oper_log (business_type);

create index idx_sys_oper_log_ot
    on sys_oper_log (oper_time);

create index idx_sys_oper_log_s
    on sys_oper_log (status);

create table sys_post
(
    post_id     bigint auto_increment comment '岗位ID'
        primary key,
    post_code   varchar(64)            not null comment '岗位编码',
    post_name   varchar(50)            not null comment '岗位名称',
    post_sort   int(4)                 not null comment '显示顺序',
    status      char                   not null comment '状态（0正常 1停用）',
    create_by   varchar(64) default '' null comment '创建者',
    create_time datetime               null comment '创建时间',
    update_by   varchar(64) default '' null comment '更新者',
    update_time datetime               null comment '更新时间',
    remark      varchar(500)           null comment '备注'
)
    comment '岗位信息表';

create table sys_role
(
    role_id             bigint auto_increment comment '角色ID'
        primary key,
    role_name           varchar(30)             not null comment '角色名称',
    role_key            varchar(100)            not null comment '角色权限字符串',
    role_sort           int(4)                  not null comment '显示顺序',
    data_scope          char        default '1' null comment '数据范围（1：全部数据权限 2：自定数据权限 3：本部门数据权限 4：本部门及以下数据权限）',
    menu_check_strictly tinyint(1)  default 1   null comment '菜单树选择项是否关联显示',
    dept_check_strictly tinyint(1)  default 1   null comment '部门树选择项是否关联显示',
    status              char                    not null comment '角色状态（0正常 1停用）',
    del_flag            char        default '0' null comment '删除标志（0代表存在 2代表删除）',
    create_by           varchar(64) default ''  null comment '创建者',
    create_time         datetime                null comment '创建时间',
    update_by           varchar(64) default ''  null comment '更新者',
    update_time         datetime                null comment '更新时间',
    remark              varchar(500)            null comment '备注'
)
    comment '角色信息表';

create table sys_role_dept
(
    role_id bigint not null comment '角色ID',
    dept_id bigint not null comment '部门ID',
    primary key (role_id, dept_id)
)
    comment '角色和部门关联表';

create table sys_role_menu
(
    role_id bigint not null comment '角色ID',
    menu_id bigint not null comment '菜单ID',
    primary key (role_id, menu_id)
)
    comment '角色和菜单关联表';

create table sys_user
(
    user_id     bigint auto_increment comment '用户ID'
        primary key,
    dept_id     bigint                    null comment '部门ID',
    user_name   varchar(30)               not null comment '用户账号',
    nick_name   varchar(30)               not null comment '用户昵称',
    user_type   varchar(2)   default '00' null comment '用户类型（00系统用户）',
    email       varchar(50)  default ''   null comment '用户邮箱',
    phonenumber varchar(11)  default ''   null comment '手机号码',
    sex         char         default '0'  null comment '用户性别（0男 1女 2未知）',
    avatar      varchar(100) default ''   null comment '头像地址',
    password    varchar(100) default ''   null comment '密码',
    status      char         default '0'  null comment '帐号状态（0正常 1停用）',
    del_flag    char         default '0'  null comment '删除标志（0代表存在 2代表删除）',
    login_ip    varchar(128) default ''   null comment '最后登录IP',
    login_date  datetime                  null comment '最后登录时间',
    create_by   varchar(64)  default ''   null comment '创建者',
    create_time datetime                  null comment '创建时间',
    update_by   varchar(64)  default ''   null comment '更新者',
    update_time datetime                  null comment '更新时间',
    remark      varchar(500)              null comment '备注',
    version     int          default 0    null comment '版本'
)
    comment '用户信息表';

create table sys_user_post
(
    user_id bigint not null comment '用户ID',
    post_id bigint not null comment '岗位ID',
    primary key (user_id, post_id)
)
    comment '用户与岗位关联表';

create table sys_user_role
(
    user_id bigint not null comment '用户ID',
    role_id bigint not null comment '角色ID',
    primary key (user_id, role_id)
)
    comment '用户和角色关联表';

create table volunteer_positions
(
    volunteer_position_id int auto_increment comment '志愿岗位ID'
        primary key,
    position_type         varchar(100) not null comment '岗位类型',
    volunteer_location    varchar(200) not null comment '志愿地点',
    job_content           text         null comment '工作内容',
    deadline              datetime     null comment '截止时间',
    current_number        int          null comment '当前人数',
    required_number       int          null comment '所需人数',
    position_status       varchar(50)  not null comment '岗位状态'
)
    comment '志愿岗位表';

create table volunteer_services
(
    service_id       int auto_increment comment '志愿ID'
        primary key,
    user_id          int          null comment '志愿者ID',
    create_time      datetime     null comment '创建时间',
    update_time      datetime     null comment '更新时间',
    service_location varchar(100) null comment '志愿地点',
    description      text         null comment '描述',
    plate_id         int          null comment '车牌号id',
    score            int          null comment '加分分数',
    status           varchar(10)  null comment '状态'
)
    comment '志愿信息表';

INSERT INTO xiaoyuanjiaotong.sys_config (config_id, config_name, config_key, config_value, config_type, create_by, create_time, update_by, update_time, remark) VALUES (1, '主框架页-默认皮肤样式名称', 'sys.index.skinName', 'skin-blue', 'Y', 'admin', '2025-03-10 15:59:36', '', null, '蓝色 skin-blue、绿色 skin-green、紫色 skin-purple、红色 skin-red、黄色 skin-yellow');
INSERT INTO xiaoyuanjiaotong.sys_config (config_id, config_name, config_key, config_value, config_type, create_by, create_time, update_by, update_time, remark) VALUES (2, '用户管理-账号初始密码', 'sys.user.initPassword', '123456', 'Y', 'admin', '2025-03-10 15:59:36', '', null, '初始化密码 123456');
INSERT INTO xiaoyuanjiaotong.sys_config (config_id, config_name, config_key, config_value, config_type, create_by, create_time, update_by, update_time, remark) VALUES (3, '主框架页-侧边栏主题', 'sys.index.sideTheme', 'theme-dark', 'Y', 'admin', '2025-03-10 15:59:36', '', null, '深色主题theme-dark，浅色主题theme-light');
INSERT INTO xiaoyuanjiaotong.sys_config (config_id, config_name, config_key, config_value, config_type, create_by, create_time, update_by, update_time, remark) VALUES (4, '账号自助-验证码开关', 'sys.account.captchaEnabled', 'true', 'Y', 'admin', '2025-03-10 15:59:36', '', null, '是否开启验证码功能（true开启，false关闭）');
INSERT INTO xiaoyuanjiaotong.sys_config (config_id, config_name, config_key, config_value, config_type, create_by, create_time, update_by, update_time, remark) VALUES (5, '账号自助-是否开启用户注册功能', 'sys.account.registerUser', 'false', 'Y', 'admin', '2025-03-10 15:59:36', '', null, '是否开启注册用户功能（true开启，false关闭）');
INSERT INTO xiaoyuanjiaotong.sys_config (config_id, config_name, config_key, config_value, config_type, create_by, create_time, update_by, update_time, remark) VALUES (6, '用户登录-黑名单列表', 'sys.login.blackIPList', '', 'Y', 'admin', '2025-03-10 15:59:36', '', null, '设置登录IP黑名单限制，多个匹配项以;分隔，支持匹配（*通配、网段）');
INSERT INTO xiaoyuanjiaotong.sys_dept (dept_id, parent_id, ancestors, dept_name, order_num, leader, phone, email, status, del_flag, create_by, create_time, update_by, update_time) VALUES (100, 0, '0', '若依科技', 0, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2025-03-10 15:59:31', '', null);
INSERT INTO xiaoyuanjiaotong.sys_dept (dept_id, parent_id, ancestors, dept_name, order_num, leader, phone, email, status, del_flag, create_by, create_time, update_by, update_time) VALUES (101, 100, '0,100', '深圳总公司', 1, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2025-03-10 15:59:31', '', null);
INSERT INTO xiaoyuanjiaotong.sys_dept (dept_id, parent_id, ancestors, dept_name, order_num, leader, phone, email, status, del_flag, create_by, create_time, update_by, update_time) VALUES (102, 100, '0,100', '长沙分公司', 2, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2025-03-10 15:59:31', '', null);
INSERT INTO xiaoyuanjiaotong.sys_dept (dept_id, parent_id, ancestors, dept_name, order_num, leader, phone, email, status, del_flag, create_by, create_time, update_by, update_time) VALUES (103, 101, '0,100,101', '研发部门', 1, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2025-03-10 15:59:31', '', null);
INSERT INTO xiaoyuanjiaotong.sys_dept (dept_id, parent_id, ancestors, dept_name, order_num, leader, phone, email, status, del_flag, create_by, create_time, update_by, update_time) VALUES (104, 101, '0,100,101', '市场部门', 2, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2025-03-10 15:59:31', '', null);
INSERT INTO xiaoyuanjiaotong.sys_dept (dept_id, parent_id, ancestors, dept_name, order_num, leader, phone, email, status, del_flag, create_by, create_time, update_by, update_time) VALUES (105, 101, '0,100,101', '测试部门', 3, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2025-03-10 15:59:31', '', null);
INSERT INTO xiaoyuanjiaotong.sys_dept (dept_id, parent_id, ancestors, dept_name, order_num, leader, phone, email, status, del_flag, create_by, create_time, update_by, update_time) VALUES (106, 101, '0,100,101', '财务部门', 4, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2025-03-10 15:59:31', '', null);
INSERT INTO xiaoyuanjiaotong.sys_dept (dept_id, parent_id, ancestors, dept_name, order_num, leader, phone, email, status, del_flag, create_by, create_time, update_by, update_time) VALUES (107, 101, '0,100,101', '运维部门', 5, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2025-03-10 15:59:31', '', null);
INSERT INTO xiaoyuanjiaotong.sys_dept (dept_id, parent_id, ancestors, dept_name, order_num, leader, phone, email, status, del_flag, create_by, create_time, update_by, update_time) VALUES (108, 102, '0,100,102', '市场部门', 1, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2025-03-10 15:59:31', '', null);
INSERT INTO xiaoyuanjiaotong.sys_dept (dept_id, parent_id, ancestors, dept_name, order_num, leader, phone, email, status, del_flag, create_by, create_time, update_by, update_time) VALUES (109, 102, '0,100,102', '财务部门', 2, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2025-03-10 15:59:31', '', null);
INSERT INTO xiaoyuanjiaotong.sys_dict_data (dict_code, dict_sort, dict_label, dict_value, dict_type, css_class, list_class, is_default, status, create_by, create_time, update_by, update_time, remark) VALUES (1, 1, '男', '0', 'sys_user_sex', '', '', 'Y', '0', 'admin', '2025-03-10 15:59:35', '', null, '性别男');
INSERT INTO xiaoyuanjiaotong.sys_dict_data (dict_code, dict_sort, dict_label, dict_value, dict_type, css_class, list_class, is_default, status, create_by, create_time, update_by, update_time, remark) VALUES (2, 2, '女', '1', 'sys_user_sex', '', '', 'N', '0', 'admin', '2025-03-10 15:59:35', '', null, '性别女');
INSERT INTO xiaoyuanjiaotong.sys_dict_data (dict_code, dict_sort, dict_label, dict_value, dict_type, css_class, list_class, is_default, status, create_by, create_time, update_by, update_time, remark) VALUES (3, 3, '未知', '2', 'sys_user_sex', '', '', 'N', '0', 'admin', '2025-03-10 15:59:35', '', null, '性别未知');
INSERT INTO xiaoyuanjiaotong.sys_dict_data (dict_code, dict_sort, dict_label, dict_value, dict_type, css_class, list_class, is_default, status, create_by, create_time, update_by, update_time, remark) VALUES (4, 1, '显示', '0', 'sys_show_hide', '', 'primary', 'Y', '0', 'admin', '2025-03-10 15:59:35', '', null, '显示菜单');
INSERT INTO xiaoyuanjiaotong.sys_dict_data (dict_code, dict_sort, dict_label, dict_value, dict_type, css_class, list_class, is_default, status, create_by, create_time, update_by, update_time, remark) VALUES (5, 2, '隐藏', '1', 'sys_show_hide', '', 'danger', 'N', '0', 'admin', '2025-03-10 15:59:35', '', null, '隐藏菜单');
INSERT INTO xiaoyuanjiaotong.sys_dict_data (dict_code, dict_sort, dict_label, dict_value, dict_type, css_class, list_class, is_default, status, create_by, create_time, update_by, update_time, remark) VALUES (6, 1, '正常', '0', 'sys_normal_disable', '', 'primary', 'Y', '0', 'admin', '2025-03-10 15:59:35', '', null, '正常状态');
INSERT INTO xiaoyuanjiaotong.sys_dict_data (dict_code, dict_sort, dict_label, dict_value, dict_type, css_class, list_class, is_default, status, create_by, create_time, update_by, update_time, remark) VALUES (7, 2, '停用', '1', 'sys_normal_disable', '', 'danger', 'N', '0', 'admin', '2025-03-10 15:59:35', '', null, '停用状态');
INSERT INTO xiaoyuanjiaotong.sys_dict_data (dict_code, dict_sort, dict_label, dict_value, dict_type, css_class, list_class, is_default, status, create_by, create_time, update_by, update_time, remark) VALUES (8, 1, '正常', '0', 'sys_job_status', '', 'primary', 'Y', '0', 'admin', '2025-03-10 15:59:35', '', null, '正常状态');
INSERT INTO xiaoyuanjiaotong.sys_dict_data (dict_code, dict_sort, dict_label, dict_value, dict_type, css_class, list_class, is_default, status, create_by, create_time, update_by, update_time, remark) VALUES (9, 2, '暂停', '1', 'sys_job_status', '', 'danger', 'N', '0', 'admin', '2025-03-10 15:59:35', '', null, '停用状态');
INSERT INTO xiaoyuanjiaotong.sys_dict_data (dict_code, dict_sort, dict_label, dict_value, dict_type, css_class, list_class, is_default, status, create_by, create_time, update_by, update_time, remark) VALUES (10, 1, '默认', 'DEFAULT', 'sys_job_group', '', '', 'Y', '0', 'admin', '2025-03-10 15:59:35', '', null, '默认分组');
INSERT INTO xiaoyuanjiaotong.sys_dict_data (dict_code, dict_sort, dict_label, dict_value, dict_type, css_class, list_class, is_default, status, create_by, create_time, update_by, update_time, remark) VALUES (11, 2, '系统', 'SYSTEM', 'sys_job_group', '', '', 'N', '0', 'admin', '2025-03-10 15:59:35', '', null, '系统分组');
INSERT INTO xiaoyuanjiaotong.sys_dict_data (dict_code, dict_sort, dict_label, dict_value, dict_type, css_class, list_class, is_default, status, create_by, create_time, update_by, update_time, remark) VALUES (12, 1, '是', 'Y', 'sys_yes_no', '', 'primary', 'Y', '0', 'admin', '2025-03-10 15:59:36', '', null, '系统默认是');
INSERT INTO xiaoyuanjiaotong.sys_dict_data (dict_code, dict_sort, dict_label, dict_value, dict_type, css_class, list_class, is_default, status, create_by, create_time, update_by, update_time, remark) VALUES (13, 2, '否', 'N', 'sys_yes_no', '', 'danger', 'N', '0', 'admin', '2025-03-10 15:59:36', '', null, '系统默认否');
INSERT INTO xiaoyuanjiaotong.sys_dict_data (dict_code, dict_sort, dict_label, dict_value, dict_type, css_class, list_class, is_default, status, create_by, create_time, update_by, update_time, remark) VALUES (14, 1, '通知', '1', 'sys_notice_type', '', 'warning', 'Y', '0', 'admin', '2025-03-10 15:59:36', '', null, '通知');
INSERT INTO xiaoyuanjiaotong.sys_dict_data (dict_code, dict_sort, dict_label, dict_value, dict_type, css_class, list_class, is_default, status, create_by, create_time, update_by, update_time, remark) VALUES (15, 2, '公告', '2', 'sys_notice_type', '', 'success', 'N', '0', 'admin', '2025-03-10 15:59:36', '', null, '公告');
INSERT INTO xiaoyuanjiaotong.sys_dict_data (dict_code, dict_sort, dict_label, dict_value, dict_type, css_class, list_class, is_default, status, create_by, create_time, update_by, update_time, remark) VALUES (16, 1, '正常', '0', 'sys_notice_status', '', 'primary', 'Y', '0', 'admin', '2025-03-10 15:59:36', '', null, '正常状态');
INSERT INTO xiaoyuanjiaotong.sys_dict_data (dict_code, dict_sort, dict_label, dict_value, dict_type, css_class, list_class, is_default, status, create_by, create_time, update_by, update_time, remark) VALUES (17, 2, '关闭', '1', 'sys_notice_status', '', 'danger', 'N', '0', 'admin', '2025-03-10 15:59:36', '', null, '关闭状态');
INSERT INTO xiaoyuanjiaotong.sys_dict_data (dict_code, dict_sort, dict_label, dict_value, dict_type, css_class, list_class, is_default, status, create_by, create_time, update_by, update_time, remark) VALUES (18, 99, '其他', '0', 'sys_oper_type', '', 'info', 'N', '0', 'admin', '2025-03-10 15:59:36', '', null, '其他操作');
INSERT INTO xiaoyuanjiaotong.sys_dict_data (dict_code, dict_sort, dict_label, dict_value, dict_type, css_class, list_class, is_default, status, create_by, create_time, update_by, update_time, remark) VALUES (19, 1, '新增', '1', 'sys_oper_type', '', 'info', 'N', '0', 'admin', '2025-03-10 15:59:36', '', null, '新增操作');
INSERT INTO xiaoyuanjiaotong.sys_dict_data (dict_code, dict_sort, dict_label, dict_value, dict_type, css_class, list_class, is_default, status, create_by, create_time, update_by, update_time, remark) VALUES (20, 2, '修改', '2', 'sys_oper_type', '', 'info', 'N', '0', 'admin', '2025-03-10 15:59:36', '', null, '修改操作');
INSERT INTO xiaoyuanjiaotong.sys_dict_data (dict_code, dict_sort, dict_label, dict_value, dict_type, css_class, list_class, is_default, status, create_by, create_time, update_by, update_time, remark) VALUES (21, 3, '删除', '3', 'sys_oper_type', '', 'danger', 'N', '0', 'admin', '2025-03-10 15:59:36', '', null, '删除操作');
INSERT INTO xiaoyuanjiaotong.sys_dict_data (dict_code, dict_sort, dict_label, dict_value, dict_type, css_class, list_class, is_default, status, create_by, create_time, update_by, update_time, remark) VALUES (22, 4, '授权', '4', 'sys_oper_type', '', 'primary', 'N', '0', 'admin', '2025-03-10 15:59:36', '', null, '授权操作');
INSERT INTO xiaoyuanjiaotong.sys_dict_data (dict_code, dict_sort, dict_label, dict_value, dict_type, css_class, list_class, is_default, status, create_by, create_time, update_by, update_time, remark) VALUES (23, 5, '导出', '5', 'sys_oper_type', '', 'warning', 'N', '0', 'admin', '2025-03-10 15:59:36', '', null, '导出操作');
INSERT INTO xiaoyuanjiaotong.sys_dict_data (dict_code, dict_sort, dict_label, dict_value, dict_type, css_class, list_class, is_default, status, create_by, create_time, update_by, update_time, remark) VALUES (24, 6, '导入', '6', 'sys_oper_type', '', 'warning', 'N', '0', 'admin', '2025-03-10 15:59:36', '', null, '导入操作');
INSERT INTO xiaoyuanjiaotong.sys_dict_data (dict_code, dict_sort, dict_label, dict_value, dict_type, css_class, list_class, is_default, status, create_by, create_time, update_by, update_time, remark) VALUES (25, 7, '强退', '7', 'sys_oper_type', '', 'danger', 'N', '0', 'admin', '2025-03-10 15:59:36', '', null, '强退操作');
INSERT INTO xiaoyuanjiaotong.sys_dict_data (dict_code, dict_sort, dict_label, dict_value, dict_type, css_class, list_class, is_default, status, create_by, create_time, update_by, update_time, remark) VALUES (26, 8, '生成代码', '8', 'sys_oper_type', '', 'warning', 'N', '0', 'admin', '2025-03-10 15:59:36', '', null, '生成操作');
INSERT INTO xiaoyuanjiaotong.sys_dict_data (dict_code, dict_sort, dict_label, dict_value, dict_type, css_class, list_class, is_default, status, create_by, create_time, update_by, update_time, remark) VALUES (27, 9, '清空数据', '9', 'sys_oper_type', '', 'danger', 'N', '0', 'admin', '2025-03-10 15:59:36', '', null, '清空操作');
INSERT INTO xiaoyuanjiaotong.sys_dict_data (dict_code, dict_sort, dict_label, dict_value, dict_type, css_class, list_class, is_default, status, create_by, create_time, update_by, update_time, remark) VALUES (28, 1, '成功', '0', 'sys_common_status', '', 'primary', 'N', '0', 'admin', '2025-03-10 15:59:36', '', null, '正常状态');
INSERT INTO xiaoyuanjiaotong.sys_dict_data (dict_code, dict_sort, dict_label, dict_value, dict_type, css_class, list_class, is_default, status, create_by, create_time, update_by, update_time, remark) VALUES (29, 2, '失败', '1', 'sys_common_status', '', 'danger', 'N', '0', 'admin', '2025-03-10 15:59:36', '', null, '停用状态');
INSERT INTO xiaoyuanjiaotong.sys_dict_data (dict_code, dict_sort, dict_label, dict_value, dict_type, css_class, list_class, is_default, status, create_by, create_time, update_by, update_time, remark) VALUES (100, 0, '待处理', '待处理', 'reports', null, 'default', 'N', '0', 'admin', '2025-03-10 18:56:34', '', null, null);
INSERT INTO xiaoyuanjiaotong.sys_dict_data (dict_code, dict_sort, dict_label, dict_value, dict_type, css_class, list_class, is_default, status, create_by, create_time, update_by, update_time, remark) VALUES (101, 1, '已处理', '已处理', 'reports', null, 'default', 'N', '0', 'admin', '2025-03-10 18:56:46', '', null, null);
INSERT INTO xiaoyuanjiaotong.sys_dict_data (dict_code, dict_sort, dict_label, dict_value, dict_type, css_class, list_class, is_default, status, create_by, create_time, update_by, update_time, remark) VALUES (102, 2, '驳回', '驳回', 'reports', null, 'default', 'N', '0', 'admin', '2025-03-11 14:50:19', '', null, null);
INSERT INTO xiaoyuanjiaotong.sys_dict_data (dict_code, dict_sort, dict_label, dict_value, dict_type, css_class, list_class, is_default, status, create_by, create_time, update_by, update_time, remark) VALUES (103, 0, '已付款', '已付款', 'qian', null, 'default', 'N', '0', 'admin', '2025-03-11 15:59:46', '', null, null);
INSERT INTO xiaoyuanjiaotong.sys_dict_data (dict_code, dict_sort, dict_label, dict_value, dict_type, css_class, list_class, is_default, status, create_by, create_time, update_by, update_time, remark) VALUES (104, 0, '待付款', '待付款', 'qian', null, 'default', 'N', '0', 'admin', '2025-03-11 15:59:57', '', null, null);
INSERT INTO xiaoyuanjiaotong.sys_dict_type (dict_id, dict_name, dict_type, status, create_by, create_time, update_by, update_time, remark) VALUES (1, '用户性别', 'sys_user_sex', '0', 'admin', '2025-03-10 15:59:35', '', null, '用户性别列表');
INSERT INTO xiaoyuanjiaotong.sys_dict_type (dict_id, dict_name, dict_type, status, create_by, create_time, update_by, update_time, remark) VALUES (2, '菜单状态', 'sys_show_hide', '0', 'admin', '2025-03-10 15:59:35', '', null, '菜单状态列表');
INSERT INTO xiaoyuanjiaotong.sys_dict_type (dict_id, dict_name, dict_type, status, create_by, create_time, update_by, update_time, remark) VALUES (3, '系统开关', 'sys_normal_disable', '0', 'admin', '2025-03-10 15:59:35', '', null, '系统开关列表');
INSERT INTO xiaoyuanjiaotong.sys_dict_type (dict_id, dict_name, dict_type, status, create_by, create_time, update_by, update_time, remark) VALUES (4, '任务状态', 'sys_job_status', '0', 'admin', '2025-03-10 15:59:35', '', null, '任务状态列表');
INSERT INTO xiaoyuanjiaotong.sys_dict_type (dict_id, dict_name, dict_type, status, create_by, create_time, update_by, update_time, remark) VALUES (5, '任务分组', 'sys_job_group', '0', 'admin', '2025-03-10 15:59:35', '', null, '任务分组列表');
INSERT INTO xiaoyuanjiaotong.sys_dict_type (dict_id, dict_name, dict_type, status, create_by, create_time, update_by, update_time, remark) VALUES (6, '系统是否', 'sys_yes_no', '0', 'admin', '2025-03-10 15:59:35', '', null, '系统是否列表');
INSERT INTO xiaoyuanjiaotong.sys_dict_type (dict_id, dict_name, dict_type, status, create_by, create_time, update_by, update_time, remark) VALUES (7, '通知类型', 'sys_notice_type', '0', 'admin', '2025-03-10 15:59:35', '', null, '通知类型列表');
INSERT INTO xiaoyuanjiaotong.sys_dict_type (dict_id, dict_name, dict_type, status, create_by, create_time, update_by, update_time, remark) VALUES (8, '通知状态', 'sys_notice_status', '0', 'admin', '2025-03-10 15:59:35', '', null, '通知状态列表');
INSERT INTO xiaoyuanjiaotong.sys_dict_type (dict_id, dict_name, dict_type, status, create_by, create_time, update_by, update_time, remark) VALUES (9, '操作类型', 'sys_oper_type', '0', 'admin', '2025-03-10 15:59:35', '', null, '操作类型列表');
INSERT INTO xiaoyuanjiaotong.sys_dict_type (dict_id, dict_name, dict_type, status, create_by, create_time, update_by, update_time, remark) VALUES (10, '系统状态', 'sys_common_status', '0', 'admin', '2025-03-10 15:59:35', '', null, '登录状态列表');
INSERT INTO xiaoyuanjiaotong.sys_dict_type (dict_id, dict_name, dict_type, status, create_by, create_time, update_by, update_time, remark) VALUES (100, '举报处理', 'reports', '0', 'admin', '2025-03-10 18:55:57', '', null, null);
INSERT INTO xiaoyuanjiaotong.sys_dict_type (dict_id, dict_name, dict_type, status, create_by, create_time, update_by, update_time, remark) VALUES (101, '付款', 'qian', '0', 'admin', '2025-03-11 15:59:27', '', null, null);
INSERT INTO xiaoyuanjiaotong.sys_job (job_id, job_name, job_group, invoke_target, cron_expression, misfire_policy, concurrent, status, create_by, create_time, update_by, update_time, remark) VALUES (1, '系统默认（无参）', 'DEFAULT', 'ryTask.ryNoParams', '0/10 * * * * ?', '3', '1', '1', 'admin', '2025-03-10 15:59:36', '', null, '');
INSERT INTO xiaoyuanjiaotong.sys_job (job_id, job_name, job_group, invoke_target, cron_expression, misfire_policy, concurrent, status, create_by, create_time, update_by, update_time, remark) VALUES (2, '系统默认（有参）', 'DEFAULT', 'ryTask.ryParams(\'ry\')', '0/15 * * * * ?', '3', '1', '1', 'admin', '2025-03-10 15:59:36', '', null, '');
INSERT INTO xiaoyuanjiaotong.sys_job (job_id, job_name, job_group, invoke_target, cron_expression, misfire_policy, concurrent, status, create_by, create_time, update_by, update_time, remark) VALUES (3, '系统默认（多参）', 'DEFAULT', 'ryTask.ryMultipleParams(\'ry\', true, 2000L, 316.50D, 100)', '0/20 * * * * ?', '3', '1', '1', 'admin', '2025-03-10 15:59:36', '', null, '');
INSERT INTO xiaoyuanjiaotong.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (1, '系统管理', 0, 0, 'system', null, '', '', 1, 0, 'M', '0', '0', '', 'system', 'admin', '2025-03-10 15:59:31', 'admin', '2025-04-26 12:22:39', '系统管理目录');
INSERT INTO xiaoyuanjiaotong.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (2, '系统监控', 0, 2, 'monitor', null, '', '', 1, 0, 'M', '0', '0', '', 'monitor', 'admin', '2025-03-10 15:59:31', '', null, '系统监控目录');
INSERT INTO xiaoyuanjiaotong.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (100, '用户管理', 1, 1, 'user', 'system/user/index', '', '', 1, 0, 'C', '0', '0', 'system:user:list', 'user', 'admin', '2025-03-10 15:59:31', '', null, '用户管理菜单');
INSERT INTO xiaoyuanjiaotong.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (101, '角色管理', 1, 2, 'role', 'system/role/index', '', '', 1, 0, 'C', '0', '0', 'system:role:list', 'peoples', 'admin', '2025-03-10 15:59:32', '', null, '角色管理菜单');
INSERT INTO xiaoyuanjiaotong.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (102, '菜单管理', 1, 3, 'menu', 'system/menu/index', '', '', 1, 0, 'C', '0', '0', 'system:menu:list', 'tree-table', 'admin', '2025-03-10 15:59:32', '', null, '菜单管理菜单');
INSERT INTO xiaoyuanjiaotong.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (103, '部门管理', 1, 4, 'dept', 'system/dept/index', '', '', 1, 0, 'C', '0', '0', 'system:dept:list', 'tree', 'admin', '2025-03-10 15:59:32', '', null, '部门管理菜单');
INSERT INTO xiaoyuanjiaotong.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (104, '岗位管理', 1, 5, 'post', 'system/post/index', '', '', 1, 0, 'C', '0', '0', 'system:post:list', 'post', 'admin', '2025-03-10 15:59:32', '', null, '岗位管理菜单');
INSERT INTO xiaoyuanjiaotong.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (105, '字典管理', 1, 6, 'dict', 'system/dict/index', '', '', 1, 0, 'C', '0', '0', 'system:dict:list', 'dict', 'admin', '2025-03-10 15:59:32', '', null, '字典管理菜单');
INSERT INTO xiaoyuanjiaotong.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (106, '参数设置', 1, 7, 'config', 'system/config/index', '', '', 1, 0, 'C', '0', '0', 'system:config:list', 'edit', 'admin', '2025-03-10 15:59:32', '', null, '参数设置菜单');
INSERT INTO xiaoyuanjiaotong.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (107, '通知公告', 1, 8, 'notice', 'system/notice/index', '', '', 1, 0, 'C', '0', '0', 'system:notice:list', 'message', 'admin', '2025-03-10 15:59:32', '', null, '通知公告菜单');
INSERT INTO xiaoyuanjiaotong.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (108, '日志管理', 1, 9, 'log', '', '', '', 1, 0, 'M', '0', '0', '', 'log', 'admin', '2025-03-10 15:59:32', '', null, '日志管理菜单');
INSERT INTO xiaoyuanjiaotong.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (109, '在线用户', 2, 1, 'online', 'monitor/online/index', '', '', 1, 0, 'C', '0', '0', 'monitor:online:list', 'online', 'admin', '2025-03-10 15:59:32', '', null, '在线用户菜单');
INSERT INTO xiaoyuanjiaotong.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (110, '定时任务', 2, 2, 'job', 'monitor/job/index', '', '', 1, 0, 'C', '0', '0', 'monitor:job:list', 'job', 'admin', '2025-03-10 15:59:32', '', null, '定时任务菜单');
INSERT INTO xiaoyuanjiaotong.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (111, '数据监控', 2, 3, 'druid', 'monitor/druid/index', '', '', 1, 0, 'C', '0', '0', 'monitor:druid:list', 'druid', 'admin', '2025-03-10 15:59:32', '', null, '数据监控菜单');
INSERT INTO xiaoyuanjiaotong.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (112, '服务监控', 2, 4, 'server', 'monitor/server/index', '', '', 1, 0, 'C', '0', '0', 'monitor:server:list', 'server', 'admin', '2025-03-10 15:59:32', '', null, '服务监控菜单');
INSERT INTO xiaoyuanjiaotong.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (113, '缓存监控', 2, 5, 'cache', 'monitor/cache/index', '', '', 1, 0, 'C', '0', '0', 'monitor:cache:list', 'redis', 'admin', '2025-03-10 15:59:32', '', null, '缓存监控菜单');
INSERT INTO xiaoyuanjiaotong.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (114, '缓存列表', 2, 6, 'cacheList', 'monitor/cache/list', '', '', 1, 0, 'C', '0', '0', 'monitor:cache:list', 'redis-list', 'admin', '2025-03-10 15:59:32', '', null, '缓存列表菜单');
INSERT INTO xiaoyuanjiaotong.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (115, '表单构建', 3, 1, 'build', 'tool/build/index', '', '', 1, 0, 'C', '0', '0', 'tool:build:list', 'build', 'admin', '2025-03-10 15:59:32', 'admin', '2025-04-26 12:20:34', '表单构建菜单');
INSERT INTO xiaoyuanjiaotong.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (116, '代码生成', 3, 2, 'gen', 'tool/gen/index', '', '', 1, 0, 'C', '0', '0', 'tool:gen:list', 'code', 'admin', '2025-03-10 15:59:32', '', null, '代码生成菜单');
INSERT INTO xiaoyuanjiaotong.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (117, '系统接口', 3, 3, 'swagger', 'tool/swagger/index', '', '', 1, 0, 'C', '0', '0', 'tool:swagger:list', 'swagger', 'admin', '2025-03-10 15:59:32', '', null, '系统接口菜单');
INSERT INTO xiaoyuanjiaotong.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (500, '操作日志', 108, 1, 'operlog', 'monitor/operlog/index', '', '', 1, 0, 'C', '0', '0', 'monitor:operlog:list', 'form', 'admin', '2025-03-10 15:59:32', '', null, '操作日志菜单');
INSERT INTO xiaoyuanjiaotong.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (501, '登录日志', 108, 2, 'logininfor', 'monitor/logininfor/index', '', '', 1, 0, 'C', '0', '0', 'monitor:logininfor:list', 'logininfor', 'admin', '2025-03-10 15:59:32', '', null, '登录日志菜单');
INSERT INTO xiaoyuanjiaotong.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (1000, '用户查询', 100, 1, '', '', '', '', 1, 0, 'F', '0', '0', 'system:user:query', '#', 'admin', '2025-03-10 15:59:32', '', null, '');
INSERT INTO xiaoyuanjiaotong.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (1001, '用户新增', 100, 2, '', '', '', '', 1, 0, 'F', '0', '0', 'system:user:add', '#', 'admin', '2025-03-10 15:59:32', '', null, '');
INSERT INTO xiaoyuanjiaotong.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (1002, '用户修改', 100, 3, '', '', '', '', 1, 0, 'F', '0', '0', 'system:user:edit', '#', 'admin', '2025-03-10 15:59:32', '', null, '');
INSERT INTO xiaoyuanjiaotong.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (1003, '用户删除', 100, 4, '', '', '', '', 1, 0, 'F', '0', '0', 'system:user:remove', '#', 'admin', '2025-03-10 15:59:32', '', null, '');
INSERT INTO xiaoyuanjiaotong.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (1004, '用户导出', 100, 5, '', '', '', '', 1, 0, 'F', '0', '0', 'system:user:export', '#', 'admin', '2025-03-10 15:59:32', '', null, '');
INSERT INTO xiaoyuanjiaotong.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (1005, '用户导入', 100, 6, '', '', '', '', 1, 0, 'F', '0', '0', 'system:user:import', '#', 'admin', '2025-03-10 15:59:32', '', null, '');
INSERT INTO xiaoyuanjiaotong.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (1006, '重置密码', 100, 7, '', '', '', '', 1, 0, 'F', '0', '0', 'system:user:resetPwd', '#', 'admin', '2025-03-10 15:59:32', '', null, '');
INSERT INTO xiaoyuanjiaotong.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (1007, '角色查询', 101, 1, '', '', '', '', 1, 0, 'F', '0', '0', 'system:role:query', '#', 'admin', '2025-03-10 15:59:32', '', null, '');
INSERT INTO xiaoyuanjiaotong.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (1008, '角色新增', 101, 2, '', '', '', '', 1, 0, 'F', '0', '0', 'system:role:add', '#', 'admin', '2025-03-10 15:59:32', '', null, '');
INSERT INTO xiaoyuanjiaotong.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (1009, '角色修改', 101, 3, '', '', '', '', 1, 0, 'F', '0', '0', 'system:role:edit', '#', 'admin', '2025-03-10 15:59:32', '', null, '');
INSERT INTO xiaoyuanjiaotong.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (1010, '角色删除', 101, 4, '', '', '', '', 1, 0, 'F', '0', '0', 'system:role:remove', '#', 'admin', '2025-03-10 15:59:32', '', null, '');
INSERT INTO xiaoyuanjiaotong.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (1011, '角色导出', 101, 5, '', '', '', '', 1, 0, 'F', '0', '0', 'system:role:export', '#', 'admin', '2025-03-10 15:59:32', '', null, '');
INSERT INTO xiaoyuanjiaotong.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (1012, '菜单查询', 102, 1, '', '', '', '', 1, 0, 'F', '0', '0', 'system:menu:query', '#', 'admin', '2025-03-10 15:59:32', '', null, '');
INSERT INTO xiaoyuanjiaotong.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (1013, '菜单新增', 102, 2, '', '', '', '', 1, 0, 'F', '0', '0', 'system:menu:add', '#', 'admin', '2025-03-10 15:59:33', '', null, '');
INSERT INTO xiaoyuanjiaotong.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (1014, '菜单修改', 102, 3, '', '', '', '', 1, 0, 'F', '0', '0', 'system:menu:edit', '#', 'admin', '2025-03-10 15:59:33', '', null, '');
INSERT INTO xiaoyuanjiaotong.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (1015, '菜单删除', 102, 4, '', '', '', '', 1, 0, 'F', '0', '0', 'system:menu:remove', '#', 'admin', '2025-03-10 15:59:33', '', null, '');
INSERT INTO xiaoyuanjiaotong.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (1016, '部门查询', 103, 1, '', '', '', '', 1, 0, 'F', '0', '0', 'system:dept:query', '#', 'admin', '2025-03-10 15:59:33', '', null, '');
INSERT INTO xiaoyuanjiaotong.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (1017, '部门新增', 103, 2, '', '', '', '', 1, 0, 'F', '0', '0', 'system:dept:add', '#', 'admin', '2025-03-10 15:59:33', '', null, '');
INSERT INTO xiaoyuanjiaotong.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (1018, '部门修改', 103, 3, '', '', '', '', 1, 0, 'F', '0', '0', 'system:dept:edit', '#', 'admin', '2025-03-10 15:59:33', '', null, '');
INSERT INTO xiaoyuanjiaotong.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (1019, '部门删除', 103, 4, '', '', '', '', 1, 0, 'F', '0', '0', 'system:dept:remove', '#', 'admin', '2025-03-10 15:59:33', '', null, '');
INSERT INTO xiaoyuanjiaotong.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (1020, '岗位查询', 104, 1, '', '', '', '', 1, 0, 'F', '0', '0', 'system:post:query', '#', 'admin', '2025-03-10 15:59:33', '', null, '');
INSERT INTO xiaoyuanjiaotong.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (1021, '岗位新增', 104, 2, '', '', '', '', 1, 0, 'F', '0', '0', 'system:post:add', '#', 'admin', '2025-03-10 15:59:33', '', null, '');
INSERT INTO xiaoyuanjiaotong.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (1022, '岗位修改', 104, 3, '', '', '', '', 1, 0, 'F', '0', '0', 'system:post:edit', '#', 'admin', '2025-03-10 15:59:33', '', null, '');
INSERT INTO xiaoyuanjiaotong.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (1023, '岗位删除', 104, 4, '', '', '', '', 1, 0, 'F', '0', '0', 'system:post:remove', '#', 'admin', '2025-03-10 15:59:33', '', null, '');
INSERT INTO xiaoyuanjiaotong.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (1024, '岗位导出', 104, 5, '', '', '', '', 1, 0, 'F', '0', '0', 'system:post:export', '#', 'admin', '2025-03-10 15:59:33', '', null, '');
INSERT INTO xiaoyuanjiaotong.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (1025, '字典查询', 105, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:dict:query', '#', 'admin', '2025-03-10 15:59:33', '', null, '');
INSERT INTO xiaoyuanjiaotong.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (1026, '字典新增', 105, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:dict:add', '#', 'admin', '2025-03-10 15:59:33', '', null, '');
INSERT INTO xiaoyuanjiaotong.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (1027, '字典修改', 105, 3, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:dict:edit', '#', 'admin', '2025-03-10 15:59:33', '', null, '');
INSERT INTO xiaoyuanjiaotong.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (1028, '字典删除', 105, 4, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:dict:remove', '#', 'admin', '2025-03-10 15:59:33', '', null, '');
INSERT INTO xiaoyuanjiaotong.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (1029, '字典导出', 105, 5, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:dict:export', '#', 'admin', '2025-03-10 15:59:33', '', null, '');
INSERT INTO xiaoyuanjiaotong.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (1030, '参数查询', 106, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:config:query', '#', 'admin', '2025-03-10 15:59:33', '', null, '');
INSERT INTO xiaoyuanjiaotong.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (1031, '参数新增', 106, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:config:add', '#', 'admin', '2025-03-10 15:59:33', '', null, '');
INSERT INTO xiaoyuanjiaotong.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (1032, '参数修改', 106, 3, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:config:edit', '#', 'admin', '2025-03-10 15:59:33', '', null, '');
INSERT INTO xiaoyuanjiaotong.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (1033, '参数删除', 106, 4, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:config:remove', '#', 'admin', '2025-03-10 15:59:33', '', null, '');
INSERT INTO xiaoyuanjiaotong.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (1034, '参数导出', 106, 5, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:config:export', '#', 'admin', '2025-03-10 15:59:33', '', null, '');
INSERT INTO xiaoyuanjiaotong.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (1035, '公告查询', 107, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:notice:query', '#', 'admin', '2025-03-10 15:59:33', '', null, '');
INSERT INTO xiaoyuanjiaotong.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (1036, '公告新增', 107, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:notice:add', '#', 'admin', '2025-03-10 15:59:33', '', null, '');
INSERT INTO xiaoyuanjiaotong.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (1037, '公告修改', 107, 3, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:notice:edit', '#', 'admin', '2025-03-10 15:59:33', '', null, '');
INSERT INTO xiaoyuanjiaotong.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (1038, '公告删除', 107, 4, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:notice:remove', '#', 'admin', '2025-03-10 15:59:33', '', null, '');
INSERT INTO xiaoyuanjiaotong.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (1039, '操作查询', 500, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:operlog:query', '#', 'admin', '2025-03-10 15:59:33', '', null, '');
INSERT INTO xiaoyuanjiaotong.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (1040, '操作删除', 500, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:operlog:remove', '#', 'admin', '2025-03-10 15:59:33', '', null, '');
INSERT INTO xiaoyuanjiaotong.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (1041, '日志导出', 500, 3, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:operlog:export', '#', 'admin', '2025-03-10 15:59:33', '', null, '');
INSERT INTO xiaoyuanjiaotong.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (1042, '登录查询', 501, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:logininfor:query', '#', 'admin', '2025-03-10 15:59:33', '', null, '');
INSERT INTO xiaoyuanjiaotong.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (1043, '登录删除', 501, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:logininfor:remove', '#', 'admin', '2025-03-10 15:59:33', '', null, '');
INSERT INTO xiaoyuanjiaotong.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (1044, '日志导出', 501, 3, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:logininfor:export', '#', 'admin', '2025-03-10 15:59:33', '', null, '');
INSERT INTO xiaoyuanjiaotong.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (1045, '账户解锁', 501, 4, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:logininfor:unlock', '#', 'admin', '2025-03-10 15:59:33', '', null, '');
INSERT INTO xiaoyuanjiaotong.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (1046, '在线查询', 109, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:online:query', '#', 'admin', '2025-03-10 15:59:33', '', null, '');
INSERT INTO xiaoyuanjiaotong.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (1047, '批量强退', 109, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:online:batchLogout', '#', 'admin', '2025-03-10 15:59:33', '', null, '');
INSERT INTO xiaoyuanjiaotong.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (1048, '单条强退', 109, 3, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:online:forceLogout', '#', 'admin', '2025-03-10 15:59:33', '', null, '');
INSERT INTO xiaoyuanjiaotong.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (1049, '任务查询', 110, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:job:query', '#', 'admin', '2025-03-10 15:59:33', '', null, '');
INSERT INTO xiaoyuanjiaotong.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (1050, '任务新增', 110, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:job:add', '#', 'admin', '2025-03-10 15:59:33', '', null, '');
INSERT INTO xiaoyuanjiaotong.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (1051, '任务修改', 110, 3, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:job:edit', '#', 'admin', '2025-03-10 15:59:33', '', null, '');
INSERT INTO xiaoyuanjiaotong.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (1052, '任务删除', 110, 4, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:job:remove', '#', 'admin', '2025-03-10 15:59:33', '', null, '');
INSERT INTO xiaoyuanjiaotong.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (1053, '状态修改', 110, 5, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:job:changeStatus', '#', 'admin', '2025-03-10 15:59:33', '', null, '');
INSERT INTO xiaoyuanjiaotong.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (1054, '任务导出', 110, 6, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:job:export', '#', 'admin', '2025-03-10 15:59:33', '', null, '');
INSERT INTO xiaoyuanjiaotong.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (1055, '生成查询', 116, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'tool:gen:query', '#', 'admin', '2025-03-10 15:59:33', '', null, '');
INSERT INTO xiaoyuanjiaotong.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (1056, '生成修改', 116, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'tool:gen:edit', '#', 'admin', '2025-03-10 15:59:33', '', null, '');
INSERT INTO xiaoyuanjiaotong.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (1057, '生成删除', 116, 3, '#', '', '', '', 1, 0, 'F', '0', '0', 'tool:gen:remove', '#', 'admin', '2025-03-10 15:59:33', '', null, '');
INSERT INTO xiaoyuanjiaotong.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (1058, '导入代码', 116, 4, '#', '', '', '', 1, 0, 'F', '0', '0', 'tool:gen:import', '#', 'admin', '2025-03-10 15:59:33', '', null, '');
INSERT INTO xiaoyuanjiaotong.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (1059, '预览代码', 116, 5, '#', '', '', '', 1, 0, 'F', '0', '0', 'tool:gen:preview', '#', 'admin', '2025-03-10 15:59:33', '', null, '');
INSERT INTO xiaoyuanjiaotong.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (1060, '生成代码', 116, 6, '#', '', '', '', 1, 0, 'F', '0', '0', 'tool:gen:code', '#', 'admin', '2025-03-10 15:59:33', '', null, '');
INSERT INTO xiaoyuanjiaotong.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (2006, '车牌管理', 0, 1, 'plates', 'manage/plates/index', null, '', 1, 0, 'C', '0', '0', 'manage:plates:list', 'row', 'admin', '2025-03-10 19:04:56', 'admin', '2025-03-11 16:09:50', '车牌菜单');
INSERT INTO xiaoyuanjiaotong.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (2007, '车牌查询', 2006, 1, '#', '', null, '', 1, 0, 'F', '0', '0', 'manage:plates:query', '#', 'admin', '2025-03-10 19:04:56', '', null, '');
INSERT INTO xiaoyuanjiaotong.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (2008, '车牌新增', 2006, 2, '#', '', null, '', 1, 0, 'F', '0', '0', 'manage:plates:add', '#', 'admin', '2025-03-10 19:04:56', '', null, '');
INSERT INTO xiaoyuanjiaotong.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (2009, '车牌修改', 2006, 3, '#', '', null, '', 1, 0, 'F', '0', '0', 'manage:plates:edit', '#', 'admin', '2025-03-10 19:04:56', '', null, '');
INSERT INTO xiaoyuanjiaotong.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (2010, '车牌删除', 2006, 4, '#', '', null, '', 1, 0, 'F', '0', '0', 'manage:plates:remove', '#', 'admin', '2025-03-10 19:04:56', '', null, '');
INSERT INTO xiaoyuanjiaotong.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (2011, '车牌导出', 2006, 5, '#', '', null, '', 1, 0, 'F', '0', '0', 'manage:plates:export', '#', 'admin', '2025-03-10 19:04:56', '', null, '');
INSERT INTO xiaoyuanjiaotong.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (2012, '题库管理', 0, 1, 'questions', 'manage/questions/index', null, '', 1, 0, 'C', '0', '0', 'manage:questions:list', 'education', 'admin', '2025-03-10 19:05:11', 'admin', '2025-03-11 16:10:02', '题库菜单');
INSERT INTO xiaoyuanjiaotong.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (2013, '题库查询', 2012, 1, '#', '', null, '', 1, 0, 'F', '0', '0', 'manage:questions:query', '#', 'admin', '2025-03-10 19:05:11', '', null, '');
INSERT INTO xiaoyuanjiaotong.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (2014, '题库新增', 2012, 2, '#', '', null, '', 1, 0, 'F', '0', '0', 'manage:questions:add', '#', 'admin', '2025-03-10 19:05:11', '', null, '');
INSERT INTO xiaoyuanjiaotong.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (2015, '题库修改', 2012, 3, '#', '', null, '', 1, 0, 'F', '0', '0', 'manage:questions:edit', '#', 'admin', '2025-03-10 19:05:11', '', null, '');
INSERT INTO xiaoyuanjiaotong.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (2016, '题库删除', 2012, 4, '#', '', null, '', 1, 0, 'F', '0', '0', 'manage:questions:remove', '#', 'admin', '2025-03-10 19:05:11', '', null, '');
INSERT INTO xiaoyuanjiaotong.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (2017, '题库导出', 2012, 5, '#', '', null, '', 1, 0, 'F', '0', '0', 'manage:questions:export', '#', 'admin', '2025-03-10 19:05:11', '', null, '');
INSERT INTO xiaoyuanjiaotong.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (2018, '充电记录管理', 0, 1, 'records', 'manage/records/index', null, '', 1, 0, 'C', '0', '0', 'manage:records:list', 'money', 'admin', '2025-03-10 19:05:25', 'admin', '2025-03-11 16:10:09', '充电记录菜单');
INSERT INTO xiaoyuanjiaotong.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (2019, '充电记录查询', 2018, 1, '#', '', null, '', 1, 0, 'F', '0', '0', 'manage:records:query', '#', 'admin', '2025-03-10 19:05:25', '', null, '');
INSERT INTO xiaoyuanjiaotong.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (2020, '充电记录新增', 2018, 2, '#', '', null, '', 1, 0, 'F', '0', '0', 'manage:records:add', '#', 'admin', '2025-03-10 19:05:25', '', null, '');
INSERT INTO xiaoyuanjiaotong.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (2021, '充电记录修改', 2018, 3, '#', '', null, '', 1, 0, 'F', '0', '0', 'manage:records:edit', '#', 'admin', '2025-03-10 19:05:25', '', null, '');
INSERT INTO xiaoyuanjiaotong.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (2022, '充电记录删除', 2018, 4, '#', '', null, '', 1, 0, 'F', '0', '0', 'manage:records:remove', '#', 'admin', '2025-03-10 19:05:25', '', null, '');
INSERT INTO xiaoyuanjiaotong.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (2023, '充电记录导出', 2018, 5, '#', '', null, '', 1, 0, 'F', '0', '0', 'manage:records:export', '#', 'admin', '2025-03-10 19:05:25', '', null, '');
INSERT INTO xiaoyuanjiaotong.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (2024, '举报信息管理', 0, 1, 'reports', 'manage/reports/index', null, '', 1, 0, 'C', '0', '0', 'manage:reports:list', 'bug', 'admin', '2025-03-10 19:05:46', 'admin', '2025-03-11 16:10:20', '举报信息菜单');
INSERT INTO xiaoyuanjiaotong.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (2025, '举报信息查询', 2024, 1, '#', '', null, '', 1, 0, 'F', '0', '0', 'manage:reports:query', '#', 'admin', '2025-03-10 19:05:46', '', null, '');
INSERT INTO xiaoyuanjiaotong.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (2026, '举报信息新增', 2024, 2, '#', '', null, '', 1, 0, 'F', '0', '0', 'manage:reports:add', '#', 'admin', '2025-03-10 19:05:46', '', null, '');
INSERT INTO xiaoyuanjiaotong.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (2027, '举报信息修改', 2024, 3, '#', '', null, '', 1, 0, 'F', '0', '0', 'manage:reports:edit', '#', 'admin', '2025-03-10 19:05:46', '', null, '');
INSERT INTO xiaoyuanjiaotong.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (2028, '举报信息删除', 2024, 4, '#', '', null, '', 1, 0, 'F', '0', '0', 'manage:reports:remove', '#', 'admin', '2025-03-10 19:05:46', '', null, '');
INSERT INTO xiaoyuanjiaotong.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (2029, '举报信息导出', 2024, 5, '#', '', null, '', 1, 0, 'F', '0', '0', 'manage:reports:export', '#', 'admin', '2025-03-10 19:05:46', '', null, '');
INSERT INTO xiaoyuanjiaotong.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (2030, '志愿信息管理', 0, 1, 'services', 'manage/services/index', null, '', 1, 0, 'C', '0', '0', 'manage:services:list', 'guide', 'admin', '2025-03-10 19:06:05', 'admin', '2025-03-11 16:10:48', '志愿信息菜单');
INSERT INTO xiaoyuanjiaotong.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (2031, '志愿信息查询', 2030, 1, '#', '', null, '', 1, 0, 'F', '0', '0', 'manage:services:query', '#', 'admin', '2025-03-10 19:06:05', '', null, '');
INSERT INTO xiaoyuanjiaotong.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (2032, '志愿信息新增', 2030, 2, '#', '', null, '', 1, 0, 'F', '0', '0', 'manage:services:add', '#', 'admin', '2025-03-10 19:06:05', '', null, '');
INSERT INTO xiaoyuanjiaotong.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (2033, '志愿信息修改', 2030, 3, '#', '', null, '', 1, 0, 'F', '0', '0', 'manage:services:edit', '#', 'admin', '2025-03-10 19:06:05', '', null, '');
INSERT INTO xiaoyuanjiaotong.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (2034, '志愿信息删除', 2030, 4, '#', '', null, '', 1, 0, 'F', '0', '0', 'manage:services:remove', '#', 'admin', '2025-03-10 19:06:05', '', null, '');
INSERT INTO xiaoyuanjiaotong.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (2035, '志愿信息导出', 2030, 5, '#', '', null, '', 1, 0, 'F', '0', '0', 'manage:services:export', '#', 'admin', '2025-03-10 19:06:05', '', null, '');
INSERT INTO xiaoyuanjiaotong.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (2036, '充电桩', 0, 1, 'chargingstations', 'manage/chargingstations/index', null, '', 1, 0, 'C', '0', '0', 'manage:chargingstations:list', 'international', 'admin', '2025-04-26 12:09:44', 'admin', '2025-04-26 12:23:32', '充电桩菜单');
INSERT INTO xiaoyuanjiaotong.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (2037, '充电桩查询', 2036, 1, '#', '', null, '', 1, 0, 'F', '0', '0', 'manage:chargingstations:query', '#', 'admin', '2025-04-26 12:09:44', '', null, '');
INSERT INTO xiaoyuanjiaotong.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (2038, '充电桩新增', 2036, 2, '#', '', null, '', 1, 0, 'F', '0', '0', 'manage:chargingstations:add', '#', 'admin', '2025-04-26 12:09:44', '', null, '');
INSERT INTO xiaoyuanjiaotong.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (2039, '充电桩修改', 2036, 3, '#', '', null, '', 1, 0, 'F', '0', '0', 'manage:chargingstations:edit', '#', 'admin', '2025-04-26 12:09:44', '', null, '');
INSERT INTO xiaoyuanjiaotong.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (2040, '充电桩删除', 2036, 4, '#', '', null, '', 1, 0, 'F', '0', '0', 'manage:chargingstations:remove', '#', 'admin', '2025-04-26 12:09:44', '', null, '');
INSERT INTO xiaoyuanjiaotong.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (2041, '充电桩导出', 2036, 5, '#', '', null, '', 1, 0, 'F', '0', '0', 'manage:chargingstations:export', '#', 'admin', '2025-04-26 12:09:44', '', null, '');
INSERT INTO xiaoyuanjiaotong.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (2042, '志愿岗位', 0, 1, 'positions', 'manage/positions/index', null, '', 1, 0, 'C', '0', '0', 'manage:positions:list', 'job', 'admin', '2025-04-26 12:09:44', 'admin', '2025-04-26 12:23:50', '志愿岗位菜单');
INSERT INTO xiaoyuanjiaotong.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (2043, '志愿岗位查询', 2042, 1, '#', '', null, '', 1, 0, 'F', '0', '0', 'manage:positions:query', '#', 'admin', '2025-04-26 12:09:44', '', null, '');
INSERT INTO xiaoyuanjiaotong.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (2044, '志愿岗位新增', 2042, 2, '#', '', null, '', 1, 0, 'F', '0', '0', 'manage:positions:add', '#', 'admin', '2025-04-26 12:09:44', '', null, '');
INSERT INTO xiaoyuanjiaotong.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (2045, '志愿岗位修改', 2042, 3, '#', '', null, '', 1, 0, 'F', '0', '0', 'manage:positions:edit', '#', 'admin', '2025-04-26 12:09:44', '', null, '');
INSERT INTO xiaoyuanjiaotong.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (2046, '志愿岗位删除', 2042, 4, '#', '', null, '', 1, 0, 'F', '0', '0', 'manage:positions:remove', '#', 'admin', '2025-04-26 12:09:44', '', null, '');
INSERT INTO xiaoyuanjiaotong.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (2047, '志愿岗位导出', 2042, 5, '#', '', null, '', 1, 0, 'F', '0', '0', 'manage:positions:export', '#', 'admin', '2025-04-26 12:09:45', '', null, '');
INSERT INTO xiaoyuanjiaotong.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (2048, '学法考试分数', 0, 1, 'score', 'manage/score/index', null, '', 1, 0, 'C', '0', '0', 'manage:score:list', 'form', 'admin', '2025-04-26 12:09:45', 'admin', '2025-04-26 12:23:23', '学法考试分数菜单');
INSERT INTO xiaoyuanjiaotong.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (2049, '学法考试分数查询', 2048, 1, '#', '', null, '', 1, 0, 'F', '0', '0', 'manage:score:query', '#', 'admin', '2025-04-26 12:09:45', '', null, '');
INSERT INTO xiaoyuanjiaotong.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (2050, '学法考试分数新增', 2048, 2, '#', '', null, '', 1, 0, 'F', '0', '0', 'manage:score:add', '#', 'admin', '2025-04-26 12:09:45', '', null, '');
INSERT INTO xiaoyuanjiaotong.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (2051, '学法考试分数修改', 2048, 3, '#', '', null, '', 1, 0, 'F', '0', '0', 'manage:score:edit', '#', 'admin', '2025-04-26 12:09:45', '', null, '');
INSERT INTO xiaoyuanjiaotong.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (2052, '学法考试分数删除', 2048, 4, '#', '', null, '', 1, 0, 'F', '0', '0', 'manage:score:remove', '#', 'admin', '2025-04-26 12:09:45', '', null, '');
INSERT INTO xiaoyuanjiaotong.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (2053, '学法考试分数导出', 2048, 5, '#', '', null, '', 1, 0, 'F', '0', '0', 'manage:score:export', '#', 'admin', '2025-04-26 12:09:45', '', null, '');
INSERT INTO xiaoyuanjiaotong.sys_post (post_id, post_code, post_name, post_sort, status, create_by, create_time, update_by, update_time, remark) VALUES (1, 'ceo', '董事长', 1, '0', 'admin', '2025-03-10 15:59:31', '', null, '');
INSERT INTO xiaoyuanjiaotong.sys_post (post_id, post_code, post_name, post_sort, status, create_by, create_time, update_by, update_time, remark) VALUES (2, 'se', '项目经理', 2, '0', 'admin', '2025-03-10 15:59:31', '', null, '');
INSERT INTO xiaoyuanjiaotong.sys_post (post_id, post_code, post_name, post_sort, status, create_by, create_time, update_by, update_time, remark) VALUES (3, 'hr', '人力资源', 3, '0', 'admin', '2025-03-10 15:59:31', '', null, '');
INSERT INTO xiaoyuanjiaotong.sys_post (post_id, post_code, post_name, post_sort, status, create_by, create_time, update_by, update_time, remark) VALUES (4, 'user', '普通员工', 4, '0', 'admin', '2025-03-10 15:59:31', '', null, '');
INSERT INTO xiaoyuanjiaotong.sys_role (role_id, role_name, role_key, role_sort, data_scope, menu_check_strictly, dept_check_strictly, status, del_flag, create_by, create_time, update_by, update_time, remark) VALUES (1, '超级管理员', 'admin', 1, '1', 1, 1, '0', '0', 'admin', '2025-03-10 15:59:31', '', null, '超级管理员');
INSERT INTO xiaoyuanjiaotong.sys_role (role_id, role_name, role_key, role_sort, data_scope, menu_check_strictly, dept_check_strictly, status, del_flag, create_by, create_time, update_by, update_time, remark) VALUES (2, '普通角色', 'common', 2, '2', 1, 0, '0', '0', 'admin', '2025-03-10 15:59:31', '', '2025-03-11 15:46:37', '普通角色');
INSERT INTO xiaoyuanjiaotong.sys_role_menu (role_id, menu_id) VALUES (2, 1);
INSERT INTO xiaoyuanjiaotong.sys_role_menu (role_id, menu_id) VALUES (2, 2);
INSERT INTO xiaoyuanjiaotong.sys_role_menu (role_id, menu_id) VALUES (2, 3);
INSERT INTO xiaoyuanjiaotong.sys_role_menu (role_id, menu_id) VALUES (2, 4);
INSERT INTO xiaoyuanjiaotong.sys_role_menu (role_id, menu_id) VALUES (2, 100);
INSERT INTO xiaoyuanjiaotong.sys_role_menu (role_id, menu_id) VALUES (2, 101);
INSERT INTO xiaoyuanjiaotong.sys_role_menu (role_id, menu_id) VALUES (2, 102);
INSERT INTO xiaoyuanjiaotong.sys_role_menu (role_id, menu_id) VALUES (2, 103);
INSERT INTO xiaoyuanjiaotong.sys_role_menu (role_id, menu_id) VALUES (2, 104);
INSERT INTO xiaoyuanjiaotong.sys_role_menu (role_id, menu_id) VALUES (2, 105);
INSERT INTO xiaoyuanjiaotong.sys_role_menu (role_id, menu_id) VALUES (2, 106);
INSERT INTO xiaoyuanjiaotong.sys_role_menu (role_id, menu_id) VALUES (2, 107);
INSERT INTO xiaoyuanjiaotong.sys_role_menu (role_id, menu_id) VALUES (2, 108);
INSERT INTO xiaoyuanjiaotong.sys_role_menu (role_id, menu_id) VALUES (2, 109);
INSERT INTO xiaoyuanjiaotong.sys_role_menu (role_id, menu_id) VALUES (2, 110);
INSERT INTO xiaoyuanjiaotong.sys_role_menu (role_id, menu_id) VALUES (2, 111);
INSERT INTO xiaoyuanjiaotong.sys_role_menu (role_id, menu_id) VALUES (2, 112);
INSERT INTO xiaoyuanjiaotong.sys_role_menu (role_id, menu_id) VALUES (2, 113);
INSERT INTO xiaoyuanjiaotong.sys_role_menu (role_id, menu_id) VALUES (2, 114);
INSERT INTO xiaoyuanjiaotong.sys_role_menu (role_id, menu_id) VALUES (2, 115);
INSERT INTO xiaoyuanjiaotong.sys_role_menu (role_id, menu_id) VALUES (2, 116);
INSERT INTO xiaoyuanjiaotong.sys_role_menu (role_id, menu_id) VALUES (2, 117);
INSERT INTO xiaoyuanjiaotong.sys_role_menu (role_id, menu_id) VALUES (2, 500);
INSERT INTO xiaoyuanjiaotong.sys_role_menu (role_id, menu_id) VALUES (2, 501);
INSERT INTO xiaoyuanjiaotong.sys_role_menu (role_id, menu_id) VALUES (2, 1000);
INSERT INTO xiaoyuanjiaotong.sys_role_menu (role_id, menu_id) VALUES (2, 1001);
INSERT INTO xiaoyuanjiaotong.sys_role_menu (role_id, menu_id) VALUES (2, 1002);
INSERT INTO xiaoyuanjiaotong.sys_role_menu (role_id, menu_id) VALUES (2, 1003);
INSERT INTO xiaoyuanjiaotong.sys_role_menu (role_id, menu_id) VALUES (2, 1004);
INSERT INTO xiaoyuanjiaotong.sys_role_menu (role_id, menu_id) VALUES (2, 1005);
INSERT INTO xiaoyuanjiaotong.sys_role_menu (role_id, menu_id) VALUES (2, 1006);
INSERT INTO xiaoyuanjiaotong.sys_role_menu (role_id, menu_id) VALUES (2, 1007);
INSERT INTO xiaoyuanjiaotong.sys_role_menu (role_id, menu_id) VALUES (2, 1008);
INSERT INTO xiaoyuanjiaotong.sys_role_menu (role_id, menu_id) VALUES (2, 1009);
INSERT INTO xiaoyuanjiaotong.sys_role_menu (role_id, menu_id) VALUES (2, 1010);
INSERT INTO xiaoyuanjiaotong.sys_role_menu (role_id, menu_id) VALUES (2, 1011);
INSERT INTO xiaoyuanjiaotong.sys_role_menu (role_id, menu_id) VALUES (2, 1012);
INSERT INTO xiaoyuanjiaotong.sys_role_menu (role_id, menu_id) VALUES (2, 1013);
INSERT INTO xiaoyuanjiaotong.sys_role_menu (role_id, menu_id) VALUES (2, 1014);
INSERT INTO xiaoyuanjiaotong.sys_role_menu (role_id, menu_id) VALUES (2, 1015);
INSERT INTO xiaoyuanjiaotong.sys_role_menu (role_id, menu_id) VALUES (2, 1016);
INSERT INTO xiaoyuanjiaotong.sys_role_menu (role_id, menu_id) VALUES (2, 1017);
INSERT INTO xiaoyuanjiaotong.sys_role_menu (role_id, menu_id) VALUES (2, 1018);
INSERT INTO xiaoyuanjiaotong.sys_role_menu (role_id, menu_id) VALUES (2, 1019);
INSERT INTO xiaoyuanjiaotong.sys_role_menu (role_id, menu_id) VALUES (2, 1020);
INSERT INTO xiaoyuanjiaotong.sys_role_menu (role_id, menu_id) VALUES (2, 1021);
INSERT INTO xiaoyuanjiaotong.sys_role_menu (role_id, menu_id) VALUES (2, 1022);
INSERT INTO xiaoyuanjiaotong.sys_role_menu (role_id, menu_id) VALUES (2, 1023);
INSERT INTO xiaoyuanjiaotong.sys_role_menu (role_id, menu_id) VALUES (2, 1024);
INSERT INTO xiaoyuanjiaotong.sys_role_menu (role_id, menu_id) VALUES (2, 1025);
INSERT INTO xiaoyuanjiaotong.sys_role_menu (role_id, menu_id) VALUES (2, 1026);
INSERT INTO xiaoyuanjiaotong.sys_role_menu (role_id, menu_id) VALUES (2, 1027);
INSERT INTO xiaoyuanjiaotong.sys_role_menu (role_id, menu_id) VALUES (2, 1028);
INSERT INTO xiaoyuanjiaotong.sys_role_menu (role_id, menu_id) VALUES (2, 1029);
INSERT INTO xiaoyuanjiaotong.sys_role_menu (role_id, menu_id) VALUES (2, 1030);
INSERT INTO xiaoyuanjiaotong.sys_role_menu (role_id, menu_id) VALUES (2, 1031);
INSERT INTO xiaoyuanjiaotong.sys_role_menu (role_id, menu_id) VALUES (2, 1032);
INSERT INTO xiaoyuanjiaotong.sys_role_menu (role_id, menu_id) VALUES (2, 1033);
INSERT INTO xiaoyuanjiaotong.sys_role_menu (role_id, menu_id) VALUES (2, 1034);
INSERT INTO xiaoyuanjiaotong.sys_role_menu (role_id, menu_id) VALUES (2, 1035);
INSERT INTO xiaoyuanjiaotong.sys_role_menu (role_id, menu_id) VALUES (2, 1036);
INSERT INTO xiaoyuanjiaotong.sys_role_menu (role_id, menu_id) VALUES (2, 1037);
INSERT INTO xiaoyuanjiaotong.sys_role_menu (role_id, menu_id) VALUES (2, 1038);
INSERT INTO xiaoyuanjiaotong.sys_role_menu (role_id, menu_id) VALUES (2, 1039);
INSERT INTO xiaoyuanjiaotong.sys_role_menu (role_id, menu_id) VALUES (2, 1040);
INSERT INTO xiaoyuanjiaotong.sys_role_menu (role_id, menu_id) VALUES (2, 1041);
INSERT INTO xiaoyuanjiaotong.sys_role_menu (role_id, menu_id) VALUES (2, 1042);
INSERT INTO xiaoyuanjiaotong.sys_role_menu (role_id, menu_id) VALUES (2, 1043);
INSERT INTO xiaoyuanjiaotong.sys_role_menu (role_id, menu_id) VALUES (2, 1044);
INSERT INTO xiaoyuanjiaotong.sys_role_menu (role_id, menu_id) VALUES (2, 1045);
INSERT INTO xiaoyuanjiaotong.sys_role_menu (role_id, menu_id) VALUES (2, 1046);
INSERT INTO xiaoyuanjiaotong.sys_role_menu (role_id, menu_id) VALUES (2, 1047);
INSERT INTO xiaoyuanjiaotong.sys_role_menu (role_id, menu_id) VALUES (2, 1048);
INSERT INTO xiaoyuanjiaotong.sys_role_menu (role_id, menu_id) VALUES (2, 1049);
INSERT INTO xiaoyuanjiaotong.sys_role_menu (role_id, menu_id) VALUES (2, 1050);
INSERT INTO xiaoyuanjiaotong.sys_role_menu (role_id, menu_id) VALUES (2, 1051);
INSERT INTO xiaoyuanjiaotong.sys_role_menu (role_id, menu_id) VALUES (2, 1052);
INSERT INTO xiaoyuanjiaotong.sys_role_menu (role_id, menu_id) VALUES (2, 1053);
INSERT INTO xiaoyuanjiaotong.sys_role_menu (role_id, menu_id) VALUES (2, 1054);
INSERT INTO xiaoyuanjiaotong.sys_role_menu (role_id, menu_id) VALUES (2, 1055);
INSERT INTO xiaoyuanjiaotong.sys_role_menu (role_id, menu_id) VALUES (2, 1056);
INSERT INTO xiaoyuanjiaotong.sys_role_menu (role_id, menu_id) VALUES (2, 1057);
INSERT INTO xiaoyuanjiaotong.sys_role_menu (role_id, menu_id) VALUES (2, 1058);
INSERT INTO xiaoyuanjiaotong.sys_role_menu (role_id, menu_id) VALUES (2, 1059);
INSERT INTO xiaoyuanjiaotong.sys_role_menu (role_id, menu_id) VALUES (2, 1060);
INSERT INTO xiaoyuanjiaotong.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, create_by, create_time, update_by, update_time, remark, version) VALUES (1, 103, 'admin', '胡', '00', 'ry@163.com', '15888888888', '1', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '127.0.0.1', '2025-04-26 15:44:20', 'admin', '2025-03-10 15:59:31', '', '2025-04-26 15:44:19', '管理员', 0);
INSERT INTO xiaoyuanjiaotong.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, create_by, create_time, update_by, update_time, remark, version) VALUES (2, 105, 'ry', '若依', '00', 'ry@qq.com', '15666666666', '1', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '127.0.0.1', '2025-03-10 15:59:31', 'admin', '2025-03-10 15:59:31', '', null, '测试员', 0);
INSERT INTO xiaoyuanjiaotong.sys_user_post (user_id, post_id) VALUES (1, 1);
INSERT INTO xiaoyuanjiaotong.sys_user_post (user_id, post_id) VALUES (2, 2);
INSERT INTO xiaoyuanjiaotong.sys_user_role (user_id, role_id) VALUES (1, 1);
INSERT INTO xiaoyuanjiaotong.sys_user_role (user_id, role_id) VALUES (2, 2);
