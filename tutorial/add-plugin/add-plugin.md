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
TODO: explain why this is required

```bash
cp /home/piku/piku.py /root/piku.py
```{{execute}}

We can define our plugin in the `/root/.piku/plugins/automation/__init__.py` file.
TODO: explain what it is, why we want it/why it NEEDS to be a plugin

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
    """change the timer variable"""
    os.system("ssh piku@localhost sample-clojure-app config:set TIMER_DURATION={}".format(duration))
    pass

def cli_commands():
    return automation
```{{copy}}

TODO: we should actually explain that what we're doing here is creating a command,
which allows us to do <things>, etc etc
After that everytime we use piku, the new command should be usable.

We can test the new command by running:

```bash
./piku automation:change-timer 5000
```{{execute}}


