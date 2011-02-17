/*
 *  Time Desk
 *  Project Resource Management System
 *  http://code.google.com/p/timedesk
 *   
 *  Masters in Enterprise Applications Development
 *  Sri Lanka Institute of Information Technology, Sri Lanka
 *  Sheffield Hallam University, United Kingdom
 *  
 *  History:
 *  2011 Feb 17 - Imesh - Created
 *
 */

package org.timedesk.web.util;

public class ApplicationTrace
{
	private static boolean enabled = false;
	
	public static void trace(String message)
	{
		if(enabled)
			System.out.println("[APPTRACE] " + message);
	}
}
