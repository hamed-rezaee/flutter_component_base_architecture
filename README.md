# Flutter Component Base Architecture

This architecture is based on a `clean architecture` pattern with the purpose of separating concerns and promoting modularity, testability and maintainability of the code. It includes the following components:

1. **Entities**: Represents the domain models of the application. It contains the data structure of the domain layer and is platform-independent.
2. **Models**: Represents the data models of the application. It contains the data structure of the data layer.
3. **Mappers**: Convert entities to models and vice versa.
4. **Repositories**: Manage the storage and retrieval of data from different data sources (e.g. local storage, network).
5. **Services**: Provide the business logic of the application. They orchestrate repositories to perform business operations and expose them to the presentation layer.
6. **Cubits**: Manage the state of the presentation layer. They react to user events, interact with services to perform business operations, and emit states to rebuild the UI.
7. **States**: Represent the different states of the presentation layer. They contain the data necessary to rebuild the UI and indicate the current status of the operation being performed.
8. **Widgets**: Build the UI using the states emitted by cubits.

By separating concerns, this architecture enables developers to easily replace or modify components without affecting the entire system. It also promotes testability by allowing for the easy creation of isolated tests for each component.

## Component Generator

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

#### Component Architecture Diagram

![Component Architecture UML Diagram](/component_architecture.png)

#### Architecture Diagram

![Architecture Diagram](/architecture_diagram.png)

#### Sample Component Diagram

![Sample component Diagram](/sample_component_diagram.png)

## Running the Application

To run the application, execute the following command in the terminal:

```shell
dcli component_generator.dart
```

Note: You need to have the `dcli` package installed in order to run the application.
