*** Settings ***
Library    Process
Library    OperatingSystem
Library    SerialLibrary
Library    SeleniumLibrary
Library    SSHLibrary
Library     String
Library     BuiltIn
Library    open_login.py
Library     telnet_case.py
#Suite Setup    SSH To Router And Get all SSID and BSSID
*** Variables ***
${COM_PORT}    COM3    
${baudrate_value}    115200
${IFACE}       wlp3s0f0
${Client_PASSWORD}    password
${conf_PATH}   /etc/wpa_supplicant/wpa_supplicant.conf
${conf_wpa3_PATH}   /etc/wpa_supplicant/wpa_supplicant_wpa3.conf
${conf_open_PATH}   /etc/wpa_supplicant/wpa_supplicant_open.conf
${Config_name}    test.conf
${TIMEOUT}     10s
${Count_Number}    0
${total_unable_to_get_value_from_USP}    0
${total_get_value_from_USP}    0
${wait_counter}        0
${dynamic_value}        0
${TMP_CONF}    test_tmp.conf
${ORIG_CONF}    /etc/wpa_supplicant/wpa_supplicant.conf
${TMP1_CONF}    test_tmp1.conf
${ORIG_wpa3_CONF}    /etc/wpa_supplicant/wpa_supplicant_wpa3.conf
${ORIG_open_CONF}   /etc/wpa_supplicant/wpa_supplicant_open.conf
${TMP1_wpa3_CONF}    test_wpa3_tmp1.conf
${GUI_IP}    192.168.1.1
${TMP1_open_CONF}    test_open_tmp1.conf
${ORIG_employee_CONF}    /etc/wpa_supplicant/wpa_supplicant_employee.conf
${TMP1_employee_CONF}    test_employee_tmp1.conf
${conf_employee_PATH}    /etc/wpa_supplicant/wpa_supplicant_employee.conf
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
#${Default_PSK}    4cba7d0291fc
${Changed_Guest_SSID}    Guest_123456789012345
${Changed_Employee_SSID}    Employee_123456789012345
${Changed_Employee_PSK}    123456789012345678901234567890121234567890123456789012345678901
${EMAIL}         agchone29x@mail.com
${URL_protal}    http://neverssl.com
${URL_protal2}    http://detectportal.firefox.com/
${URL_protal3}    http://example.com
*** Test Cases ***
Enable Client wired Network 
    [Tags]    Mesh
    Enable Client wired Network
    Disable the switch port connected to the agent

Check Wizard
    [Tags]    Wizard    Mesh
    Check Wizard

Default DUT   
    [Tags]    Mesh
    Login GUI    ${HOST}
    Defalut DUT/Agent and Wait setup
    Close All Browsers  

Setup Wizard
    [Tags]    Wizard    Mesh
    Login Wizard GUI    ${HOST}
    Setup Wizard
    Close All Browsers   

Check DUT FW 
    [Tags]    Mesh
    Check DUT FW   ${HOST}

Enable SSh
    [Tags]    Mesh
    Enable SSH
   
Check Guest status
    [Tags]    Guest    Mesh
    Check the Guest setting and enable it
    Check Guest Captive Portal status and Disable it

Set the DUT channel to be scannable
    [Tags]    6G    5G    channel    Mesh
    Set DUT 5G and 6G channel to be scannable

Get Router Guest SSID and BSSID
    [Tags]    Mesh    
    SSH To Enable Mesh Router And Get Guest SSID and BSSID

Disable Client wired Network and Reset WiFi Interface
    [Tags]    Mesh
    Disable Client wired Network
    Reset WiFi Interface

No.1 Connect to guest 2G SSID
    [Tags]    2G    Guest    Mesh
    Modify WPA Supplicant Open Config    ${2G_Guest_SSID}    ${2G_Guest_SSID_BSSID}    
    Connect to Guest ssid and Check client can get ip    ${2G_Guest_SSID_BSSID}     
    [Teardown]    Run Keyword If    '${TEST STATUS}' == 'FAIL'    Check SSID can be scan    ${2G_Guest_SSID_BSSID}

No.2 Connect to guest 5G SSID
    [Tags]    5G    Guest    Mesh
    Modify WPA Supplicant Open Config    ${5G_Guest_SSID}    ${5G_Guest_SSID_BSSID}    
    Connect to Guest ssid and Check client can get ip    ${5G_Guest_SSID_BSSID} 
    [Teardown]    Run Keyword If    '${TEST STATUS}' == 'FAIL'    Check SSID can be scan    ${5G_Guest_SSID_BSSID}

No.3 Connect to guest 6G SSID
    [Tags]    6G    Guest    Mesh
    Modify WPA Supplicant Open Config    ${6G_Guest_SSID}    ${6G_Guest_SSID_BSSID}   
    Connect to Guest ssid and Check client can get ip    ${6G_Guest_SSID_BSSID} 
    [Teardown]    Run Keyword If    '${TEST STATUS}' == 'FAIL'    Check SSID can be scan    ${6G_Guest_SSID_BSSID}

Enable Guest Captive Portal
    [Tags]    Guest    Mesh
    Enable Client wired Network
    Enable Guest Captive Portal
    Disable Client wired Network

No.4 Connect to guest 2G SSID
    [Tags]    2G    Guest    Mesh
    Modify WPA Supplicant Open Config    ${2G_Guest_SSID}    ${2G_Guest_SSID_BSSID}   
    Connect to Guest ssid and Check client can get ip > portal    ${2G_Guest_SSID_BSSID}     
    Send Guest Captive Portal Auth 2G
    Verify Client and access to Internet
    Verify Client cannot open GUI
    Check time out and Verify Client cannot access to Internet
    [Teardown]    Run Keyword If    '${TEST STATUS}' == 'FAIL'    Check SSID can be scan    ${2G_Guest_SSID_BSSID}
    
No.5 Connect to guest 5G SSID
    [Tags]    5G    Guest    Mesh
    Modify WPA Supplicant Open Config    ${5G_Guest_SSID}    ${5G_Guest_SSID_BSSID}   
    Connect to Guest ssid and Check client can get ip > portal    ${5G_Guest_SSID_BSSID} 
    Send Guest Captive Portal Auth 5G
    Verify Client and access to Internet
    Verify Client cannot open GUI
    Check time out and Verify Client cannot access to Internet
    [Teardown]    Run Keyword If    '${TEST STATUS}' == 'FAIL'    Check SSID can be scan    ${5G_Guest_SSID_BSSID}

No.6 Connect to guest 6G SSID
    [Tags]    6G    Guest    Mesh
    Modify WPA Supplicant Open Config    ${6G_Guest_SSID}    ${6G_Guest_SSID_BSSID}   
    Connect to Guest ssid and Check client can get ip > portal    ${6G_Guest_SSID_BSSID} 
    Send Guest Captive Portal Auth 6G
    Verify Client and access to Internet
    Verify Client cannot open GUI
    [Teardown]    Run Keyword If    '${TEST STATUS}' == 'FAIL'    Check SSID can be scan    ${6G_Guest_SSID_BSSID}

Change Guest SSID
    [Tags]    Guest    Mesh
    Enable Client wired Network
    Change Guest SSID
    SSH To Enable Mesh Router And Get Guest SSID and BSSID
    Disable Client wired Network

No.7 Change 2G Guest SSID and connect it
    [Tags]    2G    Guest    Mesh
    Restore client mac
    Modify WPA Supplicant Open Config    ${2G_Guest_SSID}    ${2G_Guest_SSID_BSSID}   
    Connect to Guest ssid and Check client can get ip > portal    ${2G_Guest_SSID_BSSID}     
    Send Guest Captive Portal Auth 2G
    Verify Client and access to Internet
    Verify Client cannot open GUI
    Check time out and Verify Client cannot access to Internet
    [Teardown]    Run Keyword If    '${TEST STATUS}' == 'FAIL'    Check SSID can be scan    ${2G_Guest_SSID_BSSID}

No.8 Connect 5G Guest SSID
    [Tags]    5G    Guest    Mesh
    Change client mac    
    Modify WPA Supplicant Open Config    ${5G_Guest_SSID}    ${5G_Guest_SSID_BSSID}   
    Connect to Guest ssid and Check client can get ip > portal    ${5G_Guest_SSID_BSSID} 
    Send Guest Captive Portal Auth 5G
    Verify Client and access to Internet
    Verify Client cannot open GUI
    Check time out and Verify Client cannot access to Internet
    [Teardown]    Run Keyword If    '${TEST STATUS}' == 'FAIL'    Check SSID can be scan    ${5G_Guest_SSID_BSSID}

No.9 Connect 6G Guest SSID    
    [Tags]    6G   Guest    Mesh
    Modify WPA Supplicant Open Config    ${6G_Guest_SSID}    ${6G_Guest_SSID_BSSID}   
    Connect to Guest ssid and Check client can get ip > portal    ${6G_Guest_SSID_BSSID} 
    Send Guest Captive Portal Auth 6G
    Verify Client and access to Internet
    Verify Client cannot open GUI
   Check time out and Verify Client cannot access to Internet
   [Teardown]    Run Keyword If    '${TEST STATUS}' == 'FAIL'    Check SSID can be scan    ${6G_Guest_SSID_BSSID}

Enable Employee
    [Tags]    Employee    Mesh
    Enable Client wired Network
    Enable Employee
    SSH To Controller And Get default wifi password
    SSH To Enable Mesh Router And Get Employee SSID and BSSID
    Disable Client wired Network
    
No.10 Connect to Employee 2G SSID
    [Tags]    2G    Employee    Mesh
    Modify WPA Supplicant employee Config    ${2G_Employee_SSID}    ${2G_Employee_SSID_BSSID}    ${Default_PSK}
    Connect to employee ssid and Check client can get ip    ${2G_Employee_SSID_BSSID}     
    [Teardown]    Run Keyword If    '${TEST STATUS}' == 'FAIL'    Check SSID can be scan    ${2G_Employee_SSID_BSSID}

No.11 Connect to Employee 5G SSID
    [Tags]    5G    Employee    Mesh
    Modify WPA Supplicant employee Config    ${5G_Employee_SSID}    ${5G_Employee_SSID_BSSID}    ${Default_PSK}
    Connect to employee ssid and Check client can get ip    ${5G_Employee_SSID_BSSID} 
    [Teardown]    Run Keyword If    '${TEST STATUS}' == 'FAIL'    Check SSID can be scan    ${5G_Employee_SSID_BSSID}

No.12 Connect to Employee 6G SSID
    [Tags]    6G    Employee    Mesh
    Modify WPA Supplicant employee Config    ${6G_Employee_SSID}    ${6G_Employee_SSID_BSSID}    ${Default_PSK}
    Connect to employee ssid and Check client can get ip    ${6G_Employee_SSID_BSSID} 
    [Teardown]    Run Keyword If    '${TEST STATUS}' == 'FAIL'    Check SSID can be scan    ${6G_Employee_SSID_BSSID}

Change Employee SSID and Password 
    [Tags]    Employee     Mesh
    Enable Client wired Network
    Change Employee SSID and password
    SSH To Enable Mesh Router And Get Employee SSID and BSSID
    Disable Client wired Network
    Restore client mac

No.13 Connect to Employee 2G SSID
    [Tags]    2G    Employee    Mesh
    Modify WPA Supplicant employee Config    ${2G_Employee_SSID}    ${2G_Employee_SSID_BSSID}    ${Changed_Employee_PSK}
    Connect to employee ssid and Check client can get ip    ${2G_Employee_SSID_BSSID}   
    [Teardown]    Run Keyword If    '${TEST STATUS}' == 'FAIL'    Check SSID can be scan    ${2G_Employee_SSID_BSSID}  

No.14 Connect to Employee 5G SSID
    [Tags]    5G    Employee    Mesh
    Modify WPA Supplicant employee Config    ${5G_Employee_SSID}    ${5G_Employee_SSID_BSSID}    ${Changed_Employee_PSK}
    Connect to employee ssid and Check client can get ip    ${5G_Employee_SSID_BSSID} 
    [Teardown]    Run Keyword If    '${TEST STATUS}' == 'FAIL'    Check SSID can be scan    ${5G_Employee_SSID_BSSID}

No.15 Connect to Employee 6G SSID
    [Tags]    6G    Employee    Mesh
    Modify WPA Supplicant employee Config    ${6G_Employee_SSID}    ${6G_Employee_SSID_BSSID}    ${Changed_Employee_PSK}
    Connect to employee ssid and Check client can get ip    ${6G_Employee_SSID_BSSID} 
    [Teardown]    Run Keyword If    '${TEST STATUS}' == 'FAIL'    Check SSID can be scan    ${6G_Employee_SSID_BSSID}

# Enable Employee Captive Portal
#     [Tags]    Employee    Employee Captive Portal
#     Enable Client wired Network
#     Enable Employee Captive Portal

#     Disable Client wired Network

# No.16 Connect to Employee 2G SSID
#     [Tags]    2G    Employee    Employee Captive Portal
#     Restore client mac
#     Modify WPA Supplicant employee Config    ${2G_Employee_SSID}    ${2G_Employee_SSID_BSSID}    ${Default_PSK}
#     Connect to Employee ssid and Check client can get ip > portal    ${2G_Employee_SSID_BSSID}     
#     Send Employee Captive Portal Auth 2G
#     Verify Client and access to Internet
#     Verify Client cannot open GUI
#    [Teardown]    Run Keyword If    '${TEST STATUS}' == 'FAIL'    Check SSID can be scan    ${2G_Employee_SSID_BSSID}

# No.17 Connect to Employee 5G SSID
#     [Tags]    5G    Employee    Employee Captive Portal
#     Change client mac
#     Modify WPA Supplicant employee Config    ${5G_Employee_SSID}    ${5G_Employee_SSID_BSSID}    ${Default_PSK}
#     Connect to Employee ssid and Check client can get ip > portal    ${5G_Employee_SSID_BSSID} 
#     Send Employee Captive Portal Auth 5G
#     Verify Client and access to Internet
#     Verify Client cannot open GUI
#     [Teardown]    Run Keyword If    '${TEST STATUS}' == 'FAIL'    Check SSID can be scan    ${5G_Employee_SSID_BSSID}

# No.18 Connect to Employee 6G SSID
#     [Tags]    6G    Employee    Employee Captive Portal
#     Modify WPA Supplicant employee Config    ${6G_Employee_SSID}    ${6G_Employee_SSID_BSSID}    ${Default_PSK}
#     Connect to Employee ssid and Check client can get ip > portal    ${6G_Employee_SSID_BSSID} 
#     Send Employee Captive Portal Auth 6G
#     Verify Client and access to Internet
#     Verify Client cannot open GUI
#     [Teardown]    Run Keyword If    '${TEST STATUS}' == 'FAIL'    Check SSID can be scan    ${6G_Employee_SSID_BSSID}

Enable Client wired Network
    [Tags]    Employee    Mesh   
    Enable Client wired Network

Default DUT
    [Tags]    Employee    Mesh   
    Login GUI    ${HOST}
    Defalut DUT/Agent and Wait setup
    Close All Browsers  

Setup Wizard
    [Tags]    Wizard    Guest    Employee    Mesh  
    Login Wizard GUI    ${HOST}
    Setup Wizard
    Close All Browsers 

Enable SSh
    [Tags]    Employee    Mesh   
    Enable SSH
    Reset WiFi Interface

Set the DUT channel to be scannable
    [Tags]    6G    5G    channel    Mesh
    Set DUT 5G and 6G channel to be scannable

Check Guest status
    [Tags]    Guest    Employee    Mesh   
    Check the Guest setting and disable it

Enable Employee
    [Tags]    Employee    Mesh   
    Enable Employee
    SSH To Controller And Get default wifi password
    SSH To Enable Mesh Router And Get Employee SSID and BSSID > only Employee SSID
    Disable Client wired Network

No.16 Connect to Employee 2G SSID
    [Tags]    2G    Employee    Mesh
    Modify WPA Supplicant employee Config    ${2G_Employee_SSID}    ${2G_Employee_SSID_BSSID}    ${Default_PSK}
    Connect to employee ssid and Check client can get ip    ${2G_Employee_SSID_BSSID}     
    [Teardown]    Run Keyword If    '${TEST STATUS}' == 'FAIL'    Check SSID can be scan    ${2G_Employee_SSID_BSSID}

No.17 Connect to Employee 5G SSID
    [Tags]    5G    Employee    Mesh
    Modify WPA Supplicant employee Config    ${5G_Employee_SSID}    ${5G_Employee_SSID_BSSID}    ${Default_PSK}
    Connect to employee ssid and Check client can get ip    ${5G_Employee_SSID_BSSID} 
    [Teardown]    Run Keyword If    '${TEST STATUS}' == 'FAIL'    Check SSID can be scan    ${5G_Employee_SSID_BSSID}

No.18 Connect to Employee 6G SSID
    [Tags]    6G    Employee    Mesh
    Modify WPA Supplicant employee Config    ${6G_Employee_SSID}    ${6G_Employee_SSID_BSSID}    ${Default_PSK}
    Connect to employee ssid and Check client can get ip    ${6G_Employee_SSID_BSSID} 
    [Teardown]    Run Keyword If    '${TEST STATUS}' == 'FAIL'    Check SSID can be scan    ${6G_Employee_SSID_BSSID}

Enable Guest and Guest Captive Portal
    [Tags]    Guest    Employee    Mesh    
    Enable Client wired Network
    Enable Guest and Guest Captive Portal
    SSH To Enable Mesh Router And Get Guest SSID and BSSID
    Disable Client wired Network

No.19 Connect to guest 2G SSID
    [Tags]    2G    Guest    Employee    Mesh    
    Modify WPA Supplicant Open Config    ${2G_Guest_SSID}    ${2G_Guest_SSID_BSSID}   
    Connect to Guest ssid and Check client can get ip > portal    ${2G_Guest_SSID_BSSID}     
    Send Guest Captive Portal Auth 2G
    Verify Client and access to Internet
    Verify Client cannot open GUI
    Check time out and Verify Client cannot access to Internet
    [Teardown]    Run Keyword If    '${TEST STATUS}' == 'FAIL'    Check SSID can be scan    ${2G_Guest_SSID_BSSID}
    
No.20 Connect to guest 5G SSID
    [Tags]    5G    Guest    Employee    Mesh    
    Modify WPA Supplicant Open Config    ${5G_Guest_SSID}    ${5G_Guest_SSID_BSSID}   
    Connect to Guest ssid and Check client can get ip > portal    ${5G_Guest_SSID_BSSID} 
    Send Guest Captive Portal Auth 5G
    Verify Client and access to Internet
    Verify Client cannot open GUI
    Check time out and Verify Client cannot access to Internet
    [Teardown]    Run Keyword If    '${TEST STATUS}' == 'FAIL'    Check SSID can be scan    ${5G_Guest_SSID_BSSID}

No.21 Connect to guest 6G SSID
    [Tags]    6G    Guest    Employee    Employee Captive Portal    Mesh
    Modify WPA Supplicant Open Config    ${6G_Guest_SSID}    ${6G_Guest_SSID_BSSID}   
    Connect to Guest ssid and Check client can get ip > portal    ${6G_Guest_SSID_BSSID} 
    Send Guest Captive Portal Auth 6G
    Verify Client and access to Internet
    Verify Client cannot open GUI
    [Teardown]    Run Keyword If    '${TEST STATUS}' == 'FAIL'    Check SSID can be scan    ${6G_Guest_SSID_BSSID}

No.22 Disable Employee SSID
    [Tags]    Employee    Mesh
    Enable Client wired Network
    Disable Employee
    Disable Client wired Network
    Verify Employee SSID is not broadcasted

No.23 Disable Guest SSID
    [Tags]    Guest    Mesh
    Enable Client wired Network
    Check the Guest setting and disable it
    Disable Client wired Network
    Verify Guest SSID is not broadcasted

####----Disable Mesh

Enable Client wired Network
    Enable Client wired Network

Default Controller
    Login GUI    ${HOST}
    Defalut DUT/Agent and Wait setup
    Close All Browsers  

Setup Wizard
    [Tags]    Wizard
    Login Wizard GUI    ${HOST}
    Setup Wizard
    Close All Browsers  

Enable SSh
    Enable SSH

Set the DUT channel to be scannable
    [Tags]    6G    5G    channel
    Set DUT 5G and 6G channel to be scannable

Disable Mesh
    Disable Mesh

Check Guest status
    [Tags]    Guest
    Check the Guest setting and enable it
    Check Guest Captive Portal status and Disable it

Get Router Guest SSID and BSSID
    SSH To Disable Mesh Router And Get Guest SSID and BSSID

Disable Client wired Network and Reset WiFi Interface.
    Disable Client wired Network
    Reset WiFi Interface

No.24 Connect to guest 2G SSID
    [Tags]    2G    Guest
    Modify WPA Supplicant Open Config    ${2G_Guest_SSID}    ${2G_Guest_SSID_BSSID}    
    Connect to Guest ssid and Check client can get ip    ${2G_Guest_SSID_BSSID}     
    [Teardown]    Run Keyword If    '${TEST STATUS}' == 'FAIL'    Check SSID can be scan    ${2G_Guest_SSID_BSSID}

No.25 Connect to guest 5G SSID
    [Tags]    5G    Guest
    Modify WPA Supplicant Open Config    ${5G_Guest_SSID}    ${5G_Guest_SSID_BSSID}    
    Connect to Guest ssid and Check client can get ip    ${5G_Guest_SSID_BSSID} 
    [Teardown]    Run Keyword If    '${TEST STATUS}' == 'FAIL'    Check SSID can be scan    ${5G_Guest_SSID_BSSID}

No.26 Connect to guest 6G SSID
    [Tags]    6G    Guest
    Modify WPA Supplicant Open Config    ${6G_Guest_SSID}    ${6G_Guest_SSID_BSSID}   
    Connect to Guest ssid and Check client can get ip    ${6G_Guest_SSID_BSSID} 
    [Teardown]    Run Keyword If    '${TEST STATUS}' == 'FAIL'    Check SSID can be scan    ${6G_Guest_SSID_BSSID}

Enable Guest Captive Portal
    [Tags]    Guest
    Enable Client wired Network
    Enable Guest Captive Portal
    Disable Client wired Network

No.27 Connect to guest 2G SSID
    [Tags]    2G    Guest
    Modify WPA Supplicant Open Config    ${2G_Guest_SSID}    ${2G_Guest_SSID_BSSID}   
    Connect to Guest ssid and Check client can get ip > portal    ${2G_Guest_SSID_BSSID}     
    Send Guest Captive Portal Auth 2G
    Verify Client and access to Internet
    Verify Client cannot open GUI
    Check time out and Verify Client cannot access to Internet
    [Teardown]    Run Keyword If    '${TEST STATUS}' == 'FAIL'    Check SSID can be scan    ${2G_Guest_SSID_BSSID}
    
No.28 Connect to guest 5G SSID
    [Tags]    5G    Guest
    Modify WPA Supplicant Open Config    ${5G_Guest_SSID}    ${5G_Guest_SSID_BSSID}   
    Connect to Guest ssid and Check client can get ip > portal    ${5G_Guest_SSID_BSSID} 
    Send Guest Captive Portal Auth 5G
    Verify Client and access to Internet
    Verify Client cannot open GUI
    Check time out and Verify Client cannot access to Internet
    [Teardown]    Run Keyword If    '${TEST STATUS}' == 'FAIL'    Check SSID can be scan    ${5G_Guest_SSID_BSSID}

No.29 Connect to guest 6G SSID
    [Tags]    6G    Guest
    Modify WPA Supplicant Open Config    ${6G_Guest_SSID}    ${6G_Guest_SSID_BSSID}   
    Connect to Guest ssid and Check client can get ip > portal    ${6G_Guest_SSID_BSSID} 
    Send Guest Captive Portal Auth 6G
    Verify Client and access to Internet
    Verify Client cannot open GUI
    [Teardown]    Run Keyword If    '${TEST STATUS}' == 'FAIL'    Check SSID can be scan    ${6G_Guest_SSID_BSSID}

Change Guest SSID
    [Tags]    Guest
    Enable Client wired Network
    Change Guest SSID
    SSH To Disable Mesh Router And Get Guest SSID and BSSID
    Disable Client wired Network

No.30 Change 2G Guest SSID and connect it
    [Tags]    2G   Guest
    Restore client mac
    Modify WPA Supplicant Open Config    ${2G_Guest_SSID}    ${2G_Guest_SSID_BSSID}   
    Connect to Guest ssid and Check client can get ip > portal    ${2G_Guest_SSID_BSSID}     
    Send Guest Captive Portal Auth 2G
    Verify Client and access to Internet
    Verify Client cannot open GUI
    Check time out and Verify Client cannot access to Internet
    [Teardown]    Run Keyword If    '${TEST STATUS}' == 'FAIL'    Check SSID can be scan    ${2G_Guest_SSID_BSSID}

No.31 Connect 5G Guest SSID
    [Tags]    5G   Guest
    Change client mac    
    Modify WPA Supplicant Open Config    ${5G_Guest_SSID}    ${5G_Guest_SSID_BSSID}   
    Connect to Guest ssid and Check client can get ip > portal    ${5G_Guest_SSID_BSSID} 
    Send Guest Captive Portal Auth 5G
    Verify Client and access to Internet
    Verify Client cannot open GUI
    Check time out and Verify Client cannot access to Internet
    [Teardown]    Run Keyword If    '${TEST STATUS}' == 'FAIL'    Check SSID can be scan    ${5G_Guest_SSID_BSSID}

No.32 Connect 6G Guest SSID    
    [Tags]    6G   Guest
    Modify WPA Supplicant Open Config    ${6G_Guest_SSID}    ${6G_Guest_SSID_BSSID}   
    Connect to Guest ssid and Check client can get ip > portal    ${6G_Guest_SSID_BSSID} 
    Send Guest Captive Portal Auth 6G
    Verify Client and access to Internet
    Verify Client cannot open GUI
   Check time out and Verify Client cannot access to Internet
   [Teardown]    Run Keyword If    '${TEST STATUS}' == 'FAIL'    Check SSID can be scan    ${6G_Guest_SSID_BSSID}

Enable Employee
    [Tags]    Employee
    Enable Client wired Network
    Enable Employee
    SSH To Controller And Get default wifi password
    SSH To Disable Mesh Router And Get Employee SSID and BSSID
    Disable Client wired Network
    
No.33 Connect to Employee 2G SSID
    [Tags]    2G    Employee
    Modify WPA Supplicant employee Config    ${2G_Employee_SSID}    ${2G_Employee_SSID_BSSID}    ${Default_PSK}
    Connect to employee ssid and Check client can get ip    ${2G_Employee_SSID_BSSID}     
    [Teardown]    Run Keyword If    '${TEST STATUS}' == 'FAIL'    Check SSID can be scan    ${2G_Employee_SSID_BSSID}

No.34 Connect to Employee 5G SSID
    [Tags]    5G    Employee
    Modify WPA Supplicant employee Config    ${5G_Employee_SSID}    ${5G_Employee_SSID_BSSID}    ${Default_PSK}
    Connect to employee ssid and Check client can get ip    ${5G_Employee_SSID_BSSID} 
    [Teardown]    Run Keyword If    '${TEST STATUS}' == 'FAIL'    Check SSID can be scan    ${5G_Employee_SSID_BSSID}

No.35 Connect to Employee 6G SSID
    [Tags]    6G    Employee
    Modify WPA Supplicant employee Config    ${6G_Employee_SSID}    ${6G_Employee_SSID_BSSID}    ${Default_PSK}
    Connect to employee ssid and Check client can get ip    ${6G_Employee_SSID_BSSID} 
    [Teardown]    Run Keyword If    '${TEST STATUS}' == 'FAIL'    Check SSID can be scan    ${6G_Employee_SSID_BSSID}

Change Employee SSID and Password
    [Tags]    Employee
    Enable Client wired Network
    Change Employee SSID and password
    SSH To Disable Mesh Router And Get Employee SSID and BSSID
    Disable Client wired Network
    Restore client mac

No.36 Connect to Employee 2G SSID
    [Tags]    2G    Employee
    Modify WPA Supplicant employee Config    ${2G_Employee_SSID}    ${2G_Employee_SSID_BSSID}    ${Changed_Employee_PSK}
    Connect to employee ssid and Check client can get ip    ${2G_Employee_SSID_BSSID}     
    [Teardown]    Run Keyword If    '${TEST STATUS}' == 'FAIL'    Check SSID can be scan    ${2G_Employee_SSID_BSSID}

No.37 Connect to Employee 5G SSID
    [Tags]    5G    Employee
    Modify WPA Supplicant employee Config    ${5G_Employee_SSID}    ${5G_Employee_SSID_BSSID}    ${Changed_Employee_PSK}
    Connect to employee ssid and Check client can get ip    ${5G_Employee_SSID_BSSID} 
    [Teardown]    Run Keyword If    '${TEST STATUS}' == 'FAIL'    Check SSID can be scan    ${5G_Employee_SSID_BSSID}

No.38 Connect to Employee 6G SSID
    [Tags]    6G    Employee
    Modify WPA Supplicant employee Config    ${6G_Employee_SSID}    ${6G_Employee_SSID_BSSID}    ${Changed_Employee_PSK}
    Connect to employee ssid and Check client can get ip    ${6G_Employee_SSID_BSSID} 
    [Teardown]    Run Keyword If    '${TEST STATUS}' == 'FAIL'    Check SSID can be scan    ${6G_Employee_SSID_BSSID}

# Enable Employee Captive Portal
#     [Tags]    Employee    Employee Captive Portal
#     Enable Client wired Network
#     Enable Employee Captive Portal

#     Disable Client wired Network

# No.39 Connect to Employee 2G SSID
#     [Tags]    2G    Employee    Employee Captive Portal
#     Restore client mac
#     Modify WPA Supplicant employee Config    ${2G_Employee_SSID}    ${2G_Employee_SSID_BSSID}    ${Default_PSK}
#     Connect to Employee ssid and Check client can get ip > portal    ${2G_Employee_SSID_BSSID}     
#     Send Employee Captive Portal Auth 2G
#     Verify Client and access to Internet
#     Verify Client cannot open GUI
#     [Teardown]    Run Keyword If    '${TEST STATUS}' == 'FAIL'    Check SSID can be scan    ${2G_Employee_SSID_BSSID}

# No.40 Connect to Employee 5G SSID
#     [Tags]    5G    Employee    Employee Captive Portal
#     Change client mac
#     Modify WPA Supplicant employee Config    ${5G_Employee_SSID}    ${5G_Employee_SSID_BSSID}    ${Default_PSK}
#     Connect to Employee ssid and Check client can get ip > portal    ${5G_Employee_SSID_BSSID} 
#     Send Employee Captive Portal Auth 5G
#     Verify Client and access to Internet
#     Verify Client cannot open GUI
#     [Teardown]    Run Keyword If    '${TEST STATUS}' == 'FAIL'    Check SSID can be scan    ${5G_Employee_SSID_BSSID}

# No.41 Connect to Employee 6G SSID
#     [Tags]    6G    Employee    Employee Captive Portal
#     Modify WPA Supplicant employee Config    ${6G_Employee_SSID}    ${6G_Employee_SSID_BSSID}    ${Default_PSK}
#     Connect to Employee ssid and Check client can get ip > portal    ${6G_Employee_SSID_BSSID} 
#     Send Employee Captive Portal Auth 6G
#     Verify Client and access to Internet
#     Verify Client cannot open GUI
#     [Teardown]    Run Keyword If    '${TEST STATUS}' == 'FAIL'    Check SSID can be scan    ${6G_Employee_SSID_BSSID}

Enable Client wired Network
    [Tags]    Employee  
    Enable Client wired Network

Default Controller
    [Tags]    Employee   
    Login GUI    ${HOST}
    Defalut DUT/Agent and Wait setup
    Close All Browsers  

Setup Wizard
    [Tags]    Wizard   Employee
    Login Wizard GUI    ${HOST}
    Setup Wizard
    Close All Browsers  

Enable SSh
    [Tags]    Employee   
    Enable SSH
    Reset WiFi Interface

Set the DUT channel to be scannable
    [Tags]    6G    5G    channel
    Set DUT 5G and 6G channel to be scannable

Disable Mesh
    [Tags]    Employee   
    Disable Mesh

Disable Guest
    [Tags]    Employee  
    Check the Guest setting and disable it

Enable Employee
    [Tags]    Employee
    Enable Employee 
    SSH To Disable Mesh Router And Get Employee SSID and BSSID > only Employee SSID
    Disable Client wired Network

No.39 Connect to Employee 2G SSID
    [Tags]    2G    Employee    
    Modify WPA Supplicant employee Config    ${2G_Employee_SSID}    ${2G_Employee_SSID_BSSID}    ${Default_PSK}
    Connect to employee ssid and Check client can get ip    ${2G_Employee_SSID_BSSID}     
    [Teardown]    Run Keyword If    '${TEST STATUS}' == 'FAIL'    Check SSID can be scan    ${2G_Employee_SSID_BSSID}

No.40 Connect to Employee 5G SSID
    [Tags]    5G    Employee    
    Modify WPA Supplicant employee Config    ${5G_Employee_SSID}    ${5G_Employee_SSID_BSSID}    ${Default_PSK}
    Connect to employee ssid and Check client can get ip    ${5G_Employee_SSID_BSSID} 
    [Teardown]    Run Keyword If    '${TEST STATUS}' == 'FAIL'    Check SSID can be scan    ${5G_Employee_SSID_BSSID}

No.41 Connect to Employee 6G SSID
    [Tags]    6G    Employee   
    Modify WPA Supplicant employee Config    ${6G_Employee_SSID}    ${6G_Employee_SSID_BSSID}    ${Default_PSK}
    Connect to employee ssid and Check client can get ip    ${6G_Employee_SSID_BSSID}
    [Teardown]    Run Keyword If    '${TEST STATUS}' == 'FAIL'    Check SSID can be scan    ${6G_Employee_SSID_BSSID} 

Enable Guest and Guest Captive Portal
    [Tags]    Employee    
    Enable Client wired Network
    Enable Guest and Guest Captive Portal
    SSH To Disable Mesh Router And Get Guest SSID and BSSID
    Disable Client wired Network

No.42 Connect to guest 2G SSID
    [Tags]    2G    Guest    Employee   
    Modify WPA Supplicant Open Config    ${2G_Guest_SSID}    ${2G_Guest_SSID_BSSID}   
    Connect to Guest ssid and Check client can get ip > portal    ${2G_Guest_SSID_BSSID}     
    Send Guest Captive Portal Auth 2G
    Verify Client and access to Internet
    Verify Client cannot open GUI
    Check time out and Verify Client cannot access to Internet
    [Teardown]    Run Keyword If    '${TEST STATUS}' == 'FAIL'    Check SSID can be scan    ${2G_Guest_SSID_BSSID}
    
No.43 Connect to guest 5G SSID
    [Tags]    5G    Guest    Employee   
    Modify WPA Supplicant Open Config    ${5G_Guest_SSID}    ${5G_Guest_SSID_BSSID}   
    Connect to Guest ssid and Check client can get ip > portal    ${5G_Guest_SSID_BSSID} 
    Send Guest Captive Portal Auth 5G
    Verify Client and access to Internet
    Verify Client cannot open GUI
    Check time out and Verify Client cannot access to Internet
    [Teardown]    Run Keyword If    '${TEST STATUS}' == 'FAIL'    Check SSID can be scan    ${5G_Guest_SSID_BSSID}

No.44 Connect to guest 6G SSID
    [Tags]    6G    Guest    Employee    
    Modify WPA Supplicant Open Config    ${6G_Guest_SSID}    ${6G_Guest_SSID_BSSID}   
    Connect to Guest ssid and Check client can get ip > portal    ${6G_Guest_SSID_BSSID} 
    Send Guest Captive Portal Auth 6G
    Verify Client and access to Internet
    Verify Client cannot open GUI
    [Teardown]    Run Keyword If    '${TEST STATUS}' == 'FAIL'    Check SSID can be scan    ${6G_Guest_SSID_BSSID}

No.45 Disable Employee SSID
    [Tags]    Employee
    Enable Client wired Network
    Disable Employee
    Disable Client wired Network
    Verify Employee SSID is not broadcasted

No.46 Disable Guest SSID
    [Tags]    Guest
    Enable Client wired Network
    Check the Guest setting and disable it
    Disable Client wired Network
    Verify Guest SSID is not broadcasted

Enable Client wired Network.... 
    Enable Client wired Network





*** Keywords ***

${COM_PORT} AAA
    Click Element    xpath=//*[@id="menu_management"]

Defalut DUT/Agent and No wait setup
    Click Element    xpath=//*[@id="menu_management"]
    sleep    3
    Click Element    xpath=//*[@id="menu_management_settings"]
    sleep    3
    Click Element    xpath=//*[@id="lang_restore_btn"]
    sleep    3
    Click Element    xpath=//*[@id="confirm_dialog_confirmed"]
    sleep    3

Defalut DUT/Agent and Wait setup
    Click Element    xpath=//*[@id="menu_management"]
    sleep    3
    Click Element    xpath=//*[@id="menu_management_settings"]
    sleep    3
    Click Element    xpath=//*[@id="lang_restore_btn"]
    sleep    3
    Click Element    xpath=//*[@id="confirm_dialog_confirmed"]
    sleep    300

Reboot Agent and No wait setup
    Click Element    xpath=//*[@id="menu_management"]
    sleep    3
    Click Element    xpath=//*[@id="menu_management_reboot"]
    sleep    3
    Click Element    xpath=//*[@id="lang_reboot_btn_title"]
    sleep    3

Release and renew ip on client
    ${output}=	Run    echo ${Client_PASSWORD} | sudo -S dhclient -r
    ${output}=	Run    echo ${Client_PASSWORD} | sudo -S dhclient

Disable Client wired Network
    ${output}=    Run    echo ${Client_PASSWORD} | sudo -S /sbin/ifconfig enp1s0 down

Enable Client wired Network
    ${output}=    Run    echo ${Client_PASSWORD} | sudo -S /sbin/ifconfig enp1s0 up
    ${output}=    Run    echo ${Client_PASSWORD} | sudo -S service NetworkManager start
    ${output}=    Run    echo ${Client_PASSWORD} | sudo -S dhclient enp1s0 -r
    ${output}=    Run    echo ${Client_PASSWORD} | sudo -S ifconfig enp1s0 192.168.1.199 netmask 255.255.255.0
    sleep    60
    # ${output}=    Run    echo ${Client_PASSWORD} | sudo -S dhclient enp1s0
    ${output}=    Run    ping 192.168.1.1 -c 4
    Should Contain    ${output}    ttl=
    
Check time out and Verify Client cannot access to Internet
    sleep    300
    ${output}=    Run    ping 8.8.8.8 -I ${IFACE} -c 4
    Should Not Contain    ${output}    ttl=    

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

Connect DUT SSID
    [Arguments]    ${SSID_mac}
    Wait Until Keyword Succeeds    3x    10s    Retry Connect DUT SSID    ${SSID_mac}

Retry Connect DUT SSID
    [Arguments]    ${SSID_mac}
    ${output}=	Run    echo ${Client_PASSWORD} | sudo -S service NetworkManager stop
    sleep    10
    #Log To Console	${output}
    ${output}=	Run    echo ${Client_PASSWORD} | sudo killall wpa_supplicant
    #Log To Console	${output}
    ${output}=	Run    echo ${Client_PASSWORD} | sudo rm -rf /var/run/wpa_supplicant
    Change client mac
    ${output}=	Run    echo ${Client_PASSWORD} | sudo wpa_supplicant -B -i ${IFACE} -c ${conf_PATH} -D nl80211
    #Log To Console	${output}
    Sleep          15
    ${output}=     Run    iw ${IFACE} link    
    Log            ${output}
    sleep   3
    Should Contain    ${output}    Connected to ${SSID_mac}
    Run    echo ${Client_PASSWORD} | sudo dhclient ${IFACE}
    Sleep          3s

Connect DUT employee SSID
    [Arguments]    ${SSID_mac}
    ${output}=	Run    echo ${Client_PASSWORD} | sudo -S service NetworkManager stop
    sleep    10
    #Log To Console	${output}
    ${output}=	Run    echo ${Client_PASSWORD} | sudo killall wpa_supplicant
    #Log To Console	${output}
    ${output}=	Run    echo ${Client_PASSWORD} | sudo rm -rf /var/run/wpa_supplicant
    Change client mac
    ${output}=	Run    echo ${Client_PASSWORD} | sudo wpa_supplicant -B -i ${IFACE} -c ${conf_employee_PATH} -D nl80211
    #Log To Console	${output}
    Sleep          15
    ${output}=     Run    iw ${IFACE} link    
    Log            ${output}
    sleep   3
    Should Contain    ${output}    Connected to ${SSID_mac}
    Run    echo ${Client_PASSWORD} | sudo dhclient ${IFACE}
    #Run    echo ${Client_PASSWORD} | sudo ifconfig ${IFACE} 192.168.30.198 netmask 255.255.255.0
    Sleep          3

Connect DUT open SSID > portal
    [Arguments]    ${SSID_mac}
    ${output}=	Run    echo ${Client_PASSWORD} | sudo -S service NetworkManager stop
    sleep    10
    #Log To Console	${output}
    ${output}=	Run    echo ${Client_PASSWORD} | sudo killall wpa_supplicant
    #Log To Console	${output}
    ${output}=	Run    echo ${Client_PASSWORD} | sudo rm -rf /var/run/wpa_supplicant
    Change client mac
    ${output}=	Run    echo ${Client_PASSWORD} | sudo wpa_supplicant -B -i ${IFACE} -c ${conf_open_PATH} -D nl80211
    #Log To Console	${output}
    Sleep          15
    ${output}=     Run    iw ${IFACE} link    
    Log            ${output}
    sleep   3
    Should Contain    ${output}    Connected to ${SSID_mac}
    Run    echo ${Client_PASSWORD} | sudo dhclient ${IFACE}
    #Run    echo ${Client_PASSWORD} | sudo ifconfig ${IFACE} 192.168.182.100 netmask 255.255.255.0
    Sleep          3

Connect DUT open SSID
    [Arguments]    ${SSID_mac}
    ${output}=	Run    echo ${Client_PASSWORD} | sudo -S service NetworkManager stop
    sleep    10
    #Log To Console	${output}
    ${output}=	Run    echo ${Client_PASSWORD} | sudo killall wpa_supplicant
    #Log To Console	${output}
    ${output}=	Run    echo ${Client_PASSWORD} | sudo rm -rf /var/run/wpa_supplicant
    Change client mac
    ${output}=	Run    echo ${Client_PASSWORD} | sudo wpa_supplicant -B -i ${IFACE} -c ${conf_open_PATH} -D nl80211
    #Log To Console	${output}
    Sleep          15
    ${output}=     Run    iw ${IFACE} link    
    Log            ${output}
    sleep   3
    Should Contain    ${output}    Connected to ${SSID_mac}
    #Run    echo ${Client_PASSWORD} | sudo dhclient ${IFACE}
    Run    echo ${Client_PASSWORD} | sudo ifconfig ${IFACE} 192.168.20.198 netmask 255.255.255.0
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
    Wait Until Keyword Succeeds    3x    10s    Retry Connect DUT wpa3 SSID    ${SSID_mac}

Retry Connect DUT wpa3 SSID
    [Arguments]    ${SSID_mac}
    ${output}=	Run    echo ${Client_PASSWORD} | sudo -S service NetworkManager stop
    sleep    10
    #Log To Console	${output}
    ${output}=	Run    echo ${Client_PASSWORD} | sudo killall wpa_supplicant
    #Log To Console	${output}
    ${output}=	Run    echo ${Client_PASSWORD} | sudo rm -rf /var/run/wpa_supplicant
    Change client mac
    ${output}=	Run    echo ${Client_PASSWORD} | sudo wpa_supplicant -B -i ${IFACE} -c ${conf_wpa3_PATH} -D nl80211
    #Log To Console	${output}
    Sleep          15
    ${output}=     Run    iw ${IFACE} link    
    Log            ${output}
    sleep   3
    Should Contain    ${output}    Connected to ${SSID_mac}
    #Run    echo ${Client_PASSWORD} | sudo dhclient ${IFACE}
    Run    echo ${Client_PASSWORD} | sudo ifconfig ${IFACE} 192.168.1.198 netmask 255.255.255.0
    Sleep          3

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

Send Guest Captive Portal Auth 2G
    Run Keyword And Ignore Error    Close All Browsers 
    ${output}=     Run Process    curl    -v    ${URL_protal}    stdout=PIPE    stderr=PIPE
    ${portal_url}=    Fetch From Right    ${output.stdout}    Location:
    ${portal_url}=    Fetch From Left    ${portal_url}    < Content-Type:
    Log To Console    Portal URL: ${portal_url}
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
    # 如果沒有 token，回傳空字串
    Return From Keyword    ""

Disable the switch port connected to the agent
    ${banner}=    Open Telnet Connection    ${Switch_HOST}    ${Switch_PORT}
    Log To Console    \n--- BANNER ---\n${banner}\n
    ${out}=    telnet_command    ethctl eth0 phy-power down
    Log To Console    \n--- IFCONFIG ---\n${out}\n
    telnet_exec_command
    sleep    60

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

Check DUT FW 
    [Arguments]    ${DUT_IP}
    Login GUI    ${DUT_IP}
    ${text} =    Get Text    xpath=//*[@id="dashboard_system_swversion"]
    Log    ${text}
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

Enable MLO
    Click Element    xpath=//*[@id="menu_basic_setting"]
    sleep    3
    Click Element    xpath=//*[@id="menu_basic_setting_wlan"]
    sleep    3
    Click Element    xpath=//*[@id="switch_layout_MLO_enable"]
    sleep    3
    Click Element    xpath=//*[@id="apply"]
    sleep    300

Change common/MLO SSID, Authentication and Key
    Click Element    xpath=//*[@id="menu_basic_setting"]
    sleep    3
    Click Element    xpath=//*[@id="menu_basic_setting_wlan"]
    sleep    3
    Input Text    xpath=//*[@id="commong_ssid"]    ${Changed_common_SSID}
    sleep    3
    Input Text    xpath=//*[@id="commong_wpa_key"]    ${Changed_common_PSK}
    sleep    3
    Select From List By Value    id=authtype_commong    mixed3
    sleep    3
    Click Element    xpath=//*[@id="apply"]
    sleep    300
    
Change Mode/Channel/Bandwidth
    Click Element    xpath=//*[@id="menu_basic_setting"]
    sleep    3
    Click Element    xpath=//*[@id="menu_basic_setting_wlan"]
    sleep    3
    Click Element    xpath=//*[@id="tab_wifi_adv_allinone"]
    sleep    3
    ##-----2G-----
    Select From List By Value    id=wifi_mode_select2    ax
    Select From List By Value    id=wifi_bw_select2    40only
    Select From List By Value    id=wifi_channel_select2    1
    ##-----5G-----
    Select From List By Value    id=wifi_mode_select5    ax
    Select From List By Value    id=wifi_bw_select5    204080
    Select From List By Value    id=wifi_channel_select5    36
    ##-----6G-----
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

SSH To Enable Mesh Router And Get Guest SSID and BSSID
    Wait Until Keyword Succeeds    3x    10s    Retry SSH To Enable Mesh Router And Get Guest SSID and BSSID

Retry SSH To Enable Mesh Router And Get Guest SSID and BSSID
    Run Keyword And Ignore Error    Close All Connections
    Open Connection    ${HOST}
    Login              ${USER}    ${SSH_PASSWORD}

    ${2G_Guest_SSID} =    Execute Command    iw dev | grep -A5 "Interface mld6" | awk '/ssid/{print $2}'
    ${2G_Guest_SSID_BSSID} =    Execute Command    iw dev mld6 info | awk '/link 0:/{getline; print $2}'
    Should Not Be Equal    ${2G_Guest_SSID_BSSID}    ${EMPTY}
    ${2G_channel} =    Execute Command    iw dev mld6 info | grep channel
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

    ${6G_Guest_SSID} =    Execute Command    iw dev | grep -A5 "Interface mld8" | awk '/ssid/{print $2}'
    ${6G_Guest_SSID_BSSID} =    Execute Command    iw dev mld8 info | awk '/link 2:/{getline; print $2}'
    Should Not Be Equal    ${6G_Guest_SSID_BSSID}    ${EMPTY}
    ${6G_channel} =    Execute Command    iw dev mld8 info | grep channel
    ${6G_Guest_SSID_BSSID}=    Convert To Lower Case    ${6G_Guest_SSID_BSSID}
    Set Suite Variable    ${6G_Guest_SSID}
    Set Suite Variable    ${6G_Guest_SSID_BSSID}

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

    ${2G_Employee_SSID} =    Execute Command    iw dev | grep -A5 "Interface mld9" | awk '/ssid/{print $2}'
    ${2G_Employee_SSID_BSSID} =    Execute Command    iw dev mld9 info | awk '/link 0:/{getline; print $2}'
    Should Not Be Equal    ${2G_Employee_SSID_BSSID}    ${EMPTY}
    ${2G_channel} =    Execute Command    iw dev mld9 info | grep channel
    ${2G_Employee_SSID_BSSID}=    Convert To Lower Case    ${2G_Employee_SSID_BSSID}
    Set Suite Variable    ${2G_Employee_SSID}
    Set Suite Variable    ${2G_Employee_SSID_BSSID}

    ${5G_Employee_SSID} =    Execute Command    iw dev | grep -A5 "Interface mld10" | awk '/ssid/{print $2}'
    ${5G_Employee_SSID_BSSID} =    Execute Command    iw dev mld10 info | awk '/link 1:/{getline; print $2}'
    Should Not Be Equal    ${5G_Employee_SSID_BSSID}    ${EMPTY}
    ${5G_channel} =    Execute Command    iw dev mld10 info | grep channel
    ${5G_Employee_SSID_BSSID}=    Convert To Lower Case    ${5G_Employee_SSID_BSSID}
    Set Suite Variable    ${5G_Employee_SSID}
    Set Suite Variable    ${5G_Employee_SSID_BSSID}

    ${6G_Employee_SSID} =    Execute Command    iw dev | grep -A5 "Interface mld11" | awk '/ssid/{print $2}'
    ${6G_Employee_SSID_BSSID} =    Execute Command    iw dev mld11 info | awk '/link 2:/{getline; print $2}'
    Should Not Be Equal    ${6G_Employee_SSID_BSSID}    ${EMPTY}
    ${6G_channel} =    Execute Command    iw dev mld11 info | grep channel
    ${6G_Employee_SSID_BSSID}=    Convert To Lower Case    ${6G_Employee_SSID_BSSID}
    Set Suite Variable    ${6G_Employee_SSID}
    Set Suite Variable    ${6G_Employee_SSID_BSSID}

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

Reset WiFi Interface
    Run    echo ${Client_PASSWORD} | sudo pkill -f wpa_supplicant || true
    Run    echo ${Client_PASSWORD} | sudo pkill -f dhclient || true
    Run    echo ${Client_PASSWORD} | sudo rm -rf /var/run/wpa_supplicant
    Run    echo ${Client_PASSWORD} | sudo ip link set ${IFACE} down
    Sleep    2
    Run    echo ${Client_PASSWORD} | sudo ip addr flush dev ${IFACE}
    Run    echo ${Client_PASSWORD} | sudo ip link set ${IFACE} up
    Sleep    2

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
    Should Contain    ${result}   	${2G_common_SSID}    
    Should Contain    ${result}    	${2G_common_SSID_BSSID}
    Should Contain    ${result}   	${5G_common_SSID}    
    Should Contain    ${result}    	${5G_common_SSID_BSSID}
    Should Contain    ${result}   	${6G_common_SSID}    
    # Should Contain    ${result}    	${6G_common_SSID_BSSID}
    Should Contain    ${result}   	${2G_Guest_SSID}    
    Should Contain    ${result}    	${2G_Guest_SSID_BSSID}
    Should Contain    ${result}   	${5G_Guest_SSID}    
    Should Contain    ${result}    	${5G_Guest_SSID_BSSID}
    Should Contain    ${result}   	${6G_Guest_SSID}    
    # Should Contain    ${result}    	${6G_Guest_SSID_BSSID}
