<p align="center">
  <img src="./logo.png" />
</p>

# GameMaker Language Extended

## A GameMaker extension to complement GameMaker Studio 2.3+ built-in functions.

### Last updated: 2023-06-16

[![license](https://img.shields.io/github/license/DAndrewBox/GML-Extended?style=for-the-badge)](LICENSE)

### Author & Collaborators

Originally created by [**@DAndrewBox**](https://twitter.com/DAndrewBox_).

[![github](https://img.shields.io/badge/DAndrewBox-000?style=for-the-badge&logo=github&label=Github&logoColor=white)](https://github.com/DAndrewBox)

Collaborators:

[![github](https://img.shields.io/badge/Shynif-000?style=for-the-badge&logo=github&label=Github&logoColor=white)](https://github.com/Shynif)
[![github](https://img.shields.io/badge/Gizmo199-000?style=for-the-badge&logo=github&label=Github&logoColor=white)](https://github.com/Gizmo199)

### Special Thanks

- [**YoYo Games**](https://www.yoyogames.com/) for creating GameMaker.
- [**Xot**](https://twitter.com/xotmatrix) for a way to get the [unix timestamp](https://www.gmlscripts.com/script/unix_timestamp) used as a base for the `lib_time`.
- [**Shaun Spalding**](https://twitter.com/shaunspalding) for the original `array_shuffle` script.
- [**YellowAfterLife**](https://yal.cc) for `layer_get_element_ids_fixed` script base using tilemaps.

---

### Table of Contents

- [Installation](#installation)
- [Documentation](#documentation)
- [Contributing](#contributing)
- [License](#license)
- [Versioning & Compatibility](#versioning--compatibility)

---

### Installation

1. Download the latest release from the [releases page](https://github.com/DAndrewBox/GML-Extended/releases). **(Be sure you are downloading the correct version for your GameMaker version. Check the compatible versions in this table.)**

2. (A) Import the contents into your project just draggin the `gml-extended-[version].yymps` file into it.

3. (B) You can also import it into your project using the top toolbar on Tools > Import Local Package > Select the `gml-extended-[version].yymps` file.

4. A window should appear asking you to select the resources you want to import. Here, you can select what resources you want to import from the project (Importing all is recommended but you can select just the ones you need. You can always import more later, or download a version with less resources.)

5. Select the `GML-Extended` folder, press `Add All`, and then click `Import`.

<p style="text-align: center;">
  <img src="https://i.imgur.com/ErUhn3b.png" width="75%"/>
<p>

5. Resources should now be imported into your project in a main folder named `GML-Extended` or as a sub folder of `Libraries`, be sure to check both if exists.

<p style="text-align: center;">
  <img src="https://i.imgur.com/BfU9Tnw.png" width="75%"/>
<p>

6. You can now use the extension in your project.

---

### Documentation

The documentation is also available in the `Docs` folder of this repository or pressing the links below.

#### Core Functions

This are needed for the extension to work and must be always imported. Without these, the extension will not work.

- [**Arrays**](Docs/Core/Arrays.md)
- [**Colors**](Docs/Core/Colors.md)
- [**Files**](Docs/Core/Files.md)
- [**Math**](Docs/Core/Math.md)
- [**Shortcuts**](Docs/Core/Shortcuts.md)
- [**Strings**](Docs/Core/Strings.md)
- [**Structs**](Docs/Core/Structs.md)

#### Optional Functions

This are optional functions that you can import if you need them. You can import them all or just the ones you need.

- [**Draw**](Docs/Optional/Draw.md)
- [**Ease**](Docs/Optional/Ease.md)
- [**Game**](Docs/Optional/Game.md)
- [**Images**](Docs/Optional/Images.md)
- [**Instances & Events**](Docs/Optional/Instances_and_Events.md)
- [**Layers**](Docs/Optional/Layers.md)
- [**Time**](Docs/Optional/Time.md)

#### Experimental Functions

This are experimental functions that are still in development and are not recommended to use in production, these functions are subject to change and may be removed or implemented on another library in the future.

- [**HTTP**](Docs/Experimental/HTTP.md)
- [**Logger**](Docs/Experimental/Logger.md)
- [**Server (TCP)**](Docs/Experimental/ServerTCP.md)
- [**Shaders**](Docs/Experimental/Shaders.md)
- [**Sprites**](Docs/Experimental/Sprites.md)
- [**Surfaces**](Docs/Experimental/Surfaces.md)

**There's also an "Obsolete" folder with functions that are no longer needed or have been replaced by other functions**, these are kept for compatibility reasons you can still use them but they are not recommended to use in new projects. If you are using any of these functions, you should consider replacing them with the new ones. **Importing this folder is not recommended** if you are not using any of these functions and could break your project if you are using them.

---

### Contributing

If you want to contribute to this project, you can do so by forking this repository, finding the addecuate branch and submitting a pull request.
You can also submit an issue if you find a bug or want to suggest a new feature, I'm open to add new features to this extension as long as I can see a use for it.

---

### License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for more details.

---

### Versioning & Compatibility

Any of the releases of this extension are compatible with GameMaker Studio from versions 2.3 to 2022.9 (Including 2022.x LTS). But the table below shows the compatibility of each release.

✅: Fully compatible. (\*: Recommended for this version.)

⚠️: Compatible but could have some compatibility issues with the new features of the version.

❌: Not compatible.

| GameMaker Version | GML-Ext v1.0.0 | GML-Ext v1.1.x | GML-Ext v1.2.x | GML-Ext v1.3.x | GML-Ext v1.4.x |
| ----------------: | :------------: | :------------: | :------------: | :------------: | :------------: |
|      Studio 1.4.x |       ❌       |       ❌       |       ❌       |       ❌       |       ❌       |
|    Studio 2 - 2.2 |       ❌       |       ❌       |       ❌       |       ❌       |       ❌       |
|      Studio 2.3.x |       ✅       |      ✅\*      |       ❌       |       ❌       |       ❌       |
|        2022.x LTS |       ✅       |      ✅\*      |       ❌       |       ❌       |       ❌       |
|   2022.1 - 2022.9 |       ⚠️       |      ✅\*      |       ⚠️       |       ❌       |       ❌       |
|           2022.11 |       ❌       |       ⚠️       |      ✅\*      |       ⚠️       |       ❌       |
|   2023.1 - 2023.3 |       ❌       |       ⚠️       |       ✅       |      ✅\*      |       ⚠️       |
|           2023.4+ |       ❌       |       ❌       |       ❌       |       ✅       |      ✅\*      |

There's also branches for each GameMaker version. You can find them in the [branches page](https://github.com/DAndrewBox/GML-Extended/branches), or by clicking the links below.

- [**main**](https://github.com/DAndrewBox/GML-Extended) for the most recent version in the compatibility table.
- [**GML-Ext-v1.1.x**](https://github.com/DAndrewBox/GML-Extended/tree/GML-Ext-v1.1.x) for GameMaker Versions 2.3.x, 2022.1-9 and 2022.x LTS.
- [**GML-Ext-v1.3.x**](https://github.com/DAndrewBox/GML-Extended/tree/GML-Ext-v1.3.x) for GameMaker Versions 2023.1 - 2023.3.

#### For versions before 2022.11 I recommend using [**GML-Ext-v1.1.x**](https://github.com/DAndrewBox/GML-Extended/tree/GML-Ext-v1.1.x) due to versions 2022.11+ have new array and string functions that were not available in previous versions and now share the same name and functionality than the ones in the GML-Extended, so those functions were removed from the extension to prioritize compatibility and prevent conflicts.

---
