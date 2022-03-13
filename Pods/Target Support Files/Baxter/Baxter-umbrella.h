#ifdef __OBJC__
#import <UIKit/UIKit.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "Baxter.h"
#import "KBAFetchedResultsController.h"
#import "KBAFetchedResultsObserver.h"
#import "KBAManagedObjectEntityMapping.h"
#import "KBAManagedObjectPropertyMapping.h"
#import "NSFetchRequest+KBAExtensions.h"
#import "NSManagedObjectContext+KBAExtensions.h"
#import "NSManagedObjectContext+KBAImportExtensions.h"

FOUNDATION_EXPORT double BaxterVersionNumber;
FOUNDATION_EXPORT const unsigned char BaxterVersionString[];

