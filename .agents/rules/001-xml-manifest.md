---
trigger: always_on
---

---
name: "XML Manifest Cascade"
description: "Ensure AI Agent always use XML file as a manifest to load each file of the project instiead of named it inside TOC file. Each folder have a XML manifest and loads each file and subfolder XML manifest file."
globs: `src/**`
---

# XML Manifest Cascade Loading
There must be a XML file at the root of each new foolder using the same name as the folder that loads each file inside the folder and other XML Manifest file inside subfolders.

* **One folder, One manifest:** Whenever you create a new folder, inmediatly create a XML file with the same name with this tag element.
```xml
<Ui xmlns="http://www.blizzard.com/wow/ui/" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://www.blizzard.com/wow/ui/
https://raw.githubusercontent.com/Meorawr/wow-ui-schema/main/UI-Classic.xsd">
<!-- 
   Each file must be loaded here 
   For lua files use <Script file="src\..." />
   For XML files use <Include file="src\.." />
-->
</Ui>
```

* **Manifest file against Frame XML:** Do MUST not trait all XML file as a Manifest. Manifest file ALWAYS match folders name where their live AND use UPPERCASE names. Frame XML will use `index.xml` or `main.xml` for orchestrator AND PascalCase name for each component created AND shall use a representative name.
```
WLV_Extends.xml -> Manifest
src/SRC.xml -> Manifest
src/frames/FRAMES.xml -> Manifest
src/frames/main.xml -> UI Orchestrator.
src/frames/components/RedBigButton.xml -> UI Components template.
```