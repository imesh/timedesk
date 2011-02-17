==================================================================
                   Timedesk Final 1.0
==================================================================

Welcome to the Timedesk Final 1.0 release.

Timedesk is a web based project resource management system developed using
Spring MVC. It provides features for Human Resource Management, Project
Management, Training Management and Employee Role Readiness Management. 
It is specially designed for managing software projects in IT organizations.

http://code.google.com/p/timedesk/
http://timedeskonline.com/timedesk/


New Features of Timedesk Final 1.0
====================================
 1) Report

Issues Fixed in Timedesk Final 1.0
====================================


Knows Issues of Timedesk Final 1.0
====================================


Technology Stack
==================

Persistence API
- Hibernate/EclipseLink
Business Logic Implementation
- Java EE 5
Web Client Implementation
- Spring MVC 3.0
Master Page Implementation for Web Client
- Apache Tiles 2.0
Code Generation + Client Framework
- Spring Roo 1.1.0
User Authentication
- Spring Security 3.0


System Requirements
=====================

Operating System
� Fedora 14/Ubuntu 10.10/Windows 7 Ultimate
Database Server
� MySQL Community Server 5.5.8
Application Server
� Apache Tomcat 6.0.29
Runtime Environment
� Java (JDK 1.6.23)
- Maven 2.2.1
- Spring Roo 1.1.0


Installation
==============

1. Download and install Apache Tomcat 6.0.29
2. Download and install Spring Tool Suite 2.5.1.
   This will contain Apache Maven 2.2.1, Spring Roo 1.1.0 and STS IDE 2.5.1.
3. Append Maven path and Spring Roo path including the bin folder to the 
   global path variable.
4. Download and install MySQL Community Server 5.5.8.
5. Extract timedesk-Final-1.0.zip and go to the extracted directory.
6. Deploy latest sql file found in database folder in the MySQL server.
   This will create the timedesk database and insert sample data.
7. Update database url, username and password in source\timedesk\src\main\resources\META-INF\spring\database.properties file.  
8. Go in to source\timedesk directory.
9. Run the command mvn tomcat:run. 
   This will build and deploy the web application in a local tomcat 
   server instance.
10. Now open a web browser and go to URL http://localhost:8080/timedesk.
11. Login using username:admin and password:admin.


Reporting
===========

Set up
-------
1) Go to "http://download.eclipse.org/birt/downloads/build.php?build=R-R1-2_6_1-201009171723" and download the "birt-runtime-2_6_1".
   NB: When BIRT runtime version change, some of maven dependencies versions also will be change.

2) Go to "$TIMEDESK_HOME/source/timedesk/pom.xml" and set "birt.runtime.location" property with your "birt-runtime-2_6_1" as,

   <birt.runtime.location>/home/channa/Desktop/birt-runtime-2_6_1/WebViewerExample</birt.runtime.location>

3) Go to "$TIMEDESK_HOME/source/timedesk/src/main/webapp/report/report_library.rptlibrary" and set your db properties.
   Note: We have to give our db password "base64" manner as,
         <encrypted-property name="odaPassword" encryptionID="base64">cGFzc3dvcmQ=</encrypted-property>
         For convert your password to "base64" use, http://www.motobit.com/util/base64-decoder-encoder.asp

Deployment
----------
1) NB: Due to some "maven tomcat" plugin issue, application will not up with "mvn clean install tomcat:run" command.
       -Therefore do install new tomcat ex: apache-tomcat-6.0.16
       -Go to "$TIMEDESK_HOME/source/timedesk" and do "mvn clean install"
       -Then copy that war file as
        cp $TIMEDESK_HOME/source/timedesk/target/timedesk-0.1.0.BUILD-SNAPSHOT.war $CATALINA_HOME/webapps/
       -Then go to $CATALINA_HOME/bin/ and run "./catalina.sh run"
       -Then try url "http://localhost:8080/timedesk-0.1.0.BUILD-SNAPSHOT"

2) If you get any memory exceptions,
   Go to "$CATALINA_HOME/bin/catalina.sh" and set JAVA_OPTS as,

    # JAVA_OPTS="$JAVA_OPTS "-Djava.util.logging.manager=org.apache.juli.ClassLoaderLogManager" "-Djava.util.logging.config.file="$CATALINA_BASE/conf/logging.properties"
    # Set juli LogManager if it is present
      if [ -r "$CATALINA_BASE"/conf/logging.properties ]; then
         JAVA_OPTS="-Xmx1024m $JAVA_OPTS -Djava.awt.headless=true "
       fi


