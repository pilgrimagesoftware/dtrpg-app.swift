## Purpose
Define how the Swift macOS application loads, presents, and refreshes the product library so library screens react predictably to navigation, filters, and updated data.

## Requirements

### Requirement: The macOS app must define library view state behavior
The Swift macOS application MUST define how product library state is loaded, displayed, and refreshed within the application.

#### Scenario: Opening the library view
- **WHEN** a user navigates to the library view
- **THEN** the app applies the documented loading and display behavior for the library state

### Requirement: Library state changes must be handled predictably
The Swift macOS application MUST define how filtering, refreshes, and result updates affect visible library state.

#### Scenario: Refreshing the library after a filter or data change
- **WHEN** the user refreshes the library or changes a supported filter
- **THEN** the app updates the visible library state according to the documented behavior
