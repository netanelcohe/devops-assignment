import socket
import logging
from abc import ABC, abstractmethod

# Abstract class for arithmetic operations
class ArithmeticOperation(ABC):
    @abstractmethod
    def compute(self, a, b):
        pass

# Concrete implementations for each operation
class Addition(ArithmeticOperation):
    def compute(self, a, b):
        return a + b

class Subtraction(ArithmeticOperation):
    def compute(self, a, b):
        return a - b

class Multiplication(ArithmeticOperation):
    def compute(self, a, b):
        return a * b

class Division(ArithmeticOperation):
    def compute(self, a, b):
        if b == 0:
            return "Error: Division by zero"
        return a / b

# Server logic
def start_server():
    logging.basicConfig(level=logging.INFO, format="%(asctime)s - %(message)s")
    server_socket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    server_socket.bind(("0.0.0.0", 5000))
    server_socket.listen(5)  # Maximum 5 connections
    logging.info("Server started and listening on port 5000")

    operations = {
        "add": Addition(),
        "subtract": Subtraction(),
        "multiply": Multiplication(),
        "divide": Division(),
    }

    while True:
        client_socket, client_address = server_socket.accept()
        logging.info(f"Connection established with {client_address}")
        
        data = client_socket.recv(1024).decode()
        if not data:
            break
        
        try:
            # Parse data: "operation number1 number2"
            operation, num1, num2 = data.split()
            num1, num2 = float(num1), float(num2)
            
            if operation in operations:
                result = operations[operation].compute(num1, num2)
            else:
                result = "Error: Unsupported operation"
        except Exception as e:
            result = f"Error: {str(e)}"
        
        logging.info(f"Received: {data} | Result: {result}")
        client_socket.send(str(result).encode())
        client_socket.close()

if __name__ == "__main__":
    start_server()

