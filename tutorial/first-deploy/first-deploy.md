# Deploying a simple web application using Piku

Now that Piku is installed and running, we can start deploying our first application!

## How does it work?

Generally speaking, Piku works by pushing to a remote, which is usually a server/VPS/similar, and uses git hooks to deploy the application. In our case, though, since we found it quite hard to navigate KillerCoda's documentations and find out how to set up a multiple host setup, we've opted to deploy it locally (that is, the "remote" will be localhost).

### Ok but... internally?

When you deploy an app using Piku, it relies on a few key concepts and files, including `Procfile` and `ENV` files, to define how the application should run and what environment variables are required.

#### **Procfile**

A `Procfile` is a simple text file used by Piku (and other systems like Heroku) to define the processes your app should run. Internally, it uses this file to determine the types of processes (like web servers, workers, or scheduled tasks) and the commands needed to run them.

For example, a `Procfile` might look like this:
```
web: python app.py
worker: python worker.py
```

Here’s how it works internally in Piku:
1. **App Deployment**: When you push your code via Git, Piku looks for a `Procfile` in your repository. If found, Piku parses this file to understand how to run your application.
   
2. **Process Management**: Piku uses `systemd`, or `supervisord`, to manage these processes. Based on the `Procfile`, it creates individual service files or configurations for each process type (e.g., `web`, `worker`).
   
3. **Execution**: After setting up the services, Piku starts the processes as defined in the `Procfile`. It uses the defined commands to launch your web server, background workers, or any other processes necessary for your application.

#### **ENV Files**

Piku uses `ENV` files to configure environment variables for your application: these allow you to separate configuration from code, making it easier to adjust settings without modifying your codebase.

As an example, an `ENV` file might look like this:
```
DATABASE_URL=postgres://user:pass@localhost/db
SECRET_KEY=mysecretkey
DEBUG=True
```

Here’s how it works internally in Piku:
1. **Environment Setup**: When you push your app, Piku looks for any existing `ENV` files or environment variables defined through `piku config:set`. These environment variables are then stored in a special configuration file that Piku maintains for each app.
   
2. **Variable Injection**: When Piku launches your app processes (e.g., using `systemd`), it injects the environment variables from the `ENV` file into the process environment. This ensures that your app runs with the correct settings without hardcoding these values in your code.

3. **Configuration Changes**: If you need to change environment variables, you can use the Piku CLI to update them dynamically. For instance, running `piku config:set VAR=value` will update the `ENV` file for that app, and Piku will automatically reload the app with the new configuration.

#### **Lifecycle of a Piku Deployment**

Here’s an internal flow of what happens when you push your code to Piku:
1. `git push`: You push your app code to the Piku server using Git. The server has a Git remote repository set up to handle these pushes.
   
2. **Code Handling**: Upon receiving the push, Piku checks for a `Procfile` and `ENV` files. It also ensures any dependencies (e.g., Python, Node.js, etc.) are installed according to the language-specific packaging tools (like `requirements.txt` for Python).

3. **Process Setup**: Based on the `Procfile`, Piku sets up process definitions using `systemd` or `supervisord`, creating background services for your app.
   
4. **Environment Injection**: Piku injects any environment variables from the `ENV` file into the running processes, ensuring they have the necessary configuration to function.

5. **App Startup**: Once everything is set up, Piku starts your app and monitors the processes. If a process crashes, `systemd` or `supervisord` will restart it automatically, ensuring high availability.

Below is a flowchart succintly representing this process:

![Piku lifecycle](../assets/flowgraph.png)

## Sample Application

Piku actually has a sample clojure application that we can use to test our deployment. It's hosted on Github, so the first step is for you to clone the repository:

```bash
git clone https://github.com/piku/sample-clojure-app
cd sample-clojure-app
```{{exec}}

In order to deploy the application we will need to install clojure

```bash
curl -O https://raw.githubusercontent.com/technomancy/leiningen/stable/bin/lein
chmod +x lein
sudo mv lein /usr/local/bin/
lein self-install

apt install --assume-yes openjdk-17-jdk
```{{exec}}

## Deploying

The first step here is to add a new remote to the repository:

```bash
git remote add piku piku@localhost:sample-clojure-app
```{{exec}}

Now, we can push the application to Piku:

```bash
git push piku master
```{{exec}}

Finally, we want to check whether the application has correctly been deployed.
The following command will show the logs of the application, in this case an application with a 10 second timer.

```bash
ssh piku@localhost logs sample-clojure-app
```{{exec}}

Use `Ctrl+C` to exit the logs.

Click the `Check` button below to formally complete this step.
