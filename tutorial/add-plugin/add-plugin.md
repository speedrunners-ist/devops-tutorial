# Create Plugins

Piku also allows you to create plugins to extend its core functionalities.
Although this feature is currently only on an experimental basis, we still thought it
would be interesting for you to test it out, and see if it fits your workflow in
the future!

## Why Plugins?

The developers' idea here was to have a smaller core, including support for the most common languages,
basic job scheduling, logging, etc., while things such as database management, more advanced
logging and metrics, secret management, and some others would be left as plugins.
In fact, the concept is so experimental that the developers frequently still discuss
often discuss whether or not [some of these](https://github.com/piku/piku/discussions/309)
should be plugins or not!

To quote them:

> The basic notion here is that even though we can use Piku for “big stuff” like running public services, the core should be something that is immediately useful for hobbyists and K12 to get something running quickly.

## Writing a Plugin

For this, first, we need to copy the Piku from the `piku` user's home directory to root.
We need to do this because only this instance of piku is able to use the plugins that we define.

In order to create plugins we use [click](https://click.palletsprojects.com/en/8.1.x/) which is a Python package that allows us to create command-line interfaces.
We can define groups of commands, and then define the commands themselves with or without arguments.

In this tutorial, we will create a plugin that allows us to change the timer of our Clojure app to a specific value given as an argument.

We can define our plugin in the `/root/.piku/plugins/automation/__init__.py` file.

```bash
mkdir -p /home/piku/.piku/plugins/automation
touch /home/piku/.piku/plugins/automation/__init__.py
```{{execute}}

Then we can define the plugin as follows:

```python
import click

import os

@click.group()
def automation():
    """command plugin"""
    pass

@automation.command("automation:change-timer")
@click.argument('duration')
def change_timer(duration):
    """changes the timer variable of the sample-clojure-app"""
    os.system("./piku.py config:set sample-clojure-app TIMER_DURATION={}".format(duration))
    pass

def cli_commands():
    return automation
```{{copy}}

After that everytime we use piku, the new command should be usable.

We can test the new command by running:

```bash
ssh piku@localhost automation:change-timer 5000
```{{execute}}

```bash
ssh piku@localhost logs sample-clojure-app
```{{exec}}

Use `Ctrl+C` to exit the logs.

Click the `next` button below to formally complete the tutorial.
