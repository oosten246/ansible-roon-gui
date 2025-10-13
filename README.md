Ansible playbook roon-gui
=========================

Install Roon GUI on Debian or Redhat based systems.

Requirements
------------
**User with sudo privileges.**

If Ansible is not yet installed you can use below one-line command that does it all: Install the software to run the Ansible playbook plus dependencies, and then run the playbook to install the latest version of Wine and the Roon GUI.

    wget -O- https://raw.githubusercontent.com/oosten246/ansible-roon-gui/main/install.sh | bash -s
or

    curl -sfL https://raw.githubusercontent.com/oosten246/ansible-roon-gui/main/install.sh | bash -s

To delete and reinstall the Roon GUI you can use this one-line command:

    wget -O- https://raw.githubusercontent.com/oosten246/ansible-roon-gui/main/install.sh | ROON_ON_WINE_REINSTALL=true bash -s
or

    curl -sfL https://raw.githubusercontent.com/oosten246/ansible-roon-gui/main/install.sh | ROON_ON_WINE_REINSTALL=true bash -s

The information about Role Variables, Dependencies and Example Playbook is only applicable if you do not use the one-line commands.

Tested
------

|Operating System|  |
|----------------|--|
|Ubuntu 20.04 LTS|ok|
|Ubuntu 22.04 LTS|ok|
|Ubuntu 24.04 LTS|ok|
|Ubuntu 24.10    |ok|
|Ubuntu 25.04    |ok|
|Fedora 40       |ok|
|Fedora 41       |ok|
|Fedora 42       |ok|
|Debian 12       |ok|
|Linux Mint 22   |ok|

Tested How?
-----------
* Fresh OS install, fully patched in a VM on a KVM/QEMU host.
* In a terminal window use the one-line install command.
* Start the Roon GUI.
* Connect to Roon server.
* Play music to a Chromecast end point.
* Play music to a Roon-bridge end point.

Role Variables
--------------
To force a re-install set roon_on_wine_reinstall to true.

    roon_on_wine_reinstall: false

Dependencies
------------
To install dependencies run:

    ansible-galaxy -r requirements.yml

Example Playbook
----------------

    ---
    - hosts: localhost
      become: true
      roles:
        - wine

    - hosts: localhost
      roles:
        - { role: roon-on-wine, roon_on_wine_reinstall: true }

License
-------

This software is available under the MIT license. See the LICENSE file for more info.

Author Information
------------------

oosten246
