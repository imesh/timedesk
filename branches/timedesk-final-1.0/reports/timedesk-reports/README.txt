==================================================================
                   Timedesk Final 1.0
==================================================================


Reporting
===========

Deployment
---------------------------
1) Go to "http://download.eclipse.org/birt/downloads/build.php?build=R-R1-2_6_1-201009171723" and download the "birt-runtime-2_6_1".
   NB: When BIRT runtime version change, some of maven dependencies versions also will be change.

2) Copy "WebViewerExample" folder found in BIRT runtime folder (birt-runtime-2_6_1/WebViewerExample) to application server deploy folder ($CATALINA_HOME/webapps) and rename it as "birt".

3) Download Apache Commons library from "http://commons.apache.org/logging/download_logging.cgi" and copy "commons-logging-1.1.1.jar" to "$CATALINA_HOME/lib" folder.

4) Go to "timedesk-final-1.0/reports/timedesk-reports/reports/report_library.rptlibrary" and set your db properties.
   Note: We have to give our db password "base64" manner as,
         <encrypted-property name="odaPassword" encryptionID="base64">cGFzc3dvcmQ=</encrypted-property>
         For convert your password to "base64" use, http://www.motobit.com/util/base64-decoder-encoder.asp

         Currently I have set,
          -DBURL=jdbc:mysql://localhost:3306/timedesk_final
          -DBUser=timedesk_final
          -DBPassword=TXNjRUFETXlTUUwx (base64 encoder of "MscEADMySQL1")

5) Copy all items in "timedesk-final-1.0/reports/timedesk-reports/reports/" folder to "$CATALINA_HOME/webapps/birt"

6) Replace jsp file "timedesk-final-1.0/reports/timedesk-reports/jsp/index.jsp" with "$CATALINA_HOME/webapps/birt/index.jsp"

7) Go to URL "http://localhost:8080/birt/" and try links called,
   - View Company Site_report
     Use Parameters as,
     Company-ID: TD
     Site-ID: CMB

   - View Employee Report
     Use Parameters as,
     Employee-ID: IMGUCMB

Note: I have used "https://timedesk.googlecode.com/svn/branches/timedesk-final-1.0/database/Timedesk-20110219-4.sql"
      SQl script for this reports.


SQL use for reports 
---------------------------

@ Project Report - Company and Site
SELECT pro.project_id, pro.name, pro.description, pro.version, pro.start_date, pro.end_date, pro.company_id FROM project AS pro, company AS com, company_site AS comsite WHERE (com.company_id = "TD" AND (com.id = comsite.company_id AND comsite.site_id = "CMB")) AND (comsite.company_id = pro.company_id);

@ Project Report - Employee
SELECT pro.project_id, pro.name, pro.description, pro.version, pro.start_date, pro.end_date, pro.company_id FROM project AS pro, employee AS emp, company_site AS comsite WHERE (emp.employee_id = "IMGUCMB") AND (emp.site_id = comsite.id) AND (comsite.company_id = pro.company_id);




