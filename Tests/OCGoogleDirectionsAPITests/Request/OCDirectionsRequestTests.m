//
//  OCDIrestionsRequestTests.m
//  OCGoogleDirectionsAPI
//
//  Created by Marcin Iwanicki on 3/11/14.
//
//

#import <XCTest/XCTest.h>
#import <CoreLocation/CoreLocation.h>

@import OCGoogleDirectionsAPI;

@interface OCDIrestionsRequestTests : XCTestCase

@end

@implementation OCDIrestionsRequestTests

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"

#pragma mark - Test helpers

- (void)testPrepareFirstLocationHelper {
    // when
    CLLocation *location = [self prepareFirstLocation];

    // then
    XCTAssertNotNil(location);
    XCTAssertTrue([location isMemberOfClass:[CLLocation class]]);
}

- (void)testPrepareSecondLocationHelper {
    // when
    CLLocation *location = [self prepareSecondLocation];

    // then
    XCTAssertNotNil(location);
    XCTAssertTrue([location isMemberOfClass:[CLLocation class]]);
}

- (void)testPrepareFirstStringHelper {
    // when
    NSString *string = [self prepareFirstString];

    // then
    XCTAssertNotNil(string);
    XCTAssertEqual(@"London", string);
}

- (void)testPreapreSecondStringHelper {
    // when
    NSString *string = [self prepareSecondString];

    // then
    XCTAssertNotNil(string);
    XCTAssertEqual(@"Reading", string);
}

#pragma mark - Test requestWithOriginLocation:andDestinationLocation:sensor:

- (void)testRequestWithOriginLocationAndDestinationLocationWhenOriginIsNil {
    // given
    CLLocation *originLocation = nil;
    CLLocation *destinationLocation = [self prepareSecondLocation];

    // then
    XCTAssertThrowsSpecificNamed([OCDirectionsRequest requestWithOriginLocation:originLocation
                                                         andDestinationLocation:destinationLocation
                                                                         sensor:NO], NSException, NSInvalidArgumentException);
}

- (void)testRequestWithOriginLocationAndDestinationLocationWhenDestinationIsNil {
    // given
    CLLocation *originLocation = [self prepareFirstLocation];
    CLLocation *destinationLocation = nil;

    // then
    XCTAssertThrowsSpecificNamed([OCDirectionsRequest requestWithOriginLocation:originLocation
                                                         andDestinationLocation:destinationLocation
                                                                         sensor:NO], NSException, NSInvalidArgumentException);
}

- (void)testRequestWithOriginLocationAndDestinationLocationWhenOriginAndDestinationAreNil {
    // given
    CLLocation *originLocation = nil;
    CLLocation *destinationLocation = nil;

    // then
    XCTAssertThrowsSpecificNamed([OCDirectionsRequest requestWithOriginLocation:originLocation
                                                         andDestinationLocation:destinationLocation
                                                                         sensor:NO], NSException, NSInvalidArgumentException);
}

- (void)testRequestWithOriginLocationAndDestinationLocationWhenOriginAndDestinationAreNotNil {
    // given
    CLLocation *originLocation = [self prepareFirstLocation];
    CLLocation *destinationLocation = [self prepareSecondLocation];

    // when
    OCDirectionsRequest *request = [OCDirectionsRequest requestWithOriginLocation:originLocation
                                                           andDestinationLocation:destinationLocation
                                                                           sensor:NO];
    // then
    XCTAssertNotNil(request);
    XCTAssertTrue([request isMemberOfClass:[OCDirectionsRequest class]]);
    XCTAssertEqual(originLocation, request.originLocation);
    XCTAssertNil(request.originString);
    XCTAssertEqual(destinationLocation, request.destinationLocation);
    XCTAssertNil(request.destinationString);
    XCTAssertFalse(request.sensor);

    [self verifyPropertiesWithDefaultValuesOfRequest:request];
}

- (void)testRequestWithOriginLocationAndDestinationLocationWhenOriginAndDestinationAreNotNilAndSensorIsTrue {
    // given
    CLLocation *originLocation = [self prepareFirstLocation];
    CLLocation *destinationLocation = [self prepareSecondLocation];

    // when
    OCDirectionsRequest *request = [OCDirectionsRequest requestWithOriginLocation:originLocation
                                                           andDestinationLocation:destinationLocation
                                                                           sensor:YES];
    // then
    XCTAssertNotNil(request);
    XCTAssertTrue([request isMemberOfClass:[OCDirectionsRequest class]]);
    XCTAssertEqual(originLocation, request.originLocation);
    XCTAssertNil(request.originString);
    XCTAssertEqual(destinationLocation, request.destinationLocation);
    XCTAssertNil(request.destinationString);
    XCTAssertTrue(request.sensor);

    [self verifyPropertiesWithDefaultValuesOfRequest:request];
}

#pragma mark - Test requestWithOriginString:andDestinationLocation:sensor:

- (void)testRequestWithOriginStringAndDestinationLocationWhenOriginIsNil {
    // given
    NSString *originString = nil;
    CLLocation *destinationLocation = [self prepareSecondLocation];

    // then
    XCTAssertThrowsSpecificNamed([OCDirectionsRequest requestWithOriginString:originString
                                                       andDestinationLocation:destinationLocation
                                                                       sensor:NO], NSException, NSInvalidArgumentException);
}

- (void)testRequestWithOriginStringAndDestinationLocationWhenDestinationIsNil {
    // given
    NSString *originString = [self prepareFirstString];
    CLLocation *destinationLocation = nil;

    // then
    XCTAssertThrowsSpecificNamed([OCDirectionsRequest requestWithOriginString:originString
                                                       andDestinationLocation:destinationLocation
                                                                       sensor:NO], NSException, NSInvalidArgumentException);
}

- (void)testRequestWithOriginStringAndDestinationLocationWhenOriginAndDestinationAreNil {
    // given
    NSString *originString = nil;
    CLLocation *destinationLocation = nil;

    // then
    XCTAssertThrowsSpecificNamed([OCDirectionsRequest requestWithOriginString:originString
                                                       andDestinationLocation:destinationLocation
                                                                       sensor:NO], NSException, NSInvalidArgumentException);
}

- (void)testRequestWithOriginStringAndDestinationLocationWhenOriginAndDestinationAreNotNil {
    // given
    NSString *originString = [self prepareFirstString];
    CLLocation *destinationLocation = [self prepareSecondLocation];

    // when
    OCDirectionsRequest *request = [OCDirectionsRequest requestWithOriginString:originString
                                                         andDestinationLocation:destinationLocation
                                                                         sensor:NO];

    // then
    XCTAssertNotNil(request);
    XCTAssertTrue([request isMemberOfClass:[OCDirectionsRequest class]]);
    XCTAssertEqual(originString, request.originString);
    XCTAssertNil(request.originLocation);
    XCTAssertEqual(destinationLocation, request.destinationLocation);
    XCTAssertNil(request.destinationString);
    XCTAssertFalse(request.sensor);

    [self verifyPropertiesWithDefaultValuesOfRequest:request];
}

- (void)testRequestWithOriginStringAndDestinationLocationWhenOriginAndDestinationAreNotNilAndSensorIsTrue {
    // given
    NSString *originString = [self prepareFirstString];
    CLLocation *destinationLocation = [self prepareSecondLocation];

    // when
    OCDirectionsRequest *request = [OCDirectionsRequest requestWithOriginString:originString
                                                         andDestinationLocation:destinationLocation
                                                                         sensor:YES];

    // then
    XCTAssertNotNil(request);
    XCTAssertTrue([request isMemberOfClass:[OCDirectionsRequest class]]);
    XCTAssertEqual(originString, request.originString);
    XCTAssertNil(request.originLocation);
    XCTAssertEqual(destinationLocation, request.destinationLocation);
    XCTAssertNil(request.destinationString);
    XCTAssertTrue(request.sensor);

    [self verifyPropertiesWithDefaultValuesOfRequest:request];
}

#pragma mark - Test requestWithOriginLocation:andDestinationString:sensor:

- (void)testRequestWithOriginLocationAndDestinationStringWhenOriginIsNil {
    // given
    CLLocation *originLocation = nil;
    NSString *destinationString = [self prepareSecondString];

    // then
    XCTAssertThrowsSpecificNamed([OCDirectionsRequest requestWithOriginLocation:originLocation
                                                           andDestinationString:destinationString
                                                                         sensor:NO], NSException, NSInvalidArgumentException);
}

- (void)testRequestWithOriginLocationAndDestinationStringWhenDestinationIsNil {
    // given
    CLLocation *originLocation = [self prepareFirstLocation];
    NSString *destinationString = nil;

    // then
    XCTAssertThrowsSpecificNamed([OCDirectionsRequest requestWithOriginLocation:originLocation
                                                           andDestinationString:destinationString
                                                                         sensor:NO], NSException, NSInvalidArgumentException);
}

- (void)testRequestWithOriginLocationAndDestinationStringWhenOriginAndDestinationAreNil {
    // given
    CLLocation *originLocation = nil;
    NSString *destinationString = nil;

    // then
    XCTAssertThrowsSpecificNamed([OCDirectionsRequest requestWithOriginLocation:originLocation
                                                           andDestinationString:destinationString
                                                                         sensor:NO], NSException, NSInvalidArgumentException);
}

- (void)testRequestWithOriginLocationAndDestinationStringWhenOriginAndDestinationAreNotNil {
    // given
    CLLocation *originLocation = [self prepareFirstLocation];
    NSString *destinationString = [self prepareSecondString];

    // when
    OCDirectionsRequest *request = [OCDirectionsRequest requestWithOriginLocation:originLocation
                                                             andDestinationString:destinationString
                                                                           sensor:NO];

    // then
    XCTAssertNotNil(request);
    XCTAssertTrue([request isMemberOfClass:[OCDirectionsRequest class]]);
    XCTAssertEqual(originLocation, request.originLocation);
    XCTAssertNil(request.originString);
    XCTAssertEqual(destinationString, request.destinationString);
    XCTAssertNil(request.destinationLocation);
    XCTAssertFalse(request.sensor);

    [self verifyPropertiesWithDefaultValuesOfRequest:request];
}

- (void)testRequestWithOriginLocationAndDestinationStringWhenOriginAndDestinationAreNotNilAndSensorIsTrue {
    // given
    CLLocation *originLocation = [self prepareFirstLocation];
    NSString *destinationString = [self prepareSecondString];

    // when
    OCDirectionsRequest *request = [OCDirectionsRequest requestWithOriginLocation:originLocation
                                                             andDestinationString:destinationString
                                                                           sensor:YES];

    // then
    XCTAssertNotNil(request);
    XCTAssertTrue([request isMemberOfClass:[OCDirectionsRequest class]]);
    XCTAssertEqual(originLocation, request.originLocation);
    XCTAssertNil(request.originString);
    XCTAssertEqual(destinationString, request.destinationString);
    XCTAssertNil(request.destinationLocation);
    XCTAssertTrue(request.sensor);

    [self verifyPropertiesWithDefaultValuesOfRequest:request];
}

#pragma mark - Test requestWithOriginString:andDestinationString:sensor:

- (void)testRequestWithOriginStringAndDestinationStringWhenOriginIsNil {
    // given
    NSString *originString = nil;
    NSString *destinationString = [self prepareSecondString];

    // then
    XCTAssertThrowsSpecificNamed([OCDirectionsRequest requestWithOriginString:originString
                                                         andDestinationString:destinationString
                                                                       sensor:NO], NSException, NSInvalidArgumentException);
}

- (void)testRequestWithOriginStringAndDestinationStringWhenDestinationIsNil {
    // given
    NSString *originString = [self prepareFirstString];
    NSString *destinationString = nil;

    // then
    XCTAssertThrowsSpecificNamed([OCDirectionsRequest requestWithOriginString:originString
                                                         andDestinationString:destinationString
                                                                       sensor:NO], NSException, NSInvalidArgumentException);
}

- (void)testRequestWithOriginStringAndDestinationStringWhenOriginAndDestinationAreNil {
    // given
    NSString *originString = nil;
    NSString *destinationString = nil;

    // then
    XCTAssertThrowsSpecificNamed([OCDirectionsRequest requestWithOriginString:originString
                                                         andDestinationString:destinationString
                                                                       sensor:NO], NSException, NSInvalidArgumentException);
}

- (void)testRequestWithOriginStringAndDestinationStringWhenOriginAndDestinationAreNotNil {
    // given
    NSString *originString = [self prepareFirstString];
    NSString *destinationString = [self prepareSecondString];

    // when
    OCDirectionsRequest *request = [OCDirectionsRequest requestWithOriginString:originString
                                                           andDestinationString:destinationString
                                                                         sensor:NO];

    // then
    XCTAssertNotNil(request);
    XCTAssertTrue([request isMemberOfClass:[OCDirectionsRequest class]]);
    XCTAssertEqual(originString, request.originString);
    XCTAssertNil(request.originLocation);
    XCTAssertEqual(destinationString, request.destinationString);
    XCTAssertNil(request.destinationLocation);
    XCTAssertFalse(request.sensor);

    [self verifyPropertiesWithDefaultValuesOfRequest:request];
}

- (void)testRequestWithOriginStringAndDestinationStringWhenOriginAndDestinationAreNotNilAndSensorIsTrue {
    // given
    NSString *originString = [self prepareFirstString];
    NSString *destinationString = [self prepareSecondString];

    // when
    OCDirectionsRequest *request = [OCDirectionsRequest requestWithOriginString:originString
                                                           andDestinationString:destinationString
                                                                         sensor:YES];

    // then
    XCTAssertNotNil(request);
    XCTAssertTrue([request isMemberOfClass:[OCDirectionsRequest class]]);
    XCTAssertEqual(originString, request.originString);
    XCTAssertNil(request.originLocation);
    XCTAssertEqual(destinationString, request.destinationString);
    XCTAssertNil(request.destinationLocation);
    XCTAssertTrue(request.sensor);

    [self verifyPropertiesWithDefaultValuesOfRequest:request];
}

#pragma mark - isValid

- (void)testIsValidWhenParametersAreFine {
    // given
    NSString *originString = [self prepareFirstString];
    CLLocation *originLocation = [self prepareFirstLocation];
    NSString *destinationString = [self prepareSecondString];
    CLLocation *destinationLocation = [self prepareSecondLocation];

    OCDirectionsRequest *requestLL = [OCDirectionsRequest requestWithOriginLocation:originLocation
                                                             andDestinationLocation:destinationLocation
                                                                             sensor:YES];

    OCDirectionsRequest *requestLS = [OCDirectionsRequest requestWithOriginLocation:originLocation
                                                               andDestinationString:destinationString
                                                                             sensor:YES];

    OCDirectionsRequest *requestSL = [OCDirectionsRequest requestWithOriginString:originString
                                                           andDestinationLocation:destinationLocation
                                                                           sensor:YES];

    OCDirectionsRequest *requestSS = [OCDirectionsRequest requestWithOriginString:originString
                                                             andDestinationString:destinationString
                                                                           sensor:YES];

    // when
    BOOL requestLLIsValid = [requestLL isValid];
    BOOL requestLSIsValid = [requestLS isValid];
    BOOL requestSLIsValid = [requestSL isValid];
    BOOL requestSSIsValid = [requestSS isValid];

    //then
    XCTAssertTrue(requestLLIsValid);
    XCTAssertTrue(requestLSIsValid);
    XCTAssertTrue(requestSLIsValid);
    XCTAssertTrue(requestSSIsValid);
}

#pragma mark - Custom verifiers

- (void)verifyPropertiesWithDefaultValuesOfRequest:(OCDirectionsRequest *)request {
    XCTAssertFalse(request.alternatives);
    XCTAssertTrue(request.isValid);
    XCTAssertEqual(OCDirectionsRequestTravelModeDriving, request.travelMode);
    XCTAssertEqual(OCDirectionsRequestUnitDefault, request.unit);
    XCTAssertNil(request.waypoints);
    XCTAssertFalse(request.waypointsOptimise);
}

#pragma mark - Helpers

- (CLLocation *)prepareFirstLocation {
    CLLocation *location = [[CLLocation alloc] initWithLatitude:10.0 longitude:20.0];
    return location;
}

- (CLLocation *)prepareSecondLocation {
    CLLocation *location = [[CLLocation alloc] initWithLatitude:30.0 longitude:40.0];
    return location;
}

- (NSString *)prepareFirstString {
    NSString *string = @"London";
    return string;
}

- (NSString *)prepareSecondString {
    NSString *string = @"Reading";
    return string;
}

#pragma clang diagnostic pop

@end
