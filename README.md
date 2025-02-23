# Godot Cloud Build
This repository gives a template for using the Godot with GCP cloud build.

# What is Godot Cloud Build?
This repo targets Godot developers that are interested in CD/CI on the GCP platform. 
The main purpose is to create a pipeline to continuously build your game and export it to a cloud bucket in GCP.

# How does it work?
We start with a linux docker image that has dotnet installed. We add script files to:
 * Setup the linux environment
 * Download the dependencies from a GCP Bucket
 * Add config files
 * Run tests

We also have a cloud-build script that triggers the scripts above, export the godot game, and uploads the artifacts to a GCP Bucket.

# Installation
I only tested this on Mac Apple silicone. You might have to modify the script to work for you.

In order to use this pipeline with your game, you will need:
* bash terminal
* Cloud based source-control to host your game files. I am using Github.
* A GCP project.
* A game developed with Godot mono.
* Gcloud cli installed locally

To start off, you'll need:
* GCP Cloud Storage, Cloud Build, and Billing enabled.
* A cloud builder service account in GCP IAM.

Let's prepare the GCP project:
* Create a bucket or two to store the artifacts. (I have one for the engine files and one for the build artifacts)
* Upload the linux 86_64 amd64 godot engine (mono) to a location your cloud storage. You can downlaod it from the Official Godot website.
* When downloading the matching export templates, decompress the folder and pick the templates that you need "or all" and then compress them again to a zip file.
* Upload the newly created zip file to the same bucket as before to use during the build
* In the cloud build section, create a new connection to your repo and make sure it is in a region that allows building games. Some regions on GCP do not have the quota to allow this kind builds for some reason.
* Add the game repo repository using the connection you created
* Add a trigger that fires on a commit "Or any other event that you want" and that looks at ".cloud-build/cloudbuild.yaml" file

At this point GCP should be relatively ready.

In your game repo, add a folder in the root of your project and name it ".cloud-build" and add the following files from the Godot Cloud Build Project:
* cloudbuild.yml
* Dockerfile
* scripts/{All the script files}

Modify a few things in the scripts:
* Dockerfile modify the ENV variables to match your project
* cloudbuild.yaml modify the substitutions to match you project

Now browse to the .cloud-build folder and build the docker image locally on your workstation by running following docker commands:
* Build the image ```docker buildx build --platform linux/amd64 -t godot-headless .```
* If it succeeds, tag it with the appropriate tag ```docker tag godot-headless gcr.io/your-project-name/godot-headless:4.3```
* Run Gcloud init. Make sure to point to your game project.
* Run ```gcloud auth configure-docker``` and follow the prompt
* Push the docker image to your GCP artifact registry ```docker push gcr.io/your-project-name/godot-headless:4.3```

Now you are ready to push the commit to your game repo and if everything is done properly it should kick off a build

