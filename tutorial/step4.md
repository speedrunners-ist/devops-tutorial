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

So in order to add some website plugins to piku, we need to create a python file where we will define the commands.
```bash
mkdir -p ~/.piku/plugins/website
```{{execute}}

Then we can define our plugin in the `~/.piku/plugins/website/__init.py__`.

```python
import click

@click.group()
def website():
    """command plugin"""
    pass

@website.command("website:create")
@click.argument('text')
@click.argument('user')
def chat_create():
    """website create a database"""
    pass

def cli_commands():
    return website
```{{copy}}


After that everytime we use piku, the new commands should be usable.

