<p align="center">
  <img src="./logo.png" />
</p>

# GameMaker Language Extended
## A GameMaker extension to complement GameMaker Studio 2.3+ built-in functions.
### Last updated: 2022-11-30

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

2. (B) You can also import it into your project using the top toolbar on Tools > Import Local Package > Select the `gml-extended-[version].yymps` file.

---

### Documentation
The documentation is also available in the `Docs` folder of this repository or pressing the links below.
- [**Arrays**](Docs/Arrays.md)
- [**Files**](Docs/Files.md)
- [**HTTP**](Docs/HTTP.md)
- [**Logger**](Docs/Logger.md)
- [**Math**](Docs/Math.md)
- [**Server (TCP)**](Docs/ServerTCP.md)
- [**Shaders**](Docs/Shaders.md)
- [**Sprites**](Docs/Sprites.md)
- [**Strings**](Docs/Strings.md)
- [**Structs**](Docs/Structs.md)
- [**Surfaces**](Docs/Surfaces.md)
- [**Time**](Docs/Time.md)

---

### Contributing
If you want to contribute to this project, you can do so by forking this repository, finding the addecuate branch and submitting a pull request.

---

### License
This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for more details.

---

### Versioning & Compatibility
Any of the releases of this extension are compatible with GameMaker Studio from versions 2.3 to 2022.9 (Including 2022.x LTS). But the table below shows the compatibility of each release.

✅: Fully compatible.

⚠️: Compatible but could have some compatibility issues with the new features of the version.

❌: Not compatible.

| GameMaker Version | GML-Ext v1.0.0 | GML-Ext v1.1.x | GML-Ext v1.2.x |
| ---: | :---: | :---: | :---: |
| Studio 1.4.x      | ❌ | ❌ | ❌ |
| Studio 2.3.x      | ✅ | ✅ | ✅ |
| 2022.x LTS        | ✅ | ✅ | ✅ |
| 2022.1 - 2022.9   | ✅ | ✅ | ✅ |
| 2022.11           | ❌ | ⚠️ | ✅ |

There's also branches for each GameMaker version. You can find them in the [branches page](https://github.com/DAndrewBox/GML-Extended/branches), or by clicking the links below.
- [**main**](https://github.com/DAndrewBox/GML-Extended) for the most recent version in the compatibility table (GameMaker Versions 2.11+ by the time I wrote this).
- [**GML-Ext-v1.1.x**](https://github.com/DAndrewBox/GML-Extended/tree/GML-Ext-v1.1.x) for GameMaker Versions 2.3.x, 2022.1-9 and 2022.x LTS.

---