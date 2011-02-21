==================================================================
                   Timedesk Final 1.0
==================================================================


Reporting
===========

Deployment
---------------------------
1) Go to "http://download.eclipse.org/birt/downloads/build.php?build=R-R1-2_6_1-201009171723" and download the "birt-runtime-2_6_1".
   Note: When BIRT runtime version change, some of maven dependencies versions also will be change.

2) Copy "WebViewerExample" folder found in BIRT runtime folder (birt-runtime-2_6_1/WebViewerExample) to application server deploy folder ($CATALINA_HOME/webapps) and rename it as "timedesk-reports".

3) Download Apache Commons library from "http://commons.apache.org/logging/download_logging.cgi" and copy "commons-logging-1.1.1.jar" to "$CATALINA_HOME/lib" folder.

4) Go to "timedesk-final-1.0/reports/timedesk-reports/reports/report_library.rptlibrary" and set your db properties.
   Note: We have to give our db password "base64" manner as,
         <encrypted-property name="odaPassword" encryptionID="base64">cGFzc3dvcmQ=</encrypted-property>
         For convert your password to "base64" use, http://www.motobit.com/util/base64-decoder-encoder.asp

         Currently it is set to:
          -DBURL=jdbc:mysql://localhost:3306/timedesk_final
          -DBUser=timedesk_final
          -DBPassword=TXNjRUFETXlTUUwx (base64 encoder of "MscEADMySQL1")

5) Copy all items in "timedesk-final-1.0/reports/timedesk-reports/" folder to "$CATALINA_HOME/webapps/timedesk-reports"


Fixes for exceptions might occur at deploy time
---------------------------
1) If you get any "mysql driver" related exceptions during the report browsing,
   Please copy "mysql-connector-java-5.1.13.jar" driver file to application server "$CATALINA_HOME/lib" folder and update (jarList) absolute path in report_library.rptlibrary file.
