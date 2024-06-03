# 🚀 Getting Started

## 💾 Installation

1. Download the latest release from the [releases page](https://github.com/DAndrewBox/GML-Extended/releases). **(Be sure you are downloading the correct version for your GameMaker version. Check the compatible versions in this table.)**

2. (A) Import the contents into your project just draggin the `gml-extended-[version].yymps` file into it.

3. (B) You can also import it into your project using the top toolbar on Tools > Import Local Package > Select the `gml-extended-[version].yymps` file.

4. A window should appear asking you to select the resources you want to import. Here, you can select what resources you want to import from the project (Importing all is recommended but you can select just the ones you need. You can always import more later, or download a version with less resources.)

5. Select the `GML-Extended` folder, press `Add All`, and then click `Import`.

> [!NOTE]
> You can choose which resources to import, but I recommend to import all of them to avoid any issues with dependencies. If you don't want to import all the resources, be sure to import at least the `Functions > Core` and `Functions > Compatibility` since are is required for all the extension to work properly in all GameMaker Versions listed.

<p style="text-align: center;">
  <img src="https://i.imgur.com/TZ6m9JO.png" width="75%"/>
<p>

6. Resources should now be imported into your project in a main folder named `GML-Extended` or as a sub folder of `Libraries`, be sure to check both if exists.

<p style="text-align: center;">
  <img src="https://i.imgur.com/0U80dm7.png" width="50%"/>
<p>

7. You can now use the extension in your project.

---

## 🛠️ Troubleshooting

### **I can't find the resources in my project.**

- Be sure to check the `GML-Extended` folder or the `Libraries` folder in your project. If you still can't find it, try to import the resources again.

### **I can't import the resources into my project.**

- Be sure you are importing the correct version of the extension for your GameMaker version. Check the compatibility table in the [Versioning & Compatibility](./Versioning-&-Compatibility) section.

- If you are still having trouble, try to import the resources manually. You can find the resources in the `GML-Extended` folder inside the `.yymps` file.

### **I imported the files but I cannot run the project or the functions are not working.**

- GML-Extended depends on the `Functions > Core` folder to work properly. Be sure to import the `Core` folder along with the other resources. If you still have trouble, try to import the `Core` folder manually.

- Additionally, check if the problems are not related to the GameMaker version compatibility. Check the compatibility table in the [Versioning & Compatibility](./Versioning-&-Compatibility) section.

- Another cause could be with the `Functions > Experimental` folder. If you are using the experimental functions, this folder is not required and have no peer dependencies, but if you are using the experimental functions that could be change, removed or added to the library in the future, be sure to import the `Experimental` folder along with the other resources.

### **I imported the files but I'm getting errors when running the project.**

- Be sure to check the `Output` tab in GameMaker Studio 2 for any errors. If you can't find the error, try to import the resources again. If the error persists, report it in the issues section of the repository.
