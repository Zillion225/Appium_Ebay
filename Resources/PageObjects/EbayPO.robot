*** Settings ***
# Import necessary libraries and resources
Library     AppiumLibrary    # For interacting with mobile applications
Resource    ../CommonPO.robot    # Common resource file containing reusable keywords


*** Keywords ***
# Keyword: Set up the test environment
Test setup
    [Documentation]    Initializes the test by launching the mobile app, starting screen recording, and closing any popup banners.
    [Arguments]
    ...    ${capability_json_file_path}    # Path to the JSON file containing app capabilities

    # Launch the mobile application using the provided capabilities
    CommonPO.Launch mobile app    json_path=${capability_json_file_path}
    # Start recording the screen for the test session
    Start Screen Recording
    # Ensure a clean test start by closing any popup banners
    Close popup banner in main page

# Keyword: Clean up the test environment

Test stop
    [Documentation]    Stops screen recording and closes the application after the test.

    Stop Screen Recording
    Close Application

# Keyword: Close the popup banner on the main page

Close popup banner in main page
    [Documentation]    Handles and dismisses any popup banner on the main page.

    # Wait until the 'Close' button is visible
    Wait Until Element Is Visible    locator=accessibility_id=Close    timeout=30s
    # Click the 'Close' button to dismiss the banner
    Click Element    locator=accessibility_id=Close
    # Verify that the popup is no longer present
    Page Should Not Contain Element
    ...    locator=xpath=//android.widget.TextView[@resource-id="com.ebay.mobile:id/screen_title"]

# Keyword: Search for an item using the search bar

Use search bar to search item
    [Documentation]    Performs a search for the specified item using the search bar.
    [Arguments]
    ...    ${search_text}    # The text to search for

    # Activate the search bar
    Click Element    locator=accessibility_id=Search Keyword Search on eBay
    # Wait until the search input field is visible
    Wait Until Element Is Visible    locator=id=com.ebay.mobile:id/search_src_text    timeout=30s
    # Input the search text and perform the search
    Input Text    locator=id=com.ebay.mobile:id/search_src_text    text=${search_text}
    Press Keycode    keycode=66

# Keyword: Close the warning popup on the search results page

Close warning popup in search page
    [Documentation]    Handles and dismisses the warning popup on the search results page, if present.

    # Define the locator for the warning popup
    ${warning_popup}=    Set Variable
    ...    accessibility_id=When you save a search, we'll let you know when a new item is listed double tap to dismiss
    # Wait until the warning popup is visible
    Wait Until Element Is Visible    locator=${warning_popup}    timeout=30s
    # Click the warning popup to dismiss it
    Click Element    locator=${warning_popup}
    # Verify that the warning popup is no longer present
    Page Should Not Contain Element    locator=${warning_popup}

# Keyword: Verify the search results page is displayed correctly

Check search result page is display
    [Documentation]    Ensures that the search results page is displayed and contains the expected elements.
    [Arguments]
    ...    ${search_text}    # The text of the search query

    # Check that the search text is visible in the results
    Page Should Contain Element    locator=xpath=//android.widget.TextView[@text="${search_text}"]
    # Verify the presence of the 'Follow' button
    Page Should Contain Element    locator=id=com.ebay.mobile:id/following_button_follow

# Keyword: Retrieve search results and their details

Get search results
    [Documentation]    Extracts details of search results from the page and returns them as a list of dictionaries.

    # Locate all search result items
    ${search_results}=    Get Webelements
    ...    locator=xpath=//android.view.ViewGroup[@resource-id="com.ebay.mobile:id/cell_collection_item"]
    # Get the total number of search results
    ${length}=    Get Length    ${search_results}
    # Log the raw search results for debugging
    Log    ${search_results}
    # Process each result element and extract details
    ${element_details}=    Search result elements to list of dictionary    elements=${search_results}
    RETURN    ${element_details}

# Keyword: Convert search result elements to a list of dictionaries

Search result elements to list of dictionary
    [Documentation]    Processes a list of search result elements to extract details (name, description, price).
    [Arguments]
    ...    ${elements}    # List of search result elements

    # Initialize an empty list to store extracted details
    ${list_items}=    Create List
    # Loop through each element and extract details
    FOR    ${element}    IN    @{elements}
        # Extract the item's name
        ${name}=    CommonPO.Get text attribute from child
        ...    ${element}
        ...    xpath=//*[@resource-id="com.ebay.mobile:id/textview_header_0"]
        # Extract the first description
        ${desc1}=    CommonPO.Get text attribute from child
        ...    ${element}
        ...    xpath=//*[@resource-id="com.ebay.mobile:id/textview_subheader_0"]
        # Extract the item's price as text
        ${priceText}=    CommonPO.Get text attribute from child
        ...    ${element}
        ...    xpath=//*[@resource-id="com.ebay.mobile:id/textview_primary_0"]
        # Convert the price text to a numeric value
        ${price}=    CommonPO.Get numeric from text    text=${priceText}
        # Create a dictionary with the extracted details
        ${data}=    Create Dictionary    Name=${name}    Desc1=${desc1}    Price=${price}    PriceText=${priceText}
        # Add the dictionary to the list
        Append To List    ${list_items}    ${data}
    END
    RETURN    ${list_items}
