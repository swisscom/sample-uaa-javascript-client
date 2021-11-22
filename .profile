export CREDENTIALS_FIRST_SERVICE=$(jq '.[][0].credentials' <<< $VCAP_SERVICES)
erb -v /home/vcap/app/public/index.html.erb > /home/vcap/app/public/index.html
