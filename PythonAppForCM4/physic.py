import sys
import time
import serial.tools.list_ports

class Physics:
    def __init__(self, debug_flag = 0):
        self.debug_flag = debug_flag
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


        self.portname = self.getPort()
        try:
            self.ser = serial.Serial(port=self.portname, baudrate=9600)
            print("Open successfully port: ", self.portname)
        except:
            print("Exception: Can not open the port")
            sys.exit()

    def getPort(self):
        ports = serial.tools.list_ports.comports()
        N = len(ports)
        commPort = "None"
        for i in range(0, N):
            port = ports[i]
            strPort = str(port)
            if "USB" in strPort:
                splitPort = strPort.split(" ")
                commPort = (splitPort[0])
        return commPort

    def serial_read_data(self):
        bytesToRead = self.ser.inWaiting()
        if bytesToRead > 0:
            out = self.ser.read(bytesToRead)
            data_array = [b for b in out]
            if(self.debug_flag == True): print("Return data:", data_array)
            if len(data_array) >= 7:
                array_size = len(data_array)
                value = data_array[array_size - 4] * 256 + data_array[array_size - 3]
                return data_array, value
            else:
                return data_array, None
        return None, None

    def setActuators(self, ID, state):
        # Determine the command key based on ID and state
        command_key = f'relay{ID}_{"ON" if state else "OFF"}'
        # Retrieve the command data
        command_data = self.RS485_actuartors_format.get(command_key)
        self.ser.write(command_data)
        return_data, result = self.serial_read_data
        if self.debug_flag == True and (return_data != command_data or len(return_data) <= 0):
            print("Failed to set Actuator!")

    def readSensors(self, sensorName):
        command_data = self.RS485_sensors_format.get(sensorName)
        self.ser.write(command_data)
        time.sleep(1)
        return_data, result = self.serial_read_data
        return result

if __name__ == '__main__':
    physic = Physics(True)
    while True:
        print("Testing Actuators with ID 2: ")
        print("Turn on relay_2: ")
        physic.setActuators(2,True)
        time.sleep(2)
        print("Turn on relay_2: ")
        physic.setActuators(2, False)
        time.sleep(2)

        print()
        print("Testing reading sensor: ")
        print("Soil temperature: ",physic.readSensors('soil_temperature'))
        time.sleep(1)
        print("Soil moisture: ", physic.readSensors('soil_moisture'))
        time.sleep(5)
