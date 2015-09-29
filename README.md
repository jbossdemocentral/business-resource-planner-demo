JBoss Business Resource Planner Demo 
====================================
Give you a tour of the Business Resource Planner component for resource planning in JBoss BRMS 
with two examples, a vehicle routing solution and a cloud load balancing solution.

There are two options available to you for using this demo; local and Docker.


Option 1 - Install on your machine
----------------------------------
1. [Download and unzip.](https://github.com/jbossdemocentral/business-resource-planner-demo/archive/master.zip)

2. Add products to installs directory.

3. Run 'init.sh' or 'init.bat'.

4. Start JBoss BPMS Server by running 'standalone.sh' or 'standalone.bat' in the <path-to-project>/target/jboss-eap-6.4/bin directory

5. Run web examples at [http://localhost:8080/jboss-business-resource-planner](http://localhost:8080/jboss-business-resource-planner)


Option 2 - Generate containerized install
----------------------------------
The following steps can be used to configure and run the demo in a docker container

1. [Download and unzip.](https://github.com/jbossdemocentral/business-resource-planner-demo/archive/master.zip)

2. Add product installer to installs directory.

3. Copy contents of support/docker directory to the project root.

4. Build demo image

	```
	docker build -t jbossdemocentral/business-resource-planner-demo .
	```
5. Start demo container

	```
	docker run --it -p 8080:8080 -p 9990:9990 jbossdemocentral/business-resource-planner-demo
	```
6. Run web examples at http://DOCKER_HOST:8080/jboss-business-resource-planner

Additional information can be found in the jbossdemocentral container [developer repository](https://github.com/jbossdemocentral/docker-developer)


Supporting Articles
-------------------
- [7 Steps to Your First Rules with JBoss BRMS Starter Kit](http://www.schabell.org/2015/08/7-steps-first-rules-jboss-brms-starter-kit.html)

- [3 shockingly easy ways into JBoss rules, events, planning & BPM](http://www.schabell.org/2015/01/3-shockingly-easy-ways-into-jboss-brms-bpmsuite.html)

- [Red Hat JBoss BPM Suite - all product demos updated for version 6.0.2.GA release](http://www.schabell.org/2014/07/redhat-jboss-bpmsuite-product-demos-6.0.2-updated.html)


Released versions
-----------------
See the tagged releases for the following versions of the product:

- v1.1 - JBoss Business Resource Planner from JBoss BPM Suite 6.1, JBoss EAP 6.4.0 and optional containerized installation.

- v1.0 - JBoss BRMS 6.0.3, JBoss EAP 6.1.1 and optional containerized installation.

- v0.9 - Migrated to JBoss Demo Central and updated windows init.bat support.

- v0.8 - JBoss BRMS 6.0.3, JBoss EAP 6.1.1, and Planner example war installed.

- v0.7 - moved to JBoss Demo Central.

- v0.7 - JBoss BRMS 6.0.2, JBoss EAP 6.1.1, and Planner example war installed.

- v0.6 - JBoss BRMS 6.0.1, JBoss EAP 6.1.1, and Planner example war installed.

- v0.5 - JBoss BRMS 6.0.0, JBoss EAP 6.1.1, and Planner example war installed.

- v0.4 - JBoss BRMS 6.0.0.CR2, JBoss EAP 6.1.1, and Planner example war installed.

- v0.3 - JBoss BRMS 6.0.0.CR1, JBoss EAP 6.1.1, and Planner example war installed.

- v0.2 - JBoss BRMS 6.0.0.Beta, JBoss EAP 6.1.1, and Planner example war installed.

- v0.1 - JBoss BRMS 6.0.0.Beta1, JBoss EAP 6.1, and Planner example war installed.


![Cloud Balancing] (https://github.com/jbossdemocentral/business-resource-planner-demo/blob/master/docs/demo-images/cloud-balancing.png?raw=true)

![Vehicle Routing] (https://github.com/jbossdemocentral/business-resource-planner-demo/blob/master/docs/demo-images/vehicle-routing.png?raw=true)
