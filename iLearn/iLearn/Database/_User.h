// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to User.h instead.

@import CoreData;

extern const struct UserAttributes {
	__unsafe_unretained NSString *fname;
	__unsafe_unretained NSString *isAdmin;
	__unsafe_unretained NSString *lname;
	__unsafe_unretained NSString *password;
	__unsafe_unretained NSString *picPath;
	__unsafe_unretained NSString *userId;
} UserAttributes;

extern const struct UserRelationships {
	__unsafe_unretained NSString *feedbacks;
	__unsafe_unretained NSString *requestedSessions;
	__unsafe_unretained NSString *sessions;
} UserRelationships;

@class Feedback;
@class Session;
@class Session;

@interface UserID : NSManagedObjectID {}
@end

@interface _User : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) UserID* objectID;

@property (nonatomic, strong) NSString* fname;

//- (BOOL)validateFname:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSNumber* isAdmin;

@property (atomic) BOOL isAdminValue;
- (BOOL)isAdminValue;
- (void)setIsAdminValue:(BOOL)value_;

//- (BOOL)validateIsAdmin:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* lname;

//- (BOOL)validateLname:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* password;

//- (BOOL)validatePassword:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* picPath;

//- (BOOL)validatePicPath:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* userId;

//- (BOOL)validateUserId:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSSet *feedbacks;

- (NSMutableSet*)feedbacksSet;

@property (nonatomic, strong) NSSet *requestedSessions;

- (NSMutableSet*)requestedSessionsSet;

@property (nonatomic, strong) NSSet *sessions;

- (NSMutableSet*)sessionsSet;

@end

@interface _User (FeedbacksCoreDataGeneratedAccessors)
- (void)addFeedbacks:(NSSet*)value_;
- (void)removeFeedbacks:(NSSet*)value_;
- (void)addFeedbacksObject:(Feedback*)value_;
- (void)removeFeedbacksObject:(Feedback*)value_;

@end

@interface _User (RequestedSessionsCoreDataGeneratedAccessors)
- (void)addRequestedSessions:(NSSet*)value_;
- (void)removeRequestedSessions:(NSSet*)value_;
- (void)addRequestedSessionsObject:(Session*)value_;
- (void)removeRequestedSessionsObject:(Session*)value_;

@end

@interface _User (SessionsCoreDataGeneratedAccessors)
- (void)addSessions:(NSSet*)value_;
- (void)removeSessions:(NSSet*)value_;
- (void)addSessionsObject:(Session*)value_;
- (void)removeSessionsObject:(Session*)value_;

@end

@interface _User (CoreDataGeneratedPrimitiveAccessors)

- (NSString*)primitiveFname;
- (void)setPrimitiveFname:(NSString*)value;

- (NSNumber*)primitiveIsAdmin;
- (void)setPrimitiveIsAdmin:(NSNumber*)value;

- (BOOL)primitiveIsAdminValue;
- (void)setPrimitiveIsAdminValue:(BOOL)value_;

- (NSString*)primitiveLname;
- (void)setPrimitiveLname:(NSString*)value;

- (NSString*)primitivePassword;
- (void)setPrimitivePassword:(NSString*)value;

- (NSString*)primitivePicPath;
- (void)setPrimitivePicPath:(NSString*)value;

- (NSString*)primitiveUserId;
- (void)setPrimitiveUserId:(NSString*)value;

- (NSMutableSet*)primitiveFeedbacks;
- (void)setPrimitiveFeedbacks:(NSMutableSet*)value;

- (NSMutableSet*)primitiveRequestedSessions;
- (void)setPrimitiveRequestedSessions:(NSMutableSet*)value;

- (NSMutableSet*)primitiveSessions;
- (void)setPrimitiveSessions:(NSMutableSet*)value;

@end
