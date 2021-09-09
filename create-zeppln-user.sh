#!/usr/bin/env bash


Help()
{
  echo "Usage:"
   echo "Creates an AWS user and access/secret key pair with read-only access to AWS infrastructure."
   echo "Credential information will be output to screen. Make sure to copy and store the AWS secret"
   echo "key in a safe place. You will not be able to obtain this secret key once it has been created."
   echo
   echo "Syntax: ./create-zeppln-user.sh -c [-p|-h]"
   echo "options:"
   echo "h     Print this Help."
   echo "p     Use specific AWS credential profile"
   echo "c     Create user, access/secret key, and apply read-only policy"
   echo
}

CreateUser()
{
  PROFILE_ARGS=$1
  aws --output text ${PROFILE_ARGS} iam create-user --user-name ${ZEPPLNUSERNAME}
}

AttachPolicy()
{
  PROFILE_ARGS=$1
  aws --output text ${PROFILE_ARGS} iam attach-user-policy --user-name ${ZEPPLNUSERNAME} --policy-arn 'arn:aws:iam::aws:policy/ReadOnlyAccess'
}

CreateAccessKey()
{
  PROFILE_ARGS=$1
  aws --output text ${PROFILE_ARGS} iam create-access-key --user-name ${ZEPPLNUSERNAME}
}


while getopts "hp:c" option; do
   case $option in
      h)
         Help
         exit;;
      c)
        CREATE=1
        ;;
      p)
        USEPROFILE=1
        PROFILE_NAME=${OPTARG}
         ;;
       \?)
         echo "Error - Not a valid option."
         Help
         exit;;
   esac
done

if [[ "${CREATE}" -eq "1" ]]; then

  echo "Option c passed in, will attempt to create user, assign policy, and create keys."
  ZEPPLNUSERNAME='zeppln-com'

  if [[ $USEPROFILE == 1 ]]; then

    echo "Option p passed, will use AWS credential profile ${PROFILE_NAME}."
    CreateUser "--profile ${PROFILE_NAME}"
    AttachPolicy "--profile ${PROFILE_NAME}"
    CreateAccessKey "--profile ${PROFILE_NAME}"

  else

    CreateUser
    AttachPolicy
    CreateAccessKey

  fi

else

  echo "Option '-c' was not passed in and is required to attempt to perform AWS operations.";
  echo
  Help

fi

if [ $OPTIND -eq 1 ]; then
  echo "No options passed. Option '-c' required to attempt to perform AWS operations.";
  echo
  Help
fi

