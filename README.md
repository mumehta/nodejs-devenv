sudo dpkg --remove --force-remove-reinstreq mongo-tools 3.6.3-0ubuntu1

 default:  trying to overwrite '/usr/bin/bsondump', which is also in package mongo-tools 3.6.3-0ubuntu1
    default: dpkg-deb: error: paste subprocess was killed by signal (Broken pipe)
    default: Selecting previously unselected package mongodb-org.
    default: Preparing to unpack .../mongodb-org_3.6.5_amd64.deb ...
    default: Unpacking mongodb-org (3.6.5) ...
    default: Errors were encountered while processing:
    default:  /var/cache/apt/archives/mongodb-org-tools_3.6.5_amd64.deb


    mongo-tools 3.6.3-0ubuntu1