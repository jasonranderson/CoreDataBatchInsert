#!/bin/sh

COREDATA_MODEL_FILES=(`find $SRCROOT/$TARGET_NAME -name *.xcdatamodeld`)

for FILE in ${COREDATA_MODEL_FILES[@]}
do
    mogenerator -m $FILE -H $SRCROOT/$TARGET_NAME/CoreData -M $SRCROOT/$TARGET_NAME/CoreData/machine --template-var arc=true --swift

    echo "Updated CoreData files for $FILE"
done