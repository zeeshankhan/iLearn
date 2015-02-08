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
	__unsafe_unretained NSString *feedback;
	__unsafe_unretained NSString *session;
} UserRelationships;

@class Feedback;
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

@property (nonatomic, strong) NSSet *feedback;

- (NSMutableSet*)feedbackSet;

@property (nonatomic, strong) NSSet *session;

- (NSMutableSet*)sessionSet;

@end

@interface _User (FeedbackCoreDataGeneratedAccessors)
- (void)addFeedback:(NSSet*)value_;
- (void)removeFeedback:(NSSet*)value_;
- (void)addFeedbackObject:(Feedback*)value_;
- (void)removeFeedbackObject:(Feedback*)value_;

@end

@interface _User (SessionCoreDataGeneratedAccessors)
- (void)addSession:(NSSet*)value_;
- (void)removeSession:(NSSet*)value_;
- (void)addSessionObject:(Session*)value_;
- (void)removeSessionObject:(Session*)value_;

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

- (NSMutableSet*)primitiveFeedback;
- (void)setPrimitiveFeedback:(NSMutableSet*)value;

- (NSMutableSet*)primitiveSession;
- (void)setPrimitiveSession:(NSMutableSet*)value;

@end
