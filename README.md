# hpcc_R_setup

These scripts were written to setup your R environment on the MSU HPCC system. R is a module that you need to load, and installing packages does not work as it would normally on your personal machine. You do not have admin rights, so all packages need to be locally installed. Rather than every user do this, I wrote these scripts to maintain a cummulative package repository for all GERMS members in our research directory.

Alternatively there is an option to use a different directory for your library if you wish to for whatever reason.


## Setup R
If you run the `R_setup.sh` script, it will set your R library directory and also set your HPCC to automatically load the R-Core module every time you log into the developmental environments. I don't see this causing any issues at the moment, but if it does, I will update to use a flag to do this in the future.
<br>
To run the program with default settings use:

```
sh /mnt/research/germs/schuyler/scripts/R_setup/R_setup.sh
```
If you want to set a new directory for your library, then use the `-l` flag and set the directory:

```
sh /mnt/research/germs/schuyler/scripts/R_setup/R_setup.sh -l ~/R/library
```

and if you want R to install a predefined set of useful packages use the -i flag:

```
sh /mnt/research/germs/schuyler/scripts/R_setup/R_setup.sh -l -i ~/R/library 
```

## Install New Packages

I have already installed a lot of packages in the defauly GERMS repository. If you need to install new packages I wrote a program to (hopefully) make installing new packages easy! And it can take any number of packages from the same source.

I added an alias in your bashrc through the R_setup script so that you can run the comman `rinstall` that will install packages.

```
rinstall [package_name] [package_name ...]
```

If you want to install a package from the BioConductor server then use the `-b` flag


```
rinstall -b [package_name] [package_name ...]
```

And for github packages use `-g`


```
rinstall -g [github_user/package_name] [github_user/package_name] ...
```
