*** Settings ***
# Import libraries and resources
Library             AppiumLibrary    # For interacting with mobile applications
Resource            ../Resources/PageObjects/CommonPO.robot    # Common reusable keywords
Resource            ../Resources/PageObjects/EbayPO.robot    # eBay-specific page object keywords

# Define test setup and teardown
Test Setup          EbayPO.Test setup    capability_json_file_path=${CAPABILITY_JSON_FILE}
Test Teardown       EbayPO.Test stop


*** Variables ***
# Define constants for the test
${CAPABILITY_JSON_FILE}     Resources/Capabilities.json    # Path to JSON file containing capabilities


*** Test Cases ***
# Test Case: Search for Tesla on eBay and verify the first result price is not zero
Search for Tesla on eBay and verify the first result price is not zero
    [Documentation]
    ...    Searches for "Tesla" on eBay, closes any warning popups, verifies the search results page,
    ...    and checks if the price of the first result is not zero.

    # Log the start of the test
    Log    message=Start Test Here

    # Set the search text variable
    ${search_text}=    Set Variable    Tesla

    # Perform a search for the specified text
    EbayPO.Use search bar to search item    search_text=${search_text}

    # Close any warning popups that appear on the search page
    EbayPO.Close warning popup in search page

    # Verify the search results page is displayed with the correct search text
    EbayPO.Check search result page is display    search_text=${search_text}

    # Get the list of search results
    ${search_results_list}=    EbayPO.Get search results
    Log    ${search_results_list}    # Log the search results for debugging

    # Extract the price of the first item in the search results
    ${select_item_price}=    Get From Dictionary    dictionary=${search_results_list[0]}    key=Price

    # Verify that the price of the first item is not zero
    Log    ${select_item_price}    # Log the search results for debugging
    Should Be True    ${select_item_price} != 0
