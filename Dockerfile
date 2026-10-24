# Use the official Tomcat 9 image with Java 11
FROM tomcat:9.0-jdk11-corretto

# 🔥 极限省内存：压榨 JVM，防止爆 128MB 内存
ENV JAVA_OPTS="-Xms16m -Xmx48m -XX:MaxMetaspaceSize=32m -Xss512k"

# Remove the default Tomcat welcome applications
RUN rm -rf /usr/local/tomcat/webapps/*

# Copy the war file and the entry point
COPY attendance.war /usr/local/tomcat/webapps/attendance.war
COPY entrypoint.sh /usr/local/tomcat/bin/entrypoint.sh

# 修复 Windows 换行符并加权限
RUN sed -i 's/\r$//' /usr/local/tomcat/bin/entrypoint.sh && chmod +x /usr/local/tomcat/bin/entrypoint.sh

EXPOSE 8080
CMD ["/usr/local/tomcat/bin/entrypoint.sh"]
