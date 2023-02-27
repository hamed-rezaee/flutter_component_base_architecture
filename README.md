# Deriv Component Generator

This is a command-line application that generates boilerplate code for a component. It generates code for the data layer, domain layer, and presentation layer using the following files:

- `extensions`: Contains extension methods that are used by the generator.
- `generator`: Contains the code that generates the files.
- `model_structure`: Contains the data structures used by the generator.
- `types`: Contains a map of Dart types.

The generator asks the user for the following information:

- The component name.
- The component directory postfix.
- The path where the component will be generated.
- The fields of the component's model.

Then it generates the following files:

### Data Layer

`component_model`: A class representing the component's data model.

`component_mapper`: A class that maps the component's data model to the domain model.

`component_repository`: A class that fetches the component's data from the data source.

### Domain Layer

`component_entity`: A class representing the component's domain model.

`component_service`: A class that handles the business logic of the component.

`base_repository`: An abstract class that defines the methods of the repository.

### Presentation Layer

`component_cubit`: A class that manages the state of the component.

`component_widget`: A widget that displays the component's UI.

## Architecture

#### Architecture Diagram

![Architecture Diagram](/architecture_diagram.png)

#### Sample Component Diagram

![Sample component Diagram](/sample_component_diagram.png)

## Running the Application

To run the application, execute the following command in the terminal:

```shell
dcli deriv_component_generator.dart
```

- Note: You need to have the `dcli` package installed in order to run the application.
