
# Appium_Ebay

This repository contains Robot Framework automation scripts for testing the eBay mobile application using Appium. The current implementation includes a test case that searches for items on eBay and verifies that the price of the first search result is not zero.

## Prerequisites

Before setting up and running the tests, ensure that the following software is installed on your system:

- **Python**: Version 3.6 or higher.
- **Appium Server**: For automating mobile applications.
- **Robot Framework**: A generic test automation framework.
- **AppiumLibrary**: A Robot Framework library for Appium.

## Installation

1. **Clone the Repository**:

   ```bash
   git clone https://github.com/Zillion225/Appium_Ebay.git
   ```

2. **Navigate to the Project Directory**:

   ```bash
   cd Appium_Ebay
   ```

3. **Install Required Python Packages**:

   Ensure you have `pip` installed. Then, install the necessary packages using:

   ```bash
   pip install -r requirements.txt
   ```

   The `requirements.txt` file includes all the dependencies needed to run the tests.

## Setup

1. **Configure Appium Capabilities**:

   - Navigate to the `Resources` directory.
   - Open the `Capabilities.json` file.
   - Update the desired capabilities to match your test environment. This includes device name, platform version, app package, and app activity for the eBay application.

2. **Start Appium Server**:

   Ensure that the Appium server is running and accessible. You can start the Appium server using the command line or the Appium Desktop application.

## Running the Tests

1. **Execute the Test Suite**:

   You can run the test suite using the provided batch script:

   ```bash
   run.bat
   ```

   Alternatively, execute the tests directly with Robot Framework:

   ```bash
   robot -d Results Tests
   ```

   This command runs the test cases located in the `Tests` directory and outputs the results to the `Results` directory.

## Test Case Overview

The primary test case performs the following steps:

1. **Search for an Item**: Uses the search bar to look for a specified item (e.g., "Tesla") on the eBay app.
2. **Handle Popups**: Closes any warning popups that may appear during the search process.
3. **Verify Search Results**: Ensures that the search results page is displayed correctly with the relevant items.
4. **Check Item Price**: Retrieves the price of the first item in the search results and verifies that it is not zero.

## Logging and Results

- **Logs**: The test execution logs are available in the console output and provide detailed information about each step.
- **Results**: After execution, the results, including logs and reports, are stored in the `Results` directory. Review these files to analyze the test outcomes.

## License

This project is licensed under the MIT License. See the `LICENSE` file for more details.

## Acknowledgments

Special thanks to the contributors of the Robot Framework and Appium projects for providing the tools and libraries that make this automation possible.

For more information, visit the [Appium_Ebay GitHub repository](https://github.com/Zillion225/Appium_Ebay).
