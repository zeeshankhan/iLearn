// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Attendee.h instead.

@import CoreData;

extern const struct AttendeeAttributes {
	__unsafe_unretained NSString *attendeeId;
	__unsafe_unretained NSString *name;
	__unsafe_unretained NSString *userId;
} AttendeeAttributes;

extern const struct AttendeeRelationships {
	__unsafe_unretained NSString *session;
} AttendeeRelationships;

@class Session;

@interface AttendeeID : NSManagedObjectID {}
@end

@interface _Attendee : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) AttendeeID* objectID;

@property (nonatomic, strong) NSString* attendeeId;

//- (BOOL)validateAttendeeId:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* name;

//- (BOOL)validateName:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* userId;

//- (BOOL)validateUserId:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSSet *session;

- (NSMutableSet*)sessionSet;

@end

@interface _Attendee (SessionCoreDataGeneratedAccessors)
- (void)addSession:(NSSet*)value_;
- (void)removeSession:(NSSet*)value_;
- (void)addSessionObject:(Session*)value_;
- (void)removeSessionObject:(Session*)value_;

@end

@interface _Attendee (CoreDataGeneratedPrimitiveAccessors)

- (NSString*)primitiveAttendeeId;
- (void)setPrimitiveAttendeeId:(NSString*)value;

- (NSString*)primitiveName;
- (void)setPrimitiveName:(NSString*)value;

- (NSString*)primitiveUserId;
- (void)setPrimitiveUserId:(NSString*)value;

- (NSMutableSet*)primitiveSession;
- (void)setPrimitiveSession:(NSMutableSet*)value;

@end
