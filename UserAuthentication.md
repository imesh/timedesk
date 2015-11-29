#User Authentication implementation using Spring Security 3.0.

### Introduction ###

User Authentication of Time Desk is handled by Spring Security 3.0. It will make use of two entities, namely User and Role.

```
entity Role
{
    string name;
}

entity User
{
    string username;
    string password;
    boolean enabled;
    set<Role> roles;
}
```

Above two entities will be mapped to 3 database tables, namely user, role and user\_role. The User Management client interface will provide features to manage users and their roles.

### Security Configuration ###

The below security configuration settings will be used to define access permissions for different sections of the system.

```
<!-- HTTP security configurations -->
    <http auto-config="true" use-expressions="true">
    	<form-login login-processing-url="/resources/j_spring_security_check" login-page="/login" authentication-failure-url="/login?login_error=t"/>
        <logout logout-url="/resources/j_spring_security_logout"/>
        
        <!-- Configure these elements to secure URIs in your application -->
        <intercept-url pattern="/choices/**" access="hasRole('ROLE_ADMIN')"/>
        <intercept-url pattern="/member/**" access="isAuthenticated()" />
        <intercept-url pattern="/resources/**" access="permitAll" />
        <intercept-url pattern="/<url>/**" access="isAuthenticated()" />
        <intercept-url pattern="/**" access="permitAll" />
    </http>
```

### Authentication Manager ###

File applicationContext-security.xml will be used to define the JDBC User Service. It will provide one SQL query to list out Users and another to list out Authorities. Spring Security will make use of those two queries to handle access permissions.

```
<!-- Configure Authentication mechanism -->
<authentication-manager alias="authenticationManager">
    <authentication-provider>
        <password-encoder hash="md5"/>
	<jdbc-user-service data-source-ref="dataSource"
	 users-by-username-query="SELECT username, password, enabled FROM users where username=?"
	 authorities-by-username-query="SELECT u.username, r.name as authority FROM user u, user_role ur, role r WHERE u.id = ur.Users_id AND ur.roles_id AND u.username = ?" />
    </authentication-provider>
</authentication-manager>
```