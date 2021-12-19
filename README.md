# rider-cam

A test run at making a ruby based drive recorder for Raspbery Pi (Raspbian OS). 

This app will...
1) Use raspberry pi's native camera app `raspivid` to record video when offline
2) Use google's drive api to upload recorded videos when online

You will have to setup a GCP app to upload your videos onto google drive.

## How things should work...

When your Raspberry Pi has access to the internet, the program will detect any video files on local disk and upload them to google drive. When you've lost internet connection the camera will start recording on its own. The Camera is currently set to take 3 low quality frames per sec as to save space, but the values can be adjusted in `lib/rider_cam.rb`

## Setup

### Work Directory & Environment

Clone this repository into `/usr/local/` to have the installation work properly.
Once you’ve cloned rider-cam into `/usr/local` on your raspberry pi run,

```bash
bin/install
```

Install will run the usual apt-get update/upgrade and install ruby and it’s dependencies.
THIS PROCESS WILL TAKE A WHILE WITH OLD OR LOW POWERED RASPBERRY PIs.

Once install is completed run,

```bash
bin/setup
```

This will set up a symlink of rider-cam.service to the systemd directory so that systemctl will take care of running the program on boot.

You can try running the program by hand by running,

```bash
bin/run_rider_cam
```

Or disable symlink by running,

```bash
bin/uninstall
``` 

### Drive API

This program requires you to have set up an app on GCP with API credentials for OAuth 2.0 Client created.

Once you've created your credentials, create a copy of `config/drive.yml.sample` as `config/drive.yml` in the repository, and copy Client ID and Client Secret into the file.

Now that you have your credentials saved you can run,

```bash
bin/run_rider_cam
```

And you should get a QR code on screen. Access the site and go through the OAuth consent process to receive an access token. Press enter and follow the instructions that will appear on screen. The Authentication process should only be required on the programs first run. 

