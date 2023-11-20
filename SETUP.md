# Setup

This is a step by step guide on how to setup a VM to run this ruby on rails programme

## Requirements


- vm
    - 8 GB RAM
    - 4 Cores
    - 80 GB Hard Disk
    - Network Adapter set to NAT: Used to share the host's IP address
    - Ubuntu 22.04 LTS
    - VMware Tools
- OpenVPN GUI with working VPN on the host machine

## Programs to install

> Install these programs with the Ubuntu Software installer application.

- RubyMine

## Install Git


```shell
sudo apt-get update
sudo apt-get install git-all
```

## Install Rbenv

```shell
sudo apt update
```

```shell
sudo apt install git curl libssl-dev libreadline-dev zlib1g-dev autoconf bison build-essential libyaml-dev libreadline-dev libncurses5-dev libffi-dev libgdbm-dev
```

```shell
curl -fsSL https://github.com/rbenv/rbenv-installer/raw/HEAD/bin/rbenv-installer | bash
```

```shell
echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bashrc
```

```shell
echo 'eval "$(rbenv init -)"' >> ~/.bashrc
```

```shell
source ~/.bashrc
```
Verify that rbenv is set up properly by running the type command, which displays more information about the rbenv command:

```shell
type rbenv
```
Your terminal window will display the following:

```shell
Output
rbenv is a function
rbenv ()
{
    local command;
    command="${1:-}";
    if [ "$#" -gt 0 ]; then
        shift;
    fi;
    case "$command" in
        rehash | shell)
            eval "$(rbenv "sh-$command" "$@")"
        ;;
        *)
            command rbenv "$command" "$@"
        ;;
    esac
}
```
At this point, you have both rbenv and ruby-build installed.
## Install Ruby with rbenv and ruby-build

With the ruby-build plugin now installed, you can install whatever versions of Ruby that you may need with a single command. First, list all the available versions of Ruby:
```shell
rbenv install -l
```
The output of that command lists all the versions that you can choose to install:

```shell
Output
2.7.7
3.0.5
3.1.3
3.2.0
jruby-9.4.0.0
mruby-3.1.0
picoruby-3.0.0
truffleruby-22.3.1
truffleruby+graalvm-22.3.1

Only latest stable releases for each Ruby implementation are shown.
Use 'rbenv install --list-all / -L' to show all local versions.
```
Now, install Ruby 3.2.0:

```shell
rbenv install 3.2.2
```
After installing it check with ruby -v if everything was installed correctly.

```shell
ruby -v
```
Set your default ruby version:
```shell
rbenv global 3.2.2
```

## Create SSH key

Create a new SSH key with this command and just press enter until the key is created. You don't need any special settings for your key.
```shell
ssh-keygen -t ed25519 -C "your_email@example.com"
```
Add your new key to the ssh-agent.

```shell
ssh-add ~/.ssh/id_ed25519
```

Now you can copy the text from your public key into Gitlab and everywhere else you need your ssh key.

## Install other essential tools
### Install Postgresql

Install packages needed for postgresql
```shell
sudo apt-get install libpq-dev build-essential
sudo apt install postgresql
```

Open the Postgresql console
```shell
sudo -u postgres psql
```

Create a Superuser
> To have the least problems create a Postgresql user with the same name as your normal user on your vm.


```postgresql
CREATE USER <username>;
```

```postgresql
ALTER USER <username> WITH SUPERUSER;
```

### Install npm and node


```shell
sudo apt install npm
sudo npm cache clean -f
sudo npm install -g n
sudo n stable
```

after you installed node restart your terminal and then check with ``node --version`` if it is 14.0.0 or higher.
### Install Yarn

```shell
sudo npm install --global yarn
```

### Install Docker

Run the following command to uninstall all conflicting packages:
```shell
for pkg in docker.io docker-doc docker-compose podman-docker containerd runc; do sudo apt-get remove $pkg; done
```

Set up Docker's Apt repository.

```shell
# Add Docker's official GPG key:
sudo apt-get update
sudo apt-get install ca-certificates curl gnupg
sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
sudo chmod a+r /etc/apt/keyrings/docker.gpg

# Add the repository to Apt sources:
echo \
  "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  "$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update
```

Install the Docker packages.
```shell
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
```

Add user to the docker group.
```shell
sudo groupadd docker
sudo usermod -aG docker $USER
newgrp docker
```
> Restart the vm after adding the User to update the user permissions.

Verify if the installation is working.
```shell
docker run hello-world
```
