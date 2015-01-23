@ECHO OFF
setlocal enabledelayedexpansion

set PROJECT_HOME=%~dp0
set DEMO=JBoss Business Optimizer Demo
set AUTHORS=Geoffrey De Smet, Andrew Block, Eric D. Schabell
set PROJECT=git@github.com:jbossdemocentral/brms-planner-demo.git
set PRODUCT=JBoss BRMS
set TARGET_DIR=%PROJECT_HOME%target
set JBOSS_HOME=%PROJECT_HOME%target\jboss-eap-6.1
set SERVER_DIR=%JBOSS_HOME%\standalone\deployments\
set SERVER_CONF=%JBOSS_HOME%\standalone\configuration\
set SERVER_BIN=%JBOSS_HOME%\bin
set SRC_DIR=%PROJECT_HOME%installs
set SUPPORT_DIR=%PROJECT_HOME%support
set PRJ_DIR=%PROJECT_HOME%projects
set EAP=jboss-eap-6.1.1.zip
set PLANNER=jboss-bpms-brms-6.0.3.GA-redhat-1-optaplanner
set EXAMPLE_WAR=optaplanner-webexamples-6.0.3-redhat-6.war
set VERSION=6.0.3

REM wipe screen.
cls

echo.
echo #####################################################################
echo ##                                                                 ##   
echo ##  Setting up the %DEMO%                   ##
echo ##                                                                 ##   
echo ##                                                                 ##   
echo ##  #####  ####   #####  #####  #   #  #####  #####  #####  ####   ##
echo ##  #   #  #   #    #      #    # # #    #     #     #      #   #  ##
echo ##  #   #  ####     #      #    #   #    #      #    ###    ####   ##
echo ##  #   #  #        #      #    #   #    #       #   #      #  #   ##
echo ##  #####  #        #    #####  #   #  #####  #####  #####  #   #  ##
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

if exist %SRC_DIR%\%PLANNER%.zip (
        echo Product sources are present...
        echo.
) else (
        echo Need to download %PLANNER%.zip package from the Customer Support Portal
        echo and place it in the %SRC_DIR% directory to proceed...
        echo.
        GOTO :EOF
)

if not exist %TARGET_DIR% (
	echo - creating the target directory...
	echo.
	md %TARGET_DIR%
) else (
	echo - detected target directory, moving on...
	echo.
)

REM Unzip the JBoss EAP instance.
echo Unpacking new JBoss Enterprise EAP 6...
echo.

cscript /nologo %SUPPORT_DIR%\unzip.vbs %SRC_DIR%\%EAP% %TARGET_DIR%

REM Unzip the required files from JBoss product deployable.
echo Unpacking %PRODUCT% %VERSION%...
echo.

cscript /nologo %SUPPORT_DIR%\unzip.vbs %SRC_DIR%\%PLANNER%.zip %TARGET_DIR%

echo - installing the JBoss Business Resource Optimizer example app..
echo.

xcopy /Y /Q "%TARGET_DIR%\%PLANNER%\webexamples\binaries\%EXAMPLE_WAR%" "%SERVER_DIR%"

rmdir /s /q "%TARGET_DIR%\%PLANNER%"

echo - enabling demo accounts logins in application-users.properties file...
echo.
xcopy /Y /Q "%SUPPORT_DIR%\application-users.properties" "%SERVER_CONF%"

echo - enabling demo accounts role setup in application-roles.properties file...
echo.
xcopy /Y /Q "%SUPPORT_DIR%\application-roles.properties" "%SERVER_CONF%"

echo - setting up standalone.xml configuration adjustments...
echo.
xcopy /Y /Q "%SUPPORT_DIR%\standalone.xml" "%SERVER_CONF%"

echo You can now start the %PRODUCT% with %SERVER_BIN%\standalone.bat
echo.

echo %PRODUCT% %VERSION% %DEMO% Setup Complete.
echo.

