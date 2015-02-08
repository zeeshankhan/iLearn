// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Attendee.m instead.

#import "_Attendee.h"

const struct AttendeeAttributes AttendeeAttributes = {
	.attendeeId = @"attendeeId",
	.name = @"name",
	.userId = @"userId",
};

const struct AttendeeRelationships AttendeeRelationships = {
	.session = @"session",
};

@implementation AttendeeID
@end

@implementation _Attendee

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"Attendee" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"Attendee";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"Attendee" inManagedObjectContext:moc_];
}

- (AttendeeID*)objectID {
	return (AttendeeID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];

	return keyPaths;
}

@dynamic attendeeId;

@dynamic name;

@dynamic userId;

@dynamic session;

- (NSMutableSet*)sessionSet {
	[self willAccessValueForKey:@"session"];

	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"session"];

	[self didAccessValueForKey:@"session"];
	return result;
}

@end

