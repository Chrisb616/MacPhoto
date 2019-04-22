# MacPhoto
Simple Photo Organization App for the Mac. WIP

Built in Swift on Xcode for OSX

# Project Structure

- **View** classes deal with visual user interactable classes. They only communicate with the Service layer. Follows Mac OS conventioon.
- **Service** classes managage Tool and Model data for access by the view classes. They are organized into major app capabilities. Methods should be named after placement within view processes (i.e. onWindowLoad).
- **Tools** classes are data classes that handle complex tasks with results too abstract or raw for access directly from the View. Methods should be named based on the task being carried out (i.e. reloadAllData)
- **Model** classes are functionless data structures which serve the purpose of organizing data into usable parts.

##Project Basics ToDo

1. <del>Drag and drop photo into window to save in program directory.</del>
2. <del>Select directory to load photos from to save in program directory.</del>
3. <del>Save photo info in JSON format in program directory.</del>
4. <del>Load photo info from JSON to populate program with photos.</del>
5. Create person in app, which can be tagged in photos.
6. <del>Save person info in JSON format in program directory.</del>
7. <del>Load person info from JSON to populate program with people.</del>
8. <del>Associate photos with tagged people upon load.</del>
9. Create location (abstracted into Spot for geographic coordinates, and Area for non specific regions) in app, which can be tagged on photos.
10. Save location info in JSON format in program directory.
11. Load location info from JSON to populate program with Spots, Areas, and Regions.
12. Associate photos with tagged spots upon load.
13. <del>Allow for change in project directory.</del>
14. <del>Create collection view of images.</del>
15. Allow for tags of photos.
16. Filter images by tags, locations, people, etc.
17. Show spots on map.

##Next Steps ToDo
1. Facial Recognition
2. Open image in Photoshop
