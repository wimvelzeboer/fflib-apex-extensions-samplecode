#!/bin/bash

# Make sure that the shared-functions.sh script exists.
if [ ! -r `dirname $0`/lib/shared-functions.sh ]; then
  echo "\nFATAL ERROR: `tput sgr0``tput setaf 1`Could not load dev-tools/lib/shared-functions.sh.  File not found.\n"
  exit 1
fi

# Load the shared-functions.sh library.  This action will also cause the
# config variables from dev-tools/lib/local-config.sh to be loaded.
source `dirname $0`/lib/shared-functions.sh

# STEP 0
resetStepMsgCounter 4

# STEP 1
echoStepMsg "Creating temp folder for downloading fflib-apex-extensions"
mkdir $PROJECT_ROOT/temp
cd $PROJECT_ROOT/temp
rm -Rf fflib-apex-extensions/

echoStepMsg "Downloading latest version of fflib-apex-extensions from GitHub"
git clone https://github.com/apex-enterprise-patterns/fflib-apex-mocks.git
git clone https://github.com/apex-enterprise-patterns/fflib-apex-common.git
git clone https://github.com/wimvelzeboer/fflib-apex-extensions.git

echoStepMsg "Deploying fflib-apex-extensions to $SCRATCH_ORG_ALIAS scratch org"
sfdx force:source:deploy -p ./fflib-apex-mocks/sfdx-source -u $SCRATCH_ORG_ALIAS
sfdx force:source:deploy -p ./fflib-apex-common/sfdx-source -u $SCRATCH_ORG_ALIAS
sfdx force:source:deploy -p ./fflib-apex-extensions/sfdx-source -u $SCRATCH_ORG_ALIAS

echoStepMsg "Cleaning up"
rm -Rf fflib-apex-mocks/
rm -Rf fflib-apex-common/
rm -Rf fflib-apex-extensions/

echo "Done."