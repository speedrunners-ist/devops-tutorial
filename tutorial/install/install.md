# Installing Piku

The first thing to do, of course, is installing Piku in our machine.
Although downloading things with a `curl` command is not the most secure way to install software (!), for this tutorial's sake, that's what we're going to do.

```bash
curl https://piku.github.io/get | sh
```{{exec}}

Note that the above command only downloads the bootstrap script: now, you'll need to actually run it.

We can now proceed to the bootstrap script. The first command will automatically install the required dependencies, while the second one runs an Ansible playbook which creates a `piku` user in the machine (required for Piku to work), checks for SSH, and sets up Piku.

```bash
./piku-bootstrap first-run --no-interactive
```{{exec}}

```bash
./piku-bootstrap install
```{{exec}}

Click the green button below to check whether Piku was correctly installed!
