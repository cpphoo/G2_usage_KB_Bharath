# G2_usage_KB_Bharath
This repo contains a few scripts/notes I wrote to help folks get started with the G2 server. If you are new to G2, you should start by reading the preliminary section. Then you could proceed to different sections depending on your use case. 


## Preliminary 
* There are three environments you should be aware of:
    * **login-node**: This is a NFS that does not have any compute. When you first ssh into the G2 server, you are login to the login node and this is where you can start requesting compute-node to start running experiments. 
    * **compute-node**: This is the node/machine that has the GPUs and compute for you to run experiments. 
    * **local**: this is your local computer. 
* The standard procedure for running experiments is:
    1. From your **local** computer, ssh into one of the **login-node**
    2. In the **login-node**, submit a job/experiment using SLURM commands. Note: SLURM is a scheduler used to manage different jobs on linux-based server. 
    3. Then your job will be scheduled based on its priority. Once your job started running, it will be run in the **compute-node** you mentioned in the SLURM commands.
* When you submit your job, you can submit it to different queues/partitions. They will have different priorities:
    1. **default_partition**: this is the queue that everyone on G2 has access to. If you do not specify which queue you want to submit your job to, this is the queue your job will go to by default. 
    2. **bala**: priority queue to KB's compute-nodes.
    3. **hariharan**: priority queue to Bharath's compute nodes. 
* To check which priority queue you have access to, run the following on the login node:
```
    (login-node) sinfo
```
* Please request resources evenly based on the GPU you requested on a compute-node. For instance, on compute-node `hariharan-compute-01`, we have 4 GPUs, 122 GB RAM, 20 CPUs. If your experiment requires 1 GPU, please request 1 GPU, 122/4~30GB of RAM and 5 CPUs. If you need to know the resources available on one of the compute node, see one the following sections. 

## Checking Resources Available on Different Compute Nodes on G2
```
(login-node) bash ls_resources.sh
```

## Checking Jobs Running on a Particular Queue on G2

```
(login-node) bash ls_usage.sh hariharan
```

## Checking Jobs You have Submitted
```
(login-node) squeue
```


## Setting up a Jupyter Notebook Server
### Preliminary 
You only have do these steps once. Once this is done, you don't have to do these steps the next time you want to set up a notebook server. 

#### Step 1: Set up passwordless ssh
Make sure that you already have your ssh key pair generated. Then run the following:
```
    (login-node) ssh-copy-id {netid}@{login-node}
```
If you could run 
```
    (login-node) ssh login-node
```
without needing password, then you are all set. 

#### Step 2: Set a password for your jupyter notebook
```
    (login-node) jupyter notebook password 
```




### The Process
#### Step 1: Modify the **#TODO** in **jupyter.sub** to specify the compute node and resources you want to allocate to your notebook server. 

#### Step 2: Submit your job using the the SLURM command 
```
(login-node) sbatch jupyter.sub
```
After you run the command, take note of the job id of your submitted job. 

#### Step 3: Check whether your job has started running by running
```
(login-node) squeue
```
If it has, you will see the letter "R" under the "ST" status column.

#### Step 4: Get the port number you need to ssh into by running
```
(login-node) python port_lookup.py --jobid {jobid}
```
If nothing goes wrong, you should expect the script to print a port number. If nothing is printed, wait for a minute to re-run the script. Otherwise, one of your previous steps is probably faulty (e.g jobs has not started running or the specifications in step 1 are incorrect.)

#### Step 5: SSH into the port on your local computer
```
(local) ssh -NfL {port_number}:localhost:{port_number} {netid}@{login-node}.coecis.cornell.edu
```
Note that the login-node has to be the one that you specify in step 1. Also, make sure that port {port_number} are not in use in your local computer.

#### Step 6: Open a browser window and go the address **localhost:{port_number}**. Enter the password for your notebook and then you are all set!

## Additional References:
1. G2 Usage: https://it.coecis.cornell.edu/researchit/g2cluster/
2. Passwordless SSH: https://linuxize.com/post/how-to-setup-passwordless-ssh-login/

## Notes:
1. Feel free to submit a PR for improvements. 
