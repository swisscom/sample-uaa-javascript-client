export CREDENTIALS_FIRST_SERVICE=$(jq '.[][0].credentials' <<< $VCAP_SERVICES)

if [ "$ALLOW_PUBLIC" = true ] ; then
    export CREDENTIALS_FIRST_SERVICE=$(jq 'del(.clientSecret)' <<< $CREDENTIALS_FIRST_SERVICE)
fi

erb -v /home/vcap/app/public/index.html.erb > /home/vcap/app/public/index.html

