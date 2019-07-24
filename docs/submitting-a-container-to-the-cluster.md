# Submitting a Container to the Cluster
You've got a container! Now what? 

This document describes the process of submitting a personal container to the cluster.

## Table of Contents
1. [Container Building Guidelines](#container-building-guidelines)
    + [Security](#security)
    + [Licensing](#licensing)
    + [Definition File](#definition-file)
2. [Submitting for Approval](#submitting-for-approval)
3. [Next Steps](#next-steps)</br></br>

## Container Building Guidelines
Any container used on Hope's cluster must follow the same guidelines.

### Security
The container must not require root privileges to run, and any software within the container must be usable by a non-root user.

### Licensing
You must provide a proof of licensing for the software used within the container, with the obvious exception of open source programs.

### Definition File
The definition file should provide enough comments that any user can understand its contents.</br></br>

## Submitting for Approval
Once you have built and tested a container in your own environment, you may send an email to a Hope system administrator with the following information:

1. Your name and organization (and your PI, if that is not you).
2. The reason that you need this container.
3. A description of what the container is intended to do.
4. A proof of licensing if you are using software that is not open source.
5. A list of users that should be allowed to access the container if deemed necessary by the license agreement.
6. The definition file for the container.
7. A test case/calculation for the container. For example, if you were submitting a Gaussian container, you would include a test input file along with the expected output file.</br></br>

## Next Steps
We will review this information and decide if this container is ready to be deployed on our cluster. If it requres modification to meet our standards, we will let you know and you will be able to submit it again once you have made the necessary changes.
