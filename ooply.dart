
import 'dart:io';

// Define an interface for a shape
abstract class Shape {
  double get area;
}

// Define a class for a rectangle that implements the Shape interface
class Rectangle implements Shape {
  final double width;
  final double height;

  Rectangle(this.width, this.height);

  @override
  double get area => width * height;
}

// Define a class for a circle that also implements the Shape interface
class Circle implements Shape {
  final double radius;

  Circle(this.radius);

  @override
  double get area => 3.14 * radius * radius;
}

// Define a class for reading data from a file
class FileReader {
  final String filePath;

  FileReader(this.filePath);

  List<String> readLines() {
    List<String> lines = [];
    File file = File(filePath);
    if (file.existsSync()) {
      lines = file.readAsLinesSync();
    }
    return lines;
  }
}

// Define a class for processing the data from the file
class DataProcessor {
  List<Shape> processData(FileReader fileReader) {
    List<Shape> shapes = [];
    List<String> lines = fileReader.readLines();
    for (String line in lines) {
      List<String> parts = line.split(',');
      if (parts.length == 2) {
        double width = double.parse(parts[0]);
        double height = double.parse(parts[1]);
        shapes.add(Rectangle(width, height));
      } else if (parts.length == 1) {
        double radius = double.parse(parts[0]) / 2;
        shapes.add(Circle(radius));
      }
    }
    return shapes;
  }
}

// Define a class for calculating the total area of all shapes
class TotalAreaCalculator {
  double calculateTotalArea(List<Shape> shapes) {
    double totalArea = 0;
    for (Shape shape in shapes) {
      totalArea += shape.area;
    }
    return totalArea;
  }
}

void main() {
  // Initialize an instance of the FileReader class with the path to the data file
  FileReader fileReader = FileReader('data.txt');

  // Initialize an instance of the DataProcessor class
  DataProcessor dataProcessor = DataProcessor();

  // Read the data from the file and process it into a list of Shape objects
  List<Shape> shapes = dataProcessor.processData(fileReader);

  // Initialize an instance of the TotalAreaCalculator class
  TotalAreaCalculator totalAreaCalculator = TotalAreaCalculator();

  // Calculate the total area of all shapes
  double totalArea = totalAreaCalculator.calculateTotalArea(shapes);

  // Print the total area to the console
  print('Total area: $totalArea');
}