# puppet playground

Puppetmaster + clients in a box. Try a puppetmaster with a dynamic workflow using r10k.

### Requirements

* Vagrant 1.2+
* Vagrant plugins (vagrant plugin install <name>)
  * vagrant-puppet-install
  * vagrant-r10k
  * puppet
* VirtualBox
* Puppet 3.8

### Get started!

Simply run vagrant up to start building the environment. Vagrant will start 5 boxes:

* vdc-puppetmaster1 - The Puppetmaster, configured with Passenger
* vdc1-web-01 - Web server, located in Virtual DataCenter 1
* vdc2-web-01 - Web server, located in Virtual DataCenter 2
* vdc1-db-01 - DB server, located in Virtual DataCenter 2
* vdc2-db-01 - DB server, located in Virtual DataCenter 2

### Workflow

This setup uses R10k with a "control" repository, which contains the actual Puppetfile. The Puppetfile is used by R10k to deploy the required modules. See (and clone/fork) https://github.com/furhouse/puppet-playground/blob/development/Puppetfile

If you want to deploy a new Puppet module, simply add it to the Puppetfile of said repository and run `r10k deploy environment -pv` on the puppetmaster. This will update all modules according to the Puppetfile. 

Besides the control repository (for the modules), a second repository is used for the Hiera data. This repo is available at https://github.com/furhouse/500k-hiera

Both the control and hiera repo's are managed by r10k. Making changes to either requires a `r10k deploy environment -pv` on the puppetmaster. 

You might have noticed the brances of both repositories, they mimic eachother. At the moment, 2 branches are configured:
* production
* development

Environments are isolated, so adding a module to the Puppetfile of the development branch doesn't impact production. Environments enable testing of different versions, modules and nodes. For instance, if you wish to update a module to a newer version, you can test it on the development branch, and merge the change into production if you're happy with the results.

Adding a new environment is as simple as creating a new branch on both repositories (for the hieradata and the modules):
* `git checkout -b puppetinberlin`
* `git push -u origin puppetinberlin`
* `r10k deploy environment puppetinberlin -pv`
