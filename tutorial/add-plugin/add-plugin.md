# Create Plugins

Piku allows you to create plugins to extend its functionality.

First we will copy the piku tool from the piku directory.

```bash
cp /home/piku/piku.py /root/piku.py
```{{execute}}

We can define our plugin in the `/root/.piku/plugins/automation/__init__.py`.

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


After that everytime we use piku, the new command should be usable.

We can test the new command by running:

```bash
./piku automation:change-timer 5000
```{{execute}}


