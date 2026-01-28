*** Settings ***
Library    Process
Library    OperatingSystem
Library    SerialLibrary
Library    SeleniumLibrary
Library    SSHLibrary
Library     String
Library     BuiltIn
Library     telnet_case.py
*** Variables ***
${COM_PORT}    COM3    
${baudrate_value}    115200
${IFACE}       wlp3s0f0
${Client_PASSWORD}    password
${conf_PATH}   /etc/wpa_supplicant/wpa_supplicant.conf
${conf_wpa3_PATH}   /etc/wpa_supplicant/wpa_supplicant_wpa3.conf
${Config_name}    test.conf
${TIMEOUT}     10
${Count_Number}    0
${total_unable_to_get_value_from_USP}    0
${total_get_value_from_USP}    0
${wait_counter}        0
${dynamic_value}        0
${TMP_CONF}    test_tmp.conf
${ORIG_CONF}    /etc/wpa_supplicant/wpa_supplicant.conf
${TMP1_CONF}    test_tmp1.conf
${ORIG_wpa3_CONF}    /etc/wpa_supplicant/wpa_supplicant_wpa3.conf
${TMP1_wpa3_CONF}    test_wpa3_tmp1.conf
${GUI_IP}    192.168.1.1
##---telnet buffalo console-----
${Switch_HOST}    127.0.0.1
${Switch_PORT}    9999
##---SSH-----
${HOST}     192.168.1.1
${USER}     root
${SSH_PASSWORD}    
${CMD}      ifconfig
##---DUT SSID---
${Default_PSK}    
#${Default_PSK}    4cba7d0291ed
${Changed_PSK}    12345678
${Changed_SSID}    AUTOmeshTEST
${Changed_SSID_PSK}    123456789012345678901234567890121234567890123456789012345678901
${Changed_2G_SSID}    AUTOWiFiBasic_2G_123456789012345
${Changed_5G_SSID}    AUTOWiFiBasic_5G_123456789012345
${Changed_6G_SSID}    AUTOWiFiBasic_6G_123456789012345
##---Guest & Employee SSID---
${Changed_Guest_SSID}    Guest_123456789012345
${Changed_Employee_SSID}    Employee_123456789012345
${Changed_Employee_PSK}    123456789012345678901234567890121234567890123456789012345678901
${Changed_common_SSID}    AUTOmeshTEST
${Changed_common_PSK}    12345678
##---Portal URLs---
${conf_open_PATH}    /etc/wpa_supplicant/wpa_supplicant_open.conf
${conf_employee_PATH}    /etc/wpa_supplicant/wpa_supplicant_employee.conf
${ORIG_open_CONF}    /etc/wpa_supplicant/wpa_supplicant_open.conf
${ORIG_employee_CONF}    /etc/wpa_supplicant/wpa_supplicant_employee.conf
${TMP1_open_CONF}    test_open_tmp1.conf
${TMP1_employee_CONF}    test_employee_tmp1.conf
${EMAIL}    agchone29x@mail.com
${URL_protal}    http://1.1.1.1
${URL_protal2}    http://1.1.1.2
${URL_protal3}    http://1.1.1.3
*** Test Cases ***
Enable Client wired Network 
    Enable Client wired Network

Check Wizard
    [Tags]    Wizard
    Check Wizard

Default Controller    
    Login GUI    ${HOST}
    Defalut DUT/Agent and Wait setup
    Close All Browsers  

Setup Wizard
    [Tags]    Wizard
    Login Wizard GUI    ${HOST}
    Setup Wizard
    Close All Browsers   

Check Controller FW 
    Check DUT FW   ${HOST}

Check Guest status
    [Tags]    Guest    Mesh
    Check the Guest setting and enable it
    Check Guest Captive Portal status and Disable it

No.1 Check Mesh Agent is online
    [Tags]    Agent
    Enable the switch port connected to the agent
    sleep    300
    Get agent ip

Check Agent FW 
    Check DUT FW   ${Agent_IP}
    
Enable SSh
    Enable SSH
    Enable Agent SSH
   
Get Agent all SSID and BSSID
    [Tags]	Agent
    SSH To Enable Mesh Agent And Get all Common/disable common SSID and BSSID
    
Get Router all SSID,password and BSSID
    SSH To Enable Mesh Router And Get all Common/disable common SSID and BSSID
    SSH To Controller And Get default wifi password

Get Router Guest SSID and BSSID
    [Tags]    Guest    Controller    Setup
    SSH To Enable Mesh Router And Get Guest SSID and BSSID

Get Agent Guest SSID and BSSID
    [Tags]    Guest    Agent    Setup
    SSH To Enable Mesh Agent And Get Guest SSID and BSSID

Disable Client wired Network and Reset WiFi Interface
    Disable Client wired Network
    Reset WiFi Interface

No.2 Connect to Common SSID 2G controller
    [Tags]    2G
    Modify WPA Supplicant wpa3 Config    ${2G_SSID}    ${2G_SSID_BSSID}    ${Default_PSK}
    Connect to ssid and ping controller and agent    ${2G_SSID_BSSID}    
    [Teardown]    Run Keyword If    '${TEST STATUS}' == 'FAIL'    Check SSID can be scan    ${2G_SSID_BSSID}

No.3 Connect to Common SSID 5G controller
    [Tags]    5G
    Modify WPA Supplicant wpa3 Config    ${5G_SSID}    ${5G_SSID_BSSID}    ${Default_PSK}
    Connect to ssid and ping controller and agent    ${5G_SSID_BSSID} 
    [Teardown]    Run Keyword If    '${TEST STATUS}' == 'FAIL'    Check SSID can be scan    ${5G_SSID_BSSID}

No.4 Connect to Common SSID 6G controller
    [Tags]    6G
    Modify WPA Supplicant wpa3 Config    ${6G_SSID}    ${6G_SSID_BSSID}    ${Default_PSK}
    Connect to ssid and ping controller and agent    ${6G_SSID_BSSID} 
    [Teardown]    Run Keyword If    '${TEST STATUS}' == 'FAIL'    Check SSID can be scan    ${6G_SSID_BSSID}

No.5 Connect to Common SSID 2G agent
    [Tags]    Agent    2G
    Modify WPA Supplicant wpa3 Config    ${2G_Agent_SSID}    ${2G_Agent_SSID_BSSID}    ${Default_PSK}
    Connect to ssid and ping controller and agent    ${2G_Agent_SSID_BSSID} 
    [Teardown]    Run Keyword If    '${TEST STATUS}' == 'FAIL'    Check SSID can be scan    ${2G_Agent_SSID_BSSID}

No.6 Connect to Common SSID 5G agent
    [Tags]    Agent    5G
    Modify WPA Supplicant wpa3 Config    ${5G_Agent_SSID}    ${5G_Agent_SSID_BSSID}    ${Default_PSK}
    Connect to ssid and ping controller and agent    ${5G_Agent_SSID_BSSID} 
    [Teardown]    Run Keyword If    '${TEST STATUS}' == 'FAIL'    Check SSID can be scan    ${5G_Agent_SSID_BSSID}

No.7 Connect to Common SSID 6G agent
    [Tags]    Agent    6G
    Modify WPA Supplicant wpa3 Config    ${6G_Agent_SSID}    ${6G_Agent_SSID_BSSID}    ${Default_PSK}
    Connect to ssid and ping controller and agent    ${6G_Agent_SSID_BSSID} 
    [Teardown]    Run Keyword If    '${TEST STATUS}' == 'FAIL'    Check SSID can be scan    ${6G_Agent_SSID_BSSID}

No.8 Connect to Guest Fronthaul SSID 2G controller
    [Tags]    Guest    2G    Controller
    Connect to Guest ssid and Check client can get ip    ${2G_Controller_Guest_SSID}
    Verify Client cannot open GUI
    Verify Client and access to Internet
    [Teardown]    Run Keyword If    '${TEST STATUS}' == 'FAIL'    Check SSID can be scan    ${2G_Controller_Guest_SSID_BSSID}

No.9 Connect to Guest Fronthaul SSID 5G controller
    [Tags]    Guest    5G    Controller
    Connect to Guest ssid and Check client can get ip    ${5G_Controller_Guest_SSID}
    Verify Client cannot open GUI
    Verify Client and access to Internet
    [Teardown]    Run Keyword If    '${TEST STATUS}' == 'FAIL'    Check SSID can be scan    ${5G_Controller_Guest_SSID_BSSID}

No.10 Connect to Guest Fronthaul SSID 6G controller
    [Tags]    Guest    6G    Controller
    Connect to Guest ssid and Check client can get ip    ${6G_Controller_Guest_SSID}
    Verify Client cannot open GUI
    Verify Client and access to Internet
    [Teardown]    Run Keyword If    '${TEST STATUS}' == 'FAIL'    Check SSID can be scan    ${6G_Controller_Guest_SSID_BSSID}

No.11 Connect to Guest Fronthaul SSID 2G agent
    [Tags]    Guest    2G    Agent
    Connect to Guest ssid and Check client can get ip    ${2G_Agent_Guest_SSID}
    Verify Client cannot open GUI
    Verify Client and access to Internet
    [Teardown]    Run Keyword If    '${TEST STATUS}' == 'FAIL'    Check SSID can be scan    ${2G_Agent_Guest_SSID_BSSID}

No.12 Connect to Guest Fronthaul SSID 5G agent
    [Tags]    Guest    5G    Agent
    Connect to Guest ssid and Check client can get ip    ${5G_Agent_Guest_SSID}
    Verify Client cannot open GUI
    Verify Client and access to Internet
    [Teardown]    Run Keyword If    '${TEST STATUS}' == 'FAIL'    Check SSID can be scan    ${5G_Agent_Guest_SSID_BSSID}

No.13 Connect to Guest Fronthaul SSID 6G agent
    [Tags]    Guest    6G    Agent
    Connect to Guest ssid and Check client can get ip    ${6G_Agent_Guest_SSID}
    Verify Client cannot open GUI
    Verify Client and access to Internet
    [Teardown]    Run Keyword If    '${TEST STATUS}' == 'FAIL'    Check SSID can be scan    ${6G_Agent_Guest_SSID_BSSID}

No.14 Change the Agent to Wireless connection
    [Tags]    Agent    Wireless    Connection

    Disable the switch port connected to the agent
    sleep    300

    Check Agent can connect to Controller
    [Teardown]    Enable the switch port connected to the agent

Setup Guest Captive Portal for Controller
    [Tags]    Guest    Captive    Controller    Setup
    Enable Guest Captive Portal

No.15 Connect to Controller 2G Guest Captive Portal
    [Tags]    Guest    Captive    2G    Controller
    Connect to Guest ssid and Check client can get ip > portal    ${2G_Controller_Guest_SSID}
    Verify Client cannot open GUI
    Send Guest Captive Portal Auth
    Verify Client and access to Internet
    [Teardown]    Run Keyword If    '${TEST STATUS}' == 'FAIL'    Check SSID can be scan    ${2G_Controller_Guest_SSID_BSSID}

No.16 Connect to Controller 5G Guest Captive Portal
    [Tags]    Guest    Captive    5G    Controller
    Connect to Guest ssid and Check client can get ip > portal    ${5G_Controller_Guest_SSID}
    Verify Client cannot open GUI
    Send Guest Captive Portal Auth 5G
    Verify Client and access to Internet
    [Teardown]    Run Keyword If    '${TEST STATUS}' == 'FAIL'    Check SSID can be scan    ${5G_Controller_Guest_SSID_BSSID}

No.17 Connect to Controller 6G Guest Captive Portal
    [Tags]    Guest    Captive    6G    Controller
    Connect to Guest ssid and Check client can get ip > portal    ${6G_Controller_Guest_SSID}
    Verify Client cannot open GUI
    Send Guest Captive Portal Auth 6G
    Verify Client and access to Internet
    [Teardown]    Run Keyword If    '${TEST STATUS}' == 'FAIL'    Check SSID can be scan    ${6G_Controller_Guest_SSID_BSSID}

No.18 Connect to Agent 2G Guest Captive Portal
    [Tags]    Guest    Captive    2G    Agent
    Connect to Guest ssid and Check client can get ip > portal    ${2G_Agent_Guest_SSID}
    Verify Client cannot open GUI
    Send Guest Captive Portal Auth
    Verify Client and access to Internet
    [Teardown]    Run Keyword If    '${TEST STATUS}' == 'FAIL'    Check SSID can be scan    ${2G_Agent_Guest_SSID_BSSID}

No.19 Connect to Agent 5G Guest Captive Portal
    [Tags]    Guest    Captive    5G    Agent
    Connect to Guest ssid and Check client can get ip > portal    ${5G_Agent_Guest_SSID}
    Verify Client cannot open GUI
    Send Guest Captive Portal Auth 5G
    Verify Client and access to Internet
    [Teardown]    Run Keyword If    '${TEST STATUS}' == 'FAIL'    Check SSID can be scan    ${5G_Agent_Guest_SSID_BSSID}

No.20 Connect to Agent 6G Guest Captive Portal
    [Tags]    Guest    Captive    6G    Agent
    Connect to Guest ssid and Check client can get ip > portal    ${6G_Agent_Guest_SSID}
    Verify Client cannot open GUI
    Send Guest Captive Portal Auth 6G
    Verify Client and access to Internet
    [Teardown]    Run Keyword If    '${TEST STATUS}' == 'FAIL'    Check SSID can be scan    ${6G_Agent_Guest_SSID_BSSID}

Change Guest SSID
    [Tags]    Guest    SSID    Change
    Change Guest SSID
    sleep    300
    SSH To Enable Mesh Router And Get Guest SSID and BSSID

No.21 Connect to Changed Guest SSID 2G Controller
    [Tags]    Guest    Changed    2G    Controller
    Connect to Guest ssid and Check client can get ip > portal    ${2G_Controller_Guest_SSID}
    Verify Client cannot open GUI
    Send Guest Captive Portal Auth
    Verify Client and access to Internet
    [Teardown]    Run Keyword If    '${TEST STATUS}' == 'FAIL'    Check SSID can be scan    ${2G_Controller_Guest_SSID_BSSID}

No.22 Connect to Changed Guest SSID 5G Controller
    [Tags]    Guest    Changed    5G    Controller
    Connect to Guest ssid and Check client can get ip > portal    ${5G_Controller_Guest_SSID}
    Verify Client cannot open GUI
    Send Guest Captive Portal Auth 5G
    Verify Client and access to Internet
    [Teardown]    Run Keyword If    '${TEST STATUS}' == 'FAIL'    Check SSID can be scan    ${5G_Controller_Guest_SSID_BSSID}

No.23 Connect to Changed Guest SSID 6G Controller
    [Tags]    Guest    Changed    6G    Controller
    Connect to Guest ssid and Check client can get ip > portal    ${6G_Controller_Guest_SSID}
    Verify Client cannot open GUI
    Send Guest Captive Portal Auth 6G
    Verify Client and access to Internet
    [Teardown]    Run Keyword If    '${TEST STATUS}' == 'FAIL'    Check SSID can be scan    ${6G_Controller_Guest_SSID_BSSID}

Refresh Agent Guest SSID after Controller Changed
    [Tags]    Guest    Changed    Agent    Setup
    SSH To Enable Mesh Agent And Get Guest SSID and BSSID

No.24 Connect to Changed Guest SSID 2G Agent
    [Tags]    Guest    Changed    2G    Agent
    Connect to Guest ssid and Check client can get ip > portal    ${2G_Agent_Guest_SSID}
    Verify Client cannot open GUI
    Send Guest Captive Portal Auth
    Verify Client and access to Internet
    [Teardown]    Run Keyword If    '${TEST STATUS}' == 'FAIL'    Check SSID can be scan    ${2G_Agent_Guest_SSID_BSSID}

No.25 Connect to Changed Guest SSID 5G Agent
    [Tags]    Guest    Changed    5G    Agent
    Connect to Guest ssid and Check client can get ip > portal    ${5G_Agent_Guest_SSID}
    Verify Client cannot open GUI
    Send Guest Captive Portal Auth 5G
    Verify Client and access to Internet
    [Teardown]    Run Keyword If    '${TEST STATUS}' == 'FAIL'    Check SSID can be scan    ${5G_Agent_Guest_SSID_BSSID}

No.26 Connect to Changed Guest SSID 6G Agent
    [Tags]    Guest    Changed    6G    Agent
    Connect to Guest ssid and Check client can get ip > portal    ${6G_Agent_Guest_SSID}
    Verify Client cannot open GUI
    Send Guest Captive Portal Auth 6G
    Verify Client and access to Internet
    [Teardown]    Run Keyword If    '${TEST STATUS}' == 'FAIL'    Check SSID can be scan    ${6G_Agent_Guest_SSID_BSSID}

Enable Employee Network on Controller
    [Tags]    Employee    Controller    Setup
    Enable Employee
    SSH To Enable Mesh Router And Get Employee SSID and BSSID

No.27 Connect to Controller 2G Employee Fronthaul SSID
    [Tags]    Employee    2G    Controller
    Connect to Employee ssid and Check client can get ip    ${2G_Controller_Employee_SSID}
    Verify Client cannot open GUI
    Verify Client and access to Internet
    [Teardown]    Run Keyword If    '${TEST STATUS}' == 'FAIL'    Check SSID can be scan    ${2G_Controller_Employee_SSID_BSSID}

No.28 Connect to Controller 5G Employee Fronthaul SSID
    [Tags]    Employee    5G    Controller
    Connect to Employee ssid and Check client can get ip    ${5G_Controller_Employee_SSID}
    Verify Client cannot open GUI
    Verify Client and access to Internet
    [Teardown]    Run Keyword If    '${TEST STATUS}' == 'FAIL'    Check SSID can be scan    ${5G_Controller_Employee_SSID_BSSID}

No.29 Connect to Controller 6G Employee Fronthaul SSID
    [Tags]    Employee    6G    Controller
    Connect to Employee ssid and Check client can get ip    ${6G_Controller_Employee_SSID}
    Verify Client cannot open GUI
    Verify Client and access to Internet
    [Teardown]    Run Keyword If    '${TEST STATUS}' == 'FAIL'    Check SSID can be scan    ${6G_Controller_Employee_SSID_BSSID}

Get Agent Employee SSID and BSSID
    [Tags]    Employee    Agent    Setup
    SSH To Enable Mesh Agent And Get Employee SSID and BSSID

No.30 Connect to Agent 2G Employee Fronthaul SSID
    [Tags]    Employee    2G    Agent
    Connect to Employee ssid and Check client can get ip    ${2G_Agent_Employee_SSID}
    Verify Client cannot open GUI
    Verify Client and access to Internet
    [Teardown]    Run Keyword If    '${TEST STATUS}' == 'FAIL'    Check SSID can be scan    ${2G_Agent_Employee_SSID_BSSID}

No.31 Connect to Agent 5G Employee Fronthaul SSID
    [Tags]    Employee    5G    Agent
    Connect to Employee ssid and Check client can get ip    ${5G_Agent_Employee_SSID}
    Verify Client cannot open GUI
    Verify Client and access to Internet
    [Teardown]    Run Keyword If    '${TEST STATUS}' == 'FAIL'    Check SSID can be scan    ${5G_Agent_Employee_SSID_BSSID}

No.32 Connect to Agent 6G Employee Fronthaul SSID
    [Tags]    Employee    6G    Agent
    Connect to Employee ssid and Check client can get ip    ${6G_Agent_Employee_SSID}
    Verify Client cannot open GUI
    Verify Client and access to Internet
    [Teardown]    Run Keyword If    '${TEST STATUS}' == 'FAIL'    Check SSID can be scan    ${6G_Agent_Employee_SSID_BSSID}

Change Employee SSID and Password on Controller
    [Tags]    Employee    SSID    Change
    Change Employee SSID and password
    sleep    300
    SSH To Enable Mesh Router And Get Employee SSID and BSSID

No.33 Connect to Changed Employee SSID 2G Controller
    [Tags]    Employee    Changed    2G    Controller
    Connect to Employee ssid and Check client can get ip    ${2G_Controller_Employee_SSID}
    Verify Client cannot open GUI
    Verify Client and access to Internet
    [Teardown]    Run Keyword If    '${TEST STATUS}' == 'FAIL'    Check SSID can be scan    ${2G_Controller_Employee_SSID_BSSID}

No.34 Connect to Changed Employee SSID 5G Controller
    [Tags]    Employee    Changed    5G    Controller
    Connect to Employee ssid and Check client can get ip    ${5G_Controller_Employee_SSID}
    Verify Client cannot open GUI
    Verify Client and access to Internet
    [Teardown]    Run Keyword If    '${TEST STATUS}' == 'FAIL'    Check SSID can be scan    ${5G_Controller_Employee_SSID_BSSID}

No.35 Connect to Changed Employee SSID 6G Controller
    [Tags]    Employee    Changed    6G    Controller
    Connect to Employee ssid and Check client can get ip    ${6G_Controller_Employee_SSID}
    Verify Client cannot open GUI
    Verify Client and access to Internet
    [Teardown]    Run Keyword If    '${TEST STATUS}' == 'FAIL'    Check SSID can be scan    ${6G_Controller_Employee_SSID_BSSID}

Refresh Agent Employee SSID after Controller Changed
    [Tags]    Employee    Changed    Agent    Setup
    SSH To Enable Mesh Agent And Get Employee SSID and BSSID

No.36 Connect to Changed Employee SSID 2G Agent
    [Tags]    Employee    Changed    2G    Agent
    Connect to Employee ssid and Check client can get ip    ${2G_Agent_Employee_SSID}
    Verify Client cannot open GUI
    Verify Client and access to Internet
    [Teardown]    Run Keyword If    '${TEST STATUS}' == 'FAIL'    Check SSID can be scan    ${2G_Agent_Employee_SSID_BSSID}

No.37 Connect to Changed Employee SSID 5G Agent
    [Tags]    Employee    Changed    5G    Agent
    Connect to Employee ssid and Check client can get ip    ${5G_Agent_Employee_SSID}
    Verify Client cannot open GUI
    Verify Client and access to Internet
    [Teardown]    Run Keyword If    '${TEST STATUS}' == 'FAIL'    Check SSID can be scan    ${5G_Agent_Employee_SSID_BSSID}

No.38 Connect to Changed Employee SSID 6G Agent
    [Tags]    Employee    Changed    6G    Agent
    Connect to Employee ssid and Check client can get ip    ${6G_Agent_Employee_SSID}
    Verify Client cannot open GUI
    Verify Client and access to Internet
    [Teardown]    Run Keyword If    '${TEST STATUS}' == 'FAIL'    Check SSID can be scan    ${6G_Agent_Employee_SSID_BSSID}

Enable Client wired Network
    Enable Client wired Network
    Check the interface the connect to Jenkins

###@@@@----Guest Captive Portal Test Cases-----@@@@###

Default Agent
    [Tags]	Agent
    Get agent ip 
    Login GUI    ${Agent_IP}
    Defalut DUT/Agent and No wait setup
    Close All Browsers  

Disable the switch port connected to the agent
    [Tags]	Agent
    Disable the switch port connected to the agent

Default Controller
    Login GUI    ${HOST}
    Defalut DUT/Agent and Wait setup
    Close All Browsers  

Setup Wizard
    [Tags]    Wizard
    Login Wizard GUI    ${HOST}
    Setup Wizard
    Close All Browsers   

Enable Guest and Guest Captive Portal
    [Tags]    Guest    Mesh
    Enable Guest and Guest Captive Portal

No.39 Check Mesh Agent is online
    [Tags]    Agent
    Enable the switch port connected to the agent
    sleep    300
    Get agent ip

Check Agent FW 
    Check DUT FW   ${Agent_IP}
    
Enable SSh
    Enable SSH
    Enable Agent SSH
   
Get Agent all SSID and BSSID
    [Tags]	Agent
    SSH To Enable Mesh Agent And Get all Common/disable common SSID and BSSID
    
Get Router all SSID,password and BSSID
    SSH To Enable Mesh Router And Get all Common/disable common SSID and BSSID
    SSH To Controller And Get default wifi password

Disable Client wired Network and Reset WiFi Interface
    Disable Client wired Network
    Reset WiFi Interface

No.3x Connect to Common SSID 2G controller
    [Tags]    2G
    Modify WPA Supplicant wpa3 Config    ${2G_SSID}    ${2G_SSID_BSSID}    ${Default_PSK}
    Connect to ssid and ping controller and agent    ${2G_SSID_BSSID}    
    [Teardown]    Run Keyword If    '${TEST STATUS}' == 'FAIL'    Check SSID can be scan    ${2G_SSID_BSSID}

No.40 Connect to Common SSID 5G controller
    [Tags]    5G
    Modify WPA Supplicant wpa3 Config    ${5G_SSID}    ${5G_SSID_BSSID}    ${Default_PSK}
    Connect to ssid and ping controller and agent    ${5G_SSID_BSSID} 
    [Teardown]    Run Keyword If    '${TEST STATUS}' == 'FAIL'    Check SSID can be scan    ${5G_SSID_BSSID}

No.41 Connect to Common SSID 6G controller
    [Tags]    6G
    Modify WPA Supplicant wpa3 Config    ${6G_SSID}    ${6G_SSID_BSSID}    ${Default_PSK}
    Connect to ssid and ping controller and agent    ${6G_SSID_BSSID} 
    [Teardown]    Run Keyword If    '${TEST STATUS}' == 'FAIL'    Check SSID can be scan    ${6G_SSID_BSSID}

No.42 Connect to Common SSID 2G agent
    [Tags]    Agent    2G
    Modify WPA Supplicant wpa3 Config    ${2G_Agent_SSID}    ${2G_Agent_SSID_BSSID}    ${Default_PSK}
    Connect to ssid and ping controller and agent    ${2G_Agent_SSID_BSSID} 
    [Teardown]    Run Keyword If    '${TEST STATUS}' == 'FAIL'    Check SSID can be scan    ${2G_Agent_SSID_BSSID}

No.43 Connect to Common SSID 5G agent
    [Tags]    Agent    5G
    Modify WPA Supplicant wpa3 Config    ${5G_Agent_SSID}    ${5G_Agent_SSID_BSSID}    ${Default_PSK}
    Connect to ssid and ping controller and agent    ${5G_Agent_SSID_BSSID} 
    [Teardown]    Run Keyword If    '${TEST STATUS}' == 'FAIL'    Check SSID can be scan    ${5G_Agent_SSID_BSSID}

No.44 Connect to Common SSID 6G agent
    [Tags]    Agent    6G
    Modify WPA Supplicant wpa3 Config    ${6G_Agent_SSID}    ${6G_Agent_SSID_BSSID}    ${Default_PSK}
    Connect to ssid and ping controller and agent    ${6G_Agent_SSID_BSSID} 
    [Teardown]    Run Keyword If    '${TEST STATUS}' == 'FAIL'    Check SSID can be scan    ${6G_Agent_SSID_BSSID}

No.45 Connect to Controller 2G Guest Captive Portal
    [Tags]    Guest    Captive    2G    Controller
    Connect to Guest ssid and Check client can get ip > portal    ${2G_Controller_Guest_SSID}
    Verify Client cannot open GUI
    Send Guest Captive Portal Auth
    Verify Client and access to Internet
    [Teardown]    Run Keyword If    '${TEST STATUS}' == 'FAIL'    Check SSID can be scan    ${2G_Controller_Guest_SSID_BSSID}

No.46 Connect to Controller 5G Guest Captive Portal
    [Tags]    Guest    Captive    5G    Controller
    Connect to Guest ssid and Check client can get ip > portal    ${5G_Controller_Guest_SSID}
    Verify Client cannot open GUI
    Send Guest Captive Portal Auth 5G
    Verify Client and access to Internet
    [Teardown]    Run Keyword If    '${TEST STATUS}' == 'FAIL'    Check SSID can be scan    ${5G_Controller_Guest_SSID_BSSID}

No.47 Connect to Controller 6G Guest Captive Portal
    [Tags]    Guest    Captive    6G    Controller
    Connect to Guest ssid and Check client can get ip > portal    ${6G_Controller_Guest_SSID}
    Verify Client cannot open GUI
    Send Guest Captive Portal Auth 6G
    Verify Client and access to Internet
    [Teardown]    Run Keyword If    '${TEST STATUS}' == 'FAIL'    Check SSID can be scan    ${6G_Controller_Guest_SSID_BSSID}

No.48 Connect to Agent 2G Guest Captive Portal
    [Tags]    Guest    Captive    2G    Agent
    Connect to Guest ssid and Check client can get ip > portal    ${2G_Agent_Guest_SSID}
    Verify Client cannot open GUI
    Send Guest Captive Portal Auth
    Verify Client and access to Internet
    [Teardown]    Run Keyword If    '${TEST STATUS}' == 'FAIL'    Check SSID can be scan    ${2G_Agent_Guest_SSID_BSSID}

No.49 Connect to Agent 5G Guest Captive Portal
    [Tags]    Guest    Captive    5G    Agent
    Connect to Guest ssid and Check client can get ip > portal    ${5G_Agent_Guest_SSID}
    Verify Client cannot open GUI
    Send Guest Captive Portal Auth 5G
    Verify Client and access to Internet
    [Teardown]    Run Keyword If    '${TEST STATUS}' == 'FAIL'    Check SSID can be scan    ${5G_Agent_Guest_SSID_BSSID}

No.50 Connect to Agent 6G Guest Captive Portal
    [Tags]    Guest    Captive    6G    Agent
    Connect to Guest ssid and Check client can get ip > portal    ${6G_Agent_Guest_SSID}
    Verify Client cannot open GUI
    Send Guest Captive Portal Auth 6G
    Verify Client and access to Internet
    [Teardown]    Run Keyword If    '${TEST STATUS}' == 'FAIL'    Check SSID can be scan    ${6G_Agent_Guest_SSID_BSSID}

Change Guest SSID
    [Tags]    Guest    SSID    Change
    Change Guest SSID
    sleep    300
    SSH To Enable Mesh Router And Get Guest SSID and BSSID

No.51 Connect to Changed Guest SSID 2G Controller
    [Tags]    Guest    Changed    2G    Controller
    Connect to Guest ssid and Check client can get ip > portal    ${2G_Controller_Guest_SSID}
    Verify Client cannot open GUI
    Send Guest Captive Portal Auth
    Verify Client and access to Internet
    [Teardown]    Run Keyword If    '${TEST STATUS}' == 'FAIL'    Check SSID can be scan    ${2G_Controller_Guest_SSID_BSSID}

No.52 Connect to Changed Guest SSID 5G Controller
    [Tags]    Guest    Changed    5G    Controller
    Connect to Guest ssid and Check client can get ip > portal    ${5G_Controller_Guest_SSID}
    Verify Client cannot open GUI
    Send Guest Captive Portal Auth 5G
    Verify Client and access to Internet
    [Teardown]    Run Keyword If    '${TEST STATUS}' == 'FAIL'    Check SSID can be scan    ${5G_Controller_Guest_SSID_BSSID}

No.53 Connect to Changed Guest SSID 6G Controller
    [Tags]    Guest    Changed    6G    Controller
    Connect to Guest ssid and Check client can get ip > portal    ${6G_Controller_Guest_SSID}
    Verify Client cannot open GUI
    Send Guest Captive Portal Auth 6G
    Verify Client and access to Internet
    [Teardown]    Run Keyword If    '${TEST STATUS}' == 'FAIL'    Check SSID can be scan    ${6G_Controller_Guest_SSID_BSSID}

Refresh Agent Guest SSID after Controller Changed
    [Tags]    Guest    Changed    Agent    Setup
    SSH To Enable Mesh Agent And Get Guest SSID and BSSID

No.54 Connect to Changed Guest SSID 2G Agent
    [Tags]    Guest    Changed    2G    Agent
    Connect to Guest ssid and Check client can get ip > portal    ${2G_Agent_Guest_SSID}
    Verify Client cannot open GUI
    Send Guest Captive Portal Auth
    Verify Client and access to Internet
    [Teardown]    Run Keyword If    '${TEST STATUS}' == 'FAIL'    Check SSID can be scan    ${2G_Agent_Guest_SSID_BSSID}

No.55 Connect to Changed Guest SSID 5G Agent
    [Tags]    Guest    Changed    5G    Agent
    Connect to Guest ssid and Check client can get ip > portal    ${5G_Agent_Guest_SSID}
    Verify Client cannot open GUI
    Send Guest Captive Portal Auth 5G
    Verify Client and access to Internet
    [Teardown]    Run Keyword If    '${TEST STATUS}' == 'FAIL'    Check SSID can be scan    ${5G_Agent_Guest_SSID_BSSID}

No.56 Connect to Changed Guest SSID 6G Agent
    [Tags]    Guest    Changed    6G    Agent
    Connect to Guest ssid and Check client can get ip > portal    ${6G_Agent_Guest_SSID}
    Verify Client cannot open GUI
    Send Guest Captive Portal Auth 6G
    Verify Client and access to Internet
    [Teardown]    Run Keyword If    '${TEST STATUS}' == 'FAIL'    Check SSID can be scan    ${6G_Agent_Guest_SSID_BSSID}

Enable Employee Network on Controller
    [Tags]    Employee    Controller    Setup

    Enable Employee
    SSH To Enable Mesh Router And Get Employee SSID and BSSID

Get Agent Employee SSID and BSSID
    [Tags]    Employee    Agent    Setup
    SSH To Enable Mesh Agent And Get Employee SSID and BSSID

No.57 Connect to Controller 2G Employee Fronthaul SSID
    [Tags]    Employee    2G    Controller
    Connect to Employee ssid and Check client can get ip    ${2G_Controller_Employee_SSID}
    Verify Client cannot open GUI
    Verify Client and access to Internet
    [Teardown]    Run Keyword If    '${TEST STATUS}' == 'FAIL'    Check SSID can be scan    ${2G_Controller_Employee_SSID_BSSID}

No.58 Connect to Controller 5G Employee Fronthaul SSID
    [Tags]    Employee    5G    Controller
    Connect to Employee ssid and Check client can get ip    ${5G_Controller_Employee_SSID}
    Verify Client cannot open GUI
    Verify Client and access to Internet
    [Teardown]    Run Keyword If    '${TEST STATUS}' == 'FAIL'    Check SSID can be scan    ${5G_Controller_Employee_SSID_BSSID}

No.59 Connect to Controller 6G Employee Fronthaul SSID
    [Tags]    Employee    6G    Controller
    Connect to Employee ssid and Check client can get ip    ${6G_Controller_Employee_SSID}
    Verify Client cannot open GUI
    Verify Client and access to Internet
    [Teardown]    Run Keyword If    '${TEST STATUS}' == 'FAIL'    Check SSID can be scan    ${6G_Controller_Employee_SSID_BSSID}

No.60 Connect to Agent 2G Employee Fronthaul SSID
    [Tags]    Employee    2G    Agent
    Connect to Employee ssid and Check client can get ip    ${2G_Agent_Employee_SSID}
    Verify Client cannot open GUI
    Verify Client and access to Internet
    [Teardown]    Run Keyword If    '${TEST STATUS}' == 'FAIL'    Check SSID can be scan    ${2G_Agent_Employee_SSID_BSSID}

No.61 Connect to Agent 5G Employee Fronthaul SSID
    [Tags]    Employee    5G    Agent
    Connect to Employee ssid and Check client can get ip    ${5G_Agent_Employee_SSID}
    Verify Client cannot open GUI
    Verify Client and access to Internet
    [Teardown]    Run Keyword If    '${TEST STATUS}' == 'FAIL'    Check SSID can be scan    ${5G_Agent_Employee_SSID_BSSID}

No.62 Connect to Agent 6G Employee Fronthaul SSID
    [Tags]    Employee    6G    Agent
    Connect to Employee ssid and Check client can get ip    ${6G_Agent_Employee_SSID}
    Verify Client cannot open GUI
    Verify Client and access to Internet
    [Teardown]    Run Keyword If    '${TEST STATUS}' == 'FAIL'    Check SSID can be scan    ${6G_Agent_Employee_SSID_BSSID}

Change Employee SSID and Password on Controller
    [Tags]    Employee    SSID    Change
    Change Employee SSID and password
    sleep    300
    SSH To Enable Mesh Router And Get Employee SSID and BSSID

No.63 Connect to Changed Employee SSID 2G Controller
    [Tags]    Employee    Changed    2G    Controller
    Connect to Employee ssid and Check client can get ip    ${2G_Controller_Employee_SSID}
    Verify Client cannot open GUI
    Verify Client and access to Internet
    [Teardown]    Run Keyword If    '${TEST STATUS}' == 'FAIL'    Check SSID can be scan    ${2G_Controller_Employee_SSID_BSSID}

No.64 Connect to Changed Employee SSID 5G Controller
    [Tags]    Employee    Changed    5G    Controller
    Connect to Employee ssid and Check client can get ip    ${5G_Controller_Employee_SSID}
    Verify Client cannot open GUI
    Verify Client and access to Internet
    [Teardown]    Run Keyword If    '${TEST STATUS}' == 'FAIL'    Check SSID can be scan    ${5G_Controller_Employee_SSID_BSSID}

No.65 Connect to Changed Employee SSID 6G Controller
    [Tags]    Employee    Changed    6G    Controller
    Connect to Employee ssid and Check client can get ip    ${6G_Controller_Employee_SSID}
    Verify Client cannot open GUI
    Verify Client and access to Internet
    [Teardown]    Run Keyword If    '${TEST STATUS}' == 'FAIL'    Check SSID can be scan    ${6G_Controller_Employee_SSID_BSSID}

Refresh Agent Employee SSID after Controller Changed
    [Tags]    Employee    Changed    Agent    Setup
    SSH To Enable Mesh Agent And Get Employee SSID and BSSID

No.66 Connect to Changed Employee SSID 2G Agent
    [Tags]    Employee    Changed    2G    Agent
    Connect to Employee ssid and Check client can get ip    ${2G_Agent_Employee_SSID}
    Verify Client cannot open GUI
    Verify Client and access to Internet
    [Teardown]    Run Keyword If    '${TEST STATUS}' == 'FAIL'    Check SSID can be scan    ${2G_Agent_Employee_SSID_BSSID}

No.67 Connect to Changed Employee SSID 5G Agent
    [Tags]    Employee    Changed    5G    Agent
    Connect to Employee ssid and Check client can get ip    ${5G_Agent_Employee_SSID}
    Verify Client cannot open GUI
    Verify Client and access to Internet
    [Teardown]    Run Keyword If    '${TEST STATUS}' == 'FAIL'    Check SSID can be scan    ${5G_Agent_Employee_SSID_BSSID}

No.68 Connect to Changed Employee SSID 6G Agent
    [Tags]    Employee    Changed    6G    Agent
    Connect to Employee ssid and Check client can get ip    ${6G_Agent_Employee_SSID}
    Verify Client cannot open GUI
    Verify Client and access to Internet
    [Teardown]    Run Keyword If    '${TEST STATUS}' == 'FAIL'    Check SSID can be scan    ${6G_Agent_Employee_SSID_BSSID}

No.68 Disable Guest Captive Portal
    [Tags]    Guest    CaptivePortal
    Check Guest Captive Portal status and Disable it

No.70 Connect to Controller 2G Guest Fronthaul SSID
    [Tags]    Guest    Fronthaul    2G    Controller
    Connect to Guest ssid and Check client can get ip    ${2G_Controller_Guest_SSID}
    Verify Client cannot open GUI
    Verify Client and access to Internet
    [Teardown]    Run Keyword If    '${TEST STATUS}' == 'FAIL'    Check SSID can be scan    ${2G_Controller_Guest_SSID_BSSID}

No.71 Connect to Controller 5G Guest Fronthaul SSID
    [Tags]    Guest    Fronthaul    5G    Controller
    Connect to Guest ssid and Check client can get ip    ${5G_Controller_Guest_SSID}
    Verify Client cannot open GUI
    Verify Client and access to Internet
    [Teardown]    Run Keyword If    '${TEST STATUS}' == 'FAIL'    Check SSID can be scan    ${5G_Controller_Guest_SSID_BSSID}

No.72 Connect to Controller 6G Guest Fronthaul SSID
    [Tags]    Guest    Fronthaul    6G    Controller
    Connect to Guest ssid and Check client can get ip    ${6G_Controller_Guest_SSID}
    Verify Client cannot open GUI
    Verify Client and access to Internet
    [Teardown]    Run Keyword If    '${TEST STATUS}' == 'FAIL'    Check SSID can be scan    ${6G_Controller_Guest_SSID_BSSID}

No.73 Connect to Agent 2G Guest Fronthaul SSID
    [Tags]    Guest    Fronthaul    2G    Agent
    Connect to Guest ssid and Check client can get ip    ${2G_Agent_Guest_SSID}
    Verify Client cannot open GUI
    Verify Client and access to Internet
    [Teardown]    Run Keyword If    '${TEST STATUS}' == 'FAIL'    Check SSID can be scan    ${2G_Agent_Guest_SSID_BSSID}

No.74 Connect to Agent 5G Guest Fronthaul SSID
    [Tags]    Guest    Fronthaul    5G    Agent
    Connect to Guest ssid and Check client can get ip    ${5G_Agent_Guest_SSID}
    Verify Client cannot open GUI
    Verify Client and access to Internet
    [Teardown]    Run Keyword If    '${TEST STATUS}' == 'FAIL'    Check SSID can be scan    ${5G_Agent_Guest_SSID_BSSID}

No.75 Connect to Agent 6G Guest Fronthaul SSID
    [Tags]    Guest    Fronthaul    6G    Agent
    Connect to Guest ssid and Check client can get ip    ${6G_Agent_Guest_SSID}
    Verify Client cannot open GUI
    Verify Client and access to Internet
    [Teardown]    Run Keyword If    '${TEST STATUS}' == 'FAIL'    Check SSID can be scan    ${6G_Agent_Guest_SSID_BSSID}

Enable Client wired Network
    Enable Client wired Network
    Check the interface the connect to Jenkins

###@@@@----Employee Test Cases-----@@@@###

Default Agent
    [Tags]	Agent
    Get agent ip 
    Login GUI    ${Agent_IP}
    Defalut DUT/Agent and No wait setup
    Close All Browsers  

Disable the switch port connected to the agent
    [Tags]	Agent
    Disable the switch port connected to the agent

Default Controller
    Login GUI    ${HOST}
    Defalut DUT/Agent and Wait setup
    Close All Browsers  

Setup Wizard
    [Tags]    Wizard
    Login Wizard GUI    ${HOST}
    Setup Wizard
    Close All Browsers   

Enable Employee Network on Controller
    [Tags]    Employee    Controller    Setup
    Check the Guest setting and disable it
    Enable Employee
    SSH To Enable Mesh Router And Get Employee SSID and BSSID

No.77 Check Mesh Agent is online
    [Tags]    Agent
    Enable the switch port connected to the agent
    sleep    300
    Get agent ip

Check Agent FW 
    Check DUT FW   ${Agent_IP}
    
Enable SSh
    Enable SSH
    Enable Agent SSH
   
Get Agent all SSID and BSSID
    [Tags]	Agent
    SSH To Enable Mesh Agent And Get all Common/disable common SSID and BSSID
    
Get Router all SSID,password and BSSID
    SSH To Enable Mesh Router And Get all Common/disable common SSID and BSSID
    SSH To Controller And Get default wifi password

Refresh Controller Employee SSID after Controller Changed
    [Tags]    Employee    Changed    Controller    Setup
    SSH To Enable Mesh Router And Get Employee SSID and BSSID > only Employee SSID

Refresh Agent Employee SSID after Controller Changed
    [Tags]    Employee    Changed    Agent    Setup
    SSH To Enable Mesh Agent And Get Employee SSID and BSSID > only Employee SSID

Disable Client wired Network and Reset WiFi Interface
    Disable Client wired Network
    Reset WiFi Interface

No.76 Connect to Common SSID 2G controller
    [Tags]    2G
    Modify WPA Supplicant wpa3 Config    ${2G_SSID}    ${2G_SSID_BSSID}    ${Default_PSK}
    Connect to ssid and ping controller and agent    ${2G_SSID_BSSID}    
    [Teardown]    Run Keyword If    '${TEST STATUS}' == 'FAIL'    Check SSID can be scan    ${2G_SSID_BSSID}

No.7x Connect to Common SSID 5G controller
    [Tags]    5G
    Modify WPA Supplicant wpa3 Config    ${5G_SSID}    ${5G_SSID_BSSID}    ${Default_PSK}
    Connect to ssid and ping controller and agent    ${5G_SSID_BSSID} 
    [Teardown]    Run Keyword If    '${TEST STATUS}' == 'FAIL'    Check SSID can be scan    ${5G_SSID_BSSID}

No.78 Connect to Common SSID 6G controller
    [Tags]    6G
    Modify WPA Supplicant wpa3 Config    ${6G_SSID}    ${6G_SSID_BSSID}    ${Default_PSK}
    Connect to ssid and ping controller and agent    ${6G_SSID_BSSID} 
    [Teardown]    Run Keyword If    '${TEST STATUS}' == 'FAIL'    Check SSID can be scan    ${6G_SSID_BSSID}

No.79 Connect to Common SSID 2G agent
    [Tags]    Agent    2G
    Modify WPA Supplicant wpa3 Config    ${2G_Agent_SSID}    ${2G_Agent_SSID_BSSID}    ${Default_PSK}
    Connect to ssid and ping controller and agent    ${2G_Agent_SSID_BSSID} 
    [Teardown]    Run Keyword If    '${TEST STATUS}' == 'FAIL'    Check SSID can be scan    ${2G_Agent_SSID_BSSID}

No.80 Connect to Common SSID 5G agent
    [Tags]    Agent    5G
    Modify WPA Supplicant wpa3 Config    ${5G_Agent_SSID}    ${5G_Agent_SSID_BSSID}    ${Default_PSK}
    Connect to ssid and ping controller and agent    ${5G_Agent_SSID_BSSID} 
    [Teardown]    Run Keyword If    '${TEST STATUS}' == 'FAIL'    Check SSID can be scan    ${5G_Agent_SSID_BSSID}

No.81 Connect to Common SSID 6G agent
    [Tags]    Agent    6G
    Modify WPA Supplicant wpa3 Config    ${6G_Agent_SSID}    ${6G_Agent_SSID_BSSID}    ${Default_PSK}
    Connect to ssid and ping controller and agent    ${6G_Agent_SSID_BSSID} 
    [Teardown]    Run Keyword If    '${TEST STATUS}' == 'FAIL'    Check SSID can be scan    ${6G_Agent_SSID_BSSID}

No.82 Connect to Controller 2G Employee Fronthaul SSID
    [Tags]    Employee    2G    Controller
    Connect to Employee ssid and Check client can get ip    ${2G_Controller_Employee_SSID}
    Verify Client cannot open GUI
    Verify Client and access to Internet
    [Teardown]    Run Keyword If    '${TEST STATUS}' == 'FAIL'    Check SSID can be scan    ${2G_Controller_Employee_SSID_BSSID}

No.83 Connect to Controller 5G Employee Fronthaul SSID
    [Tags]    Employee    5G    Controller
    Connect to Employee ssid and Check client can get ip    ${5G_Controller_Employee_SSID}
    Verify Client cannot open GUI
    Verify Client and access to Internet
    [Teardown]    Run Keyword If    '${TEST STATUS}' == 'FAIL'    Check SSID can be scan    ${5G_Controller_Employee_SSID_BSSID}

No.84 Connect to Controller 6G Employee Fronthaul SSID
    [Tags]    Employee    6G    Controller
    Connect to Employee ssid and Check client can get ip    ${6G_Controller_Employee_SSID}
    Verify Client cannot open GUI
    Verify Client and access to Internet
    [Teardown]    Run Keyword If    '${TEST STATUS}' == 'FAIL'    Check SSID can be scan    ${6G_Controller_Employee_SSID_BSSID}

No.85 Connect to Agent 2G Employee Fronthaul SSID
    [Tags]    Employee    2G    Agent
    Connect to Employee ssid and Check client can get ip    ${2G_Agent_Employee_SSID}
    Verify Client cannot open GUI
    Verify Client and access to Internet
    [Teardown]    Run Keyword If    '${TEST STATUS}' == 'FAIL'    Check SSID can be scan    ${2G_Agent_Employee_SSID_BSSID}

No.86 Connect to Agent 5G Employee Fronthaul SSID
    [Tags]    Employee    5G    Agent
    Connect to Employee ssid and Check client can get ip    ${5G_Agent_Employee_SSID}
    Verify Client cannot open GUI
    Verify Client and access to Internet
    [Teardown]    Run Keyword If    '${TEST STATUS}' == 'FAIL'    Check SSID can be scan    ${5G_Agent_Employee_SSID_BSSID}

No.87 Connect to Agent 6G Employee Fronthaul SSID
    [Tags]    Employee    6G    Agent
    Connect to Employee ssid and Check client can get ip    ${6G_Agent_Employee_SSID}
    Verify Client cannot open GUI
    Verify Client and access to Internet
    [Teardown]    Run Keyword If    '${TEST STATUS}' == 'FAIL'    Check SSID can be scan    ${6G_Agent_Employee_SSID_BSSID}

Change Employee SSID and Password on Controller
    [Tags]    Employee    SSID    Change
    Change Employee SSID and password
    sleep    300

Refresh Controller Employee SSID after Controller Changed
    [Tags]    Employee    Changed    Controller    Setup
    SSH To Enable Mesh Router And Get Employee SSID and BSSID > only Employee SSID

Refresh Agent Employee SSID after Controller Changed
    [Tags]    Employee    Changed    Agent    Setup
    SSH To Enable Mesh Agent And Get Employee SSID and BSSID > only Employee SSID

No.88 Connect to Changed Employee SSID 2G Controller
    [Tags]    Employee    Changed    2G    Controller
    Connect to Employee ssid and Check client can get ip    ${2G_Controller_Employee_SSID}
    Verify Client cannot open GUI
    Verify Client and access to Internet
    [Teardown]    Run Keyword If    '${TEST STATUS}' == 'FAIL'    Check SSID can be scan    ${2G_Controller_Employee_SSID_BSSID}

No.89 Connect to Changed Employee SSID 5G Controller
    [Tags]    Employee    Changed    5G    Controller
    Connect to Employee ssid and Check client can get ip    ${5G_Controller_Employee_SSID}
    Verify Client cannot open GUI
    Verify Client and access to Internet
    [Teardown]    Run Keyword If    '${TEST STATUS}' == 'FAIL'    Check SSID can be scan    ${5G_Controller_Employee_SSID_BSSID}

No.90 Connect to Changed Employee SSID 6G Controller
    [Tags]    Employee    Changed    6G    Controller
    Connect to Employee ssid and Check client can get ip    ${6G_Controller_Employee_SSID}
    Verify Client cannot open GUI
    Verify Client and access to Internet
    [Teardown]    Run Keyword If    '${TEST STATUS}' == 'FAIL'    Check SSID can be scan    ${6G_Controller_Employee_SSID_BSSID}

No.91 Connect to Changed Employee SSID 2G Agent
    [Tags]    Employee    Changed    2G    Agent
    Connect to Employee ssid and Check client can get ip    ${2G_Agent_Employee_SSID}
    Verify Client cannot open GUI
    Verify Client and access to Internet
    [Teardown]    Run Keyword If    '${TEST STATUS}' == 'FAIL'    Check SSID can be scan    ${2G_Agent_Employee_SSID_BSSID}

No.92 Connect to Changed Employee SSID 5G Agent
    [Tags]    Employee    Changed    5G    Agent
    Connect to Employee ssid and Check client can get ip    ${5G_Agent_Employee_SSID}
    Verify Client cannot open GUI
    Verify Client and access to Internet
    [Teardown]    Run Keyword If    '${TEST STATUS}' == 'FAIL'    Check SSID can be scan    ${5G_Agent_Employee_SSID_BSSID}

No.93 Connect to Changed Employee SSID 6G Agent
    [Tags]    Employee    Changed    6G    Agent
    Connect to Employee ssid and Check client can get ip    ${6G_Agent_Employee_SSID}
    Verify Client cannot open GUI
    Verify Client and access to Internet
    [Teardown]    Run Keyword If    '${TEST STATUS}' == 'FAIL'    Check SSID can be scan    ${6G_Agent_Employee_SSID_BSSID}

No.94 Change the Agent to Wireless connection
    [Tags]    Agent    Wireless    Connection
    Disable the switch port connected to the agent
    sleep    300
    Check Agent can connect to Controller
    [Teardown]    Enable the switch port connected to the agent

Check Guest status
    [Tags]    Guest    Mesh
    Check the Guest setting and enable it

Get Router Guest SSID and BSSID
    [Tags]    Guest    Controller    Setup
    SSH To Enable Mesh Router And Get Guest SSID and BSSID

Get Agent Guest SSID and BSSID
    [Tags]    Guest    Agent    Setup
    SSH To Enable Mesh Agent And Get Guest SSID and BSSID

Disable Client wired Network and Reset WiFi Interface
    Disable Client wired Network
    Reset WiFi Interface

No.95 Connect to Guest Fronthaul SSID 2G controller
    [Tags]    Guest    2G    Controller
    Connect to Guest ssid and Check client can get ip    ${2G_Controller_Guest_SSID}
    Verify Client cannot open GUI
    Verify Client and access to Internet
    [Teardown]    Run Keyword If    '${TEST STATUS}' == 'FAIL'    Check SSID can be scan    ${2G_Controller_Guest_SSID_BSSID}

No.96 Connect to Guest Fronthaul SSID 5G controller
    [Tags]    Guest    5G    Controller
    Connect to Guest ssid and Check client can get ip    ${5G_Controller_Guest_SSID}
    Verify Client cannot open GUI
    Verify Client and access to Internet
    [Teardown]    Run Keyword If    '${TEST STATUS}' == 'FAIL'    Check SSID can be scan    ${5G_Controller_Guest_SSID_BSSID}

No.97 Connect to Guest Fronthaul SSID 6G controller
    [Tags]    Guest    6G    Controller
    Connect to Guest ssid and Check client can get ip    ${6G_Controller_Guest_SSID}
    Verify Client cannot open GUI
    Verify Client and access to Internet
    [Teardown]    Run Keyword If    '${TEST STATUS}' == 'FAIL'    Check SSID can be scan    ${6G_Controller_Guest_SSID_BSSID}

No.98 Connect to Guest Fronthaul SSID 2G agent
    [Tags]    Guest    2G    Agent
    Connect to Guest ssid and Check client can get ip    ${2G_Agent_Guest_SSID}
    Verify Client cannot open GUI
    Verify Client and access to Internet
    [Teardown]    Run Keyword If    '${TEST STATUS}' == 'FAIL'    Check SSID can be scan    ${2G_Agent_Guest_SSID_BSSID}

No.99 Connect to Guest Fronthaul SSID 5G agent
    [Tags]    Guest    5G    Agent
    Connect to Guest ssid and Check client can get ip    ${5G_Agent_Guest_SSID}
    Verify Client cannot open GUI
    Verify Client and access to Internet
    [Teardown]    Run Keyword If    '${TEST STATUS}' == 'FAIL'    Check SSID can be scan    ${5G_Agent_Guest_SSID_BSSID}

No.100 Connect to Guest Fronthaul SSID 6G agent
    [Tags]    Guest    6G    Agent
    Connect to Guest ssid and Check client can get ip    ${6G_Agent_Guest_SSID}
    Verify Client cannot open GUI
    Verify Client and access to Internet
    [Teardown]    Run Keyword If    '${TEST STATUS}' == 'FAIL'    Check SSID can be scan    ${6G_Agent_Guest_SSID_BSSID}

Setup Guest Captive Portal for Controller
    [Tags]    Guest    Captive    Controller    Setup
    Enable Guest Captive Portal

No.101 Connect to Controller 2G Guest Captive Portal
    [Tags]    Guest    Captive    2G    Controller
    Connect to Guest ssid and Check client can get ip > portal    ${2G_Controller_Guest_SSID}
    Verify Client cannot open GUI
    Send Guest Captive Portal Auth
    Verify Client and access to Internet
    [Teardown]    Run Keyword If    '${TEST STATUS}' == 'FAIL'    Check SSID can be scan    ${2G_Controller_Guest_SSID_BSSID}

No.102 Connect to Controller 5G Guest Captive Portal
    [Tags]    Guest    Captive    5G    Controller
    Connect to Guest ssid and Check client can get ip > portal    ${5G_Controller_Guest_SSID}
    Verify Client cannot open GUI
    Send Guest Captive Portal Auth 5G
    Verify Client and access to Internet
    [Teardown]    Run Keyword If    '${TEST STATUS}' == 'FAIL'    Check SSID can be scan    ${5G_Controller_Guest_SSID_BSSID}

No.103 Connect to Controller 6G Guest Captive Portal
    [Tags]    Guest    Captive    6G    Controller
    Connect to Guest ssid and Check client can get ip > portal    ${6G_Controller_Guest_SSID}
    Verify Client cannot open GUI
    Send Guest Captive Portal Auth 6G
    Verify Client and access to Internet
    [Teardown]    Run Keyword If    '${TEST STATUS}' == 'FAIL'    Check SSID can be scan    ${6G_Controller_Guest_SSID_BSSID}

No.104 Connect to Agent 2G Guest Captive Portal
    [Tags]    Guest    Captive    2G    Agent
    Connect to Guest ssid and Check client can get ip > portal    ${2G_Agent_Guest_SSID}
    Verify Client cannot open GUI
    Send Guest Captive Portal Auth
    Verify Client and access to Internet
    [Teardown]    Run Keyword If    '${TEST STATUS}' == 'FAIL'    Check SSID can be scan    ${2G_Agent_Guest_SSID_BSSID}

No.105 Connect to Agent 5G Guest Captive Portal
    [Tags]    Guest    Captive    5G    Agent
    Connect to Guest ssid and Check client can get ip > portal    ${5G_Agent_Guest_SSID}
    Verify Client cannot open GUI
    Send Guest Captive Portal Auth 5G
    Verify Client and access to Internet
    [Teardown]    Run Keyword If    '${TEST STATUS}' == 'FAIL'    Check SSID can be scan    ${5G_Agent_Guest_SSID_BSSID}

No.106 Connect to Agent 6G Guest Captive Portal
    [Tags]    Guest    Captive    6G    Agent
    Connect to Guest ssid and Check client can get ip > portal    ${6G_Agent_Guest_SSID}
    Verify Client cannot open GUI
    Send Guest Captive Portal Auth 6G
    Verify Client and access to Internet
    [Teardown]    Run Keyword If    '${TEST STATUS}' == 'FAIL'    Check SSID can be scan    ${6G_Agent_Guest_SSID_BSSID}

Change Guest SSID
    [Tags]    Guest    SSID    Change
    Change Guest SSID
    sleep    300
    SSH To Enable Mesh Router And Get Guest SSID and BSSID

No.107 Connect to Changed Guest SSID 2G Controller
    [Tags]    Guest    Changed    2G    Controller
    Connect to Guest ssid and Check client can get ip > portal    ${2G_Controller_Guest_SSID}
    Verify Client cannot open GUI
    Send Guest Captive Portal Auth
    Verify Client and access to Internet
    [Teardown]    Run Keyword If    '${TEST STATUS}' == 'FAIL'    Check SSID can be scan    ${2G_Controller_Guest_SSID_BSSID}

No.108 Connect to Changed Guest SSID 5G Controller
    [Tags]    Guest    Changed    5G    Controller
    Connect to Guest ssid and Check client can get ip > portal    ${5G_Controller_Guest_SSID}
    Verify Client cannot open GUI
    Send Guest Captive Portal Auth 5G
    Verify Client and access to Internet
    [Teardown]    Run Keyword If    '${TEST STATUS}' == 'FAIL'    Check SSID can be scan    ${5G_Controller_Guest_SSID_BSSID}

No.109 Connect to Changed Guest SSID 6G Controller
    [Tags]    Guest    Changed    6G    Controller
    Connect to Guest ssid and Check client can get ip > portal    ${6G_Controller_Guest_SSID}
    Verify Client cannot open GUI
    Send Guest Captive Portal Auth 6G
    Verify Client and access to Internet
    [Teardown]    Run Keyword If    '${TEST STATUS}' == 'FAIL'    Check SSID can be scan    ${6G_Controller_Guest_SSID_BSSID}

Refresh Agent Guest SSID after Controller Changed
    [Tags]    Guest    Changed    Agent    Setup
    SSH To Enable Mesh Agent And Get Guest SSID and BSSID

No.110 Connect to Changed Guest SSID 2G Agent
    [Tags]    Guest    Changed    2G    Agent
    Connect to Guest ssid and Check client can get ip > portal    ${2G_Agent_Guest_SSID}
    Verify Client cannot open GUI
    Send Guest Captive Portal Auth
    Verify Client and access to Internet
    [Teardown]    Run Keyword If    '${TEST STATUS}' == 'FAIL'    Check SSID can be scan    ${2G_Agent_Guest_SSID_BSSID}

No.111 Connect to Changed Guest SSID 5G Agent
    [Tags]    Guest    Changed    5G    Agent
    Connect to Guest ssid and Check client can get ip > portal    ${5G_Agent_Guest_SSID}
    Verify Client cannot open GUI
    Send Guest Captive Portal Auth 5G
    Verify Client and access to Internet
    [Teardown]    Run Keyword If    '${TEST STATUS}' == 'FAIL'    Check SSID can be scan    ${5G_Agent_Guest_SSID_BSSID}

No.112 Connect to Changed Guest SSID 6G Agent
    [Tags]    Guest    Changed    6G    Agent
    Connect to Guest ssid and Check client can get ip > portal    ${6G_Agent_Guest_SSID}
    Verify Client cannot open GUI
    Send Guest Captive Portal Auth 6G
    Verify Client and access to Internet
    [Teardown]    Run Keyword If    '${TEST STATUS}' == 'FAIL'    Check SSID can be scan    ${6G_Agent_Guest_SSID_BSSID}
















































Default Agent and disable switch port
    Default Agent and disable switch port

Check the interface the connect to Jenkins
    Check the interface the connect to Jenkins

*** Keywords ***




Check the Guest setting and enable it
    Login GUI    ${HOST}
    Click Element    xpath=//*[@id="menu_basic_setting"]
    sleep    3
    Click Element    xpath=//*[@id="menu_basic_setting_wlan"]
    sleep    3
    Click Element    xpath=//*[@id="tab_wifi_zone"]
    sleep    3
    ${guest_status}=    Get Element Attribute    id=guest_enable    value    
    Run Keyword If    '${guest_status}' == '0'    Click Guest button

Check Guest Captive Portal status and Disable it
    Login GUI    ${HOST}
    Click Element    xpath=//*[@id="menu_basic_setting"]
    sleep    3
    Click Element    xpath=//*[@id="menu_basic_setting_wlan"]
    sleep    3
    Click Element    xpath=//*[@id="tab_wifi_zone"]
    sleep    5
    ${guest_captive_status}=    Get Element Attribute    id=guest_captive_enable    value
    Run Keyword If    '${guest_captive_status}' == '1'    Click Guest Captive Portal button

Defalut DUT/Agent and No wait setup
    Click Element    xpath=//*[@id="menu_management"]
    sleep    5
    Click Element    xpath=//*[@id="menu_management_settings"]
    sleep    5
    Click Element    xpath=//*[@id="lang_restore_btn"]
    sleep    5
    Click Element    xpath=//*[@id="confirm_dialog_confirmed"]
    sleep    3

Defalut DUT/Agent and Wait setup
    Click Element    xpath=//*[@id="menu_management"]
    sleep    5
    Click Element    xpath=//*[@id="menu_management_settings"]
    sleep    5
    Click Element    xpath=//*[@id="lang_restore_btn"]
    sleep    5
    Click Element    xpath=//*[@id="confirm_dialog_confirmed"]
    sleep    300

Check DUT FW 
    [Arguments]    ${DUT_IP}
    Login GUI    ${DUT_IP}
    ${text} =    Get Text    xpath=//*[@id="dashboard_system_swversion"]
    Log    ${text}
    Close All Browsers

Login Wizard GUI
    [Arguments]    ${DUT_IP}
    Open browser    http://${DUT_IP}    
    sleep    3
    Input Text    xpath=//*[@id="acnt_username"]    admin
    sleep    1
    Input Text    xpath=//*[@id="acnt_passwd"]    admin
    sleep    1
    Click Element    xpath=//*[@id="myButton"]
    sleep    8
    
Check Wizard
    Login Wizard GUI    ${HOST}
    ${result}=  Run Keyword And Return Status    Wait Until Element Is Visible    xpath=//*[@id="lang_have_read_and_agree"]    timeout=10
    Run Keyword If    '${result}'=='True'    Setup Wizard
    Close All Browsers

Setup Wizard
    Wait Until Keyword Succeeds    3x    10s    Retry Setup Wizard

Retry Setup Wizard
    Run Keyword And Ignore Error    Close All Browsers
    Login Wizard GUI    ${HOST}
    Execute Javascript    document.body.style.zoom='0.5'
    Click Element    xpath=//*[@id="lang_have_read_and_agree"]
    sleep    5
    Click Element    xpath=//*[@id="ml_agree"]
    sleep    5
    Click Element    xpath=//*[@id="router-mode-card"]
    Click Element    xpath=//*[@id="ml_next"]
    sleep    5
    Click Element    xpath=//*[@id="ml_next"]
    sleep    5
    Click Element    xpath=//*[@id="ml_next"]
    sleep    5
    Click Element    xpath=//*[@id="switch_layout_enable_mesh_btn"]   
    sleep    5
    Click Element    xpath=//*[@id="ml_next"]
    sleep    5
    Click Element    xpath=//*[@id="ml_next"]
    sleep    5
    Input Text    xpath=//*[@id="new_pwd"]    admin 
    Input Text    xpath=//*[@id="confirm_pwd"]    admin
    Click Element    xpath=//*[@id="ml_next"]
    sleep    5
    Click Element    xpath=//*[@id="ml_apply"]
    sleep    180
    Click Element    xpath=//*[@id="btn_redirect"]
    sleep    5
    Wait Until Element Is Visible    xpath=//*[@id="acnt_username"]    timeout=60
    sleep    120

Restore to ethernet onbording
    Enable the switch port connected to the agent
    sleep    300

Disable the switch port connected to the agent
    ${banner}=    Open Telnet Connection    ${Switch_HOST}    ${Switch_PORT}
    Log To Console    \n--- BANNER ---\n${banner}\n
    ${out}=    telnet_command    ethctl eth0 phy-power down
    Log To Console    \n--- IFCONFIG ---\n${out}\n
    telnet_exec_command

Enable the switch port connected to the agent
    ${banner}=    Open Telnet Connection    ${Switch_HOST}    ${Switch_PORT}
    Log To Console    \n--- BANNER ---\n${banner}\n
    ${out}=    telnet_command    ethctl eth0 phy-power up
    ${out1}=    telnet_command    ethctl eth0 media-type auto
    Log To Console    \n--- IFCONFIG ---\n${out}\n
    Log To Console    \n--- IFCONFIG ---\n${out1}\n
    telnet_exec_command

Disable the switch port connected to the controller
    ${banner}=    Open Telnet Connection    ${Switch_HOST}    ${Switch_PORT}
    Log To Console    \n--- BANNER ---\n${banner}\n
    ${out}=    telnet_command    ethctl eth3 phy-power down
    Log To Console    \n--- IFCONFIG ---\n${out}\n
    telnet_exec_command

Enable the switch port connected to the controller
    ${banner}=    Open Telnet Connection    ${Switch_HOST}    ${Switch_PORT}
    Log To Console    \n--- BANNER ---\n${banner}\n
    ${out}=    telnet_command    ethctl eth3 phy-power up
    ${out1}=    telnet_command    ethctl eth3 media-type auto
    Log To Console    \n--- IFCONFIG ---\n${out}\n
    Log To Console    \n--- IFCONFIG ---\n${out1}\n
    telnet_exec_command

Reboot Agent and No wait setup
    Click Element    xpath=//*[@id="menu_management"]
    sleep    5
    Click Element    xpath=//*[@id="menu_management_reboot"]
    sleep    5
    Click Element    xpath=//*[@id="lang_reboot_btn_title"]
    sleep    3

Release and renew ip on client
    ${output}=	Run    echo ${Client_PASSWORD} | sudo -S dhclient -r
    ${output}=	Run    echo ${Client_PASSWORD} | sudo -S dhclient

Disable Client wired Network
    ${output}=    Run    echo ${Client_PASSWORD} | sudo -S /sbin/ifconfig enp1s0 down

Renew IP
    ${output}=    Run    echo ${Client_PASSWORD} | sudo -S dhclient enp2s0 -r
    ${output}=    Run    echo ${Client_PASSWORD} | sudo -S dhclient enp2s0

Check the interface the connect to Jenkins
    ${output}=    Run    echo ${Client_PASSWORD} | sudo -S ifconfig enp2s0
    ${result}=  Run Keyword And Return Status    Should Contain    ${output}    10.5.163.
    Run Keyword If    '${result}'=='False'    Renew IP


Enable Client wired Network
    ${output}=    Run    echo ${Client_PASSWORD} | sudo -S /sbin/ifconfig enp1s0 up
    ${output}=    Run    echo ${Client_PASSWORD} | sudo -S service NetworkManager start
    ${output}=    Run    echo ${Client_PASSWORD} | sudo -S dhclient enp1s0 -r
    ${output}=    Run    echo ${Client_PASSWORD} | sudo -S ifconfig enp1s0 192.168.1.199 netmask 255.255.255.0
    sleep    60
    # ${output}=    Run    echo ${Client_PASSWORD} | sudo -S dhclient enp1s0
    ${output}=    Run    ping 192.168.1.1 -c 4
    Should Contain    ${output}    ttl=
    
Modify WPA Supplicant Config
    [Arguments]    ${SSID}    ${BSSID}    ${PSK}
    Run Process    echo ${Client_PASSWORD} | sudo -S cp ${ORIG_CONF} ${TMP_CONF}    shell=True
    ${content}=    OperatingSystem.Get File    ${TMP_CONF}
    ${content}=    Replace String Using Regexp    ${content}    ssid=".*?"    ssid="${SSID}"
    ${content}=    Replace String Using Regexp    ${content}    bssid=.*    bssid=${BSSID}
    ${content}=    Replace String Using Regexp    ${content}    psk=".*?"    psk="${PSK}"
    Create File    ${TMP1_CONF}    ${content}
    Run Process    echo ${Client_PASSWORD} | sudo -S cp ${TMP1_CONF} ${ORIG_CONF}    shell=True
    Log    ${ORIG_CONF}

Default Agent and disable switch port
    Wait Until Keyword Succeeds    3x    10s    Retry Default Agent and disable switch port

Retry Default Agent and disable switch port
    [Tags]	Agent
    Get agent ip
    Login GUI    ${Agent_IP}
    Defalut DUT/Agent and No wait setup
    Close All Browsers  
    Disable the switch port connected to the agent

Connect DUT SSID
    [Arguments]    ${SSID_mac}
    Wait Until Keyword Succeeds    3x    10s    Retry Connect DUT SSID    ${SSID_mac}

Retry Connect DUT SSID
    [Arguments]    ${SSID_mac}
    ${output}=	Run    echo ${Client_PASSWORD} | sudo -S service NetworkManager stop
    sleep    10
    ${output}=	Run    echo ${Client_PASSWORD} | sudo -S ip link set ${IFACE} up
    sleep    10
    #Log To Console	${output}
    ${output}=	Run    echo ${Client_PASSWORD} | sudo killall wpa_supplicant
    #Log To Console	${output}
    ${output}=	Run    echo ${Client_PASSWORD} | sudo rm -rf /var/run/wpa_supplicant
    ${output}=	Run    echo ${Client_PASSWORD} | sudo wpa_supplicant -B -i ${IFACE} -c ${conf_PATH} -D nl80211
    ${output}=	Run    echo ${Client_PASSWORD} | sudo wpa_cli -i ${IFACE} pmksa_flush
    #Log To Console	${output}
    Sleep          15
    ${output}=     Run    iw ${IFACE} link    
    Log            ${output}
    sleep   3
    Should Contain    ${output}    Connected to ${SSID_mac}
    Run    echo ${Client_PASSWORD} | sudo dhclient ${IFACE}
    Sleep          3s

Change SSID, Authentication and Key
    Click Element    xpath=//*[@id="menu_basic_setting"]
    sleep    3
    Click Element    xpath=//*[@id="menu_basic_setting_wlan"]
    sleep    3
    Execute Javascript    document.body.style.zoom='0.2'
    Input Text    xpath=//*[@id="2g_ssid"]    ${Changed_2G_SSID}
    sleep    3
    Input Text    xpath=//*[@id="2g_wpa_key"]    ${Changed_SSID_PSK}
    sleep    3
    Select From List By Value    id=authtype_2g    wpa3
    Input Text    xpath=//*[@id="5g_ssid"]    ${Changed_5G_SSID}
    sleep    3
    Input Text    xpath=//*[@id="5g_wpa_key"]    ${Changed_SSID_PSK}
    sleep    3
    Select From List By Value    id=authtype_5g    wpa3
    Input Text    xpath=//*[@id="6g_ssid"]    ${Changed_6G_SSID}
    sleep    3
    Input Text    xpath=//*[@id="6g_wpa_key"]    ${Changed_SSID_PSK}
    sleep    3
    Select From List By Value    id=authtype_6g    wpa3
    Click Element    xpath=//*[@id="apply"]
    sleep    300

Modify WPA Supplicant wpa3 Config
    [Arguments]    ${SSID}    ${BSSID}    ${PSK}
    Run Process    echo ${Client_PASSWORD} | sudo -S cp ${ORIG_wpa3_CONF} ${TMP_CONF}    shell=True
    ${content}=    OperatingSystem.Get File    ${TMP_CONF}
    ${content}=    Replace String Using Regexp    ${content}    ssid=".*?"    ssid="${SSID}"
    ${content}=    Replace String Using Regexp    ${content}    bssid=.*    bssid=${BSSID}
    ${content}=    Replace String Using Regexp    ${content}    psk=".*?"    psk="${PSK}"
    Create File    ${TMP1_wpa3_CONF}    ${content}
    Run Process    echo ${Client_PASSWORD} | sudo -S cp ${TMP1_wpa3_CONF} ${ORIG_wpa3_CONF}    shell=True
    Log    ${ORIG_wpa3_CONF}

Connect DUT wpa3 SSID
    [Arguments]    ${SSID_mac}
    Wait Until Keyword Succeeds    5x    10s    Retry Connect DUT wpa3 SSID    ${SSID_mac}

Retry Connect DUT wpa3 SSID
    [Arguments]    ${SSID_mac}
    ${output}=	Run    echo ${Client_PASSWORD} | sudo -S service NetworkManager stop
    sleep    10
    ${output}=	Run    echo ${Client_PASSWORD} | sudo -S ip link set ${IFACE} up
    sleep    10
    #Log To Console	${output}
    ${output}=	Run    echo ${Client_PASSWORD} | sudo killall wpa_supplicant
    #Log To Console	${output}
    ${output}=	Run    echo ${Client_PASSWORD} | sudo rm -rf /var/run/wpa_supplicant
    ${output}=	Run    echo ${Client_PASSWORD} | sudo wpa_supplicant -B -i ${IFACE} -c ${conf_wpa3_PATH} -D nl80211
    ${output}=	Run    echo ${Client_PASSWORD} | sudo wpa_cli -i ${IFACE} pmksa_flush
    #Log To Console	${output}
    Sleep          15
    ${output}=     Run    iw ${IFACE} link    
    Log            ${output}
    sleep   3
    Should Contain    ${output}    Connected to ${SSID_mac}
    #Run    echo ${Client_PASSWORD} | sudo dhclient ${IFACE}
    Run    echo ${Client_PASSWORD} | sudo ifconfig ${IFACE} 192.168.1.198 netmask 255.255.255.0
    Sleep          3

Connect to ssid and ping controller and agent
    [Arguments]    ${SSID_mac}
    Connect DUT wpa3 SSID    ${SSID_mac}
    ping controller
    ping agent
    
ping agent
    Wait Until Keyword Succeeds    3x    30s    Retry ping agent

ping controller 
    Wait Until Keyword Succeeds    3x    30s    Retry ping controller

Retry ping controller 
    ${output}=     Run    ifconfig ${IFACE}
    Should Contain    ${output}    192.168.1.
    # ${output}=    Run    ping 8.8.8.8 -c 4
    # Should Contain    ${output}    ttl=
    ${output}=    Run    ping -I ${IFACE} 192.168.1.1 -c 10
    Should Contain    ${output}    ttl=

Retry ping agent
    ${output}=     Run    ifconfig ${IFACE}
    Should Contain    ${output}    192.168.1.
    # ${output}=    Run    ping 8.8.8.8 -c 4
    # Should Contain    ${output}    ttl=
    ${output}=    Run    ping -I ${IFACE} ${Agent_IP} -c 10
    Should Contain    ${output}    ttl=

Login GUI
    [Arguments]    ${DUT_IP}
    Open browser    http://${DUT_IP}    
    sleep    3
    Input Text    xpath=//*[@id="acnt_username"]    admin
    sleep    1
    Input Text    xpath=//*[@id="acnt_passwd"]    admin
    sleep    1
    Click Element    xpath=//*[@id="myButton"]
    sleep    30
    Wait Until Element Is Visible    xpath=//*[@id="menu_dashboard"]    timeout=60
    Execute Javascript    document.body.style.zoom='0.5'
    sleep    1

Get agent ip
    Wait Until Keyword Succeeds    3x    10s    Retry Get agent ip

Retry Get agent ip
    Run Keyword And Ignore Error    Close All Browsers
    Login GUI    ${HOST} 
    Click Element    xpath=//*[@id="menu_status"]
    sleep    3
    Click Element    xpath=//*[@id="menu_status_wifiMesh"]
    sleep    20
    ${Agent_IP} =    Get Text    xpath=//*[@id="Mesh_topology_table_id_1"]/td[2]
    sleep    3
    Set Suite Variable    ${Agent_IP}
    Close All Browsers

Check agent is wireless onboarding
    Login GUI    ${HOST} 
    Click Element    xpath=//*[@id="menu_status"]
    sleep    3
    Click Element    xpath=//*[@id="menu_status_wifiMesh"]
    sleep    20
    ${value} =    Get Text    xpath=//*[@id="Mesh_topology_table_id_1"]/td[5]
    Should Contain    ${value}    WLAN
    Close All Browsers

SSH To Controller And Get default wifi password
    Wait Until Keyword Succeeds    3x    10s    Retry SSH To Controller And Get default wifi password

Retry SSH To Controller And Get default wifi password
    Run Keyword And Ignore Error    Close All Connections
    Open Connection    ${HOST}
    Login              ${USER}    ${SSH_PASSWORD}
    ${Default_PSK} =    Execute Command    cat /etc/config/wireless | grep -m1 "option key" | awk -F 'option key ' '{print $2}' | tr -d "'"
    ${2G_Guest_SSID} =    Execute Command    iwconfig ath0 | grep 'ESSID' | awk -F 'ESSID:' '{print $2}' | tr -d '" '
    Set Suite Variable    ${Default_PSK}
    Log    Default SSID PSK: ${Default_PSK}
    Close Connection

Check SSID can be scan 
    [Arguments]    ${mac}
    ${output}=    Run    echo ${Client_PASSWORD} | sudo iw dev ${IFACE} scan | grep -F -A 100 "BSS ${mac}"
    sleep    5
    ${output}=    Run    echo ${Client_PASSWORD} | sudo iw dev ${IFACE} scan | grep -F -A 100 "BSS ${mac}"
    sleep    5
    ${output}=    Run    echo ${Client_PASSWORD} | sudo iw dev ${IFACE} scan | grep -F -A 100 "BSS ${mac}"
    sleep    5
    ${output}=    Run    echo ${Client_PASSWORD} | sudo iw dev ${IFACE} scan | grep -F -A 100 "BSS ${mac}"
    sleep    5
    ${output}=    Run    echo ${Client_PASSWORD} | sudo iw dev ${IFACE} scan | grep -F -A 100 "BSS ${mac}"
    sleep    5

Enable SSH 
    Wait Until Keyword Succeeds    3x    10s    Retry Enable SSH 

Retry Enable SSH
    Run Keyword And Ignore Error    Close All Browsers   
    Login GUI    ${HOST}
    Click Element    xpath=//*[@id="menu_adv_setting"]
    sleep    5
    Click Element    xpath=//*[@id="menu_adv_setting_ssh"]
    sleep    15
    ${status}=    Get Element Attribute    id=ssh_enabled    value
    Run Keyword If    '${status}' == '0'    Click ssh button

Click ssh button    
    Click Element    xpath=//*[@id="switch_layout_ssh_enabled"]
    sleep    5
    Click Element    xpath=//*[@id="apply"]
    sleep    5
    Handle Alert
    sleep    30
    Close All Browsers  

Enable Agent SSH 
    Wait Until Keyword Succeeds    3x    10s    Retry Enable Agent SSH

Retry Enable Agent SSH
    Run Keyword And Ignore Error    Close All Browsers
    Login GUI    ${Agent_IP}
    Click Element    xpath=//*[@id="menu_adv_setting"]
    sleep    5
    Click Element    xpath=//*[@id="menu_adv_setting_ssh"]
    sleep    15
    Click Element    xpath=//*[@id="switch_layout_ssh_enabled"]
    sleep    5
    Click Element    xpath=//*[@id="apply"]
    sleep    5
    Run Keyword And Ignore Error	Handle Alert
    sleep    30
    Close All Browsers  

Set DUT 5G and 6G channel to be scannable
    Wait Until Keyword Succeeds    3x    10s    Retry Set DUT 5G and 6G channel to be scannable

Retry Set DUT 5G and 6G channel to be scannable
    Run Keyword And Ignore Error    Close All Browsers
    Login GUI    ${HOST}
    Click Element    xpath=//*[@id="menu_basic_setting"]
    sleep    3
    Click Element    xpath=//*[@id="menu_basic_setting_wlan"]
    sleep    3
    Click Element    xpath=//*[@id="tab_wifi_adv_allinone"]
    sleep    3
    Execute Javascript    document.body.style.zoom='0.2'
    Select From List By Value    id=wifi_channel_select5    40
    Select From List By Value    id=wifi_channel_select6    1
    Click Element    xpath=//*[@id="apply"]
    sleep    180
    Close All Browsers

Enable MLO
    Click Element    xpath=//*[@id="menu_basic_setting"]
    sleep    3
    Click Element    xpath=//*[@id="menu_basic_setting_wlan"]
    sleep    3
    Click Element    xpath=//*[@id="switch_layout_MLO_enable"]
    sleep    3
    Click Element    xpath=//*[@id="apply"]
    sleep    180

Change common/MLO SSID, Authentication and Key
    Click Element    xpath=//*[@id="menu_basic_setting"]
    sleep    3
    Click Element    xpath=//*[@id="menu_basic_setting_wlan"]
    sleep    3
    Input Text    xpath=//*[@id="commong_ssid"]    ${Changed_SSID}
    sleep    3
    Input Text    xpath=//*[@id="commong_wpa_key"]    ${Changed_PSK}
    sleep    3
    Select From List By Value    id=authtype_commong    mixed3
    sleep    3
    Click Element    xpath=//*[@id="apply"]
    sleep    300
    
Set DUT 6G channel to 53
    Execute Javascript    document.body.style.zoom='0.2'
    sleep    5
    Click Element    xpath=//*[@id="menu_basic_setting"]
    sleep    3
    Click Element    xpath=//*[@id="menu_basic_setting_wlan"]
    sleep    3
    Click Element    xpath=//*[@id="tab_wifi_adv_allinone"]
    sleep    3
    Select From List By Value    id=wifi_channel_select6    45
    Click Element    xpath=//*[@id="apply"]
    sleep    180

SSH To Enable Mesh Agent And Get all MLO SSID and BSSID
    Wait Until Keyword Succeeds    3x    10s    Retry SSH To Enable Mesh Agent And Get all MLO SSID and BSSID

Retry SSH To Enable Mesh Agent And Get all MLO SSID and BSSID
    Run Keyword And Ignore Error    Close All Connections
    Open Connection    ${Agent_IP}
    Login              ${USER}    ${SSH_PASSWORD}

    ${2G_Agent_SSID} =    Execute Command    iw dev | grep -A5 "Interface mld4" | awk '/ssid/{print $2}'
    ${2G_Agent_SSID_BSSID} =    Execute Command    iw dev mld4 info | awk '/link 0:/{getline; print $2}'
    Should Not Be Equal    ${2G_Agent_SSID_BSSID}    ${EMPTY}
    ${2G_channel} =    Execute Command    iw dev mld4 info | grep channel
    ${2G_Agent_SSID_BSSID}=    Convert To Lower Case    ${2G_Agent_SSID_BSSID}
    Set Suite Variable    ${2G_Agent_SSID}
    Set Suite Variable    ${2G_Agent_SSID_BSSID}

    ${5G_Agent_SSID} =    Execute Command    iw dev | grep -A5 "Interface mld2" | awk '/ssid/{print $2}'
    ${5G_Agent_SSID_BSSID} =    Execute Command    iw dev mld2 info | awk '/link 1:/{getline; print $2}'
    Should Not Be Equal    ${5G_Agent_SSID_BSSID}    ${EMPTY}
    ${5G_channel} =    Execute Command    iw dev mld2 info | grep channel
    ${5G_Agent_SSID_BSSID}=    Convert To Lower Case    ${5G_Agent_SSID_BSSID}
    Set Suite Variable    ${5G_Agent_SSID}
    Set Suite Variable    ${5G_Agent_SSID_BSSID}

    ${6G_Agent_SSID} =    Execute Command    iw dev | grep -A5 "Interface mld2" | awk '/ssid/{print $2}'
    ${6G_Agent_SSID_BSSID} =    Execute Command    iw dev mld2 info | awk '/link 2:/{getline; print $2}'
    Should Not Be Equal    ${6G_Agent_SSID_BSSID}    ${EMPTY}
    ${6G_channel} =    Execute Command    iw dev mld2 info | grep channel
    ${6G_Agent_SSID_BSSID}=    Convert To Lower Case    ${6G_Agent_SSID_BSSID}
    Set Suite Variable    ${6G_Agent_SSID}
    Set Suite Variable    ${6G_Agent_SSID_BSSID}

    Close Connection

SSH To Enable Mesh Agent And Get all Common/disable common SSID and BSSID
    Wait Until Keyword Succeeds    3x    10s    Retry SSH To Enable Mesh Agent And Get all Common/disable common SSID and BSSID

Retry SSH To Enable Mesh Agent And Get all Common/disable common SSID and BSSID
    Run Keyword And Ignore Error    Close All Connections
    Open Connection    ${Agent_IP}
    Login              ${USER}    ${SSH_PASSWORD}

    ${2G_Agent_SSID_BSSID} =    Execute Command    iw dev mld3 info | awk '/link 0:/{getline; print $2}'
    ${2G_Agent_SSID} =    Execute Command    iw dev | grep -A5 "Interface mld3" | awk '/ssid/{print $2}'
    Should Not Be Equal    ${2G_Agent_SSID_BSSID}    ${EMPTY}
    ${2G_channel} =    Execute Command    iw dev mld3 info | grep channel
    ${2G_Agent_SSID_BSSID}=    Convert To Lower Case    ${2G_Agent_SSID_BSSID}
    Set Suite Variable    ${2G_Agent_SSID}
    Set Suite Variable    ${2G_Agent_SSID_BSSID}

    ${5G_Agent_SSID_BSSID} =    Execute Command    iw dev mld5 info | awk '/link 1:/{getline; print $2}'
    ${5G_Agent_SSID} =    Execute Command    iw dev | grep -A5 "Interface mld5" | awk '/ssid/{print $2}'
    Should Not Be Equal    ${5G_Agent_SSID_BSSID}    ${EMPTY}
    ${5G_channel} =    Execute Command    iw dev mld5 info | grep channel
    ${5G_Agent_SSID_BSSID}=    Convert To Lower Case    ${5G_Agent_SSID_BSSID}
    Set Suite Variable    ${5G_Agent_SSID}
    Set Suite Variable    ${5G_Agent_SSID_BSSID}

    ${6G_Agent_SSID_BSSID} =    Execute Command    iw dev mld7 info | awk '/link 2:/{getline; print $2}'
    ${6G_Agent_SSID} =    Execute Command    iw dev | grep -A5 "Interface mld7" | awk '/ssid/{print $2}'
    Should Not Be Equal    ${6G_Agent_SSID_BSSID}    ${EMPTY}
    ${6G_channel} =    Execute Command    iw dev mld7 info | grep channel
    ${6G_Agent_SSID_BSSID}=    Convert To Lower Case    ${6G_Agent_SSID_BSSID}
    Set Suite Variable    ${6G_Agent_SSID}
    Set Suite Variable    ${6G_Agent_SSID_BSSID}

    Close Connection

Disable MLO and common ssid
    Click Element    xpath=//*[@id="menu_basic_setting"]
    sleep    3
    Click Element    xpath=//*[@id="menu_basic_setting_wlan"]
    sleep    3
    Wait Until Element Is Visible    xpath=//*[@id="switch_layout_single_ssid_enable"]    timeout=30
    Click Element    xpath=//*[@id="switch_layout_single_ssid_enable"]
    sleep    3
    Execute Javascript    document.body.style.zoom='0.2'
    sleep    5
    Click Element    xpath=//*[@id="apply"]
    sleep    180

Check Agent can connect to Controller
    Wait Until Keyword Succeeds    3x    30s    Retry Check Agent can connect to Controller

Retry Check Agent can connect to Controller
    Run Keyword And Ignore Error    Close All Browsers
    Login GUI    ${HOST}
    Click Element    xpath=//*[@id="menu_status"]
    sleep    3
    Click Element    xpath=//*[@id="menu_status_wifiMesh"]
    sleep    20
    ${Agent_Status} =    Get Text    xpath=//*[@id="Mesh_topology_table_id_1"]/td[3]
    Should Contain    ${Agent_Status}    Online
    Close All Browsers

SSH To Enable Mesh Router And Get all Common/disable common SSID and BSSID
    Wait Until Keyword Succeeds    3x    10s    Retry SSH To Enable Mesh Router And Get all Common/disable common SSID and BSSID

Retry SSH To Enable Mesh Router And Get all Common/disable common SSID and BSSID
    Run Keyword And Ignore Error    Close All Connections
    Open Connection    ${HOST}
    Login              ${USER}    ${SSH_PASSWORD}

    ${2G_SSID_BSSID} =    Execute Command    iw dev mld0 info | awk '/link 0:/{getline; print $2}'
    ${2G_SSID} =    Execute Command    iw dev | grep -A5 "Interface mld0" | awk '/ssid/{print $2}'
    Should Not Be Equal    ${2G_SSID_BSSID}    ${EMPTY}
    ${2G_channel} =    Execute Command    iw dev mld0 info | grep channel
    ${2G_SSID_BSSID}=    Convert To Lower Case    ${2G_SSID_BSSID}
    Set Suite Variable    ${2G_SSID}
    Set Suite Variable    ${2G_SSID_BSSID}

    ${5G_SSID_BSSID} =    Execute Command    iw dev mld2 info | awk '/link 1:/{getline; print $2}'
    ${5G_SSID} =    Execute Command    iw dev | grep -A5 "Interface mld2" | awk '/ssid/{print $2}'
    Should Not Be Equal    ${5G_SSID_BSSID}    ${EMPTY}
    ${5G_channel} =    Execute Command    iw dev mld2 info | grep channel
    ${5G_SSID_BSSID}=    Convert To Lower Case    ${5G_SSID_BSSID}
    Set Suite Variable    ${5G_SSID}
    Set Suite Variable    ${5G_SSID_BSSID}

    ${6G_SSID_BSSID} =    Execute Command    iw dev mld4 info | awk '/link 2:/{getline; print $2}'
    ${6G_SSID} =    Execute Command    iw dev | grep -A5 "Interface mld4" | awk '/ssid/{print $2}'
    Should Not Be Equal    ${6G_SSID_BSSID}    ${EMPTY}
    ${6G_channel} =    Execute Command    iw dev mld4 info | grep channel
    ${6G_SSID_BSSID}=    Convert To Lower Case    ${6G_SSID_BSSID}
    Set Suite Variable    ${6G_SSID}
    Set Suite Variable    ${6G_SSID_BSSID}

    Close All Connections

SSH To Enable Mesh Router And Get all MLO SSID and BSSID
    Wait Until Keyword Succeeds    3x    10s    Retry SSH To Enable Mesh Router And Get all MLO SSID and BSSID

Retry SSH To Enable Mesh Router And Get all MLO SSID and BSSID
    Run Keyword And Ignore Error    Close All Connections
    Open Connection    ${HOST}
    Login              ${USER}    ${SSH_PASSWORD}

    ${2G_SSID} =    Execute Command    iw dev | grep -A5 "Interface mld2" | awk '/ssid/{print $2}'
    ${2G_SSID_BSSID} =    Execute Command    iw dev mld2 info | awk '/link 0:/{getline; print $2}'
    Should Not Be Equal    ${2G_SSID_BSSID}    ${EMPTY}
    ${2G_channel} =    Execute Command    iw dev mld2 info | grep channel
    ${2G_SSID_BSSID}=    Convert To Lower Case    ${2G_SSID_BSSID}
    Set Suite Variable    ${2G_SSID}
    Set Suite Variable    ${2G_SSID_BSSID}

    ${5G_SSID} =    Execute Command    iw dev | grep -A5 "Interface mld1" | awk '/ssid/{print $2}'
    ${5G_SSID_BSSID} =    Execute Command    iw dev mld1 info | awk '/link 1:/{getline; print $2}'
    Should Not Be Equal    ${5G_SSID_BSSID}    ${EMPTY}
    ${5G_channel} =    Execute Command    iw dev mld1 info | grep channel
    ${5G_SSID_BSSID}=    Convert To Lower Case    ${5G_SSID_BSSID}
    Set Suite Variable    ${5G_SSID}
    Set Suite Variable    ${5G_SSID_BSSID}

    ${6G_SSID} =    Execute Command    iw dev | grep -A5 "Interface mld1" | awk '/ssid/{print $2}'
    ${6G_SSID_BSSID} =    Execute Command    iw dev mld1 info | awk '/link 2:/{getline; print $2}'
    Should Not Be Equal    ${6G_SSID_BSSID}    ${EMPTY}
    ${6G_channel} =    Execute Command    iw dev mld1 info | grep channel
    ${6G_SSID_BSSID}=    Convert To Lower Case    ${6G_SSID_BSSID}
    Set Suite Variable    ${6G_SSID}
    Set Suite Variable    ${6G_SSID_BSSID}

    Close Connection

Reset WiFi Interface
    Run    echo ${Client_PASSWORD} | sudo pkill -f wpa_supplicant || true
    Run    echo ${Client_PASSWORD} | sudo pkill -f dhclient || true
    Run    echo ${Client_PASSWORD} | sudo rm -rf /var/run/wpa_supplicant
    Run    echo ${Client_PASSWORD} | sudo ip link set ${IFACE} down
    Sleep    2s
    Run    echo ${Client_PASSWORD} | sudo ip addr flush dev ${IFACE}
    Run    echo ${Client_PASSWORD} | sudo ip link set ${IFACE} up
    Sleep    2s

Check Mesh connection status
    Click Element    xpath=//*[@id="menu_status"]
    sleep    3
    Click Element    xpath=//*[@id="menu_status_wifiMesh"]
    sleep    3
    ${Agent} =    Get Text    xpath=//*[@id="Mesh_topology_table_id_1"]/td[1]
    sleep    3
    Should Contain    ${Agent}    WREQ-130BE-
    ${Type} =    Get Text    xpath=//*[@id="Mesh_topology_table_id_1"]/td[5]
    sleep    3
    Should Contain    ${Type}    	ETHER
    ${Role} =    Get Text    xpath=//*[@id="Mesh_topology_table_id_1"]/td[6]
    sleep    3
    Should Contain    ${Role}    	Agent

Scan SSID on client 
    ${result}=    Run    echo ${Client_PASSWORD} | sudo iw dev ${IFACE} scan | grep -E 'SSID|BSS'
    Log To Console    ${result}
    Should Contain    ${result}   	${2G_SSID}    
    Should Contain    ${result}    	${2G_SSID_BSSID}
    Should Contain    ${result}   	${5G_SSID}    
    Should Contain    ${result}    	${5G_SSID_BSSID}
    Should Contain    ${result}   	${6G_SSID}    
    # Should Contain    ${result}    	${6G_SSID_BSSID}
    Should Contain    ${result}   	${2G_Agent_SSID}    
    Should Contain    ${result}    	${2G_Agent_SSID_BSSID}
    Should Contain    ${result}   	${5G_Agent_SSID}    
    Should Contain    ${result}    	${5G_Agent_SSID_BSSID}
    Should Contain    ${result}   	${6G_Agent_SSID}    
    # Should Contain    ${result}    	${6G_Agent_SSID_BSSID}
    
Disable Guest
    Login GUI    ${HOST}
    Click Element    xpath=//*[@id="menu_basic_setting"]
    sleep    3
    Click Element    xpath=//*[@id="menu_basic_setting_wlan"]
    sleep    3
    Click Element    xpath=//*[@id="tab_wifi_zone"]
    sleep    3
    Click Element    xpath=//*[@id="switch_layout_guest_enable"]
    sleep    3
    Click Element    xpath=//*[@id="apply"]
    sleep    300
    Close All Browsers   

###============================================================================
### 以下為從 Wifi_Zone.robot 補充的 63 個 Keywords（在 WiFi_Zone_Mesh.robot 中缺失的）
###============================================================================

### ===== Employee SSID 相關 Keywords =====
Connect DUT employee SSID
    [Arguments]    ${SSID_mac}
    ${output}=	Run    echo ${Client_PASSWORD} | sudo -S service NetworkManager stop
    sleep    10
    ${output}=	Run    echo ${Client_PASSWORD} | sudo killall wpa_supplicant
    ${output}=	Run    echo ${Client_PASSWORD} | sudo rm -rf /var/run/wpa_supplicant
    Change client mac
    ${output}=	Run    echo ${Client_PASSWORD} | sudo wpa_supplicant -B -i ${IFACE} -c ${conf_employee_PATH} -D nl80211
    ${output}=	Run    echo ${Client_PASSWORD} | sudo wpa_cli -i ${IFACE} pmksa_flush
    Sleep          15
    ${output}=     Run    iw ${IFACE} link    
    Log            ${output}
    sleep   3
    Should Contain    ${output}    Connected to ${SSID_mac}
    Run    echo ${Client_PASSWORD} | sudo dhclient ${IFACE}
    Sleep          3

Connect DUT open SSID > portal
    [Arguments]    ${SSID_mac}
    ${output}=	Run    echo ${Client_PASSWORD} | sudo -S service NetworkManager stop
    sleep    10
    ${output}=	Run    echo ${Client_PASSWORD} | sudo killall wpa_supplicant
    ${output}=	Run    echo ${Client_PASSWORD} | sudo rm -rf /var/run/wpa_supplicant
    Change client mac
    ${output}=	Run    echo ${Client_PASSWORD} | sudo wpa_supplicant -B -i ${IFACE} -c ${conf_open_PATH} -D nl80211
    ${output}=	Run    echo ${Client_PASSWORD} | sudo wpa_cli -i ${IFACE} pmksa_flush
    Sleep          15
    ${output}=     Run    iw ${IFACE} link    
    Log            ${output}
    sleep   3
    Should Contain    ${output}    Connected to ${SSID_mac}
    Run    echo ${Client_PASSWORD} | sudo dhclient ${IFACE}
    Sleep          3

Connect DUT open SSID
    [Arguments]    ${SSID_mac}
    ${output}=	Run    echo ${Client_PASSWORD} | sudo -S service NetworkManager stop
    sleep    10
    ${output}=	Run    echo ${Client_PASSWORD} | sudo killall wpa_supplicant
    ${output}=	Run    echo ${Client_PASSWORD} | sudo rm -rf /var/run/wpa_supplicant
    Change client mac
    ${output}=	Run    echo ${Client_PASSWORD} | sudo wpa_supplicant -B -i ${IFACE} -c ${conf_open_PATH} -D nl80211
    ${output}=	Run    echo ${Client_PASSWORD} | sudo wpa_cli -i ${IFACE} pmksa_flush
    Sleep          15
    ${output}=     Run    iw ${IFACE} link    
    Log            ${output}
    sleep   3
    Should Contain    ${output}    Connected to ${SSID_mac}
    Run    echo ${Client_PASSWORD} | sudo dhclient ${IFACE}
    Sleep          3

Modify WPA Supplicant employee Config
    [Arguments]    ${SSID}    ${BSSID}    ${PSK}
    Run Process    echo ${Client_PASSWORD} | sudo -S cp ${ORIG_employee_CONF} ${TMP_CONF}    shell=True
    ${content}=    OperatingSystem.Get File    ${TMP_CONF}
    ${content}=    Replace String Using Regexp    ${content}    ssid=".*?"    ssid="${SSID}"
    ${content}=    Replace String Using Regexp    ${content}    bssid=.*    bssid=${BSSID}
    ${content}=    Replace String Using Regexp    ${content}    psk=".*?"    psk="${PSK}"
    Create File    ${TMP1_employee_CONF}    ${content}
    Run Process    echo ${Client_PASSWORD} | sudo -S cp ${TMP1_employee_CONF} ${ORIG_employee_CONF}    shell=True
    Log    ${ORIG_employee_CONF}

Modify WPA Supplicant Open Config
    [Arguments]    ${SSID}    ${BSSID}   
    Run Process    echo ${Client_PASSWORD} | sudo -S cp ${ORIG_open_CONF} ${TMP_CONF}    shell=True
    ${content}=    OperatingSystem.Get File    ${TMP_CONF}
    ${content}=    Replace String Using Regexp    ${content}    ssid=".*?"    ssid="${SSID}"
    ${content}=    Replace String Using Regexp    ${content}    bssid=.*    bssid=${BSSID}
    Create File    ${TMP1_open_CONF}    ${content}
    Run Process    echo ${Client_PASSWORD} | sudo -S cp ${TMP1_open_CONF} ${ORIG_open_CONF}    shell=True
    Log    ${ORIG_open_CONF}

Connect to Guest ssid and Check client can get ip
    [Arguments]    ${SSID}
    Wait Until Keyword Succeeds    3x    10s    Reconnect to Guest and Check client can get ip    ${SSID}

Reconnect to Guest and Check client can get ip
    [Arguments]    ${SSID}
    Connect DUT open SSID    ${SSID}
    Check client can get ip with Guest ssid

Check client can get ip with Guest ssid
    Wait Until Keyword Succeeds    3x    10s    Retry Check client can get ip with Guest ssid

Retry Check client can get ip with Guest ssid
    ${output}=     Run    ifconfig ${IFACE}
    Should Contain    ${output}    192.168.20.
    
Connect to Guest ssid and Check client can get ip > portal
    [Arguments]    ${SSID}
    Wait Until Keyword Succeeds    3x    10s    Reconnect to Guest and Check client can get ip > portal    ${SSID}

Reconnect to Guest and Check client can get ip > portal
    [Arguments]    ${SSID}
    Connect DUT open SSID > portal    ${SSID}
    Check client can get ip with Guest ssid > portal

Check client can get ip with Guest ssid > portal
    Wait Until Keyword Succeeds    3x    10s    Retry Check client can get ip with Guest ssid > portal

Retry Check client can get ip with Guest ssid > portal
    ${output}=     Run    ifconfig ${IFACE}
    Should Contain    ${output}    192.168.182.

Verify Client and access to Internet  
    ${output}=    Run    ping 8.8.8.8 -I ${IFACE} -c 4
    Should Contain    ${output}    ttl=
  
Verify Client cannot open GUI  
    ${output}=    Run Keyword And Return Status    Login GUI    ${HOST}
    Run Keyword And Ignore Error    Close All Browsers
    Run Keyword If    '${output}'=='True'    Fail    Client can open GUI

Change client mac
    ${output}=	Run    echo ${Client_PASSWORD} | sudo -S macchanger -r ${IFACE}
  
Restore client mac
    ${output}=	Run    echo ${Client_PASSWORD} | sudo -S macchanger -p ${IFACE}

Connect to Employee ssid and Check client can get ip > portal
    [Arguments]    ${SSID}
    Wait Until Keyword Succeeds    3x    10s    Reconnect to Employee and Check client can get ip > portal    ${SSID}

Reconnect to Employee and Check client can get ip > portal
    [Arguments]    ${SSID}
    Connect DUT employee SSID    ${SSID}
    Check client can get ip with Employee ssid > portal

Check client can get ip with Employee ssid > portal
    Wait Until Keyword Succeeds    3x    10s    Retry Check client can get ip with Employee ssid > portal

Retry Check client can get ip with Employee ssid > portal
    ${output}=     Run    ifconfig ${IFACE}
    Should Contain    ${output}    192.168.183.  
    
Connect to Employee ssid and Check client can get ip
    [Arguments]    ${SSID}
    Wait Until Keyword Succeeds    3x    10s    Reconnect to Employee and Check client can get ip    ${SSID}

Reconnect to Employee and Check client can get ip
    [Arguments]    ${SSID}
    Connect DUT employee SSID    ${SSID}
    Check client can get ip with Employee ssid

Check client can get ip with Employee ssid
    Wait Until Keyword Succeeds    3x    10s    Retry Check client can get ip with Employee ssid

Retry Check client can get ip with Employee ssid
    ${output}=     Run    ifconfig ${IFACE}
    Should Contain    ${output}    192.168.30.

Enable Guest and Guest Captive Portal
    Login GUI    ${HOST}
    Click Element    xpath=//*[@id="menu_basic_setting"]
    sleep    3
    Click Element    xpath=//*[@id="menu_basic_setting_wlan"]
    sleep    3
    Click Element    xpath=//*[@id="tab_wifi_zone"]
    sleep    5
    ${guest_status}=    Get Element Attribute    id=guest_enable    value    
    Run Keyword If    '${guest_status}' == '0'    Click Element    xpath=//*[@id="switch_layout_guest_enable"]
    ${guest_captive_status}=    Get Element Attribute    id=guest_captive_enable    value
    Run Keyword If    '${guest_captive_status}' == '0'    Click Element    xpath=//*[@id="switch_layout_guest_captive_enable"]
    sleep    3
    Click Element    xpath=//*[@id="apply"]
    sleep    300   
    Close All Browsers 

Change Guest SSID
    Login GUI    ${HOST}
    Click Element    xpath=//*[@id="menu_basic_setting"]
    sleep    3
    Click Element    xpath=//*[@id="menu_basic_setting_wlan"]
    sleep    3
    Click Element    xpath=//*[@id="tab_wifi_zone"]
    sleep    5
    Input Text    xpath=//*[@id="guest_ssid"]    Guest_123456789012345
    sleep    3
    Click Element    xpath=//*[@id="apply"]
    sleep    300
    Close All Browsers

Change Employee SSID and password
    Login GUI    ${HOST}
    Click Element    xpath=//*[@id="menu_basic_setting"]
    sleep    3
    Click Element    xpath=//*[@id="menu_basic_setting_wlan"]
    sleep    3
    Click Element    xpath=//*[@id="tab_wifi_zone"]
    sleep    5
    Input Text    xpath=//*[@id="employee_ssid"]    Employee_123456789012345
    sleep    3
    Input Text    xpath=//*[@id="employee_wpa_key"]    123456789012345678901234567890121234567890123456789012345678901
    sleep    3
    Click Element    xpath=//*[@id="apply"]
    sleep    300   
    Close All Browsers 

Check the Guest setting and disable it
    Login GUI    ${HOST}
    Click Element    xpath=//*[@id="menu_basic_setting"]
    sleep    3
    Click Element    xpath=//*[@id="menu_basic_setting_wlan"]
    sleep    3
    Click Element    xpath=//*[@id="tab_wifi_zone"]
    sleep    5
    ${guest_status}=    Get Element Attribute    id=guest_enable    value
    Run Keyword If    '${guest_status}' == '1'    Click Guest button

Click Guest button
    Click Element    xpath=//*[@id="switch_layout_guest_enable"]
    sleep    3
    Click Element    xpath=//*[@id="apply"]
    sleep    300
    Close All Browsers

Enable Guest Captive Portal   
    Login GUI    ${HOST}
    Click Element    xpath=//*[@id="menu_basic_setting"]
    sleep    3
    Click Element    xpath=//*[@id="menu_basic_setting_wlan"]
    sleep    3
    Click Element    xpath=//*[@id="tab_wifi_zone"]
    sleep    5
    ${guest_captive_status}=    Get Element Attribute    id=guest_captive_enable    value
    Run Keyword If    '${guest_captive_status}' == '0'    Click Guest Captive Portal button

Click Guest Captive Portal button
    Click Element    xpath=//*[@id="switch_layout_guest_captive_enable"]
    sleep    3
    Click Element    xpath=//*[@id="apply"]
    sleep    300   
    Close All Browsers 

Disable Employee 
    Login GUI    ${HOST}
    Click Element    xpath=//*[@id="menu_basic_setting"]
    sleep    3
    Click Element    xpath=//*[@id="menu_basic_setting_wlan"]
    sleep    3
    Click Element    xpath=//*[@id="tab_wifi_zone"]
    sleep    5
    ${guest_captive_status}=    Get Element Attribute    id=employee_enable    value  
    Run Keyword If    '${guest_captive_status}' == '1'    Click Employee button

Enable Employee 
    Login GUI    ${HOST}
    Click Element    xpath=//*[@id="menu_basic_setting"]
    sleep    3
    Click Element    xpath=//*[@id="menu_basic_setting_wlan"]
    sleep    3
    Click Element    xpath=//*[@id="tab_wifi_zone"]
    sleep    5
    ${guest_captive_status}=    Get Element Attribute    id=employee_enable    value
    Run Keyword If    '${guest_captive_status}' == '0'    Click Employee button

Click Employee button
    Click Element    xpath=//*[@id="switch_layout_employee_enable"]
    sleep    3
    Click Element    xpath=//*[@id="apply"]
    sleep    300   
    Close All Browsers   

Enable Employee and Employee Captive Portal
    Login GUI    ${HOST}
    Click Element    xpath=//*[@id="menu_basic_setting"]
    sleep    3
    Click Element    xpath=//*[@id="menu_basic_setting_wlan"]
    sleep    3
    Click Element    xpath=//*[@id="tab_wifi_zone"]
    sleep    3
    Click Element    xpath=//*[@id="switch_layout_employee_enable"]
    sleep    3
    Click Element    xpath=//*[@id="switch_layout_employee_captive_enable"]
    sleep    3
    Click Element    xpath=//*[@id="apply"]
    sleep    300   
    Close All Browsers    

Enable Employee Captive Portal
    Login GUI    ${HOST}
    Click Element    xpath=//*[@id="menu_basic_setting"]
    sleep    3
    Click Element    xpath=//*[@id="menu_basic_setting_wlan"]
    sleep    3
    Click Element    xpath=//*[@id="tab_wifi_zone"]
    sleep    3
    Click Element    xpath=//*[@id="switch_layout_employee_captive_enable"]
    sleep    3
    Click Element    xpath=//*[@id="apply"]
    sleep    300   
    Close All Browsers  

Send Guest Captive Portal Auth
    Run Keyword And Ignore Error    Close All Browsers 
    ${output}=     Run Process    curl    -v    ${URL_protal}    stdout=PIPE    stderr=PIPE
    ${portal_url}=    Fetch From Right    ${output.stdout}    href='
    ${portal_url}=    Fetch From Left    ${portal_url}    '>Click here to continue
    Log To Console    Portal URL: ${portal_url} ---------
    ${output}=      open_guest_portal    ${portal_url}
    Close All Browsers

Send Guest Captive Portal Auth 5G
    Run Keyword And Ignore Error    Close All Browsers 
    ${output}=     Run Process    curl    -v    ${URL_protal2}    stdout=PIPE    stderr=PIPE
    ${portal_url}=    Fetch From Right    ${output.stdout}    Location:
    ${portal_url}=    Fetch From Left    ${portal_url}    < Content-Type:
    Log To Console    Portal URL: ${portal_url}
    ${output}=      open_guest_portal    ${portal_url}
    Close All Browsers

Send Guest Captive Portal Auth 6G
    Run Keyword And Ignore Error    Close All Browsers 
    ${output}=     Run Process    curl    -v    ${URL_protal3}    stdout=PIPE    stderr=PIPE
    ${portal_url}=    Fetch From Right    ${output.stdout}    Location:
    ${portal_url}=    Fetch From Left    ${portal_url}    < Content-Type:
    Log To Console    Portal URL: ${portal_url}
    ${output}=      open_guest_portal    ${portal_url}
    Close All Browsers

Send Employee Captive Portal Auth 2G
    ${output}=     Run Process    curl    -v    ${URL_protal}    stdout=PIPE    stderr=PIPE
    ${portal_url}=    Fetch From Right    ${output.stdout}    Location:
    ${portal_url}=    Fetch From Left    ${portal_url}    < Content-Type:
    Log To Console    Portal URL: ${portal_url}
    ${output}=      open_employee_portal    ${portal_url} 
    Close All Browsers

Send Employee Captive Portal Auth 5G
    ${output}=     Run Process    curl    -v    ${URL_protal2}    stdout=PIPE    stderr=PIPE
    ${portal_url}=    Fetch From Right    ${output.stdout}    Location:
    ${portal_url}=    Fetch From Left    ${portal_url}    < Content-Type:
    Log To Console    Portal URL: ${portal_url}
    ${output}=      open_employee_portal    ${portal_url}  
    Close All Browsers

Send Employee Captive Portal Auth 6G
    ${output}=     Run Process    curl    -v    ${URL_protal3}    stdout=PIPE    stderr=PIPE
    ${portal_url}=    Fetch From Right    ${output.stdout}    Location:
    ${portal_url}=    Fetch From Left    ${portal_url}    < Content-Type:
    Log To Console    Portal URL: ${portal_url}
    ${output}=      open_employee_portal    ${portal_url}   
    Close All Browsers

Verify Guest SSID is not broadcasted
    ${output}=	Run    echo ${Client_PASSWORD} | sudo -S iw dev ${IFACE} scan | grep SSID
    sleep    5
    Log    ${2G_Guest_SSID}
    Should Not Contain    ${output}    ${2G_Guest_SSID}
    Should Not Contain    ${output}    ${Changed_Guest_SSID}

Verify Employee SSID is not broadcasted
    ${output}=	Run    echo ${Client_PASSWORD} | sudo -S iw dev ${IFACE} scan | grep SSID
    sleep    5
    Should Not Contain    ${output}    ${2G_Employee_SSID}
    Should Not Contain    ${output}    ${Changed_Employee_SSID}

Fetch Portal Token
    [Arguments]    ${html_file}
    ${content}=    OperatingSystem.Get File    ${html_file}
    ${match}=      Evaluate    re.search(r'name="token" value="([^"]+)"', """${content}""")    re
    Run Keyword If    ${match}    Return From Keyword    ${match.group(1)}
    Return From Keyword    ""

Disable Mesh
    Login GUI    ${HOST}
    Click Element    xpath=//*[@id="menu_basic_setting"]
    sleep    3
    Click Element    xpath=//*[@id="menu_basic_setting_wlan"]
    sleep    3
    Click Element    xpath=//*[@id="tab_mesh"]
    sleep    3
    Click Element    xpath=//*[@id="switch_layout_enable_btn"]
    sleep    3
    Handle Alert    accept
    Click Element    xpath=//*[@id="apply"]
    sleep    300   
    Close All Browsers

Change Mode/Channel/Bandwidth
    Click Element    xpath=//*[@id="menu_basic_setting"]
    sleep    3
    Click Element    xpath=//*[@id="menu_basic_setting_wlan"]
    sleep    3
    Click Element    xpath=//*[@id="tab_wifi_adv_allinone"]
    sleep    3
    Select From List By Value    id=wifi_mode_select2    ax
    Select From List By Value    id=wifi_bw_select2    40only
    Select From List By Value    id=wifi_channel_select2    1
    Select From List By Value    id=wifi_mode_select5    ax
    Select From List By Value    id=wifi_bw_select5    204080
    Select From List By Value    id=wifi_channel_select5    36
    Select From List By Value    id=wifi_mode_select6    ax
    Select From List By Value    id=wifi_bw_select6    mixed160
    Select From List By Value    id=wifi_channel_select6    45
    Click Element    xpath=//*[@id="apply"]
    sleep    300

SSH To Disable Mesh Router And Get Guest SSID and BSSID
    Wait Until Keyword Succeeds    3x    10s    Retry SSH To Disable Mesh Router And Get Guest SSID and BSSID

Retry SSH To Disable Mesh Router And Get Guest SSID and BSSID
    Run Keyword And Ignore Error    Close All Connections
    Open Connection    ${HOST}
    Login              ${USER}    ${SSH_PASSWORD}

    ${2G_Guest_SSID} =    Execute Command    iw dev | grep -A5 "Interface mld3" | awk '/ssid/{print $2}'
    ${2G_Guest_SSID_BSSID} =    Execute Command    iw dev mld3 info | awk '/link 0:/{getline; print $2}'
    Should Not Be Equal    ${2G_Guest_SSID_BSSID}    ${EMPTY}
    ${2G_channel} =    Execute Command    iw dev mld3 info | grep channel
    ${2G_Guest_SSID_BSSID}=    Convert To Lower Case    ${2G_Guest_SSID_BSSID}
    Set Suite Variable    ${2G_Guest_SSID}
    Set Suite Variable    ${2G_Guest_SSID_BSSID}

    ${5G_Guest_SSID} =    Execute Command    iw dev | grep -A5 "Interface mld7" | awk '/ssid/{print $2}'
    ${5G_Guest_SSID_BSSID} =    Execute Command    iw dev mld7 info | awk '/link 1:/{getline; print $2}'
    Should Not Be Equal    ${5G_Guest_SSID_BSSID}    ${EMPTY}
    ${5G_channel} =    Execute Command    iw dev mld7 info | grep channel
    ${5G_Guest_SSID_BSSID}=    Convert To Lower Case    ${5G_Guest_SSID_BSSID}
    Set Suite Variable    ${5G_Guest_SSID}
    Set Suite Variable    ${5G_Guest_SSID_BSSID}

    ${6G_Guest_SSID} =    Execute Command    iw dev | grep -A5 "Interface mld11" | awk '/ssid/{print $2}'
    ${6G_Guest_SSID_BSSID} =    Execute Command    iw dev mld11 info | awk '/link 2:/{getline; print $2}'
    Should Not Be Equal    ${6G_Guest_SSID_BSSID}    ${EMPTY}
    ${6G_channel} =    Execute Command    iw dev mld11 info | grep channel
    ${6G_Guest_SSID_BSSID}=    Convert To Lower Case    ${6G_Guest_SSID_BSSID}
    Set Suite Variable    ${6G_Guest_SSID}
    Set Suite Variable    ${6G_Guest_SSID_BSSID}

    Close Connection

SSH To Enable Mesh Agent And Get Guest SSID and BSSID
    Wait Until Keyword Succeeds    3x    10s    Retry SSH To Enable Mesh Agent And Get Guest SSID and BSSID

Retry SSH To Enable Mesh Agent And Get Guest SSID and BSSID
    Run Keyword And Ignore Error    Close All Connections
    Open Connection    ${Agent_IP}
    Login              ${USER}    ${SSH_PASSWORD}

    ${2G_Agent_Guest_SSID} =    Execute Command    iw dev | grep -A5 "Interface mld9" | awk '/ssid/{print $2}'
    ${2G_Agent_Guest_SSID_BSSID} =    Execute Command    iw dev mld9 info | awk '/link 0:/{getline; print $2}'
    Should Not Be Equal    ${2G_Agent_Guest_SSID_BSSID}    ${EMPTY}
    ${2G_channel} =    Execute Command    iw dev mld9 info | grep channel
    ${2G_Agent_Guest_SSID_BSSID}=    Convert To Lower Case    ${2G_Agent_Guest_SSID_BSSID}
    Set Suite Variable    ${2G_Agent_Guest_SSID}
    Set Suite Variable    ${2G_Agent_Guest_SSID_BSSID}

    ${5G_Agent_Guest_SSID} =    Execute Command    iw dev | grep -A5 "Interface mld10" | awk '/ssid/{print $2}'
    ${5G_Agent_Guest_SSID_BSSID} =    Execute Command    iw dev mld10 info | awk '/link 1:/{getline; print $2}'
    Should Not Be Equal    ${5G_Agent_Guest_SSID_BSSID}    ${EMPTY}
    ${5G_channel} =    Execute Command    iw dev mld10 info | grep channel
    ${5G_Agent_Guest_SSID_BSSID}=    Convert To Lower Case    ${5G_Agent_Guest_SSID_BSSID}
    Set Suite Variable    ${5G_Agent_Guest_SSID}
    Set Suite Variable    ${5G_Agent_Guest_SSID_BSSID}

    ${6G_Agent_Guest_SSID} =    Execute Command    iw dev | grep -A5 "Interface mld11" | awk '/ssid/{print $2}'
    ${6G_Agent_Guest_SSID_BSSID} =    Execute Command    iw dev mld11 info | awk '/link 2:/{getline; print $2}'
    Should Not Be Equal    ${6G_Agent_Guest_SSID_BSSID}    ${EMPTY}
    ${6G_channel} =    Execute Command    iw dev mld11 info | grep channel
    ${6G_Agent_Guest_SSID_BSSID}=    Convert To Lower Case    ${6G_Agent_Guest_SSID_BSSID}
    Set Suite Variable    ${6G_Agent_Guest_SSID}
    Set Suite Variable    ${6G_Agent_Guest_SSID_BSSID}

    Close Connection

SSH To Enable Mesh Agent And Get Employee SSID and BSSID
    Wait Until Keyword Succeeds    3x    10s    Retry SSH To Enable Mesh Agent And Get Employee SSID and BSSID

Retry SSH To Enable Mesh Agent And Get Employee SSID and BSSID
    Run Keyword And Ignore Error    Close All Connections
    Open Connection    ${Agent_IP}
    Login              ${USER}    ${SSH_PASSWORD}

    ${2G_Agent_Employee_SSID} =    Execute Command    iw dev | grep -A5 "Interface mld12" | awk '/ssid/{print $2}'
    ${2G_Agent_Employee_SSID_BSSID} =    Execute Command    iw dev mld12 info | awk '/link 0:/{getline; print $2}'
    Should Not Be Equal    ${2G_Agent_Employee_SSID_BSSID}    ${EMPTY}
    ${2G_channel} =    Execute Command    iw dev mld12 info | grep channel
    ${2G_Agent_Employee_SSID_BSSID}=    Convert To Lower Case    ${2G_Agent_Employee_SSID_BSSID}
    Set Suite Variable    ${2G_Agent_Employee_SSID}
    Set Suite Variable    ${2G_Agent_Employee_SSID_BSSID}

    ${5G_Agent_Employee_SSID} =    Execute Command    iw dev | grep -A5 "Interface mld13" | awk '/ssid/{print $2}'
    ${5G_Agent_Employee_SSID_BSSID} =    Execute Command    iw dev mld13 info | awk '/link 1:/{getline; print $2}'
    Should Not Be Equal    ${5G_Agent_Employee_SSID_BSSID}    ${EMPTY}
    ${5G_channel} =    Execute Command    iw dev mld13 info | grep channel
    ${5G_Agent_Employee_SSID_BSSID}=    Convert To Lower Case    ${5G_Agent_Employee_SSID_BSSID}
    Set Suite Variable    ${5G_Agent_Employee_SSID}
    Set Suite Variable    ${5G_Agent_Employee_SSID_BSSID}

    ${6G_Agent_Employee_SSID} =    Execute Command    iw dev | grep -A5 "Interface mld14" | awk '/ssid/{print $2}'
    ${6G_Agent_Employee_SSID_BSSID} =    Execute Command    iw dev mld14 info | awk '/link 2:/{getline; print $2}'
    Should Not Be Equal    ${6G_Agent_Employee_SSID_BSSID}    ${EMPTY}
    ${6G_channel} =    Execute Command    iw dev mld14 info | grep channel
    ${6G_Agent_Employee_SSID_BSSID}=    Convert To Lower Case    ${6G_Agent_Employee_SSID_BSSID}
    Set Suite Variable    ${6G_Agent_Employee_SSID}
    Set Suite Variable    ${6G_Agent_Employee_SSID_BSSID}

    Close Connection


SSH To Enable Mesh Agent And Get Employee SSID and BSSID > only Employee SSID
    Wait Until Keyword Succeeds    3x    10s    Retry SSH To Enable Mesh Agent And Get Employee SSID and BSSID > only Employee SSID

Retry SSH To Enable Mesh Agent And Get Employee SSID and BSSID > only Employee SSID
    Run Keyword And Ignore Error    Close All Connections
    Open Connection    ${Agent_IP}
    Login              ${USER}    ${SSH_PASSWORD}

    ${2G_Agent_Employee_SSID} =    Execute Command    iw dev | grep -A5 "Interface mld9" | awk '/ssid/{print $2}'
    ${2G_Agent_Employee_SSID_BSSID} =    Execute Command    iw dev mld9 info | awk '/link 0:/{getline; print $2}'
    Should Not Be Equal    ${2G_Agent_Employee_SSID_BSSID}    ${EMPTY}
    ${2G_channel} =    Execute Command    iw dev mld9 info | grep channel
    ${2G_Agent_Employee_SSID_BSSID}=    Convert To Lower Case    ${2G_Agent_Employee_SSID_BSSID}
    Set Suite Variable    ${2G_Agent_Employee_SSID}
    Set Suite Variable    ${2G_Agent_Employee_SSID_BSSID}

    ${5G_Agent_Employee_SSID} =    Execute Command    iw dev | grep -A5 "Interface mld10" | awk '/ssid/{print $2}'
    ${5G_Agent_Employee_SSID_BSSID} =    Execute Command    iw dev mld10 info | awk '/link 1:/{getline; print $2}'
    Should Not Be Equal    ${5G_Agent_Employee_SSID_BSSID}    ${EMPTY}
    ${5G_channel} =    Execute Command    iw dev mld10 info | grep channel
    ${5G_Agent_Employee_SSID_BSSID}=    Convert To Lower Case    ${5G_Agent_Employee_SSID_BSSID}
    Set Suite Variable    ${5G_Agent_Employee_SSID}
    Set Suite Variable    ${5G_Agent_Employee_SSID_BSSID}

    ${6G_Agent_Employee_SSID} =    Execute Command    iw dev | grep -A5 "Interface mld11" | awk '/ssid/{print $2}'
    ${6G_Agent_Employee_SSID_BSSID} =    Execute Command    iw dev mld11 info | awk '/link 2:/{getline; print $2}'
    Should Not Be Equal    ${6G_Agent_Employee_SSID_BSSID}    ${EMPTY}
    ${6G_channel} =    Execute Command    iw dev mld11 info | grep channel
    ${6G_Agent_Employee_SSID_BSSID}=    Convert To Lower Case    ${6G_Agent_Employee_SSID_BSSID}
    Set Suite Variable    ${6G_Agent_Employee_SSID}
    Set Suite Variable    ${6G_Agent_Employee_SSID_BSSID}

    Close Connection






SSH To Enable Mesh Router And Get Guest SSID and BSSID
    Wait Until Keyword Succeeds    3x    10s    Retry SSH To Enable Mesh Router And Get Guest SSID and BSSID

Retry SSH To Enable Mesh Router And Get Guest SSID and BSSID
    Run Keyword And Ignore Error    Close All Connections
    Open Connection    ${HOST}
    Login              ${USER}    ${SSH_PASSWORD}

    ${2G_Controller_Guest_SSID} =    Execute Command    iw dev | grep -A5 "Interface mld6" | awk '/ssid/{print $2}'
    ${2G_Controller_Guest_SSID_BSSID} =    Execute Command    iw dev mld6 info | awk '/link 0:/{getline; print $2}'
    Should Not Be Equal    ${2G_Controller_Guest_SSID_BSSID}    ${EMPTY}
    ${2G_channel} =    Execute Command    iw dev mld6 info | grep channel
    ${2G_Controller_Guest_SSID_BSSID}=    Convert To Lower Case    ${2G_Controller_Guest_SSID_BSSID}
    Set Suite Variable    ${2G_Controller_Guest_SSID}
    Set Suite Variable    ${2G_Controller_Guest_SSID_BSSID}

    ${5G_Controller_Guest_SSID} =    Execute Command    iw dev | grep -A5 "Interface mld7" | awk '/ssid/{print $2}'
    ${5G_Controller_Guest_SSID_BSSID} =    Execute Command    iw dev mld7 info | awk '/link 1:/{getline; print $2}'
    Should Not Be Equal    ${5G_Controller_Guest_SSID_BSSID}    ${EMPTY}
    ${5G_channel} =    Execute Command    iw dev mld7 info | grep channel
    ${5G_Controller_Guest_SSID_BSSID}=    Convert To Lower Case    ${5G_Controller_Guest_SSID_BSSID}
    Set Suite Variable    ${5G_Controller_Guest_SSID}
    Set Suite Variable    ${5G_Controller_Guest_SSID_BSSID}

    ${6G_Controller_Guest_SSID} =    Execute Command    iw dev | grep -A5 "Interface mld8" | awk '/ssid/{print $2}'
    ${6G_Controller_Guest_SSID_BSSID} =    Execute Command    iw dev mld8 info | awk '/link 2:/{getline; print $2}'
    Should Not Be Equal    ${6G_Controller_Guest_SSID_BSSID}    ${EMPTY}
    ${6G_channel} =    Execute Command    iw dev mld8 info | grep channel
    ${6G_Controller_Guest_SSID_BSSID}=    Convert To Lower Case    ${6G_Controller_Guest_SSID_BSSID}
    Set Suite Variable    ${6G_Controller_Guest_SSID}
    Set Suite Variable    ${6G_Controller_Guest_SSID_BSSID}

    Close Connection

SSH To Disable Mesh Router And Get Employee SSID and BSSID
    Wait Until Keyword Succeeds    3x    10s    Retry SSH To Disable Mesh Router And Get Employee SSID and BSSID

Retry SSH To Disable Mesh Router And Get Employee SSID and BSSID
    Run Keyword And Ignore Error    Close All Connections
    Open Connection    ${HOST}
    Login              ${USER}    ${SSH_PASSWORD}

    ${2G_Employee_SSID} =    Execute Command    iw dev | grep -A5 "Interface mld1$" | awk '/ssid/{print $2}'
    ${2G_Employee_SSID_BSSID} =    Execute Command    iw dev mld1 info | awk '/link 0:/{getline; print $2}'
    Should Not Be Equal    ${2G_Employee_SSID_BSSID}    ${EMPTY}
    ${2G_channel} =    Execute Command    iw dev mld1 info | grep channel
    ${2G_Employee_SSID_BSSID}=    Convert To Lower Case    ${2G_Employee_SSID_BSSID}
    Set Suite Variable    ${2G_Employee_SSID}
    Set Suite Variable    ${2G_Employee_SSID_BSSID}

    ${5G_Employee_SSID} =    Execute Command    iw dev | grep -A5 "Interface mld5" | awk '/ssid/{print $2}'
    ${5G_Employee_SSID_BSSID} =    Execute Command    iw dev mld5 info | awk '/link 1:/{getline; print $2}'
    Should Not Be Equal    ${5G_Employee_SSID_BSSID}    ${EMPTY}
    ${5G_channel} =    Execute Command    iw dev mld5 info | grep channel
    ${5G_Employee_SSID_BSSID}=    Convert To Lower Case    ${5G_Employee_SSID_BSSID}
    Set Suite Variable    ${5G_Employee_SSID}
    Set Suite Variable    ${5G_Employee_SSID_BSSID}

    ${6G_Employee_SSID} =    Execute Command    iw dev | grep -A5 "Interface mld9" | awk '/ssid/{print $2}'
    ${6G_Employee_SSID_BSSID} =    Execute Command    iw dev mld9 info | awk '/link 2:/{getline; print $2}'
    Should Not Be Equal    ${6G_Employee_SSID_BSSID}    ${EMPTY}
    ${6G_channel} =    Execute Command    iw dev mld9 info | grep channel
    ${6G_Employee_SSID_BSSID}=    Convert To Lower Case    ${6G_Employee_SSID_BSSID}
    Set Suite Variable    ${6G_Employee_SSID}
    Set Suite Variable    ${6G_Employee_SSID_BSSID}

    Close Connection

SSH To Enable Mesh Router And Get Employee SSID and BSSID
    Wait Until Keyword Succeeds    3x    10s    Retry SSH To Enable Mesh Router And Get Employee SSID and BSSID

Retry SSH To Enable Mesh Router And Get Employee SSID and BSSID
    Run Keyword And Ignore Error    Close All Connections
    Open Connection    ${HOST}
    Login              ${USER}    ${SSH_PASSWORD}

    ${2G_Controller_Employee_SSID} =    Execute Command    iw dev | grep -A5 "Interface mld9" | awk '/ssid/{print $2}'
    ${2G_Controller_Employee_SSID_BSSID} =    Execute Command    iw dev mld9 info | awk '/link 0:/{getline; print $2}'
    Should Not Be Equal    ${2G_Controller_Employee_SSID_BSSID}    ${EMPTY}
    ${2G_channel} =    Execute Command    iw dev mld9 info | grep channel
    ${2G_Controller_Employee_SSID_BSSID}=    Convert To Lower Case    ${2G_Controller_Employee_SSID_BSSID}
    Set Suite Variable    ${2G_Controller_Employee_SSID}
    Set Suite Variable    ${2G_Controller_Employee_SSID_BSSID}

    ${5G_Controller_Employee_SSID} =    Execute Command    iw dev | grep -A5 "Interface mld10" | awk '/ssid/{print $2}'
    ${5G_Controller_Employee_SSID_BSSID} =    Execute Command    iw dev mld10 info | awk '/link 1:/{getline; print $2}'
    Should Not Be Equal    ${5G_Controller_Employee_SSID_BSSID}    ${EMPTY}
    ${5G_channel} =    Execute Command    iw dev mld10 info | grep channel
    ${5G_Controller_Employee_SSID_BSSID}=    Convert To Lower Case    ${5G_Controller_Employee_SSID_BSSID}
    Set Suite Variable    ${5G_Controller_Employee_SSID}
    Set Suite Variable    ${5G_Controller_Employee_SSID_BSSID}

    ${6G_Controller_Employee_SSID} =    Execute Command    iw dev | grep -A5 "Interface mld11" | awk '/ssid/{print $2}'
    ${6G_Controller_Employee_SSID_BSSID} =    Execute Command    iw dev mld11 info | awk '/link 2:/{getline; print $2}'
    Should Not Be Equal    ${6G_Controller_Employee_SSID_BSSID}    ${EMPTY}
    ${6G_channel} =    Execute Command    iw dev mld11 info | grep channel
    ${6G_Controller_Employee_SSID_BSSID}=    Convert To Lower Case    ${6G_Controller_Employee_SSID_BSSID}
    Set Suite Variable    ${6G_Controller_Employee_SSID}
    Set Suite Variable    ${6G_Controller_Employee_SSID_BSSID}

    Close Connection

SSH To Disable Mesh Router And Get Employee SSID and BSSID > only Employee SSID
    Wait Until Keyword Succeeds    3x    10s    Retry SSH To Disable Mesh Router And Get Employee SSID and BSSID > only Employee SSID

Retry SSH To Disable Mesh Router And Get Employee SSID and BSSID > only Employee SSID
    Run Keyword And Ignore Error    Close All Connections
    Open Connection    ${HOST}
    Login              ${USER}    ${SSH_PASSWORD}

    ${2G_Employee_SSID} =    Execute Command    iw dev | grep -A5 "Interface mld1$" | awk '/ssid/{print $2}'
    ${2G_Employee_SSID_BSSID} =    Execute Command    iw dev mld1 info | awk '/link 0:/{getline; print $2}'
    Should Not Be Equal    ${2G_Employee_SSID_BSSID}    ${EMPTY}
    ${2G_channel} =    Execute Command    iw dev mld1 info | grep channel
    ${2G_Employee_SSID_BSSID}=    Convert To Lower Case    ${2G_Employee_SSID_BSSID}
    Set Suite Variable    ${2G_Employee_SSID}
    Set Suite Variable    ${2G_Employee_SSID_BSSID}

    ${5G_Employee_SSID} =    Execute Command    iw dev | grep -A5 "Interface mld5" | awk '/ssid/{print $2}'
    ${5G_Employee_SSID_BSSID} =    Execute Command    iw dev mld5 info | awk '/link 1:/{getline; print $2}'
    Should Not Be Equal    ${5G_Employee_SSID_BSSID}    ${EMPTY}
    ${5G_channel} =    Execute Command    iw dev mld5 info | grep channel
    ${5G_Employee_SSID_BSSID}=    Convert To Lower Case    ${5G_Employee_SSID_BSSID}
    Set Suite Variable    ${5G_Employee_SSID}
    Set Suite Variable    ${5G_Employee_SSID_BSSID}

    ${6G_Employee_SSID} =    Execute Command    iw dev | grep -A5 "Interface mld9" | awk '/ssid/{print $2}'
    ${6G_Employee_SSID_BSSID} =    Execute Command    iw dev mld9 info | awk '/link 2:/{getline; print $2}'
    Should Not Be Equal    ${6G_Employee_SSID_BSSID}    ${EMPTY}
    ${6G_channel} =    Execute Command    iw dev mld9 info | grep channel
    ${6G_Employee_SSID_BSSID}=    Convert To Lower Case    ${6G_Employee_SSID_BSSID}
    Set Suite Variable    ${6G_Employee_SSID}
    Set Suite Variable    ${6G_Employee_SSID_BSSID}

    Close Connection

SSH To Enable Mesh Router And Get Employee SSID and BSSID > only Employee SSID
    Wait Until Keyword Succeeds    3x    10s    Retry SSH To Enable Mesh Router And Get Employee SSID and BSSID > only Employee SSID

Retry SSH To Enable Mesh Router And Get Employee SSID and BSSID > only Employee SSID
    Run Keyword And Ignore Error    Close All Connections
    Open Connection    ${HOST}
    Login              ${USER}    ${SSH_PASSWORD}

    ${2G_Employee_SSID} =    Execute Command    iw dev | grep -A5 "Interface mld6" | awk '/ssid/{print $2}'
    ${2G_Employee_SSID_BSSID} =    Execute Command    iw dev mld6 info | awk '/link 0:/{getline; print $2}'
    Should Not Be Equal    ${2G_Employee_SSID_BSSID}    ${EMPTY}
    ${2G_channel} =    Execute Command    iw dev mld6 info | grep channel
    ${2G_Employee_SSID_BSSID}=    Convert To Lower Case    ${2G_Employee_SSID_BSSID}
    Set Suite Variable    ${2G_Employee_SSID}
    Set Suite Variable    ${2G_Employee_SSID_BSSID}

    ${5G_Employee_SSID} =    Execute Command    iw dev | grep -A5 "Interface mld7" | awk '/ssid/{print $2}'
    ${5G_Employee_SSID_BSSID} =    Execute Command    iw dev mld7 info | awk '/link 1:/{getline; print $2}'
    Should Not Be Equal    ${5G_Employee_SSID_BSSID}    ${EMPTY}
    ${5G_channel} =    Execute Command    iw dev mld7 info | grep channel
    ${5G_Employee_SSID_BSSID}=    Convert To Lower Case    ${5G_Employee_SSID_BSSID}
    Set Suite Variable    ${5G_Employee_SSID}
    Set Suite Variable    ${5G_Employee_SSID_BSSID}

    ${6G_Employee_SSID} =    Execute Command    iw dev | grep -A5 "Interface mld8" | awk '/ssid/{print $2}'
    ${6G_Employee_SSID_BSSID} =    Execute Command    iw dev mld8 info | awk '/link 2:/{getline; print $2}'
    Should Not Be Equal    ${6G_Employee_SSID_BSSID}    ${EMPTY}
    ${6G_channel} =    Execute Command    iw dev mld8 info | grep channel
    ${6G_Employee_SSID_BSSID}=    Convert To Lower Case    ${6G_Employee_SSID_BSSID}
    Set Suite Variable    ${6G_Employee_SSID}
    Set Suite Variable    ${6G_Employee_SSID_BSSID}

    Close Connection

SSH To Router And Get all SSID and BSSID
    Wait Until Keyword Succeeds    3x    10s    Retry SSH To Router And Get all SSID and BSSID

Retry SSH To Router And Get all SSID and BSSID
    Run Keyword And Ignore Error    Close All Connections
    Open Connection    ${HOST}
    Login              ${USER}    ${SSH_PASSWORD}

    ${2G_common_SSID} =    Execute Command    iwconfig ath0 | grep 'ESSID' | awk -F 'ESSID:' '{print $2}' | tr -d '" '
    ${2G_common_SSID_BSSID} =    Execute Command    iwconfig ath0 | grep 'Access Point' | awk '{print $6}'
    Should Not Be Equal    ${2G_common_SSID_BSSID}    ${EMPTY}
    ${2G_channel} =    Execute Command    iw dev ath0 info | grep channel
    ${2G_common_SSID_BSSID}=    Convert To Lower Case    ${2G_common_SSID_BSSID}
    Set Suite Variable    ${2G_common_SSID}
    Set Suite Variable    ${2G_common_SSID_BSSID}

    ${5G_common_SSID} =    Execute Command    iwconfig ath1 | grep 'ESSID' | awk -F 'ESSID:' '{print $2}' | tr -d '" '
    ${5G_common_SSID_BSSID} =    Execute Command    iwconfig ath1 | grep 'Access Point' | awk '{print $6}'
    Should Not Be Equal    ${5G_common_SSID_BSSID}    ${EMPTY}
    ${5G_channel} =    Execute Command    iw dev ath1 info | grep channel
    ${5G_common_SSID_BSSID}=    Convert To Lower Case    ${5G_common_SSID_BSSID}
    Set Suite Variable    ${5G_common_SSID}
    Set Suite Variable    ${5G_common_SSID_BSSID}

    ${6G_common_SSID} =    Execute Command    iwconfig ath2 | grep 'ESSID' | awk -F 'ESSID:' '{print $2}' | tr -d '" '
    ${6G_common_SSID_BSSID} =    Execute Command    iwconfig ath2 | grep 'Access Point' | awk '{print $6}'
    Should Not Be Equal    ${6G_common_SSID_BSSID}    ${EMPTY}
    ${6G_channel} =    Execute Command    iw dev ath2 info | grep channel
    ${6G_common_SSID_BSSID}=    Convert To Lower Case    ${6G_common_SSID_BSSID}
    Set Suite Variable    ${6G_common_SSID}
    Set Suite Variable    ${6G_common_SSID_BSSID}

    Close Connection

Check time out and Verify Client cannot access to Internet
    sleep    300
    ${output}=    Run    ping 8.8.8.8 -I ${IFACE} -c 4
    Should Not Contain    ${output}    ttl=

###============================================================================
