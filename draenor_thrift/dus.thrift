# define dus service
namespace php DUS
namespace py dus

/**
 * Const
**/

const i16 DEFAULT_LIST_SIZE = 100
const i16 MAX_LIST_SIZE = 500

const i32 SYSTEM_USER = -1

/**
 * Enums
 */

enum OldVIPCardConst {
    VALID_PERIOD_MONTH = 1
    VALID_PERIOD_QUATER = 2
    VALID_PERIOD_YEAR = 3
}

enum VIPCardConst {
    CARD_TYPE_YEAR = 1
    CARD_TYPE_QUATER = 2
    CARD_TYPE_MONTH = 3

    CARD_TYPE_YEAR_PERIOD = 372
    CARD_TYPE_QUATER_PERIOD = 93
    CARD_TYPE_MONTH_PERIOD = 31

}

enum ProcessGroupConst {
    PROCESS_GROUP_SYSTEM = 0
    PROCESS_GROUP_SUPERADMIN = 1
    PROCESS_GROUP_ADMIN = 2
    PROCESS_GROUP_ACCOUNTANT = 3
    PROCESS_GROUP_COURIER = 4
    PROCESS_GROUP_WEB = 5
}

enum TCourierTurnType {
    TYPE_DUTY = 0,
    TYPE_WATCH = 1,
    TYPE_EXTRA = 2,
}


/**
 * Types and Structs
 */

typedef i64 Timestamp
typedef i64 Mobile
typedef string Json

struct TUser {
    1: required i32 id,
    2: required string name,
    3: required string name_pinyin,
    4: required Mobile mobile,
    5: required string email,
    6: required string secret_key,
    7: required i16 is_super_admin,
    8: required i16 is_valid,

    9: required Timestamp created_at,
    10: required Timestamp updated_at,
}

struct TUserUpdate {
    1: optional string name,
    2: optional string mobile,
    3: optional string email,
    4: optional i16 is_valid,
}

struct TUserQuery {
    1: optional string name,
    2: optional string name_pinyin,
    3: optional string email,
    4: optional i16 is_super_admin,
    5: optional i16 is_valid,

    7: optional list<i32> user_ids,

    8: optional i32 limit,
    9: optional i32 offset,
}

struct TCourier {
    1: required i32 user_id,
    2: required i32 station_id,
    3: required i16 is_online,
    4: required double longitude,
    5: required double latitude,
}

struct TCourierQuery {
    1: optional i32 station_id,
    2: optional i16 is_valid,
    3: optional i16 is_online,

    4: optional i32 limit,
    5: optional i32 offset,
}

struct TCourierTurn {
    1: required i32 id,
    2: required i32 user_id,
    3: required i32 type_id,
    4: required Timestamp from_datetime,
    5: required Timestamp to_datetime,
}

struct TLocation {
    1: optional double longitude,
    2: optional double latitude,
    3: optional string address,
}

# deprecated use VIPCard instead.
struct TOldVIPCard {
    1: required i32 id,
    2: required string card_id,
    3: required Mobile mobile,
    4: required i32 courier_id,
    5: required i32 station_id,
    6: required Timestamp used_at,
    7: required i32 is_valid,
    8: required i32 valid_period,
}

struct TVIPCard {
    1: required string card_id,
    2: required string batch,
    3: required i16 card_type,
    4: required double sold_price,
    5: required i16 status,
    6: required i16 retailer,
    7: required Timestamp created_at,
    8: required Timestamp updated_at,

    9: optional Mobile mobile,
    10: optional i32 courier_id,
    11: optional i32 station_id,
    12: optional Timestamp activated_at,
    13: optional Timestamp binded_at,
}

# deprecated use VIPCardQuery instead.
# TODO more filters.
struct TOldVIPCardQuery {
    1: optional Mobile mobile,
    2: optional i32 courier_id,
    3: optional i32 station_id,
    4: optional i32 limit,
    5: optional i32 offset,
    6: optional Timestamp from_datetime,
    7: optional Timestamp to_datetime,
}

struct TVIPUser {
    1: required Mobile mobile,
    2: required string valid_start,
    3: required string valid_end,
    4: required i16 is_valid,
    5: required i32 eleme_user_id,
    6: required string eleme_user_name,
}

struct TVIPCardQuery {
    1: optional string batch,
    2: optional Mobile mobile,
    3: optional i16 card_type,
    4: optional double sold_price,

    5: optional Timestamp activated_from,
    6: optional Timestamp activated_to,
    7: optional Timestamp binded_from,
    8: optional Timestamp binded_to,

    9: optional list<i32> courier_ids,
    10: optional list<i32> station_ids,
    11: optional list<i16> retailers,

    12: optional i32 limit,
    13: optional i32 offset,
}

struct TRole {
    1: required i32 id,
    2: required string name,
    3: required string name_en,
    4: required list<i32> permission_ids,
}

struct TUserRole {
    1: required i32 id,
    2: required i32 user_id,
    3: required i32 role_id,

    4: required list<i32> station_ids,
    5: required list<i32> city_ids,
}

struct TPermission {
    1: required i32 id,
    2: required string name,
    3: required string name_en,
    4: required string func,
    5: required string method,
    6: required string url,
    7: required string description,
    8: required i32 permission_group_id,
}

struct TAppVersion {
    1: required i32 id,
    2: required i16 version,
    3: required string version_name,
    4: required double size,
    5: required string time,
    6: required i16 type,
    7: required string url,
    8: required string description,
    9: required i16 level,
    10: required string sha1,
}

struct TPermissionUpdate {
    1: optional string name,
    2: optional string name_en,
    3: optional string func,
    4: optional string method,
    5: optional string url,
    6: optional string description,
    7: optional i32 permission_group_id,
}

struct TPermissionGroup {
    1: required i32 id,
    2: required string name,
}

/**
 * Exceptions
 */

enum DUSErrorCode {
    UNKNOWN_ERROR,

    // UserErrors
    COURIER_ALREADY_EXIST,
    COURIER_NOT_FOUND,
    COURIER_ID_DOES_NOT_MATCH,
    COURIER_TURN_TIME_DOES_NOT_MATCH,
    INVALID_EMAIL,
    INVALID_MOBILE,
    NONE_VALID_PERIOD_SELECTED,
    PERMISSION_NOT_FOUND,
    QUERY_PERIOD_TOO_LONG,
    ROLE_NOT_FOUND,
    STATION_ADMIN_ALREADY_EXIST,
    USER_NOT_FOUND,
    USER_PASSWORD_INVALID,
    USER_ROLE_ALREADY_EXIST,
    USER_ROLE_NOT_FOUND,
    VIPCARD_ALREADY_IN_USE,
    VIPCARD_BIND_FAILED,
    VIPCARD_NOT_FOUND,
    VIPCARD_VALID_PERIOD_INCONFORMITY,
    VIPCARD_VALIDTION_INCORRECT,
    VIPCARD_STATUS_NOTFIT,
    PROCESS_GROUP_PERMISSION_DENIED,

    // SystemErrors
    DATABASE_ERROR,

    // XingeErrors
    XINGE_ERROR,

}

exception DUSUserException {
    1: required DUSErrorCode error_code,
    2: required string error_name,
    3: optional string message,
}

exception DUSSystemException {
    1: required DUSErrorCode error_code,
    2: required string error_name,
    3: optional string message,
}

exception DUSUnknownException {
    1: required DUSErrorCode error_code,
    2: required string error_name,
    3: optional string message,
}

/**
 * Services
 */

service DistUserService {

    /**
     * Base APIs
     */

    bool ping()
        throws (1: DUSUserException user_exception,
                2: DUSSystemException system_exception,
                3: DUSUnknownException unknown_exception),

    void new_user(1: TUser new_struct)
        throws (1: DUSUserException user_exception,
                2: DUSSystemException system_exception,
                3: DUSUnknownException unknown_exception),

    void new_courier(1: string name,
                     2: Mobile mobile,
                     3: i32 station_id)
        throws (1: DUSUserException user_exception,
                2: DUSSystemException system_exception,
                3: DUSUnknownException unknown_exception),

    void set_invalid(1: i32 user_id)
        throws (1: DUSUserException user_exception,
                2: DUSSystemException system_exception,
                3: DUSUnknownException unknown_exception),

    void remove_courier(1: i32 user_id)
        throws (1: DUSUserException user_exception,
                2: DUSSystemException system_exception,
                3: DUSUnknownException unknown_exception),

    void update_user(1: i32 user_id,
                     2: TUserUpdate update_struct)
        throws (1: DUSUserException user_exception,
                2: DUSSystemException system_exception,
                3: DUSUnknownException unknown_exception),

    void send_verify_code(1: i64 mobile)
        throws (1: DUSUserException user_exception,
                2: DUSSystemException system_exception,
                3: DUSUnknownException unknown_exception),

    bool validate_verify_code(1: Mobile mobile,
                              2: string verify_code)
        throws (1: DUSUserException user_exception,
                2: DUSSystemException system_exception,
                3: DUSUnknownException unknown_exception),

    bool check_password(1: Mobile mobile,
                        2: string password)
        throws (1: DUSUserException user_exception,
                2: DUSSystemException system_exception,
                3: DUSUnknownException unknown_exception),

    void retrieve_password(1: Mobile mobile,
                           2: string password)
        throws (1: DUSUserException user_exception,
                2: DUSSystemException system_exception,
                3: DUSUnknownException unknown_exception),

    # deprecated
    void bind_old_vipcard(1: Mobile mobile,
                          2: string card_id,
                          3: i32 courier_id)
        throws (1: DUSUserException user_exception,
                2: DUSSystemException system_exception,
                3: DUSUnknownException unknown_exception),

    void set_station_admin(1: i32 user_id,
                           2: i32 station_id)
        throws (1: DUSUserException user_exception,
                2: DUSSystemException system_exception,
                3: DUSUnknownException unknown_exception),

    void set_dispatcher(1: i32 user_id,
                        2: list<i32> station_ids)
        throws (1: DUSUserException user_exception,
                2: DUSSystemException system_exception,
                3: DUSUnknownException unknown_exception),

    void set_bd(1: i32 user_id,
                2: list<i32> station_ids)
        throws (1: DUSUserException user_exception,
                2: DUSSystemException system_exception,
                3: DUSUnknownException unknown_exception),

    void set_mkt(1: i32 user_id,
                 2: list<i32> station_ids)
        throws (1: DUSUserException user_exception,
                2: DUSSystemException system_exception,
                3: DUSUnknownException unknown_exception),

    void set_accountant(1: i32 user_id)
        throws (1: DUSUserException user_exception,
                2: DUSSystemException system_exception,
                3: DUSUnknownException unknown_exception),

    void remove_user_role(1: i32 user_role_id)
        throws (1: DUSUserException user_exception,
                2: DUSSystemException system_exception,
                3: DUSUnknownException unknown_exception),

    void user_checkin(1: i16 user_id)
        throws (1: DUSUserException user_exception,
                2: DUSSystemException system_exception,
                3: DUSUnknownException unknown_exception),

    void update_courier_location(1: i16 user_id,
                                 2: TLocation location)
        throws (1: DUSUserException user_exception,
                2: DUSSystemException system_exception,
                3: DUSUnknownException unknown_exception),

    void update_courier_turn(1: i32 courier_id,
                             2: i32 year,
                             3: i32 month,
                             4: list<TCourierTurn> turns)
        throws (1: DUSUserException user_exception,
                2: DUSSystemException system_exception,
                3: DUSUnknownException unknown_exception),

    void mset_courier_online_status(1: list<i32> courier_ids,
                                    2: i16 online_status)
        throws (1: DUSUserException user_exception,
                2: DUSSystemException system_exception,
                3: DUSUnknownException unknown_exception),

    void bind_device_user(1: i32 user_id,
                          2: string device_id,
                          3: i32 device_type,
                          4: string version)
        throws (1: DUSUserException user_exception,
                2: DUSSystemException system_exception,
                3: DUSUnknownException unknown_exception),

    void unbind_device_user(1: i32 user_id,
                            2: string device_id,
                            3: i32 device_type)
        throws (1: DUSUserException user_exception,
                2: DUSSystemException system_exception,
                3: DUSUnknownException unknown_exception),

    void activate_vipcard(1: string card_id,
                          2: i32 user_id,
                          3: i32 process_group,
                          4: i32 courier_id)
        throws (1: DUSUserException user_exception,
                2: DUSSystemException system_exception,
                3: DUSUnknownException unknown_exception),

    # if the vidcard is old vipcard, card_validtion should pass 123456
    TVIPCard bind_vipcard(1: string card_id,
                      2: string card_validation,
                      3: Mobile mobile,
                      4: i32 user_id,
                      5: i32 process_group)
        throws (1: DUSUserException user_exception,
                2: DUSSystemException system_exception,
                3: DUSUnknownException unknown_exception),

    void bind_vipcard_without_activate(1: string card_id,
                                       2: string card_validation,
                                       3: Mobile mobile,
                                       4: i32 user_id,
                                       5: i32 process_group,
                                       6: i32 courier_id)
        throws (1: DUSUserException user_exception,
                2: DUSSystemException system_exception,
                3: DUSUnknownException unknown_exception),

    # bind without card validation, can be used only by paladin group.
    # courier_id is optional, pass 0 if the card is not sold by courier.
    void force_bind_vipcard(1: string card_id,
                            2: Mobile mobile,
                            3: i32 user_id,
                            4: i32 process_group,
                            5: i32 courier_id)
        throws (1: DUSUserException user_exception,
                2: DUSSystemException system_exception,
                3: DUSUnknownException unknown_exception),

    void deactivate_vipcard(1: string card_id,
                            2: i32 user_id,
                            3: i32 process_group,
                            4: string remark)
        throws (1: DUSUserException user_exception,
                2: DUSSystemException system_exception,
                3: DUSUnknownException unknown_exception),

    void invalidate_vipcard(1: string card_id,
                            2: i32 user_id,
                            3: i32 process_group,
                            4: string remark)
        throws (1: DUSUserException user_exception,
                2: DUSSystemException system_exception,
                3: DUSUnknownException unknown_exception),

    void new_permission(1: TPermission permission_struct)
        throws (1: DUSUserException user_exception,
                2: DUSSystemException system_exception,
                3: DUSUnknownException unknown_exception),

    void update_permission(1: i32 permission_id,
                           2: TPermissionUpdate permission_struct)
        throws (1: DUSUserException user_exception,
                2: DUSSystemException system_exception,
                3: DUSUnknownException unknown_exception),

    void add_role_permission(1: i32 role_id,
                             2: list<i32> permission_ids)
        throws (1: DUSUserException user_exception,
                2: DUSSystemException system_exception,
                3: DUSUnknownException unknown_exception),

    void remove_role_permission(1: i32 role_id,
                                2: list<i32> permission_ids)
        throws (1: DUSUserException user_exception,
                2: DUSSystemException system_exception,
                3: DUSUnknownException unknown_exception),

    /**
     * Inner APIs
     */

    void send_vipcard_expire_notice()
        throws (1: DUSUserException user_exception,
                2: DUSSystemException system_exception,
                3: DUSUnknownException unknown_exception),

    /**
     * Query APIs
     */

    # 按照from_datetime，在这个月的全部拿出来
    list<TCourierTurn> query_courier_turn(1: i32 courier_id,
                                          2: Timestamp from_datetime,
                                          3: Timestamp to_datetime)
        throws (1: DUSUserException user_exception,
                2: DUSSystemException system_exception,
                3: DUSUnknownException unknown_exception),

    TUser get(1: i32 user_id)
        throws (1: DUSUserException user_exception,
                2: DUSSystemException system_exception,
                3: DUSUnknownException unknown_exception),

    TUser get_by_mobile(1: Mobile mobile)
        throws (1: DUSUserException user_exception,
                2: DUSSystemException system_exception,
                3: DUSUnknownException unknown_exception),

    map<i32, TUser> mget(1: list<i32> user_ids)
        throws (1: DUSUserException user_exception,
                2: DUSSystemException system_exception,
                3: DUSUnknownException unknown_exception),

    list<i32> query(1: TUserQuery query_struct)
        throws (1: DUSUserException user_exception,
                2: DUSSystemException system_exception,
                3: DUSUnknownException unknown_exception),

    i32 count(1: TUserQuery query_struct)
        throws (1: DUSUserException user_exception,
                2: DUSSystemException system_exception,
                3: DUSUnknownException unknown_exception),

    TCourier get_courier(1: i32 user_id)
        throws (1: DUSUserException user_exception,
                2: DUSSystemException system_exception,
                3: DUSUnknownException unknown_exception),

    map<i32, TCourier> mget_courier(1: list<i32> user_ids)
        throws (1: DUSUserException user_exception,
                2: DUSSystemException system_exception,
                3: DUSUnknownException unknown_exception),

    list<i32> query_courier(1: TCourierQuery query_struct)
        throws (1: DUSUserException user_exception,
                2: DUSSystemException system_exception,
                3: DUSUnknownException unknown_exception),

    # deprecated
    TOldVIPCard get_old_vipcard(1: string card_id)
        throws (1: DUSUserException user_exception,
                2: DUSSystemException system_exception,
                3: DUSUnknownException unknown_exception),

    # deprecated
    map<string, TOldVIPCard> mget_old_vipcard(1: list<string> card_ids)
        throws (1: DUSUserException user_exception,
                2: DUSSystemException system_exception,
                3: DUSUnknownException unknown_exception),

    # deprecated
    list<string> query_old_vipcard(1: TOldVIPCardQuery query_struct)
        throws (1: DUSUserException user_exception,
                2: DUSSystemException system_exception,
                3: DUSUnknownException unknown_exception),

    TVIPUser get_vipuser_by_mobile(1: Mobile mobile)
        throws (1: DUSUserException user_exception,
                2: DUSSystemException system_exception,
                3: DUSUnknownException unknown_exception),

    map<i32, list<i32>> query_role_bu_ids(1: i32 user_id)
        throws (1: DUSUserException user_exception,
                2: DUSSystemException system_exception,
                3: DUSUnknownException unknown_exception),

    # deprecated, use query_checkin instead
    list<Timestamp> get_today_checkin(1: i16 user_id)
        throws (1: DUSUserException user_exception,
                2: DUSSystemException system_exception,
                3: DUSUnknownException unknown_exception),

    list<Timestamp> query_checkin(1: i16 user_id,
                                  2: Timestamp from_datetime,
                                  3: Timestamp to_datetime)
        throws (1: DUSUserException user_exception,
                2: DUSSystemException system_exception,
                3: DUSUnknownException unknown_exception),

    list<i32> query_bu_ids_by_user(1: i32 user_id,
                                   2: string type)
        throws (1: DUSUserException user_exception,
                2: DUSSystemException system_exception,
                3: DUSUnknownException unknown_exception),

    TRole get_role(1: i32 role_id)
        throws (1: DUSUserException user_exception,
                2: DUSSystemException system_exception,
                3: DUSUnknownException unknown_exception),

    map<i32, TRole> mget_role(1: list<i32> role_ids)
        throws (1: DUSUserException user_exception,
                2: DUSSystemException system_exception,
                3: DUSUnknownException unknown_exception),

    list<TRole> query_role_all()
        throws (1: DUSUserException user_exception,
                2: DUSSystemException system_exception,
                3: DUSUnknownException unknown_exception),

    map<i32, list<TUserRole>> mget_user_role_by_user_ids(1: list<i32> user_ids)
        throws (1: DUSUserException user_exception,
                2: DUSSystemException system_exception,
                3: DUSUnknownException unknown_exception),

    TPermission get_permission(1: i32 permission_id)
        throws (1: DUSUserException user_exception,
                2: DUSSystemException system_exception,
                3: DUSUnknownException unknown_exception),

    map<i32, TPermission> mget_permission(1: list<i32> permission_ids)
        throws (1: DUSUserException user_exception,
                2: DUSSystemException system_exception,
                3: DUSUnknownException unknown_exception),

    list<TPermission> query_permission_all()
        throws (1: DUSUserException user_exception,
                2: DUSSystemException system_exception,
                3: DUSUnknownException unknown_exception),

    list<TPermissionGroup> query_permission_group_all()
        throws (1: DUSUserException user_exception,
                2: DUSSystemException system_exception,
                3: DUSUnknownException unknown_exception),

    list<i32> query_permission_by_roles(1: list<i32> role_ids)
        throws (1: DUSUserException user_exception,
                2: DUSSystemException system_exception,
                3: DUSUnknownException unknown_exception),

    # matched user_role_id: role_id map
    map<i32, i32> check_permission(1: i32 user_id,
                                   2: string url,
                                   3: string method)
        throws (1: DUSUserException user_exception,
                2: DUSSystemException system_exception,
                3: DUSUnknownException unknown_exception),

    TVIPCard get_vipcard(1: string card_id)
        throws (1: DUSUserException user_exception,
                2: DUSSystemException system_exception,
                3: DUSUnknownException unknown_exception),

    map<string, TVIPCard> mget_vipcard(1: list<string> card_ids)
        throws (1: DUSUserException user_exception,
                2: DUSSystemException system_exception,
                3: DUSUnknownException unknown_exception),

    list<string> query_vipcard(1: TVIPCardQuery query)
        throws (1: DUSUserException user_exception,
                2: DUSSystemException system_exception,
                3: DUSUnknownException unknown_exception),

    map<string, i32> query_vipcard_amount_by_courier(1: i32 courier_id)
        throws (1: DUSUserException user_exception,
                2: DUSSystemException system_exception,
                3: DUSUnknownException unknown_exception),

    TAppVersion get_mobile_latest_app()
        throws (1: DUSUserException user_exception,
                2: DUSSystemException system_exception,
                3: DUSUnknownException unkown_exception),

    list<i32> search_user(1: string keyword)
        throws (1: DUSUserException user_exception,
                2: DUSSystemException system_exception,
                3: DUSUnknownException unkown_exception),


    /**
     * App APIs
     */

    void xinge_push_single_msg(1: i32 user_id)
        throws (1: DUSUserException user_exception,
                2: DUSSystemException system_exception,
                3: DUSUnknownException unknown_exception),

    /**
     * Signal APIs
     */

}
