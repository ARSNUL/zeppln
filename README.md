# zeppln

This repository is intended to host scripts and various utilities to help with accessing and using zeppln.com web site.

The `create-zeppln-user` script will attempt to create an AWS user in your AWS account on your behalf (using your credentials). It will then apply the AWS ReadOnlyAccess policy to this user account. Finally it will create an access and secret key combination for that you can then use at zeppln.com.

Using this script will require that aws-cli (command line) utilities to be installed. The user performing these operations must have appropriate permissions to create IAM user accounts as well as applying the necessary policy and, finally, creating AWS API keys.

The user account that will be created will be named `zeppln-com`.

After running this script make sure to copy and store in a safe place the credentials that will be output to the terminal screen since, once the key pair are created, there is no option of retrieving the secret from AWS although, of course, you can simply delete the user through the AWS console and re-run the script.

Get usage:

    $ ./create-zeppln-user -h
    
Perform operation:

    $ ./create-zeppln-user -c -p [profile name]
    
or (using your default AWS credential profile)

    $ ./create-zeppln-user -c 
