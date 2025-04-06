# Boni Auto Host Discovery Tool

Welcome to the **Boni Auto Host Discovery Tool**. This project allows you to automatically discover network hosts using Nmap. The tool provides a user-friendly interface, installs necessary dependencies, and organizes scan results in a systematic manner.

## Features

- **Automatic Nmap Installation**: Checks and installs Nmap if it's not already installed.
- **User Input for IP Block**: Prompts the user to enter the IP block to scan.
- **Network Scanning**: Uses Nmap to scan the subnet for live hosts.
- **Organized Results**: Creates a folder named after the IP block and saves scan results.
  - All live host IPs
  - IP-wise open port scan results in individual files
  - Summary of the scan including total hosts, total IPs scanned, and total live IPs found
- **User-Friendly Interface**: Displays a banner and clear prompts/messages.

## Installation

1. Clone this repository:
    ```bash
    git clone https://github.com/boniyeamincse/Autohostdiscovery.git
    cd Autohostdiscovery
    ```

2. Make the script executable:
    ```bash
    chmod +x boni-auto-host-discovery.sh
    ```

3. Install Nmap if it's not already installed:
    ```bash
    sudo apt update && sudo apt install -y nmap
    ```

## Usage

1. Run the script:
    ```bash
    ./boni-auto-host-discovery.sh
    ```

2. Enter the IP block when prompted (e.g., `192.168.1.0/24`).

### Example Output

```
==============================================
      🔍 Boni Auto Host Discovery Tool        
==============================================
__________              .__     _____          __           __________                             
\______   \ ____   ____ |__|   /  _  \  __ ___/  |_  ____   \______   \ ____   ____  ____   ____  
 |    |  _//  _ \ /    \|  |  /  /_\  \|  |  \   __\/  _ \   |       _// __ \_/ ___\/  _ \ /    \ 
 |    |   (  <_> )   |  \  | /    |    \  |  /|  | (  <_> )  |    |   \  ___/\  \__(  <_> )   |  \
 |______  /\____/|___|  /__| \____|__  /____/ |__|  \____/   |____|_  /\___  >\___  >____/|___|  /
        \/            \/             \/                             \/     \/     \/           \/ 

Author: Boni Yeamin

[+] Nmap is already installed.
Enter the IP block (e.g. 192.168.1.0/24): 192.168.1.0/24
[*] Scanning network: 192.168.1.0/24...
[*] Running Nmap ping scan to find live hosts...
[*] Scanning open ports on live hosts...
  └─ Scanning 192.168.1.1
  └─ Scanning 192.168.1.2
  └─ Scanning 192.168.1.3

✅ Scan complete!
📂 Results saved in folder: 192.168.1.0_24
   ├── all_live_hosts.txt
   ├── IP-wise port results (e.g., 192.168.1.1_ports.txt)
   └── ip_summary.txt
```

### Contents of the Output Files
#### `all_live_hosts.txt`
```
192.168.1.1
192.168.1.2
192.168.1.3
```

#### `192.168.1.1_ports.txt`
```
# Nmap 7.91 scan initiated Mon Apr  6 03:25:02 2025 as: nmap -sS -Pn -oN 192.168.1.0_24/192.168.1.1_ports.txt 192.168.1.1
Nmap scan report for 192.168.1.1
Host is up (0.00036s latency).
Not shown: 999 closed ports
PORT   STATE SERVICE
80/tcp open  http

# Nmap done at Mon Apr  6 03:25:05 2025 -- 1 IP address (1 host up) scanned in 3.06 seconds
```

#### `ip_summary.txt`
```
Network Block       : 192.168.1.0/24
Total Hosts in Block: 256
Total Live Hosts    : 3
Scan Date           : Mon Apr  6 03:25:05 UTC 2025
```

## Contributing

Contributions are welcome! Please feel free to submit a pull request or open an issue if you have any suggestions or find any bugs.

## License

This project is licensed under the MIT License.

## Contact

Author: Boni Yeamin  
Date: 2025-04-06  
Contact: boniyeamincse
