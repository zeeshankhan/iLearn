// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Session.h instead.

@import CoreData;

extern const struct SessionAttributes {
	__unsafe_unretained NSString *dateTime;
	__unsafe_unretained NSString *name;
	__unsafe_unretained NSString *sessionId;
	__unsafe_unretained NSString *status;
	__unsafe_unretained NSString *type;
	__unsafe_unretained NSString *venue;
} SessionAttributes;

extern const struct SessionRelationships {
	__unsafe_unretained NSString *attendees;
	__unsafe_unretained NSString *feedbacks;
	__unsafe_unretained NSString *requestedUser;
	__unsafe_unretained NSString *user;
} SessionRelationships;

@class Attendee;
@class Feedback;
@class User;
@class User;

@interface SessionID : NSManagedObjectID {}
@end

@interface _Session : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) SessionID* objectID;

@property (nonatomic, strong) NSString* dateTime;

//- (BOOL)validateDateTime:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* name;

//- (BOOL)validateName:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* sessionId;

//- (BOOL)validateSessionId:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSNumber* status;

@property (atomic) int16_t statusValue;
- (int16_t)statusValue;
- (void)setStatusValue:(int16_t)value_;

//- (BOOL)validateStatus:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* type;

//- (BOOL)validateType:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* venue;

//- (BOOL)validateVenue:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSSet *attendees;

- (NSMutableSet*)attendeesSet;

@property (nonatomic, strong) NSSet *feedbacks;

- (NSMutableSet*)feedbacksSet;

@property (nonatomic, strong) User *requestedUser;

//- (BOOL)validateRequestedUser:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) User *user;

//- (BOOL)validateUser:(id*)value_ error:(NSError**)error_;

@end

@interface _Session (AttendeesCoreDataGeneratedAccessors)
- (void)addAttendees:(NSSet*)value_;
- (void)removeAttendees:(NSSet*)value_;
- (void)addAttendeesObject:(Attendee*)value_;
- (void)removeAttendeesObject:(Attendee*)value_;

@end

@interface _Session (FeedbacksCoreDataGeneratedAccessors)
- (void)addFeedbacks:(NSSet*)value_;
- (void)removeFeedbacks:(NSSet*)value_;
- (void)addFeedbacksObject:(Feedback*)value_;
- (void)removeFeedbacksObject:(Feedback*)value_;

@end

@interface _Session (CoreDataGeneratedPrimitiveAccessors)

- (NSString*)primitiveDateTime;
- (void)setPrimitiveDateTime:(NSString*)value;

- (NSString*)primitiveName;
- (void)setPrimitiveName:(NSString*)value;

- (NSString*)primitiveSessionId;
- (void)setPrimitiveSessionId:(NSString*)value;

- (NSNumber*)primitiveStatus;
- (void)setPrimitiveStatus:(NSNumber*)value;

- (int16_t)primitiveStatusValue;
- (void)setPrimitiveStatusValue:(int16_t)value_;

- (NSString*)primitiveVenue;
- (void)setPrimitiveVenue:(NSString*)value;

- (NSMutableSet*)primitiveAttendees;
- (void)setPrimitiveAttendees:(NSMutableSet*)value;

- (NSMutableSet*)primitiveFeedbacks;
- (void)setPrimitiveFeedbacks:(NSMutableSet*)value;

- (User*)primitiveRequestedUser;
- (void)setPrimitiveRequestedUser:(User*)value;

- (User*)primitiveUser;
- (void)setPrimitiveUser:(User*)value;

@end
