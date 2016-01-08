// Generated by Apple Swift version 2.1.1 (swiftlang-700.1.101.15 clang-700.1.81)
#pragma clang diagnostic push

#if defined(__has_include) && __has_include(<swift/objc-prologue.h>)
# include <swift/objc-prologue.h>
#endif

#pragma clang diagnostic ignored "-Wauto-import"
#include <objc/NSObject.h>
#include <stdint.h>
#include <stddef.h>
#include <stdbool.h>

#if defined(__has_include) && __has_include(<uchar.h>)
# include <uchar.h>
#elif !defined(__cplusplus) || __cplusplus < 201103L
typedef uint_least16_t char16_t;
typedef uint_least32_t char32_t;
#endif

typedef struct _NSZone NSZone;

#if !defined(SWIFT_PASTE)
# define SWIFT_PASTE_HELPER(x, y) x##y
# define SWIFT_PASTE(x, y) SWIFT_PASTE_HELPER(x, y)
#endif
#if !defined(SWIFT_METATYPE)
# define SWIFT_METATYPE(X) Class
#endif

#if defined(__has_attribute) && __has_attribute(objc_runtime_name)
# define SWIFT_RUNTIME_NAME(X) __attribute__((objc_runtime_name(X)))
#else
# define SWIFT_RUNTIME_NAME(X)
#endif
#if defined(__has_attribute) && __has_attribute(swift_name)
# define SWIFT_COMPILE_NAME(X) __attribute__((swift_name(X)))
#else
# define SWIFT_COMPILE_NAME(X)
#endif
#if !defined(SWIFT_CLASS_EXTRA)
# define SWIFT_CLASS_EXTRA
#endif
#if !defined(SWIFT_PROTOCOL_EXTRA)
# define SWIFT_PROTOCOL_EXTRA
#endif
#if !defined(SWIFT_ENUM_EXTRA)
# define SWIFT_ENUM_EXTRA
#endif
#if !defined(SWIFT_CLASS)
# if defined(__has_attribute) && __has_attribute(objc_subclassing_restricted) 
#  define SWIFT_CLASS(SWIFT_NAME) SWIFT_RUNTIME_NAME(SWIFT_NAME) __attribute__((objc_subclassing_restricted)) SWIFT_CLASS_EXTRA
#  define SWIFT_CLASS_NAMED(SWIFT_NAME) __attribute__((objc_subclassing_restricted)) SWIFT_COMPILE_NAME(SWIFT_NAME) SWIFT_CLASS_EXTRA
# else
#  define SWIFT_CLASS(SWIFT_NAME) SWIFT_RUNTIME_NAME(SWIFT_NAME) SWIFT_CLASS_EXTRA
#  define SWIFT_CLASS_NAMED(SWIFT_NAME) SWIFT_COMPILE_NAME(SWIFT_NAME) SWIFT_CLASS_EXTRA
# endif
#endif

#if !defined(SWIFT_PROTOCOL)
# define SWIFT_PROTOCOL(SWIFT_NAME) SWIFT_RUNTIME_NAME(SWIFT_NAME) SWIFT_PROTOCOL_EXTRA
# define SWIFT_PROTOCOL_NAMED(SWIFT_NAME) SWIFT_COMPILE_NAME(SWIFT_NAME) SWIFT_PROTOCOL_EXTRA
#endif

#if !defined(SWIFT_EXTENSION)
# define SWIFT_EXTENSION(M) SWIFT_PASTE(M##_Swift_, __LINE__)
#endif

#if !defined(OBJC_DESIGNATED_INITIALIZER)
# if defined(__has_attribute) && __has_attribute(objc_designated_initializer)
#  define OBJC_DESIGNATED_INITIALIZER __attribute__((objc_designated_initializer))
# else
#  define OBJC_DESIGNATED_INITIALIZER
# endif
#endif
#if !defined(SWIFT_ENUM)
# define SWIFT_ENUM(_type, _name) enum _name : _type _name; enum SWIFT_ENUM_EXTRA _name : _type
#endif
typedef float swift_float2  __attribute__((__ext_vector_type__(2)));
typedef float swift_float3  __attribute__((__ext_vector_type__(3)));
typedef float swift_float4  __attribute__((__ext_vector_type__(4)));
typedef double swift_double2  __attribute__((__ext_vector_type__(2)));
typedef double swift_double3  __attribute__((__ext_vector_type__(3)));
typedef double swift_double4  __attribute__((__ext_vector_type__(4)));
typedef int swift_int2  __attribute__((__ext_vector_type__(2)));
typedef int swift_int3  __attribute__((__ext_vector_type__(3)));
typedef int swift_int4  __attribute__((__ext_vector_type__(4)));
#if defined(__has_feature) && __has_feature(modules)
@import UIKit;
@import ObjectiveC;
#endif

#pragma clang diagnostic ignored "-Wproperty-attribute-mismatch"
#pragma clang diagnostic ignored "-Wduplicate-method-arg"
@class UIWindow;
@class UIApplication;
@class NSObject;
@class NSURL;
@class NSManagedObjectModel;
@class NSPersistentStoreCoordinator;
@class NSManagedObjectContext;

SWIFT_CLASS("_TtC11TripTracker11AppDelegate")
@interface AppDelegate : UIResponder <UIApplicationDelegate>
@property (nonatomic, strong) UIWindow * __nullable window;
- (BOOL)application:(UIApplication * __nonnull)application didFinishLaunchingWithOptions:(NSDictionary * __nullable)launchOptions;
- (void)applicationWillResignActive:(UIApplication * __nonnull)application;
- (void)applicationDidEnterBackground:(UIApplication * __nonnull)application;
- (void)applicationWillEnterForeground:(UIApplication * __nonnull)application;
- (void)applicationDidBecomeActive:(UIApplication * __nonnull)application;
- (void)applicationWillTerminate:(UIApplication * __nonnull)application;
@property (nonatomic, strong) NSURL * __nonnull applicationDocumentsDirectory;
@property (nonatomic, strong) NSManagedObjectModel * __nonnull managedObjectModel;
@property (nonatomic, strong) NSPersistentStoreCoordinator * __nonnull persistentStoreCoordinator;
@property (nonatomic, strong) NSManagedObjectContext * __nonnull managedObjectContext;
- (void)saveContext;
- (nonnull instancetype)init OBJC_DESIGNATED_INITIALIZER;
@end

@class UITextField;
@class UIDatePicker;
@class UILabel;
@class NSBundle;
@class NSCoder;

SWIFT_CLASS("_TtC11TripTracker23DataEntryViewController")
@interface DataEntryViewController : UIViewController
@property (nonatomic, copy) NSString * __nonnull stationName;
@property (nonatomic, copy) NSString * __nonnull tripName;
@property (nonatomic, weak) IBOutlet UIDatePicker * __null_unspecified datePickerField;
@property (nonatomic, weak) IBOutlet UILabel * __null_unspecified tripNameLabel;
@property (nonatomic, weak) IBOutlet UILabel * __null_unspecified stationNameLabel;
@property (nonatomic, weak) IBOutlet UITextField * __null_unspecified currentMileageTextField;
@property (nonatomic, weak) IBOutlet UITextField * __null_unspecified gasPriceTextField;
@property (nonatomic, weak) IBOutlet UITextField * __null_unspecified totalGallonsTextField;
@property (nonatomic, weak) IBOutlet UITextField * __null_unspecified totalPriceTextField;
- (void)viewDidLoad;
- (void)didReceiveMemoryWarning;
- (BOOL)textFieldShouldReturn:(UITextField * __null_unspecified)textField;
- (nonnull instancetype)initWithNibName:(NSString * __nullable)nibNameOrNil bundle:(NSBundle * __nullable)nibBundleOrNil OBJC_DESIGNATED_INITIALIZER;
- (nullable instancetype)initWithCoder:(NSCoder * __nonnull)aDecoder OBJC_DESIGNATED_INITIALIZER;
@end

@class Trip;
@class Station;
@class UIButton;
@class UIPickerView;
@class UIBarButtonItem;

SWIFT_CLASS("_TtC11TripTracker19EnterViewController")
@interface EnterViewController : UIViewController
@property (nonatomic, copy) NSArray<Trip *> * __nonnull trips;
@property (nonatomic, copy) NSArray<Station *> * __nonnull stations;
@property (nonatomic, copy) NSString * __nonnull currentSelectedTrip;
@property (nonatomic, copy) NSString * __nonnull currentSelectedStation;
@property (nonatomic, weak) IBOutlet UIPickerView * __null_unspecified TripNamePickerView;
@property (nonatomic, weak) IBOutlet UIPickerView * __null_unspecified StationNamePickerView;
- (void)viewDidLoad;
- (void)didReceiveMemoryWarning;
- (IBAction)SubmitButtonPressed:(UIButton * __nonnull)sender;
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView * __nonnull)pickerView;
- (NSInteger)pickerView:(UIPickerView * __nonnull)pickerView numberOfRowsInComponent:(NSInteger)component;
- (NSString * __null_unspecified)pickerView:(UIPickerView * __nonnull)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component;
- (IBAction)AddTripButtonPressed:(UIBarButtonItem * __nonnull)sender;
- (IBAction)AddStationButtonPressed:(UIBarButtonItem * __nonnull)sender;
- (NSArray<Station *> * __nonnull)FetchStationData;
- (NSArray<Trip *> * __nonnull)FetchTripData;
- (void)SaveStationData:(NSString * __nonnull)stationName;
- (void)SaveTripData:(NSString * __nonnull)tripName;
- (void)updateTripName;
- (void)updateStationName;
- (nonnull instancetype)initWithNibName:(NSString * __nullable)nibNameOrNil bundle:(NSBundle * __nullable)nibBundleOrNil OBJC_DESIGNATED_INITIALIZER;
- (nullable instancetype)initWithCoder:(NSCoder * __nonnull)aDecoder OBJC_DESIGNATED_INITIALIZER;
@end

@class NSDate;

SWIFT_CLASS("_TtC11TripTracker8GasEntry")
@interface GasEntry : NSObject
@property (nonatomic, copy) NSString * __nonnull name;
@property (nonatomic, copy) NSString * __nonnull station;
@property (nonatomic) double odom;
@property (nonatomic) double gasprice;
@property (nonatomic) double totalgallons;
@property (nonatomic) double totalprice;
@property (nonatomic, strong) NSDate * __nonnull date;
- (nonnull instancetype)initWithDate:(NSDate * __nonnull)date OBJC_DESIGNATED_INITIALIZER;
@end


SWIFT_CLASS("_TtC11TripTracker7Station")
@interface Station : NSObject
@property (nonatomic, copy) NSString * __nonnull name;
@property (nonatomic) NSInteger id;
- (nonnull instancetype)initWithName:(NSString * __nonnull)name id:(NSInteger)id OBJC_DESIGNATED_INITIALIZER;
@end


SWIFT_CLASS("_TtC11TripTracker24StatisticsViewController")
@interface StatisticsViewController : UIViewController
@property (nonatomic, weak) IBOutlet UILabel * __null_unspecified totalMilesTravelled;
@property (nonatomic, weak) IBOutlet UILabel * __null_unspecified totalGallonsUsed;
@property (nonatomic, weak) IBOutlet UILabel * __null_unspecified mostFrequentedStations;
@property (nonatomic, weak) IBOutlet UILabel * __null_unspecified averagePrice;
@property (nonatomic, weak) IBOutlet UILabel * __null_unspecified averageMPG;
@property (nonatomic, weak) IBOutlet UILabel * __null_unspecified averageMiles;
@property (nonatomic, weak) IBOutlet UILabel * __null_unspecified totalAmountPaid;
- (void)viewDidLoad;
- (void)didReceiveMemoryWarning;
- (double)getTotalMilesTraveled:(NSArray<GasEntry *> * __nonnull)gasArray;
- (double)getTotalGallonsUsed:(NSArray<GasEntry *> * __nonnull)gasArray;
- (NSString * __nonnull)getMostFrequentedStations:(NSArray<GasEntry *> * __nonnull)gasArray;
- (double)getAveragePrice:(NSArray<GasEntry *> * __nonnull)gasArray;
- (double)getAverageMPG:(NSArray<GasEntry *> * __nonnull)gasArray;
- (double)getAverageMiles:(NSArray<GasEntry *> * __nonnull)gasArray;
- (double)getTotalAmountPaid:(NSArray<GasEntry *> * __nonnull)gasArray;
- (NSArray<GasEntry *> * __nonnull)FetchData;
- (nonnull instancetype)initWithNibName:(NSString * __nullable)nibNameOrNil bundle:(NSBundle * __nullable)nibBundleOrNil OBJC_DESIGNATED_INITIALIZER;
- (nullable instancetype)initWithCoder:(NSCoder * __nonnull)aDecoder OBJC_DESIGNATED_INITIALIZER;
@end


SWIFT_CLASS("_TtC11TripTracker4Trip")
@interface Trip : NSObject
@property (nonatomic, copy) NSString * __nonnull name;
@property (nonatomic) NSInteger id;
- (nonnull instancetype)initWithName:(NSString * __nonnull)name id:(NSInteger)id OBJC_DESIGNATED_INITIALIZER;
@end


SWIFT_CLASS("_TtC11TripTracker14ViewController")
@interface ViewController : UIViewController
- (void)viewDidLoad;
- (void)didReceiveMemoryWarning;
- (nonnull instancetype)initWithNibName:(NSString * __nullable)nibNameOrNil bundle:(NSBundle * __nullable)nibBundleOrNil OBJC_DESIGNATED_INITIALIZER;
- (nullable instancetype)initWithCoder:(NSCoder * __nonnull)aDecoder OBJC_DESIGNATED_INITIALIZER;
@end

#pragma clang diagnostic pop
