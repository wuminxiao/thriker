#define dss service
namespace py dss

/**
 * Const
**/

const i16 DEFAULT_LIST_SIZE = 100
const i16 MAX_LIST_SIZE = 500

const i32 SYSTEM_USER = -1

/**
 * Enums
 */

enum RestaurantConst {


    ORDER_MODE_TPD_ELEME = 7
    ORDER_MODE_TPD_NAPOS = 8

    BUSY_LEVEL_FREE = 0
    BUSY_LEVEL_CLOSED = 2
    BUSY_LEVEL_NETWORK_UNSTABLE = 3
    BUSY_LEVEL_HOLIDAY = 4

    STATUS_OPEN = 1
    STATUS_CLOSED = 2
    STATUS_SUSPEND = 3

    STATUS_PROCESSING_OPEN = 11
    STATUS_PROCESSING_SUSPEND = 12

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
typedef string Phone
typedef string Mobile

struct TStation {
    1: required i32 id,
    2: required string name,
    3: required string address,
    4: required Phone phone,
    5: required i32 city_id,
    6: required double longitude,
    7: required double latitude,
    8: required i32 admin_user_id,

    9: required Timestamp created_at,
    10: required Timestamp updated_at,

    11: required string geo_json,
}

struct TCity {
    1: required i32 id,
    2: required string name,
    3: required string city_code,
    4: required i32 admin_user_id,

    5: required Timestamp created_at,
    6: required Timestamp updated_at,
}

struct TRestaurant {
    1: required i32 id,
    2: required string name,
    3: required string address_text,
    4: required Phone phone,
    5: required Mobile mobile,
    6: required double longitude,
    7: required double latitude,
    8: required string name_for_url,
    9: required i32 station_id,
    10: required i32 status,
    11: required i16 is_own,
    12: required i16 is_valid,
    13: required i16 service_category,
    14: required string printer_sn,
    15: required string image_hash,

    16: required Timestamp created_at,
    17: required Timestamp updated_at,

    18: required i16 busy_level,
}

struct TRestaurantProfile {
    1: required TRestaurant restaurant,
    2: required i32 pickup_time,
    3: required i32 pickup_time_am,
    4: required i32 pickup_time_pm,
    5: required i16 overflow_level,
    6: required i32 order_count,
    7: required i32 order_count_am,
    8: required i32 order_count_pm,
    9: required i16 status,

    10: required Timestamp created_at,
    11: required Timestamp updated_at,
}

struct TRestaurantQuery {
    1: optional list<i32> station_ids,
    2: optional list<i32> statuses,
    3: optional i16 is_own,
    4: optional i16 is_valid,
    5: optional i16 service_category,

    6: optional i32 limit,
    7: optional i32 offset,
}

struct TBUItem {
    1: required i32 id,
    2: required i32 parent_id,
    3: required i32 depth,
    4: required string name,
    5: required string type,
}

struct TBussinessUnit {
    1: required i32 id,
    2: required string bu_name,
    3: required i32 bu_type,
    4: required i32 admin_user_id,
}

/**
 * Exceptions
 */

enum DSSErrorCode {
    UNKNOWN_ERROR,

    // UserErrors
    BUSSINESS_UNIT_NOT_FOUND,
    CITY_NOT_FOUND,
    OVERFLOW_LEVEL_MISMATCH,
    RESTAURANT_NOT_FOUND,
    STATION_NOT_FOUND,

    // SystemErrors
    DATABASE_ERROR,

}

exception DSSUserException {
    1: required DSSErrorCode error_code,
    2: required string error_name,
    3: optional string message,
}

exception DSSSystemException {
    1: required DSSErrorCode error_code,
    2: required string error_name,
    3: optional string message,
}

exception DSSUnknownException {
    1: required DSSErrorCode error_code,
    2: required string error_name,
    3: optional string message,
}

/**
 * Services
 */

service DistStationService {

    /**
     * Inner APIs
     */

    void process_sync_restaurant(1: i32 restaurant_id)
        throws (1: DSSUserException user_exception,
                2: DSSSystemException system_exception,
                3: DSSUnknownException unknown_exception),

    void set_station_admin(1: i32 station_id,
                           2: i32 user_id)
        throws (1: DSSUserException user_exception,
                2: DSSSystemException system_exception,
                3: DSSUnknownException unknown_exception),

    void assign_restaurants(1: list<i32> restaurant_ids,
                            2: i32 station_id,
                            3: i32 user_id,
                            4: i16 process_group)
        throws (1: DSSUserException user_exception,
                2: DSSSystemException system_exception,
                3: DSSUnknownException unknown_exception),

    void process_update_restaurant_profile(1: i32 restaurant_id)
        throws (1: DSSUserException user_exception,
                2: DSSSystemException system_exception,
                3: DSSUnknownException unknown_exception),

    void process_open_restaurant(1: i32 restaurant_id)
        throws (1: DSSUserException user_exception,
                2: DSSSystemException system_exception,
                3: DSSUnknownException unknown_exception),

    void process_close_restaurant(1: i32 restaurant_id)
        throws (1: DSSUserException user_exception,
                2: DSSSystemException system_exception,
                3: DSSUnknownException unknown_exception),

    void calculate_restaurant_belonging(1: i32 restaurant_id)
        throws (1: DSSUserException user_exception,
                2: DSSSystemException system_exception,
                3: DSSUnknownException unknown_exception),

    /**
     * Base APIs
     */

    bool ping()
        throws (1: DSSUserException user_exception,
                2: DSSSystemException system_exception,
                3: DSSUnknownException unknown_exception),

    void sync_restaurant(1: i32 restaurant_id)
        throws (1: DSSUserException user_exception,
                2: DSSSystemException system_exception,
                3: DSSUnknownException unknown_exception),

    # while station_id < 0, sync all restaurants.
    void refresh_restaurants(1: i32 station_id)
        throws (1: DSSUserException user_exception,
                2: DSSSystemException system_exception,
                3: DSSUnknownException unknown_exception),

    void new_station(1: TStation station)
        throws (1: DSSUserException user_exception,
                2: DSSSystemException system_exception,
                3: DSSUnknownException unknown_exception),

    void new_city(1: TCity city)
        throws (1: DSSUserException user_exception,
                2: DSSSystemException system_exception,
                3: DSSUnknownException unknown_exception),

    void update_station(1: i32 station_id,
                        2: TStation t_station)
        throws (1: DSSUserException user_exception,
                2: DSSSystemException system_exception,
                3: DSSUnknownException unknown_exception),

    void open_restaurants(1: list<i32> restaurant_ids)
        throws (1: DSSUserException user_exception,
                2: DSSSystemException system_exception,
                3: DSSUnknownException unknown_exception),

    void close_restaurants(1: list<i32> restaurant_ids)
        throws (1: DSSUserException user_exception,
                2: DSSSystemException system_exception,
                3: DSSUnknownException unknown_exception),

    void mset_restaurant_overflow_level(1: map<i32, i16> overflow_levels)
        throws (1: DSSUserException user_exception,
                2: DSSSystemException system_exception,
                3: DSSUnknownException unknown_exception),

    /**
     * Query APIs
     */

    TStation get(1: i32 station_id)
        throws (1: DSSUserException user_exception,
                2: DSSSystemException system_exception,
                3: DSSUnknownException unknown_exception),

    map<i32, TStation> mget(1: list<i32> station_ids)
        throws (1: DSSUserException user_exception,
                2: DSSSystemException system_exception,
                3: DSSUnknownException unknown_exception),

    list<i32> get_station_ids_by_city_id(1: i32 city_id)
        throws (1: DSSUserException user_exception,
                2: DSSSystemException system_exception,
                3: DSSUnknownException unknown_exception),

    TCity get_city(1: i32 city_id)
        throws (1: DSSUserException user_exception,
                2: DSSSystemException system_exception,
                3: DSSUnknownException unknown_exception),

    map<i32, TCity> mget_city(1: list<i32> city_ids)
        throws (1: DSSUserException user_exception,
                2: DSSSystemException system_exception,
                3: DSSUnknownException unknown_exception),

    TRestaurant get_restaurant(1: i32 restaurant_id)
        throws (1: DSSUserException user_exception,
                2: DSSSystemException system_exception,
                3: DSSUnknownException unknown_exception),

    map<i32,TRestaurant> mget_restaurant(1: list<i32> restaurant_ids)
        throws (1: DSSUserException user_exception,
                2: DSSSystemException system_exception,
                3: DSSUnknownException unknown_exception),

    list<i32> search_restaurant(1: string keyword,
                                2: i32 user_id)
    TBussinessUnit get_bussiness_unit(1: i32 bu_id)
        throws (1: DSSUserException user_exception,
                2: DSSSystemException system_exception,
                3: DSSUnknownException unknown_exception),

    TBussinessUnit get_business_unit(1: i32 bu_id)
        throws (1: DSSUserException user_exception,
                2: DSSSystemException system_exception,
                3: DSSUnknownException unknown_exception),

    map<i32, TBussinessUnit> mget_bussiness_unit(1: list<i32> bu_ids)
        throws (1: DSSUserException user_exception,
                2: DSSSystemException system_exception,
                3: DSSUnknownException unknown_exception),

    list<TBUItem> get_bu_tree(1: i32 bu_id)
        throws (1: DSSUserException user_exception,
                2: DSSSystemException system_exception,
                3: DSSUnknownException unknown_exception),

    list<i32> query_restaurant(1: TRestaurantQuery query_struct)
        throws (1: DSSUserException user_exception,
                2: DSSSystemException system_exception,
                3: DSSUnknownException unknown_exception),

    TRestaurantProfile get_restaurant_profile(1: i32 restaurant_id)
        throws (1: DSSUserException user_exception,
                2: DSSSystemException system_exception,
                3: DSSUnknownException unknown_exception),

    map<i32, TRestaurantProfile> mget_restaurant_profile(1: list<i32> restaurant_ids)
        throws (1: DSSUserException user_exception,
                2: DSSSystemException system_exception,
                3: DSSUnknownException unknown_exception),

    list<i32> query_restaurant_by_overflow_level(1: i32 station_id,
                                                 2: i16 level)
        throws (1: DSSUserException user_exception,
                2: DSSSystemException system_exception,
                3: DSSUnknownException unknown_exception),

 }
