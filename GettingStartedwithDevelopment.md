#Follow the below steps to prepare your workspace for Development.


### Step 1: Download Springsource Tool Suite ###

Springsource Tool Suite (STS) is needed as the IDE. Please download version 2.5.1 (zip) from: http://www.springsource.com/developer/sts. It is recommended to download the zip file as it will be easier to install and re-use.

This will include:

  * Maven 2.2.1
  * Roo 1.1.0
  * TC Server Developer 2.1.0 (Tomcat 6.0.29)

### Step 2: Download and Install Java Development Kit ###

If you have not already install JDK 1.6 please download and install version 1.6.0\_23 from: http://www.oracle.com/technetwork/java/javase/downloads/index.html

### Step 3: Extract STS 2.5.1 ###

Extract STS 2.5.1 to a new folder in your local drive.

  * Windows

> `Example: D:\Development\sts-2.5.1\`

  * Linux

> `Example: /home/user/Development/sts-2.5.1/`

### Step 4: Set Maven and Roo Paths ###

Maven and Spring Roo paths should be added to the Operating System global PATH variable. This may differ from Windows to Linux.

  * Windows

  1. Add a new Environment Variable called MVN\_HOME and set the value to Maven path. `Example: %MVN_HOME% = D:\Development\sts-2.5.1\maven-2.2.1.RELEASE`
  1. Add a new Environment Variable called ROO\_HOME and set the value to Spring Roo path. `Example: %ROO_HOME% = D:\Development\sts-2.5.1\roo-1.1.0.RELEASE`
  1. Add both variables to the global PATH variable. `Example: %PATH% = %PATH%; %MVN_HOME%\bin; %ROO_HOME%\bin;`

  * Linux:

> Open .bashrc file found in /home/user/ folder and add following lines at the bottom.

  1. Add a new Environment Variable called MVN\_HOME `Example: export MVN_HOME = /home/user/Development/sts-2.5.1/maven-2.2.1.RELEASE`
  1. Add a new Environment Variable called ROO\_HOME `Example: export ROO_HOME = /home/user/Development/sts-2.5.1/roo-1.1.0.RELEASE`
  1. Add both variables to the global PATH variable. `Example: export PATH = $MVN_HOME/bin: $ROO_HOME/bin:$PATH`

### Step 5: Update STS.ini File ###

Open STS.ini file which can be found inside ..\sts-2.5.1\sts-2.5.1.RELEASE folder and add the below line just before --vmargs.

**Windows:**

```
-vm
C:\Program Files (x86)\Java\jdk1.6.0_23\bin\javaw.exe
```

**Linux:**

To be updated...

This is the path to the Java Virtual Machine. Check your JVM installed location and use that accordingly.

So now it should looks like this:

**Windows:**

```
...
--launcher.XXMaxPermSize
256M
-vm
C:\Program Files (x86)\Java\jdk1.6.0_23\bin\javaw.exe
-vmargs
...
```

**Linux:**

To be updated...

### Step 6: Install a Subversion Client ###

**Windows:**

Install Tortoise SVN Client. This is a shell extension so you will need to restart the computer to take effect.

http://tortoisesvn.net/downloads.html.

**Linux (Ubuntu 10.10):**

Install Subversion using the following command. If available please install a Subversion GUI Client so it will be easier to work with the source control system.

```
sudo apt-get install subversion
```

### Step 7: Create a Workspace Folder ###

Create a new folder to manage the development workspace.

**Windows:
```
Example: D:\Development\TimeDesk\Work\
```** Linux:
```
Example: /home/user/Development/TimeDesk/Work
```
### Step 8: Checkout Source Files from SVN ###

Check out source files from SVN based on the current application version you are working on. Each application version will have a separate branch. Please have a look at the branches available at: https://timedesk.googlecode.com/svn/branches/
```
Example: https://timedesk.googlecode.com/svn/branches/timedesk-prototype-1.0/
```

### Step 9: Build and Run the Application ###

As the next step try to build and run the application using Maven.

**Windows:**

  1. Open command prompt.
  1. Go to timedesk source folder. Example: D:\Development\Time Desk\Work\timedesk-prototype-1.0.
  1. Run the following command:
```
mvn tomcat:run
```

### Step 10: Run STS ###

Now you are ready to go, please run STS and try to import the relevant TimeDesk application version into the IDE.