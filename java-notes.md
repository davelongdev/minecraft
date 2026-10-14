# Java notes: JDK, jar files, and build systems

*Written 2026-10-13 for a Python/C/MakeCode/Pybricks programmer who's learning Java to mod Minecraft 26.x and Hytale and to mentor an FTC team. Version numbers are as of that date; the "Sources" list at the end has every page these notes lean on.*

Java has three layers of tooling you'll meet before you write a line of code: the JDK (compiler and runtime), jar files (how compiled code travels), and a build system (almost always Gradle) that drives both. Coming from Python, the closest analogies are: the JDK is your `python3` plus `pip`'s compiler-ish bits, a jar is a wheel, the classpath is `sys.path`, and Gradle is `pip` + `make` + `venv` in one tool. Coming from C, `javac` is `gcc -c`, a jar is a `.a` archive you never link but load at run time, and Gradle is CMake with a package manager bolted on.

## The JDK

- **JVM** (Java Virtual Machine): the program that runs compiled Java bytecode. It's the interpreter plus a just-in-time compiler, like CPython but for `.class` files instead of `.pyc`.
- **JRE** (Java Runtime Environment): the JVM plus the standard library. Enough to *run* Java programs, not to compile them. Arch ships it as `jre-openjdk`; the Minecraft launcher ships its own private one.
- **JDK** (Java Development Kit): a JRE plus the developer tools. This is what you install to write code. Since JDK 11, the "JRE" is really just a subset of the JDK; most people install the JDK and never think about the JRE again.
- **Release cadence.** OpenJDK ships a new feature release every six months (March and September). Every two years one of them is marked **LTS** (long-term support): 17 (Sept 2021), 21 (Sept 2023), and 25 (Sept 2025); the next will be 29 in 2027. The other releases (24, 26, 27, ...) are supported only until the next one ships. **JDK 27 reached general availability on 15 September 2026 and is a non-LTS feature release**; its project page lists nine JEPs (G1 as the default garbage collector everywhere, compact object headers by default) and says nothing about LTS, because LTS is a promise the *distributors* make, not something in the source. Adoptium's roadmap commits to updates for 17 until at least Oct 2027, 21 until Dec 2029, and 25 until Sep 2031.
- **The tools you'll actually run**, with the JDK's own one-line descriptions:
  - `javac` — "read Java class and interface definitions and compile them into bytecode and class files". Think `gcc -c`.
  - `java` — "launch a Java application". Runs a class, a jar (`java -jar`), or since JDK 11 a `.java` source file directly.
  - `jar` — "create an archive for classes and resources, and manipulate or restore individual classes or resources from an archive". It's `zip` with a manifest; `jar tf foo.jar` lists, `jar xf` extracts.
  - `javap` — "disassemble one or more class files". `javap -c Foo.class` shows bytecode; handy for seeing what the compiler did.
  - `jshell` — a REPL: "interactively evaluate declarations, statements, and expressions". Your `python3` prompt equivalent.
  - `jlink` — "assemble and optimize a set of modules and their dependencies into a custom runtime image". You won't need it; it's how launchers like Mojang's build the stripped-down runtime they ship.
  - Also `jdeps` (dependency analyzer), `javadoc`, `jpackage`, `keytool`, and `jarsigner`.
- **Which JDK runs a tool vs which compiles your code.** These are separate questions, and most "wrong Java version" confusion is mixing them up:
  - *The JDK that runs Gradle.* Gradle 9.8 needs "a JVM version between 17 and 27" to start its daemon. Gradle 9.0 raised the floor to 17 (Gradle 8.14 was the last to start on Java 8). Running Gradle on a newer Java needs a newer Gradle: Java 25 needs 9.1.0+, 26 needs 9.4.0+, and 27 needs 9.8.0+. This is the JDK that `./gradlew` finds via `JAVA_HOME` or `PATH`.
  - *The toolchain that compiles, tests, and runs your code.* Set in `build.gradle`: `java { toolchain { languageVersion = JavaLanguageVersion.of(25) } }`. Gradle auto-detects installed JDKs (including `JAVA_HOME`, `/usr/lib/jvm`, SDKMAN) and, with the `org.gradle.toolchains.foojay-resolver-convention` plugin in `settings.gradle`, downloads a missing one into `~/.gradle/jdks`. "By default, Gradle uses the same Java toolchain for running Gradle itself and building JVM projects."
  - *The language and bytecode level.* `options.release = 25` (javac's `--release`) compiles against Java 25's API and emits 25 bytecode no matter which JDK does the compiling. `sourceCompatibility`/`targetCompatibility` are the older `-source`/`-target` flags and "do not protect against the use of APIs introduced in later Java versions". The Fabric template sets all three to 25.
  - *The IDE's project SDK.* IntelliJ, VS Code, and nvim's jdtls read the Gradle build to learn the classpath and toolchain; they still need a JDK of their own to run on (jdtls needs Java 21+). Keep the IDE's "project SDK" equal to the toolchain, or you'll see red squiggles that `./gradlew build` doesn't.

## Which JDK: OpenJDK, Adoptium Temurin, or Oracle JDK

- **OpenJDK is the source, not a download.**
  - It's "the place to collaborate on an open-source implementation of the Java Platform", licensed GPLv2 with the Classpath Exception (the exception lets you ship your own program linked against the JDK under any licence you like).
  - Every JDK below is a build of that same source tree, differing in who compiles it, how long they ship security updates, and what extras they add.
  - The serious ones pass Oracle's TCK compatibility test suite, so your mod compiles and runs identically on all of them.
- **Oracle JDK** is Oracle's branded build. Its licensing history is why "OpenJDK vs Oracle" became a question at all:
  - In 2019, updates for Oracle JDK 8 and 11 moved to the OTN licence: free for personal use and development, paid for commercial production.
  - From JDK 17 (2021), Oracle introduced the "No-Fee Terms and Conditions" (NFTC): free for everyone, "starting with Oracle JDK 17 and continue for one full year after the next LTS release", after which "Oracle intends to use the OTN License" for further updates. So Oracle JDK 17's free updates stopped a year after JDK 21 (autumn 2024), Oracle JDK 21's stop a year after JDK 25 (autumn 2026), and so on. Past that point you pay or you switch builds.
  - In 2023, the paid Java SE Universal Subscription moved to per-employee pricing (list $15 per employee per month for organisations under 1,000 people, counting every employee and contractor whether or not they use Java), with cheaper flat tiers added later for small organisations.
  - Oracle also publishes plain GPL builds of OpenJDK at jdk.java.net ("Production and Early-Access OpenJDK Builds, from Oracle"; today "Ready for use: JDK 27"), but only for the current release, no LTS updates.
- **Eclipse Temurin** (from the Adoptium working group at the Eclipse Foundation) is the vendor-neutral default.
  - Its own words: "Prebuilt OpenJDK Binaries for Free!", "Java SE TCK certified and AQAvit verified", "no licensing fees".
  - LTS updates for the years listed above: 17 to at least Oct 2027, 21 to Dec 2029, 25 to Sep 2031.
  - Adoptium runs a marketplace of other TCK-certified builds and an API that tools such as Gradle's foojay resolver and SDKMAN use to fetch JDKs, which is why tutorials, Docker images, and CI pipelines now default to it.
  - On Linux it ships apt/dnf/zypper/apk repositories (`temurin-25-jdk`) and plain tarballs you unpack anywhere and add to `PATH`; there's no pacman repo, only AUR packages (`jdk-temurin`, `jdk17-temurin`).
- **Arch's packages** (`jdk-openjdk` = current release, `jdk25-openjdk`, `jdk21-openjdk`, `jdk17-openjdk`, plus 11 and 8) are built by Arch from OpenJDK source. Arch keeps an LTS package as long as upstream OpenJDK maintains the branch, so 8 and 11 are still in `extra` with 2026 builds; that outlasts Oracle's NFTC window by years.
- **Other builds, briefly.**
  - Amazon Corretto: "no-cost, multiplatform, production-ready", versions 27/25/21/17/11/8, "long-term support". Common on AWS and in Docker images.
  - Microsoft Build of OpenJDK: built "following the same build scripts used by the Eclipse Adoptium project", TCK-passed, "a drop-in replacement for any other OpenJDK distribution". This is what Minecraft ships.
  - Azul Zulu and Red Hat's builds: same idea, different vendor.
  - GraalVM: Oracle's build with ahead-of-time native compilation; irrelevant to mods.
  - **JetBrains Runtime (JBR)**: JetBrains' fork that IntelliJ and Android Studio run on and bundle. It matters for debugging: stock HotSpot hot-swap can only replace method bodies, while JBR's DCEVM patch (`-XX:+AllowEnhancedClassRedefinition`) can add and remove methods and fields while the game or app is running.
- **Who bundles what.**
  - Minecraft 26.1+ ships "the Microsoft build of OpenJDK 25" as its runtime; the launcher's version JSON names it `java-runtime-epsilon`, major version 25, and installs it under `.minecraft/runtime/`.
  - Prism Launcher 9+ can "Auto-download Mojang Java" (the Flatpak and AppImage builds can; most distro packages can't), so *playing* never needs a system JDK. The Flathub Prism on this machine qualifies.
  - For FTC, Android Studio runs Gradle on its bundled JBR by default (`GRADLE_LOCAL_JAVA_HOME` "defaults to the JetBrains Runtime"); only a terminal `./gradlew` uses `JAVA_HOME`.
- **Does "Oracle JDK" vs "OpenJDK" ever matter functionally?** Not for mods or FTC. The historic differences (Oracle JDK bundling JavaFX until JDK 10, a few proprietary font and colour-management libraries, Flight Recorder being a paid feature before JDK 11) are gone for 17+. Pick by update length and convenience.
- **Recommendation for this machine, 2026-10-13:** install `jdk25-openjdk` from `extra` and make it the default (`sudo archlinux-java set java-25-openjdk`); keep `jdk-openjdk` (27) only if something needs it. Use Temurin when you're on a machine without a distro package (Windows, macOS, or the FTC team's laptops), and let Android Studio keep its JBR.

## Jar files and the classpath

- **A jar is a zip.** The spec says so: "A JAR file is essentially a zip file that contains an optional META-INF directory."
  - Inside are `.class` files laid out by package (`com/example/Foo.class`), resource files (textures, JSON, `fabric.mod.json`), and `META-INF/MANIFEST.MF`, a text file of `Key: Value` lines.
  - `unzip -l mod.jar` or `jar tf mod.jar` lists it; `unzip -p mod.jar META-INF/MANIFEST.MF` prints the manifest.
  - A `.class` file is one compiled class; a package is a directory path. The name the JVM looks up (`com.example.Foo`) and the path in the jar (`com/example/Foo.class`) must match exactly.
- **Manifest attributes that matter.**
  - `Main-Class`: "the class name of the main application class which the launcher will load at startup time" (no `.class` suffix). A jar with one is an *executable jar*: `java -jar app.jar`.
  - `Class-Path`: "the relative URLs of the libraries that this application needs", space-separated, resolved relative to the jar's own folder; "Relative URLs not ending with '/' are assumed to refer to JAR files". Only `java -jar` honours it.
  - `Implementation-Version`, `Automatic-Module-Name`, `Multi-Release`: metadata; NeoForge reads `Implementation-Version` when a mod sets `version="${file.jarVersion}"`.
  - Signing adds `META-INF/*.SF` and `*.RSA`/`*.DSA`/`*.EC` files; `jarsigner` creates and checks them. Mods aren't signed.
- **The classpath** is the list of places the JVM searches for a class, in order: directories of `.class` files and jars (never a directory *of* jars unless you write `dir/*`).
  - It's `sys.path` for Java, set per process, with no package manager at run time: a missing jar is simply a missing jar.
  - Colon-separated on Linux, semicolon on Windows:
    ```sh
    java -cp build/classes:libs/* com.example.Main   # directory + every jar in libs/
    java -jar app.jar                                # classpath = the jar + its Class-Path manifest entry
    ```
  - Gradle builds this list for you from the dependency configurations; the IDE asks Gradle for the same list.
- **The two errors.**
  - `ClassNotFoundException` is "thrown when an application tries to load in a class through its string name" (`Class.forName`, `ClassLoader.loadClass`) "but no definition for the class with the specified name could be found". Something asked for a class by name, typically a loader reading a config, and it isn't on any classpath.
  - `NoClassDefFoundError` is thrown when the JVM "tries to load in the definition of a class (as part of a normal method call or as part of creating a new instance using the new expression) and no definition of the class could be found. The searched-for class definition existed when the currently executing class was compiled". Your code compiled against a library that isn't there at run time: the classic symptom of a dependency that was `implementation` in Gradle but never bundled into the mod jar.
- **Fat, uber, or shadow jars.** Your jar normally contains only your classes; dependencies are separate jars.
  - A fat jar (same thing as an uber jar) copies every dependency's classes into one file so `java -jar` works alone. Paper plugins and standalone tools use them.
  - The Gradle Shadow plugin (`id "com.gradleup.shadow"`, task `shadowJar`, output `-all.jar`) does this and can *relocate* packages (rename `com.google.gson` to `mymod.libs.gson`) so two plugins bundling different versions don't collide.
  - Modders rarely need Shadow because the loaders have their own answer, nested jars, which keep each library as its own jar inside yours:
  - Fabric: the `include` configuration "declares a dependency that should be included as a jar-in-jar" in the output; it's "not transitive" (bundle each library you need explicitly), and "for non-mod dependencies, Loom will generate a mod JAR with a fabric.mod.json" so the loader can load it. Fabric API itself is never bundled; players install it.
  - NeoForge: the equivalent is jarJar (nested jars declared in the ModDevGradle build); the loader unpacks them at run time.
- **`sources.jar` and `javadoc.jar`** are companion jars (`foo-1.0-sources.jar`) holding source and docs; the Fabric template's `withSourcesJar()` produces one so IDEs can show your source. Loom's `genSources` task does the same for Minecraft by decompiling it.
- **The module system (JPMS)**, introduced in JDK 9, adds `module-info.java` files that declare what a jar `requires` and `exports`, and a *module path* that locates "whole modules" rather than the classpath's "individual types and resources". Anything without a `module-info` runs in the "unnamed module", which is where every Minecraft mod, Gradle plugin, and FTC app lives. Ignore JPMS until a library forces it on you.
- **How Minecraft itself is shipped.** There's no installer; the launcher assembles a classpath from a version JSON (`.minecraft/versions/26.3/26.3.json`) that lists:
  - `downloads.client`: the client jar, with sha1 and URL;
  - `libraries`: an array of Maven-style coordinates (`groupId:artifactId:version`), each with a download path under `.minecraft/libraries` (so the folder looks exactly like `~/.m2` or `~/.gradle/caches`);
  - `mainClass`, `assetIndex` (textures and sounds, fetched separately), and `javaVersion` (component `java-runtime-epsilon`, major 25).
  - The launcher downloads what's missing, builds a `-cp` list, and runs `mainClass` with the bundled runtime.
  - A mod loader install is just another version JSON with a different `mainClass` and extra libraries; Prism shows the same thing as "components" in an instance.
- **Android is different.** The Android Runtime doesn't execute `.class` files.
  - The Android Gradle Plugin runs `javac`, then `d8`, which "compile[s] your project's Java bytecode into DEX bytecode that runs on Android devices", taking "*.class files or containers, such as JAR, APK, or ZIP files" as input.
  - D8 also *desugars*: it rewrites newer language features (lambdas, default methods) into bytecode old Android versions can run, with `--min-api` setting the floor.
  - So an FTC TeamCode build goes `.java` → `.class` → `classes.dex` → `.apk`, and library jars (RobotCore, Hardware, Vision) go through D8 with it. The APK is installed on the Control Hub; nothing on the robot ever sees a jar.

## Build systems

### Gradle

Gradle is the build tool for Minecraft mods (Fabric, NeoForge), Hytale plugins, and every Android app. It downloads dependencies, compiles, tests, packages, and runs the game, driven by a script.

- **Two script dialects.** `build.gradle` is Groovy; `build.gradle.kts` is Kotlin. Same concepts, slightly different punctuation (`implementation "a:b:1"` vs `implementation("a:b:1")`). The Fabric and NeoForge templates default to Groovy; Android Studio's new-project templates default to Kotlin. Read whichever a template gives you.
- **The files.**
  - `settings.gradle` — names the root project and the subprojects, and its `pluginManagement { repositories { ... } }` block says where to fetch *plugins* (Fabric's template lists `https://maven.fabricmc.net/`, `mavenCentral()`, and `gradlePluginPortal()`).
  - `build.gradle` — applies plugins, declares dependencies, configures tasks.
  - `gradle.properties` — plain `key=value` settings read by both Gradle (`org.gradle.jvmargs=-Xmx1G`, `org.gradle.parallel=true`, `org.gradle.configuration-cache=true`) and your script (`minecraft_version=26.3`, `loader_version=0.19.5`, `loom_version=1.18-SNAPSHOT`, `fabric_api_version=0.162.0+26.3`). Templates put every version here so you never edit `build.gradle` for a bump.
  - `gradlew`, `gradlew.bat`, `gradle/wrapper/gradle-wrapper.jar`, `gradle/wrapper/gradle-wrapper.properties` — the **wrapper**.
    - The properties file pins the version: `distributionUrl=https\://services.gradle.org/distributions/gradle-9.7.1-bin.zip` in the current Fabric template.
    - Running `./gradlew` downloads that exact Gradle into `~/.gradle/wrapper/dists` once and uses it from then on.
    - Gradle's docs: "The recommended way to execute any Gradle build" is the wrapper, and "you need to check them into version control" so everyone (and every CI run) builds with the same version. That's why the template ships a committed jar.
    - Never install Gradle system-wide for a project that has a wrapper; `pacman -S gradle` would only matter for creating a brand-new project without one.
    - Upgrade with the wrapper task, run twice so it updates its own scripts too:
      ```sh
      ./gradlew wrapper --gradle-version 9.8.1
      ./gradlew wrapper --gradle-version 9.8.1
      ```
- **Plugins** add tasks and conventions: `id 'java'` gives you `compileJava`/`jar`/`test`; `id 'net.fabricmc.fabric-loom' version "${loom_version}"` gives you Minecraft; `id 'com.android.application'` gives you APKs.
- **Dependencies** are coordinates `group:artifact:version`, e.g. `net.fabricmc:fabric-loader:0.19.5`, fetched from **repositories** (Maven Central, Google's maven for Android, `maven.fabricmc.net`, `maven.neoforged.net`). Loom adds the Minecraft and Fabric repositories for you. Each dependency goes in a **configuration** that says *when* it's needed:
  - `implementation` — compile and run time, not re-exported to projects that depend on you (prefer this).
  - `api` — like `implementation` but exported to consumers (library projects only).
  - `compileOnly` — "required at compile time, but not at runtime" (an API you expect the game or another mod to provide).
  - `runtimeOnly` — "only required at runtime" (a driver, a logging backend).
  - `include` (Fabric) / `jarJar` (NeoForge) — bundle into the jar, in addition to one of the above.
  - `./gradlew dependencies` prints the resolved tree per configuration.
- **Tasks** are the verbs; `./gradlew tasks` lists them with descriptions.
  - From the Java plugin: `compileJava`, `processResources`, `classes`, `jar`, `test`; `assemble` (includes `jar`), `check` (includes `test`), and `build` (both); `clean` deletes `build/`.
  - From Loom: `runClient` ("launch Fabric Loader as a Minecraft client"), `runServer`, `genSources` (decompile Minecraft for the IDE), `downloadAssets`, and `vscode`/`ideaSyncTask` (write IDE run configurations).
  - From NeoForge's ModDevGradle: `runClient`/`runServer` too, with output in `build/libs/<name>-<version>.jar`.
  - Tasks declare dependencies on each other, so `./gradlew build` compiles first; `-x test` skips one.
- **The daemon** is "a long-lived, persistent process that runs in the background and hosts Gradle's execution engine" so the second build is fast; it exits after three idle hours. `./gradlew --status` lists daemons, `./gradlew --stop` kills them (do this before deleting caches), `--no-daemon` skips it.
- **Offline and caches.**
  - `./gradlew --offline build` "operate[s] without accessing network resources" once everything is cached (handy at the studio with no Wi-Fi); `--refresh-dependencies` forces a re-download.
  - Gradle User Home is `~/.gradle` (override with the `GRADLE_USER_HOME` environment variable). Inside:
    - `caches/modules-2` — "downloaded module dependencies (POMs, JARs, metadata)", shared by every project and Gradle version;
    - `caches/<gradle-version>` — compiled build scripts and other recreatable files;
    - `caches/fabric-loom` — Loom's Minecraft jars, mappings, and decompiled sources;
    - `wrapper/dists` — the Gradle zips the wrapper downloaded;
    - `jdks` — toolchain-downloaded JDKs; `daemon` — daemon logs.
  - Size: nothing official, but expect a few GB after a couple of mod projects (each Minecraft version adds client, server, and decompiled jars).
  - Gradle auto-cleans every 24 hours: unused wrapper distributions after 30 days, downloaded dependencies after 30 days unused, recreatable files and build-cache entries after 7, daemon logs after 14.
  - Manual reset, in this order (everything re-downloads on the next build):
    ```sh
    ./gradlew --stop
    rm -rf ~/.gradle/caches
    ```
  - The per-project `.gradle/` and `build/` folders are disposable too (`./gradlew clean` removes `build/`).
- **Gradle's own JDK vs toolchains.** Gradle 9 needs Java 17–27 to run; your project's `java { toolchain { languageVersion = JavaLanguageVersion.of(25) } }` can name a different JDK, and the foojay resolver plugin will download it if it's missing (GA releases only). Disable downloads with `org.gradle.java.installations.auto-download=false` in `gradle.properties` if you'd rather manage JDKs with pacman.

### Maven

Maven is Gradle's older sibling: XML instead of a script, and a fixed **lifecycle** instead of ad-hoc tasks.

- The `pom.xml` (Project Object Model) declares coordinates, dependencies, and plugins. Dependencies use the same `groupId`/`artifactId`/`version` triple Gradle borrowed; the local cache is `~/.m2/repository`.
- "There are three built-in build lifecycles: default, clean and site."
  - The default phases run in order: `validate`, `compile`, `test`, `package` ("take the compiled code and package it in its distributable format, such as a JAR"), `verify`, `install` ("install the package into the local repository"), `deploy`.
  - Naming a phase runs every phase before it, so `mvn package` compiles and tests first; `mvn clean package` is the everyday command.
  - "Plugins are artifacts that provide goals to Maven", and goals are bound to phases; `mvn dependency:tree` calls a goal directly.
- Where you'll still meet it: Paper/Spigot plugin tutorials (their docs offer both), many Java textbooks and Stack Overflow answers, and some library READMEs that give only the `<dependency>` XML. You translate `<groupId>a</groupId><artifactId>b</artifactId><version>1</version>` to `implementation "a:b:1"`.

### Lighter tools

- **Plain `javac` and `jar`** for the first week. Everything a build tool does is visible:
  ```sh
  mkdir -p out
  javac -d out src/Hello.java        # .java -> out/Hello.class
  java -cp out Hello                 # run it from the classpath
  jar --create --file hello.jar --main-class Hello -C out .
  java -jar hello.jar                # Main-Class from the manifest
  ```
- **Source-file launch.** `java Hello.java` compiles in memory and runs (JEP 330, JDK 11). Since JDK 22 (JEP 458) it follows references to other files: "running the initial file compiles its classes in memory" and any `Helper.java` it references is found by the usual package layout, so a small multi-file program needs no build at all. Add jars with `java --class-path 'libs/*' Main.java`. Shebang scripts stay single-file.
- **jbang** is a third-party launcher that extends that idea: `jbang Hello.java`, dependencies declared in a `//DEPS group:artifact:version` comment at the top of the file, and it fetches a JDK if none is present. Good for scripts and demos, not for mods. (Its docs site returned 404s during this research; the project is at jbang.dev.)

### How IDEs and jdtls see a Gradle project

- IntelliJ IDEA, Android Studio, and Eclipse's **Buildship** (which nvim and VS Code use through **jdtls**, the Eclipse JDT language server) don't parse `build.gradle` themselves; they ask Gradle through the Gradle Tooling API for the classpath, source sets, and toolchain. So the editor's view *is* the build's view, as long as you import the folder as a Gradle project and re-sync after editing build files. Never add jars by hand in the IDE.
- jdtls "requires a runtime environment of Java 21 (at a minimum) to run", found via `JAVA_HOME` or `PATH`; that's separate from the project's toolchain, which it reads from Gradle.
- Android Studio stores its Gradle JDK choice in `.idea/gradle.xml` (`gradleJvm`); the docs recommend leaving it on `GRADLE_LOCAL_JAVA_HOME` (the bundled JBR) and, if you also build from a terminal, setting `JAVA_HOME` to the same JDK.

## How the pieces fit for a Minecraft mod, and for an FTC project

### A Fabric mod on Minecraft 26.3

1. Install `jdk25-openjdk`. Minecraft 26.1 was "the first to require Java 25", and both Fabric ("To develop mods for Minecraft 26.1, you will need JDK 25") and NeoForge ("the Java 25 Development Kit") say the same.
2. Generate a project at fabricmc.net's template generator (or clone `fabric-example-mod`), in a path with no spaces, cloud sync, or non-ASCII characters. You get: `gradlew` + `gradle/wrapper/` (Gradle 9.7.1 pinned), `settings.gradle` (Fabric maven + `rootProject.name`), `build.gradle` (Loom plugin, `minecraft`/`implementation` dependencies, `options.release = 25`, `withSourcesJar()`, `processResources` filling `${version}` into `fabric.mod.json`), `gradle.properties` (all versions), `src/main/java` + `src/main/resources/fabric.mod.json` (+ mixin JSON), and `src/client/java` for client-only code.
3. `./gradlew genSources` once (decompiles Minecraft so the IDE can show its source), `./gradlew runClient` to play with the mod, `./gradlew build` to get `build/libs/<name>-<version>.jar`. Drop that jar into a Prism instance's `mods/` folder with Fabric API.
4. When it doesn't load, work down this list: is `fabric.mod.json` at the jar root with the right `id`, `entrypoints` class names, and `depends` versions? Did a library you used at compile time get `include`d? Does the jar's Minecraft version match the instance? Read `latest.log`; a `NoClassDefFoundError` names the missing class and therefore the missing jar.
5. JDK 27 can stay installed alongside 25: Arch's packages don't conflict, Gradle 9.8 runs on either, and `options.release = 25` makes the output identical. Just keep the toolchain or default JDK at 25 so Loom and the game runtime agree.

### Hytale

Hytale's deep-customisation route is Java server plugins packaged as jars in the server's `mods/` folder, built with Gradle on JDK 25 according to community guides (Hypixel's own documentation was still "in progress" in its November 2025 modding update, and updates have broken plugins at the protocol level). Everything above about jars, Gradle, and toolchains applies unchanged; treat version-specific API facts as perishable.

### The FTC Robot Controller (SDK 12.0)

- The SDK is an Android Studio project: open it with "Android Studio Narwhal 3 Feature Drop or later" (the 11.2 notes: "Gradle is upgraded to v9.1 and the Android Gradle Plugin is updated to v8.13.2"; the wrapper pins Gradle 9.1.0). Your code goes in `TeamCode/src/main/java/org/firstinspires/ftc/teamcode/`; `TeamCode/build.gradle` has `implementation project(':FtcRobotController')`, and `build.dependencies.gradle` pulls `org.firstinspires.ftc:RobotCore:12.0.0` and friends from Maven.
- `build.common.gradle` sets `compileSdkVersion 30`, `minSdkVersion 24`, `targetSdkVersion 28`, and `sourceCompatibility`/`targetCompatibility` `JavaVersion.VERSION_1_8`. That last line is why FTC code is written in Java 8 syntax (no records, no switch expressions, no `var` in lambdas) even though the JDK compiling it is 17 or newer: "OnBotJava only supports Java 1.8", and the SDK keeps Android Studio and the on-robot editor compatible.
- Which JDK runs the build: Android Studio's bundled JetBrains Runtime (Ladybug shipped JBR 21; AGP 8.x needs at least 17). You don't install anything for it, and the Arch JDK 25/27 are irrelevant unless you run `./gradlew` from a terminal, where `JAVA_HOME` or `PATH` decides. Gradle 9.1 can start on Java 17–25, so a terminal build with `JAVA_HOME=/usr/lib/jvm/java-25-openjdk` works; Java 27 would need Gradle 9.8, which this SDK doesn't pin, so don't point the FTC build at 27.
- Coexistence summary: Minecraft wants 25, FTC wants whatever Android Studio bundles, Arch's default can be 27 for everything else. `archlinux-java` switches the default; Gradle toolchains and `JAVA_HOME` override per project.

## Arch Linux specifics

- **Packages** (all in `extra`, checked 2026-10-13): `jdk-openjdk 27.u35-1` (the current release; this machine has it, set as default), `jdk25-openjdk 25.0.4.1.u1-1`, `jdk21-openjdk 21.0.12.1.u1-1`, `jdk17-openjdk 17.0.20.1.u1-1`, `jdk11-openjdk`, `jdk8-openjdk`. Each has `jreNN-openjdk` and `jreNN-openjdk-headless` siblings; JDK, JRE, and headless JRE of the *same* version conflict (the smaller ones are subsets), but different versions install side by side under `/usr/lib/jvm/java-NN-openjdk`. The wiki: "All these JVMs can be installed without conflict."
- **Switching:** `archlinux-java status` lists environments, `sudo archlinux-java set java-25-openjdk` points the `/usr/lib/jvm/default` and `default-runtime` symlinks, `archlinux-java fix` repairs a broken link. `/etc/profile.d/jre.sh` puts `/usr/lib/jvm/default/bin` on `PATH`, so `java -version` follows the default.
- **`JAVA_HOME`:** "Arch does not use JAVA_HOME. If a program explicitly requires JAVA_HOME, set JAVA_HOME=/usr/lib/jvm/default." For a one-off: `JAVA_HOME=/usr/lib/jvm/java-25-openjdk ./gradlew build`. Gradle also finds every `/usr/lib/jvm/*` JDK by itself for toolchains, so you rarely need the variable at all.
- **Other vendors** are AUR-only: `jdk-temurin`, `jdk17-temurin`, Zulu (`zulu-21-bin`), Liberica, Oracle's `jdk`. They install under `/usr/lib/jvm/java-NN-<vendor>` and work with `archlinux-java` if packaged properly.
- **Prism Launcher** from Flathub can auto-download Mojang's runtime; a system JDK is only for building mods.
- **Install for this project:**
  ```sh
  sudo pacman -S jdk25-openjdk
  sudo archlinux-java set java-25-openjdk
  java -version
  ```

## Glossary

- **AGP** — Android Gradle Plugin; the Gradle plugin that builds APKs and runs D8.
- **APK / DEX** — Android's app package and its bytecode format; D8 converts `.class` to DEX.
- **Classpath** — the ordered list of directories and jars the JVM searches for classes (`-cp`).
- **Configuration (Gradle)** — a named bucket of dependencies that says when they're needed: `implementation`, `compileOnly`, `runtimeOnly`, `api`, `include`.
- **Coordinates** — `group:artifact:version`, the address of a library in a Maven repository.
- **Daemon** — Gradle's background process that keeps the JVM warm between builds.
- **Fat / uber / shadow jar** — one jar with all dependencies copied in; Shadow is the Gradle plugin that makes one.
- **Jar** — Java ARchive; a zip of classes and resources with an optional manifest.
- **Jar-in-jar / jarJar** — a mod jar that carries library jars inside it for the loader to unpack (Fabric `include`, NeoForge jarJar).
- **JBR** — JetBrains Runtime; the JDK build IntelliJ and Android Studio ship with, notable for enhanced hot-swap.
- **JDK / JRE / JVM** — development kit (compiler + tools + runtime), runtime only, and the virtual machine inside both.
- **JEP** — JDK Enhancement Proposal; the design documents that define each feature (JEP 458 = multi-file source launch).
- **JPMS** — Java Platform Module System; `module-info.java` and the module path. Mods ignore it.
- **LTS** — long-term support release (17, 21, 25); a distributor's update promise, not a property of the code.
- **Manifest** — `META-INF/MANIFEST.MF`; `Main-Class` makes a jar runnable with `java -jar`.
- **Mixin** — Fabric/NeoForge's bytecode-patching system for changing Minecraft classes; configured by a JSON named in the mod descriptor.
- **NFTC / OTN** — Oracle's two licences: No-Fee Terms (free until a year after the next LTS) and the older OTN licence (paid for commercial production use).
- **Plugin (Gradle)** — reusable build logic that adds tasks and conventions (Java, Loom, AGP, Shadow).
- **POM** — Maven's `pom.xml` project description; also the metadata file beside every jar in a Maven repository.
- **Repository (Maven)** — an HTTP directory of jars and POMs arranged by coordinates (Maven Central, maven.fabricmc.net).
- **Task** — a Gradle unit of work (`build`, `jar`, `runClient`); `./gradlew tasks` lists them.
- **TCK** — Technology Compatibility Kit; Oracle's test suite a build must pass to call itself Java SE compatible.
- **Toolchain (Gradle)** — the JDK Gradle uses to compile, test, and run your project, independent of the JDK that runs Gradle.
- **Wrapper** — `gradlew` plus `gradle/wrapper/`; downloads and runs the pinned Gradle version. Commit it.
- **`--release`** — javac flag (Gradle `options.release`) that compiles against a specific Java version's API and bytecode level.

## Sources

- JDK tool descriptions: https://docs.oracle.com/en/java/javase/25/docs/specs/man/index.html
- OpenJDK home and licence: https://openjdk.org/ and https://openjdk.org/legal/gplv2+ce.html
- JDK 27 project page: https://openjdk.org/projects/jdk/27/
- Oracle OpenJDK builds: https://jdk.java.net/
- Oracle NFTC announcement: https://blogs.oracle.com/java/free-java-license (summary: https://www.infoq.com/news/2021/10/oracle-jdk-free-again/)
- Oracle per-employee pricing: https://i-programmer.info/news/80-java/16048-oracle-hikes-java-prices.html and https://blogs.oracle.com/java/?p=403
- Adoptium support roadmap, Temurin, marketplace, Linux install: https://adoptium.net/support/ , https://adoptium.net/temurin/ , https://adoptium.net/marketplace/ , https://adoptium.net/installation/linux/
- Microsoft Build of OpenJDK: https://learn.microsoft.com/en-us/java/openjdk/overview
- Amazon Corretto: https://aws.amazon.com/corretto/
- JetBrains Runtime releases and hot-swap: https://github.com/JetBrains/JetBrainsRuntime/releases , https://blog.jetbrains.com/?p=24453%2F , https://cdn.jsdelivr.net/gh/hotswapprojects/hotswapagent@master/README.md
- Arch Wiki "Java": https://wiki.archlinux.org/title/Java ; package search: https://archlinux.org/packages/?q=openjdk ; Prism packaging note: https://gitlab.archlinux.org/archlinux/packaging/packages/prismlauncher/-/merge_requests/2
- JAR File Specification: https://docs.oracle.com/en/java/javase/25/docs/specs/jar/jar.html
- ClassNotFoundException / NoClassDefFoundError: https://docs.oracle.com/en/java/javase/25/docs/api/java.base/java/lang/ClassNotFoundException.html , https://docs.oracle.com/en/java/javase/25/docs/api/java.base/java/lang/NoClassDefFoundError.html
- JEP 261 (modules): https://openjdk.org/jeps/261 ; JEP 458 (multi-file source launch): https://openjdk.org/jeps/458
- Shadow plugin: https://gradleup.com/shadow/
- Gradle docs: compatibility https://docs.gradle.org/current/userguide/compatibility.html ; toolchains https://docs.gradle.org/current/userguide/toolchains.html ; wrapper https://docs.gradle.org/current/userguide/gradle_wrapper.html ; directory layout https://docs.gradle.org/current/userguide/directory_layout.html ; daemon https://docs.gradle.org/current/userguide/gradle_daemon.html ; CLI https://docs.gradle.org/current/userguide/command_line_interface.html ; Java library plugin https://docs.gradle.org/current/userguide/java_library_plugin.html ; building Java https://docs.gradle.org/current/userguide/building_java_projects.html ; dependency basics https://docs.gradle.org/current/userguide/dependency_management_basics.html ; 9.0.0 release notes https://docs.gradle.org/9.0.0/release-notes.html ; releases https://github.com/gradle/gradle/releases
- Maven lifecycle: https://maven.apache.org/guides/introduction/introduction-to-the-lifecycle.html
- jbang: https://www.jbang.dev/
- jdtls README: https://github.com/eclipse-jdtls/eclipse.jdt.ls
- Fabric: docs https://docs.fabricmc.net/develop/getting-started/setting-up , https://docs.fabricmc.net/develop/getting-started/creating-a-project , https://docs.fabricmc.net/develop/getting-started/project-structure ; Loom wiki https://wiki.fabricmc.net/documentation:fabric_loom ; Loom releases https://github.com/FabricMC/fabric-loom/releases ; example mod https://github.com/FabricMC/fabric-example-mod
- NeoForge: https://docs.neoforged.net/docs/gettingstarted/ , https://docs.neoforged.net/docs/gettingstarted/modfiles
- Minecraft Wiki: https://minecraft.wiki/w/Java_Edition_26.1 , https://minecraft.wiki/w/Client.json
- Prism Launcher Java: https://prismlauncher.org/wiki/getting-started/installing-java/
- Hytale: https://hytale.com/news/2025/11/hytale-modding-strategy-and-status , https://hytalemodding.dev/en/docs/established-information/server/content-categories/plugin
- Android: D8 https://developer.android.com/tools/d8 ; JDKs in Android builds https://developer.android.com/build/jdks ; Android Studio releases https://developer.android.com/studio/releases
- FTC SDK: https://github.com/FIRST-Tech-Challenge/FtcRobotController (README release notes, `build.common.gradle`, `build.dependencies.gradle`, `TeamCode/build.gradle`, `gradle/wrapper/gradle-wrapper.properties`)
