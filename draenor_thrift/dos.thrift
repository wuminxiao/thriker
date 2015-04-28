# define dos service
namespace py dos

/**
 * Const
**/

const i16 DEFAULT_LIST_SIZE = 100
const i16 MAX_LIST_SIZE = 500

const i32 SYSTEM_USER = -1

/**
 * Enums
 */

enum DistOrderConst {

    /* Zeus statuses */
    DELIVERY_STATUS_UNPROCESSED = 0
    DELIVERY_STATUS_UNDIST = 1
    DELIVERY_STATUS_DELIVERING = 2
    DELIVERY_STATUS_RECEIPT = 3
    DELIVERY_STATUS_PRECANCELLED = 4
    DELIVERY_STATUS_CANCELLED = 5
    /* Draenor statuses */
    DELIVERY_STATUS_UNPICKUP = 10
    DELIVERY_STATUS_UNCONFIRM = 11

    COME_FROM_OTHER = 0
    COME_FROM_PC_WEB = 1
    COME_FROM_MOBILE_WEB = 2
    COME_FROM_OPENAPI = 3
    COME_FROM_IOS = 4
    COME_FROM_ANDROID = 5
    COME_FROM_IOS_AT = 6
    COME_FROM_WECHAT = 7
    COME_FROM_PLATFORM = 8

    CATEGORY_DELIVERY_FEE = 2
    CATEGORY_COUPON = 3
    CATEGORY_RESTAURANT_ACTIVITE = 12
    CATEGORY_PACKING_FEE = 102
    CATEGORY_TPD_VIP_NO_DELIVER_FEE = 103

    ORDER_MODE_TPD_ELEME = 7
    ORDER_MODE_TPD_NAPOS = 8

    REPORT_STATUS_DEFAULT = 0
    REPORT_STATUS_OK = 1

    PRINT_STATUS_DEFAULT = 0
    PRINT_STATUS_PROCESSING = 1
    PRINT_STATUS_SUCCESS = 2
    PRINT_STATUS_FAILED = 3
    PRINT_STATUS_TIMEOUT = 4

    PROCESS_GROUP_SYSTEM = 0
    PROCESS_GROUP_SUPERADMIN = 1
    PROCESS_GROUP_ADMIN = 2
    PROCESS_GROUP_ACCOUNTANT = 3
    PROCESS_GROUP_COURIER = 4

    COOP_ID_JD = 1

}

enum OrderChangeConst {
    ADD_PACKING_FEE = 1
    DELETE_PACKING_FEE = 2
    UPDATE_PACKING_FEE = 3

    ADD_OVERTIME_COMPENSATE = 4
    ADD_OTHER_COMPENSATE = 5
    DELETE_OTHER_COMPENSATE = 6
    UPDATE_OTHER_COMPENSATE = 7

    ADD_FOOD = 8
    DELETE_FOOD = 9

    CHANGE_PRICE = 10
    CHANGE_DISCOUNT = 11
    CHANGE_QUANTITY = 12
    ACTIVITY_ADD = 13
    ACTIVITY_CHANGE = 14
    ACTIVITY_DELETE = 15
}

enum ProcessGroupConst {
    PROCESS_GROUP_SYSTEM = 0
    PROCESS_GROUP_SUPERADMIN = 1
    PROCESS_GROUP_ADMIN = 2
    PROCESS_GROUP_ACCOUNTANT = 3
    PROCESS_GROUP_COURIER = 4
    PROCESS_GROUP_WEB = 5
}

/**
 * Types and Structs
 */

typedef i64 Timestamp
typedef string Mobile
typedef string Json

struct TDistOrder {
    1: required i64 order_id,
    2: required i32 restaurant_id,
    3: required string restaurant_name,
    4: required i32 restaurant_number,
    5: required i32 courier_id,
    6: required i32 station_id,
    7: required i32 city_id,

    8: required i32 user_id,
    9: required string user_name,
    10: required Mobile phone,
    11: required string phone_bk,
    12: required string address,
    13: required string ip,
    14: required string description,
    15: required string invoice,

    16: required Timestamp created_at,
    17: required Timestamp updated_at,
    18: required Timestamp eleme_created_at,
    19: required Timestamp deliver_time,

    20: required Json attribute_json,
    21: required Json detail_json,

    22: required double longitude,
    23: required double latitude,

    24: required i16 come_from,
    25: required i16 delivery_status,
    26: required i16 is_book,
    27: required i16 is_online_paid,
    28: required i16 is_new_user,
    29: required i16 is_vip_user,
    30: required i16 service_category,

    31: required double total_price,
    32: required double payable,
    33: optional double received,
    34: optional double paid,
    35: optional double marketing_fee,
    36: optional double operating_fee,
    37: required double deliver_fee,

    38: optional i32 report_status,
    39: optional i32 print_status,
    40: optional i32 account_settled,

    41: required double dish_price,

    42: optional string courier_name,
    43: optional string station_name,

    44: required i16 is_online_settled,
}


struct TDistOrderQuery {
    1: optional i32 courier_id,
    2: optional i32 station_id,
    3: optional i32 user_id,
    4: optional Timestamp from_datetime,
    5: optional Timestamp to_datetime,

    6: optional list<i16> delivery_statuses,
    7: optional list<i32> station_ids,
    8: optional list<i32> restaurant_ids,
    9: optional i16 is_book,
    10: optional i16 is_online_paid,

    11: optional i32 limit,
    12: optional i32 offset,
}


struct TOrderCount {
    1: required i32 unprocessed,
    2: required i32 undistribute,
    3: required i32 unconfirm,
    4: required i32 unpickup,
    5: required i32 delivering,
    6: required i32 unassigned,
}


struct TOrderPrintTask {
    1: required i32 id,
    2: required i64 order_id,
    3: required string printer_sn,
    4: required i32 task_id,
    5: required i32 status_code,
}


struct TOrderTimeline {
    1: required i64 order_id,
    2: optional Timestamp distribute_at,
    3: optional Timestamp confirm_at,
    4: optional Timestamp pickup_at,
    5: optional Timestamp receipt_at,
    6: optional Timestamp created_at,
    7: optional Timestamp updated_at,
}

struct TCourierOrder {
    1: required i32 courier_id,
    2: required string courier_name,
    3: required list<i64> unconfirm_order_ids,
    4: required list<i64> unpickup_order_ids,
    5: required list<i64> delivering_order_ids,
}

struct TOrderAccount {
    1: required i64 order_id,
    2: required i32 courier_id,
    3: required string courier_name,
    4: required i32 station_id,
    5: required string station_name,
    6: required Timestamp eleme_created_at,
    7: required double total_price,
    8: required double payable,
    9: required double profit_from_restaurant,
    10: required double deliver_fee,
    11: required double marketing_fee,
    12: required double operating_fee,
    13: required double received,
    14: required list<string> received_records,
    15: required double paid,
    16: required list<string> paid_records,
    17: required double handin,
    18: required i32 account_settled,
    19: required i32 delivery_status,

    # deprecated.
    20: required i32 total_time,

    21: required i16 is_book,
    22: required Timestamp deliver_time,
    23: required Timestamp receipt_at,
}

struct TOrderChange {
    1: required i32 operation,
    2: required string target,
    3: required double value,
    4: required string description,
    5: required string detail,
    6: required Timestamp created_at,
}

struct TOrderChangeLog {
    1: required i32 id,
    2: required i64 order_id,
    3: required i32 by_user_id,
    4: required i16 process_group,
    5: required string field_name,
    6: required string from_value,
    7: required string to_value,
    8: required string remark,
    9: required Timestamp created_at,

    10: required string process_group_name,
    11: required string field_verbose_name,
    12: required string description,
}


struct TOrderRating {
    1: required i32 id,
    2: required i64 order_id,
    3: required i16 time_spent,
    4: required i16 service_rating,
    5: required string service_rating_text,
    6: required Timestamp created_at,
    7: required Timestamp updated_at,
    8: required i16 rate_type,
}

struct TRefreshedDetail {
    1: required string detail_json,
    2: required double payable,
    3: required double total_price,
    4: required double dish_price,
}

/**
 * Exceptions
 */

enum DOSErrorCode {
    UNKNOWN_ERROR,

    // UserErrors
    ORDER_CANT_DISTRIBUTE,
    ORDER_NOT_FOUND,
    ORDER_ALREADY_ASSIGNED,
    ORDER_NOT_BELONG_TO_RESTAURANT_C,
    ORDER_OUTDATED,
    PERMISSION_DENIED,
    PRINT_ORDER_FAILED,
    PRINT_TASK_NOT_FOUND,
    RESTAURANT_HAS_NO_PRINTER,
    NO_ORDER_CHANGE_MADE,
    TIME_DELTA_INVALID,
    ORDER_ALREADY_CLOSED,
    ORDER_COOP_NOT_FOUND,
    ORDER_COOP_INFO_MISMATCH,
    RESTAURANT_PAYMENT_METHOD_NOT_FOUND,

    // SystemErrors
    DATABASE_ERROR,

}

exception DOSUserException {
    1: required DOSErrorCode error_code,
    2: required string error_name,
    3: optional string message,
}

exception DOSSystemException {
    1: required DOSErrorCode error_code,
    2: required string error_name,
    3: optional string message,
}

exception DOSUnknownException {
    1: required DOSErrorCode error_code,
    2: required string error_name,
    3: optional string message,
}

/**
 * Services
 */

service DistOrderService {

    /**
     * Inner APIs
     */

    void process_sync_order(1: i64 order_id)
        throws (1: DOSUserException user_exception,
                2: DOSSystemException system_exception,
                3: DOSUnknownException unknown_exception),

    void process_sync_order_rate(1: i64 order_id)
        throws (1: DOSUserException user_exception,
                2: DOSSystemException system_exception,
                3: DOSUnknownException unknown_exception),

    # draenor.dos:station:<station_id>:unprocessed -> [order_id1, order_id2]
    # undistribute, unconfirm, unpickup, delivering,
    void refresh_station_order(1: i32 station_id)
        throws (1: DOSUserException user_exception,
                2: DOSSystemException system_exception,
                3: DOSUnknownException unknown_exception),

    void process_delivery(1: i64 order_id,
                          2: i32 zeus_status)
        throws (1: DOSUserException user_exception,
                2: DOSSystemException system_exception,
                3: DOSUnknownException unknown_exception),

    void distribute_notice(1: i64 order_id)
        throws (1: DOSUserException user_exception,
                2: DOSSystemException system_exception,
                3: DOSUnknownException unknown_exception),

    void receipt_notice(1: i64 order_id)
        throws (1: DOSUserException user_exception,
                2: DOSSystemException system_exception,
                3: DOSUnknownException unknown_exception),

    void process_print_task(1: i32 print_task_id)
        throws (1: DOSUserException user_exception,
                2: DOSSystemException system_exception,
                3: DOSUnknownException unknown_exception),

    void send_vipcard_expire_notice()
        throws (1: DOSUserException user_exception,
                2: DOSSystemException system_exception,
                3: DOSUnknownException unknown_exception),

    void refresh_courier_and_station_name(1: i32 order_id)
        throws (1: DOSUserException user_exception,
                2: DOSSystemException system_exception,
                3: DOSUnknownException unknown_exception),

    /**
     * Base APIs
     */

    bool ping()
        throws (1: DOSUserException user_exception,
                2: DOSSystemException system_exception,
                3: DOSUnknownException unknown_exception),

    i32 test()
        throws (1: DOSUserException user_exception,
                2: DOSSystemException system_exception,
                3: DOSUnknownException unknown_exception),

    void sync_order(1: i64 order_id)
        throws (1: DOSUserException user_exception,
                2: DOSSystemException system_exception,
                3: DOSUnknownException unknown_exception),

    void distribute(1: i64 order_id,
                    2: i32 courier_id,
                    3: i32 user_id,
                    4: i16 process_group)
        throws (1: DOSUserException user_exception,
                2: DOSSystemException system_exception,
                3: DOSUnknownException unknown_exception),

    void distribute_to_coop(1: i64 order_id,
                            2: i32 coop_id,
                            3: i32 user_id,
                            4: i16 process_group)
        throws (1: DOSUserException user_exception,
                2: DOSSystemException system_exception,
                3: DOSUnknownException unknown_exception),

    void process(1: i64 order_id,
                 2: i32 delivery_status,
                 3: i32 user_id,
                 4: i16 process_group,
                 5: string remark)
        throws (1: DOSUserException user_exception,
                2: DOSSystemException system_exception,
                3: DOSUnknownException unknown_exception),

    void assign(1: i64 order_id,
                2: i64 station_id,
                3: i32 user_id,
                4: i16 process_group)
        throws (1: DOSUserException user_exception,
                2: DOSSystemException system_exception,
                3: DOSUnknownException unknown_exception),

    void set_paid(1: i64 order_id,
                  2: double paid,
                  3: i32 user_id,
                  4: i16 process_group,
                  5: string remark)
        throws (1: DOSUserException user_exception,
                2: DOSSystemException system_exception,
                3: DOSUnknownException unknown_exception),

    void set_received(1: i64 order_id,
                      2: double received,
                      3: i32 user_id,
                      4: i16 process_group,
                      5: string remark)
        throws (1: DOSUserException user_exception,
                2: DOSSystemException system_exception,
                3: DOSUnknownException unknown_exception),

    void set_report(1: i64 order_id,
                    2: i16 report_status,
                    3: i32 user_id,
                    4: i16 process_group)
        throws (1: DOSUserException user_exception,
                2: DOSSystemException system_exception,
                3: DOSUnknownException unknown_exception),

    void add_print_task(1: i64 order_id,
                        2: i32 user_id,
                        3: i16 process_group)
        throws (1: DOSUserException user_exception,
                2: DOSSystemException system_exception,
                3: DOSUnknownException unknown_exception),

    // period should be seconds
    void order_self_check(1: i32 period)
        throws (1: DOSUserException user_exception,
                2: DOSSystemException system_exception,
                3: DOSUnknownException unknown_exception),

    void update_print_status(1: i32 task_id,      # task_id -- task.task_id
                             2: i32 print_status) # stastus for wizard_client
        throws (1: DOSUserException user_exception,
                2: DOSSystemException system_exception,
                3: DOSUnknownException unknown_exception),

    list<TOrderChange> add_order_detail_change(1: i64 order_id,
                                               2: string detail_json)
        throws (1: DOSUserException user_exception,
                2: DOSSystemException system_exception,
                3: DOSUnknownException unknown_exception),

    TRefreshedDetail refresh_activities(1: i64 order_id,
                                        2: string detail_json)
        throws (1: DOSUserException user_exception,
                2: DOSSystemException system_exception,
                3: DOSUnknownException unknown_exception),

    void rate_service(1: i64 order_id,
                      2: i16 rate_value,
                      3: string rating_text)
        throws (1: DOSUserException user_exception,
                2: DOSSystemException system_exception,
                3: DOSUnknownException unknown_exception),

    void mset_account_settled(1: list<i64> order_ids,
                              2: i32 user_id,
                              3: i16 process_group)
        throws (1: DOSUserException user_exception,
                2: DOSSystemException system_exception,
                3: DOSUnknownException unknown_exception),

    /**
     * Query APIs
     */

    TDistOrder get(1: i64 order_id)
        throws (1: DOSUserException user_exception,
                2: DOSSystemException system_exception,
                3: DOSUnknownException unknown_exception),

    map<i64, TDistOrder> mget(1: list<i64> order_ids)
        throws (1: DOSUserException user_exception,
                2: DOSSystemException system_exception,
                3: DOSUnknownException unknown_exception),

    list<i64> query(1: TDistOrderQuery query_struct)
        throws (1: DOSUserException user_exception,
                2: DOSSystemException system_exception,
                3: DOSUnknownException unknown_exception),

    list<i64> query_unprocessed(1: i32 station_id)
        throws (1: DOSUserException user_exception,
                2: DOSSystemException system_exception,
                3: DOSUnknownException unknown_exception),

    list<i64> search(1: string keyword,
                     2: i32 user_id)
        throws (1: DOSUserException user_exception,
                2: DOSSystemException system_exception,
                3: DOSUnknownException unknown_exception),

    i32 count(1: TDistOrderQuery query_struct)
        throws (1: DOSUserException user_exception,
                2: DOSSystemException system_exception,
                3: DOSUnknownException unknown_exception),

    TOrderTimeline get_timeline(1: i64 order_id)
        throws (1: DOSUserException user_exception,
                2: DOSSystemException system_exception,
                3: DOSUnknownException unknown_exception),

    map<i64, TOrderTimeline> mget_timeline(1: list<i64> order_ids)
        throws (1: DOSUserException user_exception,
                2: DOSSystemException system_exception,
                3: DOSUnknownException unknown_exception),

    TOrderRating get_rating_by_order(1: i64 order_id)
        throws (1: DOSUserException user_exception,
                2: DOSSystemException system_exception,
                3: DOSUnknownException unknown_exception),

    map<i64, TOrderRating> mget_rating_by_order(1: list<i64> order_ids)
        throws (1: DOSUserException user_exception,
                2: DOSSystemException system_exception,
                3: DOSUnknownException unknown_exception),

    TOrderPrintTask get_print_task(1: i32 print_task_id)
        throws (1: DOSUserException user_exception,
                2: DOSSystemException system_exception,
                3: DOSUnknownException unknown_exception),

    TOrderCount count_by_station(1: i32 station_id)
        throws (1: DOSUserException user_exception,
                2: DOSSystemException system_exception,
                3: DOSUnknownException unknown_exception),

    list<TCourierOrder> query_courier_order_by_station(1: i32 station_id)
        throws (1: DOSUserException user_exception,
                2: DOSSystemException system_exception,
                3: DOSUnknownException unknown_exception),

    list<TOrderChange> get_order_change(1: i64 order_id)
        throws (1: DOSUserException user_exception,
                2: DOSSystemException system_exception,
                3: DOSUnknownException unknown_exception),

    map<i64, list<TOrderChange>> mget_order_change(1: list<i64> order_ids)
        throws (1: DOSUserException user_exception,
                2: DOSSystemException system_exception,
                3: DOSUnknownException unknown_exception),

    # yyyy-mm-dd
    list<TOrderAccount> query_order_account(1: i32 station_id,
                                            2: string date)
        throws (1: DOSUserException user_exception,
                2: DOSSystemException system_exception,
                3: DOSUnknownException unknown_exception),

    list<i32> order_distribution(1: string date,   # yyyy-mm-dd
                                 2: i32 timedelta, # seconds
                                 3: list<i32> station_ids)
        throws (1: DOSUserException user_exception,
                2: DOSSystemException system_exception,
                3: DOSUnknownException unknown_exception),

    list<TOrderChangeLog> get_order_changelog(1: i64 order_id)
        throws (1: DOSUserException user_exception,
                2: DOSSystemException system_exception,
                3: DOSUnknownException unknown_exception),

    list<TOrderChangeLog> get_order_changelogs_by_user_id(1: list<i32> user_ids)
        throws (1: DOSUserException user_exception,
                2: DOSSystemException system_exception,
                3: DOSUnknownException unknown_exception),

    /**
     * App APIs
     */

    map<i32, list<i64>> alleria_sync_courier(1: i32 courier_id,
                                             2: i32 event_id)
        throws (1: DOSUserException user_exception,
                2: DOSSystemException system_exception,
                3: DOSUnknownException unknown_exception),

    void update_coop_order(1: i64 order_id)
        throws (1: DOSUserException user_exception,
                2: DOSSystemException system_exception,
                3: DOSUnknownException unknown_exception),

    void cancel_coop_order(1: i64 order_id)
        throws (1: DOSUserException user_exception,
                2: DOSSystemException system_exception,
                3: DOSUnknownException unknown_exception),

    void receive_coop_order_status(1: i32 coop_id,
                                   2: string content)
        throws (1: DOSUserException user_exception,
                2: DOSSystemException system_exception,
                3: DOSUnknownException unknown_exception),

    /**
     * Signal APIs
     */

}
