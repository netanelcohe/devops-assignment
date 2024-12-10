import socket

def main():
    # Define the server properties
    server_ip = "127.0.0.1" 
    server_port = 5000

    # build a prompt to accept the numbers and operation
    print("Welcome to the Arithmetic Client!")
    print("Available operations:")
    print("1. Add")
    print("2. Subtract")
    print("3. Multiply")
    print("4. Divide")

    operations_map = {
        "1": "add",
        "2": "subtract",
        "3": "multiply",
        "4": "divide"
    }

    while True:
        operation_choice = input("Enter the number corresponding to the operation (or 'exit' to quit): ").strip()
        if operation_choice.lower() == "exit":
            print("Exiting. Goodbye!")
            break

        if operation_choice not in operations_map:
            print("Invalid choice. Please select a number between 1 and 4.")
            continue

        try:
            num1 = float(input("Enter the first number: "))
            num2 = float(input("Enter the second number: "))
        except ValueError:
            print("Invalid input. Please enter numeric values.")
            continue

        operation = operations_map[operation_choice]

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
