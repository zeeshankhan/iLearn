// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Feedback.h instead.

@import CoreData;

extern const struct FeedbackAttributes {
	__unsafe_unretained NSString *badThings;
	__unsafe_unretained NSString *bestThings;
	__unsafe_unretained NSString *communicationSkills;
	__unsafe_unretained NSString *feedbackId;
	__unsafe_unretained NSString *isAnonymous;
	__unsafe_unretained NSString *overallRating;
	__unsafe_unretained NSString *topicKnowledge;
} FeedbackAttributes;

extern const struct FeedbackRelationships {
	__unsafe_unretained NSString *session;
	__unsafe_unretained NSString *user;
} FeedbackRelationships;

@class Session;
@class User;

@interface FeedbackID : NSManagedObjectID {}
@end

@interface _Feedback : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) FeedbackID* objectID;

@property (nonatomic, strong) NSString* badThings;

//- (BOOL)validateBadThings:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* bestThings;

//- (BOOL)validateBestThings:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* communicationSkills;

//- (BOOL)validateCommunicationSkills:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* feedbackId;

//- (BOOL)validateFeedbackId:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSNumber* isAnonymous;

@property (atomic) BOOL isAnonymousValue;
- (BOOL)isAnonymousValue;
- (void)setIsAnonymousValue:(BOOL)value_;

//- (BOOL)validateIsAnonymous:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSNumber* overallRating;

@property (atomic) int16_t overallRatingValue;
- (int16_t)overallRatingValue;
- (void)setOverallRatingValue:(int16_t)value_;

//- (BOOL)validateOverallRating:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* topicKnowledge;

//- (BOOL)validateTopicKnowledge:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) Session *session;

//- (BOOL)validateSession:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) User *user;

//- (BOOL)validateUser:(id*)value_ error:(NSError**)error_;

@end

@interface _Feedback (CoreDataGeneratedPrimitiveAccessors)

- (NSString*)primitiveBadThings;
- (void)setPrimitiveBadThings:(NSString*)value;

- (NSString*)primitiveBestThings;
- (void)setPrimitiveBestThings:(NSString*)value;

- (NSString*)primitiveCommunicationSkills;
- (void)setPrimitiveCommunicationSkills:(NSString*)value;

- (NSString*)primitiveFeedbackId;
- (void)setPrimitiveFeedbackId:(NSString*)value;

- (NSNumber*)primitiveIsAnonymous;
- (void)setPrimitiveIsAnonymous:(NSNumber*)value;

- (BOOL)primitiveIsAnonymousValue;
- (void)setPrimitiveIsAnonymousValue:(BOOL)value_;

- (NSNumber*)primitiveOverallRating;
- (void)setPrimitiveOverallRating:(NSNumber*)value;

- (int16_t)primitiveOverallRatingValue;
- (void)setPrimitiveOverallRatingValue:(int16_t)value_;

- (NSString*)primitiveTopicKnowledge;
- (void)setPrimitiveTopicKnowledge:(NSString*)value;

- (Session*)primitiveSession;
- (void)setPrimitiveSession:(Session*)value;

- (User*)primitiveUser;
- (void)setPrimitiveUser:(User*)value;

@end
