
wget https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-cli-470.0.0-linux-x86_64.tar.gz

tar -xvf google-cloud-sdk*

./google-cloud-sdk/install.sh

echo " source ~/.bashrc # Restart the terminal or source the .bashrc or .zshrc file based on the shell profile preference you chose during the installation."

echo "gcloud --version  "
echo "gcloud init --console-only "
echo "gcloud info "
echo "List the credential account.
gcloud auth list"

echo "gcloud config set account account@devopscube.com"

echo "gcloud config list
gcloud config configurations list
gcloud config configurations activate default
gcloud cheat-sheet
gcloud components list
gcloud components update
gcloud compute images list
gcloud compute instances create devopscube-demo-instance \
 --image centos-7-v20170523 \
 --image-project centos-cloud --set-machine-type f1-micro --zone us-central1-a
"
