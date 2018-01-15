proxy=http://st17807:Guarana12318@172.23.1.8:8080
switch_trigger_location=Automatic
switch_trigger_network=jo_syrup

function set_proxy() {
  export http_proxy=$proxy
  export ftp_proxy=$proxy
  export all_proxy=$proxy
  export https_proxy=$proxy

  git config --global http.proxy $proxy
  git config --global https.proxy $proxy
  git config --global url."https://".insteadOf git://
}

function unset_proxy() {
  unset http_proxy
  unset ftp_proxy
  unset all_proxy
  unset https_proxy

  git config --global --unset http.proxy
  git config --global --unset https.proxy
  git config --global --unset url."https://".insteadOf
}

if [ "`networksetup -getcurrentlocation`" = "$switch_trigger_location" -a "`networksetup -getairportnetwork en0 | awk '{print $4}'`" = "$switch_trigger_network" ]; then
  echo "Switch to proxy for school network"
  set_proxy
else
  echo "Unset proxy settings"
  unset_proxy
fi
