# Wifi Drop Alerts (for Windows)
Receive sound notifications whenever your wifi adapter decides to drop response time. This tool is used to test the stability of your network adapter. Latency is tested against your default gateway. 

The script is used to check defective wifi adapters and to fine tune adapter configurations for stablility. The script does not detect network speed.

## Installation
1. Download and unzip anywhere you want

## Usage
1. Open the _drop-alerts.bat_ file by doubleclicking
2. Make sure there are no errors:
![startup example](https://github.com/skonagaya/Wifi-Drop-Alerts/blob/master/correct%20startup.png?raw=true)
3. Leave the command prompt open. Whenever latency drops, you will now receive sound notifications
![example](https://github.com/skonagaya/Wifi-Drop-Alerts/blob/master/reading%20example.png?raw=true)
_The example above is set to a very low threshold for the sake of showing a sample output. The default is 10 ms for a warning sound, and 100 ms for a severe sound._

## Configuration
### Changing latency threshold (in milliseconds)
The value at which the script will trigger a warning and severe level sound can be changed by modifying the following lines in the batch script:

`set WARN_THRESHOLD=10`

`set SEVERE_THRESHOLD=100`

### Customizing sounds files
The script uses wmv to play sound files such as wav and mp3. Sounds can be customized by replacing the warning and severe level sound alerts. 
To use your own sound files, place your new sound files in the same directory as the batch script. Then update the sounds file names in the batch script:

`set WARNING_SOUND_FILE=warn.wav`

`set SEVERE_SOUND_FILE=severe.mp3`

## Troubleshooting
Make sure that the user you're logged in has enough permission on the file and path where the script is run. The script requires a sound file for each warning and severe levels. Make sure your wifi adapter is turned on and is able to connect to your router/gateway.

## Tested OS
- Windows 7/8.1/10
