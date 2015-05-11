#!/bin/sh 
DEMO="JBoss Business Planner Demo"
AUTHORS="Geoffrey De Smet, Andrew Block, Eric D. Schabell"
PROJECT="git@github.com:jbossdemocentral/brms-planner-demo.git"
PRODUCT="JBoss Business Resource Planner"
TARGET_DIR=./target
JBOSS_HOME=./target/jboss-eap-6.4
SERVER_DIR=$JBOSS_HOME/standalone/deployments/
SERVER_CONF=$JBOSS_HOME/standalone/configuration/
SERVER_BIN=$JBOSS_HOME/bin
PLANNER_DIR=jboss-brms-bpmsuite-6.1.0.GA-redhat-2-planner-engine
SRC_DIR=./installs
SUPPORT_DIR=./support
PRJ_DIR=./projects/planner-demo
EAP=jboss-eap-6.4.0-installer.jar
PLANNER=jboss-brms-6.1.0.GA-planner-engine.zip
EXAMPLE_WAR=optaplanner-webexamples-6.2.0.Final-redhat-4.war
VERSION=6.1

# wipe screen.
clear 

echo
echo "#####################################################################"
echo "##                                                                 ##"   
echo "##  Setting up the ${DEMO}                     ##"
echo "##                                                                 ##"   
echo "##                                                                 ##"   
echo "##    ####   #      ###   #   #  #   #  #####  ####                ##"
echo "##    #   #  #     #   #  ##  #  ##  #  #      #   #               ##"
echo "##    ####   #     #####  # # #  # # #  ###    ####                ##"
echo "##    #      #     #   #  #  ##  #  ##  #      #  #                ##"
echo "##    #      ##### #   #  #   #  #   #  #####  #   #               ##"
echo "##                                                                 ##"   
echo "##                                                                 ##"   
echo "##  brought to you by,                                             ##"   
echo "##             ${AUTHORS}    ##"
echo "##                                                                 ##"   
echo "##  ${PROJECT}          ##"
echo "##                                                                 ##"   
echo "#####################################################################"
echo

# make some checks first before proceeding.	
if [ -r $SRC_DIR/$EAP ] || [ -L $SRC_DIR/$EAP ]; then
		echo EAP sources are present...
		echo
else
		echo Need to download $EAP package from the Customer Portal 
		echo and place it in the $SRC_DIR directory to proceed...
		echo
		exit
fi

if [ -r $SRC_DIR/$PLANNER ] || [ -L $SRC_DIR/$PLANNER ]; then
		echo Planner sources are present...
		echo
else
		echo Need to download ${PLANNER}.zip package from the Customer Portal 
		echo and place it in the $SRC_DIR directory to proceed...
		echo
		exit
fi

# Remove the old JBoss instance, if it exists.
if [ -x $JBOSS_HOME ]; then
		echo "  - removing existing install..."
		echo
		rm -rf $TARGET_DIR
fi

# Run installers.
echo "JBoss EAP installer running now..."
echo
java -jar $SRC_DIR/$EAP $SUPPORT_DIR/installation-eap -variablefile $SUPPORT_DIR/installation-eap.variables

if [ $? -ne 0 ]; then
	echo
	echo Error occurred during JBoss EAP installation!
	exit
fi

# Unzip the required files from JBoss product deployable.
echo Unpacking $PRODUCT $VERSION...
echo
unzip -q -d $TARGET_DIR $SRC_DIR/$PLANNER

echo "  - installing the JBoss Business Resource Optimizer example app.."
echo
cp -r $TARGET_DIR/$PLANNER_DIR/webexamples/binaries/$EXAMPLE_WAR $SERVER_DIR/jboss-business-resource-planner.war
rm -rf $TARGET_DIR/$PLANNER_DIR

echo "  - enabling demo accounts role setup in application-roles.properties file..."
echo
cp $SUPPORT_DIR/application-roles.properties $SERVER_CONF

echo "  - setting up standalone.xml configuration adjustments..."
echo
cp $SUPPORT_DIR/standalone.xml $SERVER_CONF

# Add execute permissions to the standalone.sh script.
echo "  - making sure standalone.sh for server is executable..."
echo
chmod u+x $JBOSS_HOME/bin/standalone.sh

echo "You can now start the $PRODUCT with $SERVER_BIN/standalone.sh"
echo

echo "Start your journey to perfect planning with the JBoss Business Resource Planner:"
echo
echo "http://localhost:8080/jboss-business-resource-planner"
echo

echo "$PRODUCT $VERSION $DEMO Setup Complete."
echo

