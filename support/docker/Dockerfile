# Use jbossdemocentral/developer as the base
FROM jbossdemocentral/developer

# Maintainer details
MAINTAINER Andrew Block <andy.block@gmail.com>

# Environment Variables 
ENV EAP_HOME /opt/jboss/eap
ENV EAP_VERSION_MAJOR 6
ENV EAP_VERSION_MINOR 1
ENV EAP_VERSION_MICRO 1

# Copy Installation Files
COPY installs/jboss-eap-$EAP_VERSION_MAJOR.$EAP_VERSION_MINOR.$EAP_VERSION_MICRO.zip installs/jboss-bpms-brms-6.0.3.GA-redhat-1-optaplanner.zip  /opt/jboss/

# Configure project prerequisites and run installer and cleanup installation components
RUN unzip -q -d $EAP_HOME /opt/jboss/jboss-eap-$EAP_VERSION_MAJOR.$EAP_VERSION_MINOR.$EAP_VERSION_MICRO.zip \
  && unzip -q -d /opt/jboss/ /opt/jboss/jboss-bpms-brms-6.0.3.GA-redhat-1-optaplanner.zip \
  && cp -r  /opt/jboss/jboss-bpms-brms-6.0.3.GA-redhat-1-optaplanner/webexamples/binaries/optaplanner-webexamples-6.0.3-redhat-6.war  $EAP_HOME/jboss-eap-6.1/standalone/deployments/ \
   && rm -rf /opt/jboss/jboss-eap-$EAP_VERSION_MAJOR.$EAP_VERSION_MINOR.$EAP_VERSION_MICRO.zip /opt/jboss/jboss-bpms-brms-6.0.3.GA-redhat-1-optaplanner.zip /opt/jboss/jboss-bpms-brms-6.0.3.GA-redhat-1-optaplanner

# Copy demo and support files
COPY support/application-roles.properties support/standalone.xml $EAP_HOME/jboss-eap-6.1/standalone/configuration/

# Swtich back to root user to perform build and cleanup
USER root

# Adjust permissions and cleanup
RUN chown -R jboss:jboss $EAP_HOME/jboss-eap-6.1/standalone/configuration/application-roles.properties $EAP_HOME/jboss-eap-6.1/standalone/configuration/standalone.xml $EAP_HOME/jboss-eap-6.1/standalone/deployments/optaplanner-webexamples-6.0.3-redhat-6.war

# Run as JBoss 
USER jboss

# Expose Ports
EXPOSE 9990 9999 8080

# Run EAP
CMD ["/opt/jboss/eap/jboss-eap-6.1/bin/standalone.sh","-c","standalone.xml","-b", "0.0.0.0","-bmanagement","0.0.0.0"]
