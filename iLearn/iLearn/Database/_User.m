// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to User.m instead.

#import "_User.h"

const struct UserAttributes UserAttributes = {
	.fname = @"fname",
	.isAdmin = @"isAdmin",
	.lname = @"lname",
	.password = @"password",
	.picPath = @"picPath",
	.userId = @"userId",
};

const struct UserRelationships UserRelationships = {
	.feedback = @"feedback",
	.session = @"session",
};

@implementation UserID
@end

@implementation _User

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"User" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"User";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"User" inManagedObjectContext:moc_];
}

- (UserID*)objectID {
	return (UserID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];

	if ([key isEqualToString:@"isAdminValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"isAdmin"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}

	return keyPaths;
}

@dynamic fname;

@dynamic isAdmin;

- (BOOL)isAdminValue {
	NSNumber *result = [self isAdmin];
	return [result boolValue];
}

- (void)setIsAdminValue:(BOOL)value_ {
	[self setIsAdmin:@(value_)];
}

- (BOOL)primitiveIsAdminValue {
	NSNumber *result = [self primitiveIsAdmin];
	return [result boolValue];
}

- (void)setPrimitiveIsAdminValue:(BOOL)value_ {
	[self setPrimitiveIsAdmin:@(value_)];
}

@dynamic lname;

@dynamic password;

@dynamic picPath;

@dynamic userId;

@dynamic feedback;

- (NSMutableSet*)feedbackSet {
	[self willAccessValueForKey:@"feedback"];

	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"feedback"];

	[self didAccessValueForKey:@"feedback"];
	return result;
}

@dynamic session;

- (NSMutableSet*)sessionSet {
	[self willAccessValueForKey:@"session"];

	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"session"];

	[self didAccessValueForKey:@"session"];
	return result;
}

@end

