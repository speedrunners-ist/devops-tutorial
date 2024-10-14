# Change Environment Variables

# Overview

Piku allows you to define and use environment variables in your services.
Here you can define secrets, IP addresses, ports, and other configurations required by your application.

As previously mentioned, Piku relies on an `ENV` file where you can define your environment variables, and a `Procfile` where you define the kind of workers to run.

# Change ENV file

Open the `ENV` file in our sample app's directory and you will see the following content:

```
AUTORESTART=1
PORT=9500
```

Here, the `AUTO_RESTART` variable is set to 1, which means that **after every push** the service will be redeployed by Piku.
The `PORT` variable is set to 9500, the default port that the service will be listening on.

By looking at the [https://piku.github.io/configuration/env.html](documentation), there are a lot of settings that we can define.

We will start by changing the port at which the service will be listening.

```
sed -i 's/^PORT=9500/PORT=2482/' ENV
```{{exec}}

Then, we can also define some custom environment variables that the service will use.

```
echo "" >> ENV
echo "TIMER_DURATION=2000" >> ENV
```{{exec}}

After modifying the `ENV` file, we need to alter the code to read (and make use of) the new environment variable.

We will modify the file `worker.clj`:

```clojure
(ns sample-clojure-app.worker
  (:gen-class))

(defn dostuff []
  (do
    (print "I'm doing lazy work\n")
    (println "Resting for" (Integer/parseInt (or (System/getenv "TIMER_DURATION") "10000")) "milliseconds.")
    (flush)))

  (loop [x 1]
    (when (< x 10)
     (dostuff)
      (Thread/sleep (Integer/parseInt (or (System/getenv "TIMER_DURATION") "10000")))
        (recur (+ x 1))))
```{{copy}}

After modifying the source code, we will need to commit the changes to the repository.

```bash
git config --global user.name 'galapagos'
git config --global user.email 'spoon@best.se'

git commit -am "feat: add environment variables"

git push piku master
```{{exec}}

Your changes will be deployed, and you should now be able to see that the service is now listening on port 2482, with the TIMER_DURATION set to 2 seconds (instead of the original 10).

```bash
ssh piku@localhost logs sample-clojure-app
```{{exec}}

