# Change Environment Variables

# Overview

Piku allows you to define and use environment variables in your services.
Here you can define secrets, ip addresses, ports, and other configuration needed by your application.

Piku relies on an `ENV` file where you can define your environment variables, and a `Procfile` where you define the kind of workers to run.

# Change ENV file

Open the `ENV` file in your service directory and you will see the following content:

```
NODE_VERSION=16.14.0
AUTO_RESTART=1
```
Here the node version is pinned to 16.14.0 and AUTO_RESTART is set to 1 which means that after every push the service will be redeployed by Piku.

By looking at the [https://piku.github.io/configuration/env.html](documentation), there are a lot of settings that we can define.

We will start by changing the port at which the service will be listening.

```
echo "PORT=2482" >> ENV
```{{exec}}

Then we can define some custom environment variables that the service will use.

```
echo "TOOL=spoon" >> ENV
```{{exec}}

After modifying the ENV file, we need to commit the changes to the repository.

```
git config --global user.name 'Test user'
git config --global user.email '<>'

git commit -am "feat: add environment variables"

git push piku master
```{{exec}}

Your changes will be deployed and you should be able to see that the service is now listening on port 2482 [http://localhost:2482]({{TRAFFIC_HOST1_2482}}).


