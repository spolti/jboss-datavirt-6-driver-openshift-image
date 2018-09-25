#!/bin/bash

set -e

SOURCES_DIR="/tmp/artifacts"
SCRIPT_DIR=$(dirname $0)
ADDED_DIR=${SCRIPT_DIR}/added
TARGET_DIR=/extensions

#JDBC_ARTIFACT="ojdbc6.jar"
#CUSTOM_MODULE_NAME="com.oracle"

MODULE_DIR=${TARGET_DIR}/modules/${DRIVER_DIR}

mkdir -p ${MODULE_DIR}

cp -r ${ADDED_DIR}/install.sh ${ADDED_DIR}/install.properties ${TARGET_DIR}

# create the module
mkdir -p /org/jboss/teiid/client/main
cp -r ${SOURCES_DIR}/${JDBC_ARTIFACT} ${MODULE_DIR}
cat ${ADDED_DIR}/module.xml | envsubst > ${MODULE_DIR}/module.xml

# Make sure the owner of added files is the 'jboss' user
chown -R jboss:root ${TARGET_DIR}

# Necessary to permit running with a randomised UID
chmod -R g+rwX ${TARGET_DIR}

