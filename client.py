import socket

def main():
    server_ip = "127.0.0.1"  # Change to the server's IP if running remotely
    server_port = 5000

    print("Welcome to the Arithmetic Client!")
    print("Available operations: add, subtract, multiply, divide")
    
    while True:
        operation = input("Enter operation (or 'exit' to quit): ").strip()
        if operation.lower() == "exit":
            print("Exiting. Goodbye!")
            break
        
        try:
            num1 = float(input("Enter the first number: "))
            num2 = float(input("Enter the second number: "))
        except ValueError:
            print("Invalid input. Please enter numeric values.")
            continue
        
        # Send request to server
        with socket.socket(socket.AF_INET, socket.SOCK_STREAM) as client_socket:
            try:
                client_socket.connect((server_ip, server_port))
                request = f"{operation} {num1} {num2}"
                client_socket.send(request.encode())
                result = client_socket.recv(1024).decode()
                print(f"Result: {result}")
            except ConnectionRefusedError:
                print("Error: Could not connect to the server. Is it running?")
                break

if __name__ == "__main__":
    main()

