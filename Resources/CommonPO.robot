*** Settings ***
# Import required libraries for interacting with mobile apps, JSON, collections, and strings
Library     AppiumLibrary    # For interacting with mobile applications using Appium
Library     JSONLibrary    # For reading and handling JSON files
Library     Collections    # For managing collections like lists and dictionaries
Library     String    # For string manipulation


*** Variables ***
# Define constants used in the tests
${APPIUM_URL}       http://127.0.0.1:4723    # URL of the Appium server


*** Keywords ***
# Keyword: Launch the mobile app
Launch mobile app
    [Documentation]
    ...    Launches a mobile application using Appium.
    ...    Loads the app capabilities from a JSON file and starts the app with the provided configurations.
    [Arguments]
    ...    ${json_path}    # Path to the JSON file containing app capabilities
    ...    ${encoding}=utf8    # Encoding format for reading the JSON file (default is 'utf8')

    # Load app capabilities from the JSON file
    ${capabilities}=    Load capabilities from JSON file    json_path=${json_path}    encoding=${encoding}
    Log    Loaded capabilities: ${capabilities}    # Log loaded capabilities for debugging

    # Open the application using Appium with the provided capabilities
    Open Application    ${APPIUM_URL}
    ...    automationName=${capabilities["automationName"]}
    ...    platformName=${capabilities["platformName"]}
    ...    platformVersion=${capabilities["platformVersion"]}
    ...    deviceName=${capabilities["deviceName"]}
    ...    appPackage=${capabilities["appPackage"]}
    ...    appActivity=${capabilities["appActivity"]}

# Keyword: Load capabilities from JSON file

Load capabilities from JSON file
    [Documentation]
    ...    Reads app capabilities from a JSON file and returns them as a dictionary.
    ...    This is typically used to load the configuration for launching the mobile app.
    [Arguments]
    ...    ${json_path}    # Path to the JSON file containing app capabilities
    ...    ${encoding}=utf8    # Encoding format for the JSON file (default is 'utf8')

    # Read the JSON file and parse its contents into a dictionary
    ${json_data}=    Load Json From File    file_name=${json_path}    encoding=${encoding}
    RETURN    ${json_data}    # Return the loaded JSON data

# Keyword: Extract text attribute from a child element

Get text attribute from child
    [Documentation]    Retrieves the 'text' attribute of a child element located within a parent element.
    [Arguments]
    ...    ${parent_element}    # The parent web element
    ...    ${child_locator}    # Locator for the child element (e.g., XPath, ID)

    # Locate the child element within the parent
    ${child_element}=    Get Webelement In Webelement    element=${parent_element}    locator=${child_locator}
    # Get the 'text' attribute of the child element
    ${text}=    Get Element Attribute    ${child_element}    text
    RETURN    ${text}

# Keyword: Extract numeric value from a text string

Get numeric from text
    [Documentation]
    ...    Removes all non-numeric characters from a text string and converts the result into a number.
    ...    Useful for extracting numeric values from strings containing text and numbers.
    [Arguments]
    ...    ${text}    # Input text string containing numbers

    # Remove all non-digit characters (except '.') using regex
    ${cleaned_number_text}=    Replace String Using Regexp    string=${text}    pattern=[^0-9.]    replace_with=
    # Convert the cleaned text to a numeric value with two decimal precision
    ${result}=    Convert To Number    item=${cleaned_number_text}    precision=2
    RETURN    ${result}
