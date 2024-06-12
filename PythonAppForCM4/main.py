import time

from hardware_manager import HardwareManager

hardware_manager = HardwareManager()
while True:
    hardware_manager.readSensorsAndPublish()
    time.sleep(30)