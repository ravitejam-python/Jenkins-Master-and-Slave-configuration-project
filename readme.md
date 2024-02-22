# Jenkins Master and Slave configuration

## 🧰 Prerequisites
1. Jenkins master server 
2. Slave server with Java installed 

## Procedure: 
1. In Jenkins Master -->Goto Manage Nodes    
   - Manage Jenkins --> Manage Nodes and Clouds --> New Node  

2. Add the node name as Permanent Agent  
   
3. Provide below information to add Jenkins agent  
   **Name:** jenkins-slave 
   **Description:** jenkins-slave agent configuration testing 
   **Number of executors:** 2  
   **Remote root directory:** /home/ubuntu  (This is the directory in Slave agent, where Jenkins workspace data is stored)
   **Labels:** jenkins-slave       (Labels (or tags) are used to group multiple agents into one logical group).  
   **Usage:**  
   - Use this node as much as possible  
   - Only build jobs with label expressions matching this node   
 
   **Launch method:**   
   	  - Launch agents via SSH
   	  - Host: Private_ip of Jenkins-slave-ec2-instance
        - Credentails: jenkins 
        - Domain: Global credentials
        - Kind: SSH Username with private key
        - id: jenkins-slave
        - Description: jenkins-slave
        - Username: ubuntu
        - Private key: Paste private key directly  

   **Host Key Verification Strategy:**  Manually trusted key verification strategy
  
   **Availability:**  
   	- Keep this agent online as much as possible  
   	- Bring this agent online according to a schedule  
   	- Bring this agent online when in demand, and take offline when idle  

4. Once you save above configuration, slave agent is now connected to master
   ```
5. Once connected you can create or edit a job to chose this option in the `Restrict where this project can be run`


## Lessons Learned:   
  1. Master and slave should have  
     - same Java version  
     - Same Maven version   
  1. In case Jave or Maven paths are referring to the agent system then aline it according to masters `Global Tool Configuration`  
  1. In case the case of the AWS server make sure your Jenkins URL should be updated to the latest Public IP.   
  
 
  

