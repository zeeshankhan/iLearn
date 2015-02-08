// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Session.m instead.

#import "_Session.h"

const struct SessionAttributes SessionAttributes = {
	.dateTime = @"dateTime",
	.name = @"name",
	.sessionId = @"sessionId",
	.status = @"status",
	.type = @"type",
	.venue = @"venue",
};

const struct SessionRelationships SessionRelationships = {
	.attendees = @"attendees",
	.feedbacks = @"feedbacks",
	.user = @"user",
};

@implementation SessionID
@end

@implementation _Session

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"Session" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"Session";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"Session" inManagedObjectContext:moc_];
}

- (SessionID*)objectID {
	return (SessionID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];

	if ([key isEqualToString:@"statusValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"status"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}

	return keyPaths;
}

@dynamic dateTime;

@dynamic name;

@dynamic sessionId;

@dynamic status;

- (int16_t)statusValue {
	NSNumber *result = [self status];
	return [result shortValue];
}

- (void)setStatusValue:(int16_t)value_ {
	[self setStatus:@(value_)];
}

- (int16_t)primitiveStatusValue {
	NSNumber *result = [self primitiveStatus];
	return [result shortValue];
}

- (void)setPrimitiveStatusValue:(int16_t)value_ {
	[self setPrimitiveStatus:@(value_)];
}

@dynamic type;

@dynamic venue;

@dynamic attendees;

- (NSMutableSet*)attendeesSet {
	[self willAccessValueForKey:@"attendees"];

	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"attendees"];

	[self didAccessValueForKey:@"attendees"];
	return result;
}

@dynamic feedbacks;

- (NSMutableSet*)feedbacksSet {
	[self willAccessValueForKey:@"feedbacks"];

	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"feedbacks"];

	[self didAccessValueForKey:@"feedbacks"];
	return result;
}

@dynamic user;

@end

