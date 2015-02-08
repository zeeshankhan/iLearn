// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Feedback.m instead.

#import "_Feedback.h"

const struct FeedbackAttributes FeedbackAttributes = {
	.badThings = @"badThings",
	.bestThings = @"bestThings",
	.communicationSkills = @"communicationSkills",
	.feedbackId = @"feedbackId",
	.isAnonymous = @"isAnonymous",
	.overallRating = @"overallRating",
	.topicKnowledge = @"topicKnowledge",
};

const struct FeedbackRelationships FeedbackRelationships = {
	.session = @"session",
	.user = @"user",
};

@implementation FeedbackID
@end

@implementation _Feedback

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"Feedback" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"Feedback";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"Feedback" inManagedObjectContext:moc_];
}

- (FeedbackID*)objectID {
	return (FeedbackID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];

	if ([key isEqualToString:@"isAnonymousValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"isAnonymous"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"overallRatingValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"overallRating"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}

	return keyPaths;
}

@dynamic badThings;

@dynamic bestThings;

@dynamic communicationSkills;

@dynamic feedbackId;

@dynamic isAnonymous;

- (BOOL)isAnonymousValue {
	NSNumber *result = [self isAnonymous];
	return [result boolValue];
}

- (void)setIsAnonymousValue:(BOOL)value_ {
	[self setIsAnonymous:@(value_)];
}

- (BOOL)primitiveIsAnonymousValue {
	NSNumber *result = [self primitiveIsAnonymous];
	return [result boolValue];
}

- (void)setPrimitiveIsAnonymousValue:(BOOL)value_ {
	[self setPrimitiveIsAnonymous:@(value_)];
}

@dynamic overallRating;

- (int16_t)overallRatingValue {
	NSNumber *result = [self overallRating];
	return [result shortValue];
}

- (void)setOverallRatingValue:(int16_t)value_ {
	[self setOverallRating:@(value_)];
}

- (int16_t)primitiveOverallRatingValue {
	NSNumber *result = [self primitiveOverallRating];
	return [result shortValue];
}

- (void)setPrimitiveOverallRatingValue:(int16_t)value_ {
	[self setPrimitiveOverallRating:@(value_)];
}

@dynamic topicKnowledge;

@dynamic session;

@dynamic user;

@end

