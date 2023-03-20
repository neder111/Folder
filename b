
import bluetooth
import pyaudio

# Search for available Bluetooth devices using discover_devices()
devices = bluetooth.discover_devices()

# Print the available Bluetooth devices
for dev in devices:
    print(dev)

# Target device MAC address & port number to connect
target_name = 'Bluetooth Speaker'
target_address = None
port = 1

# Find the address of the target device & connect to the speaker socket
for addr in devices:
    if target_name == bluetooth.lookup_name(addr):
        target_address = addr
        break

# If target Bluetooth device address not available, exit the program
if target_address is None:
    print('Could not find target Bluetooth device')
    exit(0)

# Connect to the target Bluetooth device socket
sock = bluetooth.BluetoothSocket(bluetooth.RFCOMM)
sock.connect((target_address, port))

# Initialize PyAudio object, to send audio to the connected speaker
p = pyaudio.PyAudio()
stream = p.open(format=pyaudio.paInt16, channels=1, rate=44100, output=True)

# Send audio data to speaker socket
while True:
    # Read audio data from sound sensor connected to ESP32 board
    audio_data = # code to read audio data from sound sensor
    # Send audio data to the Bluetooth speaker socket
    sock.send(audio_data)
    stream.write(audio_data)

# Close the PyAudio stream & Bluetooth socket
sock.close()
stream.stop_stream()
stream.close()
p.terminate()
