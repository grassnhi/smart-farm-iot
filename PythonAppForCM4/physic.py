import sys
import time
import serial.tools.list_ports

def crc16_modbus(data):
    """
    Calculate the CRC16 for a data array for Modbus RTU.
    :param data: The data array (excluding the CRC).
    :return: CRC16 as a tuple of two bytes.
    """
    crc = 0xFFFF
    for pos in data:
        crc ^= pos
        for i in range(8):
            if (crc & 1) != 0:
                crc >>= 1
                crc ^= 0xA001
            else:
                crc >>= 1
    return [crc & 0xFF, (crc >> 8) & 0xFF]

class Physic:
    def __init__(self, debug_flag = False):
        """Initializes the Physics class with a debug flag and the actuators and sensors formats.
        It attempts to open a serial connection to a specified port."""
        self.debug_flag = debug_flag # Debug flag to control debug output

        # Each key-value pair represents the command to turn a relay on or off
        # The array format is:
        # [ID, function code, starting address high byte, starting address low byte, data high byte, data low byte, CRC low byte, CRC high byte]
        self.RS485_actuartors_format = {
            'relay1_ON': [1, 6, 0, 0, 0, 255, 201, 138],
             'relay1_OFF': [1, 6, 0, 0, 0, 0, 137, 202],
             'relay2_ON': [2, 6, 0, 0, 0, 255, 201, 185],
             'relay2_OFF': [2, 6, 0, 0, 0, 0, 137, 249],
             'relay3_ON': [3, 6, 0, 0, 0, 255, 200, 104],
             'relay3_OFF': [3, 6, 0, 0, 0, 0, 136, 40],
             'relay4_ON': [4, 6, 0, 0, 0, 255, 201, 223],
             'relay4_OFF': [4, 6, 0, 0, 0, 0, 137, 159],
             'relay5_ON': [5, 6, 0, 0, 0, 255, 200, 14],
             'relay5_OFF': [5, 6, 0, 0, 0, 0, 136, 78],
             'relay6_ON': [6, 6, 0, 0, 0, 255, 200, 61],
             'relay6_OFF': [6, 6, 0, 0, 0, 0, 136, 125],
             'relay7_ON': [7, 6, 0, 0, 0, 255, 201, 236],
             'relay7_OFF': [7, 6, 0, 0, 0, 0, 137, 172],
             'relay8_ON': [8, 6, 0, 0, 0, 255, 201, 19],
             'relay8_OFF': [8, 6, 0, 0, 0, 0, 137, 83]
        }

        self.RS485_sensors_format = {
                "soil_temperature" : [1, 3, 0, 6, 0, 1, 100, 11],
                "soil_moisture" : [1, 3, 0, 7, 0, 1, 53, 203]
            }

        self.portname = self.getPort()  # Retrieve the serial port to use

        # Attempt to open the serial port with specified baudrate
        try:
            self.ser = serial.Serial(port=self.portname, baudrate=9600)
            print("Open successfully port: ", self.portname)
        except:
            print("Exception: Can not open the port")
            sys.exit()  # Exit the program if the serial port cannot be opened

    def getPort(self):
        """Searches for and returns the first available USB serial port."""
        ports = serial.tools.list_ports.comports()
        commPort = "None"
        for i in range(len(ports)):
            port = ports[i]
            strPort = str(port)
            if "USB" in strPort:  # Checks if the port description contains 'USB'
                splitPort = strPort.split(" ")
                commPort = splitPort[0]  # Assumes the first part is the port name
        return commPort

    def serial_read_data(self):
        """Reads incoming data from the serial port and decodes it."""
        bytesToRead = self.ser.inWaiting()  # Checks how many bytes are waiting to be read
        if bytesToRead > 0:
            out = self.ser.read(bytesToRead)
            data_array = [b for b in out]  # Converts the bytes to a list for easier processing
            if self.debug_flag == True:
                print("Return data:", data_array)
            if len(data_array) >= 7:
                array_size = len(data_array)
                value = data_array[array_size - 4] * 256 + data_array[array_size - 3]
                return data_array, value
            else:
                return data_array, None
        return None, None

    def setActuators(self, ID, state):
        """Sends a command to set the state of an actuator (relay) based on its ID."""
        command_key = f'relay{ID}_{"ON" if state else "OFF"}'
        command_data = self.RS485_actuartors_format.get(command_key)
        if self.debug_flag == True:
            print("Sending data: ",command_data)
        self.ser.write(command_data)  # Sends the command data to the actuator
        time.sleep(1)

        return_data, result = self.serial_read_data()  # Reads the response from the actuator
        if self.debug_flag == True:
            flag_check_data = True
            if len(return_data) <= 0:
                flag_check_data = False
            for i in range(6):
                if(command_data[i] != return_data[i]):
                    flag_check_data = False
            if flag_check_data == False:
                print("Failed to set Actuator!")
            else: print("Success to set actuator!")

    def readSensors(self, sensorName):
        """Sends a command to read data from a specified sensor."""
        command_data = self.RS485_sensors_format.get(sensorName)
        if self.debug_flag == True:
            print("Sending data: ",command_data)
        self.ser.write(command_data)  # Sends the command data to the sensor
        time.sleep(1)  # Wait a bit for the sensor to respond
        return_data, result = self.serial_read_data()  # Reads the response from the sensor
        if self.debug_flag == True:
            print("Received data ", return_data)
        result = result/100.00
        return result  # Returns the decoded sensor value


if __name__ == '__main__':
    physic = Physic(True)  # Initialize the class with debug mode enabled
    # Test sequence for actuators and sensors
    while True:
        # Testing actuator control
        print("\nTesting Actuators with ID 2: ")
        print("Turn on relay_2: ")
        physic.setActuators(2, True)  # Turn on relay 2
        time.sleep(5)
        print("Turn off relay_2: ")
        physic.setActuators(2, False)  # Turn off relay 2
        time.sleep(5)

        # Testing sensor reading
        print("\nTesting reading sensor: ")
        print("Soil temperature: ", physic.readSensors('soil_temperature'))  # Read and print soil temperature
        time.sleep(5)
        print("Soil moisture: ", physic.readSensors('soil_moisture'))  # Read and print soil moisture
        time.sleep(5)
