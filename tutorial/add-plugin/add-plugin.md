# Create Plugins

Piku allows you to create plugins to extend its functionality.

First we will to have the piku cli tool.

```bash
mkdir -p ~/bin
curl https://raw.githubusercontent.com/piku/piku/master/piku > ~/bin/piku && chmod 755 ~/bin/piku

export PATH=$HOME/bin:$PATH

source ~/.bashrc
```{{execute}}

Now piku should be available for use.

With that we should be able to get some useful commands.

So in order to add some automation plugins to piku, we need to create a python file where we will define the commands.
```bash
mkdir -p ~/.piku/plugins/automation
```{{execute}}

Then we can define our plugin in the `~/.piku/plugins/automation/__init.py__`.

```python
import click

import os

@click.group()
def automation():
    """command plugin"""
    pass

@automation.command("automation:worker")
def create_worker():
    """create a worker"""
    os.system("java -cp target/uberjar/sample-clojure-app-0.1.0-SNAPSHOT-standalone.jar clojure.main worker.clj")
    pass

@automation.command("automation:change-timer")
@click.argument('duration')
def change_timer(duration):
    """change the timer variable"""
    os.system("ssh piku@localhost config:set TIMER_DURATION={}".format(duration))
    os.system("ssh piku@localhost deploy")
    pass

def cli_commands():
    return automation
```{{copy}}


After that everytime we use piku, the new commands should be usable.

We can test the new commands by running:

```bash
piku automation:worker
```{{execute}}

and

```bash
pikey automation:change-timer 5000
```{{execute}}


