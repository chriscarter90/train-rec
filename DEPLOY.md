# Deploying Progress 360

## From Scratch
### DevOps should have given you a jenkins server such that:
* you can access it with a known username and password
* you can access it with your ssh key as this user
* you have sudo access for this user
* Jenkins is installed and we have been given the credentials for it

For Progress360 the details are:
URL - https://nightly-eu.progress360.pearson-intl.com/
App - app01.nightly.aws-eu-wi.progress360.uk.hosts.pearson-intl.net
Jenkins - https://app01.nightly.aws-eu-wi.progress360.uk.hosts.pearson-intl.net:44443/login?from=%2F
User - admin / (password known to team)

### SSH to an environment
* You should have provided Dev Ops with your public ssh key and a unix encryped password that only you know.
* To get a unix encrypted password:
    yum$ echo whateveryourpasswordis | openssl passwd -1 -stdin
    $1$HICuEpyC$sHH3FItjh8BKtsauZapq81
* You need to set up your ~/.ssh/config to include something like the following:

        Host bs01.prod.aws-eu-wi.mgmt.uk.hosts.pearson-intl.net
          ProxyCommand none
          User yourusername
        Host *.uk.hosts.pearson-intl.net
          ProxyCommand ssh -A bs01.prod.aws-eu-wi.mgmt.uk.hosts.pearson-intl.net nc %h %p 2>/dev/null
          User yourusername
        Host p360n
          ProxyCommand ssh -A bs01.prod.aws-eu-wi.mgmt.uk.hosts.pearson-intl.net nc %h %p 2>/dev/null
          Hostname app01.nightly.aws-eu-wi.progress360.uk.hosts.pearson-intl.net
          User yourusername

Now you should be able to
    
    ssh yourusername@app01.nightly.aws-eu-wi.progress360.uk.hosts.pearson-intl.net

or

    ssh p360n

### Give jenkins access to the repository
* ssh to the jenkins server
* Sudo to the jenkins user
    sudo su - jenkins
* Generate an ssh key
    cd ~/.ssh
    ssh-keygen -t rsa
    cat ~/.ssh/id_rsa.pub
* Assign the public key to a gitlab user that has access to the repository (Progress 360 is using the same user the MyContent team is using for this purpose: mycontent-jenkins)
* Do a manual clone of the repository
    cd /tmp
    git clone git@gitlab.pearson-intl.net:progress360/progress360.git # Are you sure you want to continue connecting (yes/no)? yes
* If this is successful jenkins has now access to the repository and we can delete the directory we just cloned
    rm -rf /tmp/progress360
* Install nodejs and npm on the jenkins
    yum install nodejs
    yum install npm
    sudo npm install bower -g

### Setting up jenkins
It is the role of jenkins to check that the build is passing and if it is to build the rpm for each environment the app is to be deployed to. Generating the rpm takes a lot longer than running the test suite so it may be desirable to have seperate jobs for these in the future. For now we are building a jenkins job that does ALL THE THINGS.
* Your codebase should already have a jenkins_build.sh file in the top directory that scripts how to build the app on the jenkins server. There should also be a config/database_jenkins.yml file with the database settings on the server. Finally to build the rpm, there needs to be a file named pearson-app-progress360-base.spec in the top directory with the app's specifications.

* Login to the jenkins admin screen
* Click 'New job'
* Select 'Build a free-style software project'
* Parameterize with name "GIT_TAG"
* Set the git repository under Source Code Management
* Specify "$GIT_TAG" for 'Branches to build'
* Add an "Execute Shell" build step with
    bash -l -e jenkins_build.sh $GIT_TAG
* Add another "Execute Shell" build step with

        VERSION=$GIT_TAG
        rm -rf /var/tmp/pearson-app-progress360-*
        time /usr/local/pearson/bin/rpmbuildandpublishtoyumv2.sh \
                --specfile $WORKSPACE/pearson-app-progress360-base.spec \
                --topdir /tmp/topdir/$JOB_NAME \
                --sourcedir $WORKSPACE \
                --version $VERSION \
                --release $BUILD_NUMBER \
                --suffix nightly \
                --versionfile $WORKSPACE/public/appversion.txt \
                --repositorydir  /srv/yum/pearson-jenkins-centos6-incoming

* Try to perform a build for the desired tag

* When the build passed Jenkins should have published the nightly rpm for the version to yum. Now you can login to the nightly server and run

        sudo /usr/local/pearson/bin/chef-client

* If this all works, from now on we can just follow the procedure in the "Deploying" section below.

## Deploying
* Ensure the branch you want to deploy is tagged with only the version number (no letters, so it should look like 0.1.14). There is a script that can automatically tag HEAD with the next patch level (assuming current branch is master): bin/autotag
* Login to Jenkins, choose the "Progress360_master" job, click "Build Now" and build with the appropriate version tag.
* If successful this will automatically create an rpm for this version and make it available to the different environments to install
* SSH to the environment you want to deploy to (see instructions in "From Scratch" section for how to set up ssh config)
* Run

        sudo /usr/local/pearson/bin/chef-client

  This should bring up the new version of the app on https://nightly-eu.progress360.pearson-intl.com/ (for nightly)
  The git sha of the currently deployed version and its git tag are available on https://nightly-eu.progress360.pearson-intl.com/version.txt (for nightly)
  The rpm version is available on https://nightly-eu.progress360.pearson-intl.com/appversion.txt (for nightly)
* If the chef-client command runs for a long time (> 5 min) there is likely something wrong with the yum install command it performs. In order to find out what the specific error might be you can run yum install pearson-app-progress360-base-nightly-w.x.y-zz (you can find out from jenkins console which package to use here)
* If you'd like to have a look at the chef scripts, there is copy of them here: /var/chef/cache/cookbooks/pearson_app_progress360/recipes
* The application DocumentRoot is /usr/local/pearson/app/progress360-base/
* When you ssh into the box to run ruby commands by hand, first set the path to include the ruby 1.9.3 bin

        export PATH=/usr/local/pearson/ruby193/bin:$PATH

* The unix user that the app is run under is progr360

### Running an environment in vagrant
Arjun will ask his team if this can be provided.

### Taking site down for maintenance
No procedure available yet.

### Adding a task to be completed after deploy
Add it to the post_deploy rake task

### Adding a new config file
Contact Dev Ops to allow them to configure chef so that the file will persist between deploys. If values need to be different for different environments, please mention this.

### Adding a new dependency
Contact Dev Ops to allow them to configure chef to add the dependency and mention this needs to be applied to all environments.
