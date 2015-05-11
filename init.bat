@ECHO OFF
setlocal enabledelayedexpansion

set PROJECT_HOME=%~dp0
set DEMO=JBoss Business Planner Demo
set AUTHORS=Geoffrey De Smet, Andrew Block, Eric D. Schabell
set PROJECT=git@github.com:jbossdemocentral/business-resource-planner-demo.git
set PRODUCT=JBoss BRMS
set TARGET_DIR=%PROJECT_HOME%target
set JBOSS_HOME=%PROJECT_HOME%target\jboss-eap-6.1
set SERVER_DIR=%JBOSS_HOME%\standalone\deployments\
set SERVER_CONF=%JBOSS_HOME%\standalone\configuration\
set SERVER_BIN=%JBOSS_HOME%\bin
set PLANNER_DIR=jboss-brms-bpmsuite-6.1.0.GA-redhat-2-planner-engine
set SRC_DIR=%PROJECT_HOME%installs
set SUPPORT_DIR=%PROJECT_HOME%support
set PRJ_DIR=%PROJECT_HOME%projects
set EAP=jboss-eap-6.4.0-installer.jar
set PLANNER=jboss-brms-6.1.0.GA-planner-engine.zip
set EXAMPLE_WAR=optaplanner-webexamples-6.2.0.Final-redhat-4.war
set VERSION=6.1

REM wipe screen.
cls

echo.
echo #####################################################################
echo ##                                                                 ##   
echo ##  Setting up the %DEMO%                     ##
echo ##                                                                 ##   
echo ##                                                                 ##   
echo ##    ####   #      ###   #   #  #   #  #####  ####                ##
echo ##    #   #  #     #   #  ##  #  ##  #  #      #   #               ##
echo ##    ####   #     #####  # # #  # # #  ###    ####                ##
echo ##    #      #     #   #  #  ##  #  ##  #      #  #                ##
echo ##    #      ##### #   #  #   #  #   #  #####  #   #               ##
echo ##                                                                 ##   
echo ##                                                                 ##   
echo ##  brought to you by,                                             ##   
echo ##             %AUTHORS%    ##
echo ##                                                                 ##   
echo ##  %PROJECT%         ##
echo ##                                                                 ##   
echo #####################################################################
echo.

REM make some checks first before proceeding.	
if exist %SRC_DIR%\%EAP% (
        echo Product sources are present...
        echo.
) else (
        echo Need to download %EAP% package from the Customer Support Portal
        echo and place it in the %SRC_DIR% directory to proceed...
        echo.
        GOTO :EOF
)

if exist %SRC_DIR%\%PLANNER% (
        echo Product sources are present...
        echo.
) else (
        echo Need to download %PLANNER% package from the Customer Support Portal
        echo and place it in the %SRC_DIR% directory to proceed...
        echo.
        GOTO :EOF
)

REM Remove the old JBoss instance, if it exists.
if exist %JBOSS_HOME% (
         echo - removing existing JBoss product install...
         echo.
        
         rmdir /s /q "%JBOSS_HOME%"
 )

REM Run installers.
echo EAP installer running now...
echo.
call java -jar %SRC_DIR%/%EAP% %SUPPORT_DIR%\installation-eap -variablefile %SUPPORT_DIR%\installation-eap.variables


if not "%ERRORLEVEL%" == "0" (
  echo.
	echo Error Occurred During JBoss EAP Installation!
	echo.
	GOTO :EOF
)

REM Unzip the required files from JBoss product deployable.
echo Unpacking %PRODUCT% %VERSION%...
echo.

cscript /nologo %SUPPORT_DIR%\unzip.vbs %SRC_DIR%\%PLANNER% %TARGET_DIR%

echo - installing the JBoss Business Resource Optimizer example app..
echo.

xcopy /Y /Q "%TARGET_DIR%\%PLANNER_DIR%\webexamples\binaries\%EXAMPLE_WAR%" "%SERVER_DIR%\jboss-business-resource-planner.war"

rmdir /s /q "%TARGET_DIR%\%PLANNER_DIR%"

echo - enabling demo accounts role setup in application-roles.properties file...
echo.
xcopy /Y /Q "%SUPPORT_DIR%\application-roles.properties" "%SERVER_CONF%"

echo - setting up standalone.xml configuration adjustments...
echo.
xcopy /Y /Q "%SUPPORT_DIR%\standalone.xml" "%SERVER_CONF%"

echo You can now start the %PRODUCT% with %SERVER_BIN%\standalone.bat
echo.

echo Start your journey to perfect planning with the JBoss Business Resource Planner:
echo.
echo http://localhost:8080/jboss-business-resource-planner
echo.

echo %PRODUCT% %VERSION% %DEMO% Setup Complete.
echo.

