allprojects {
    repositories {
        google()
        mavenCentral()
    }
}

val newBuildDir: Directory =
    rootProject.layout.buildDirectory
        .dir("../../build")
        .get()
rootProject.layout.buildDirectory.value(newBuildDir)

subprojects {
    val newSubprojectBuildDir: Directory = newBuildDir.dir(project.name)
    project.layout.buildDirectory.value(newSubprojectBuildDir)
}
subprojects {
    project.evaluationDependsOn(":app")
    val configureAndroid = object : Action<Project> {
        override fun execute(p: Project) {
            val extension = p.extensions.findByName("android")
            if (extension != null) {
                try {
                    val method = extension.javaClass.getMethod("setCompileSdk", Int::class.javaPrimitiveType)
                    method.invoke(extension, 37)
                } catch (e: Exception) {
                    try {
                        val method = extension.javaClass.getMethod("setCompileSdkVersion", Int::class.javaPrimitiveType)
                        method.invoke(extension, 37)
                    } catch (e2: Exception) {}
                }
            }
        }
    }
    if (state.executed) {
        configureAndroid.execute(this)
    } else {
        afterEvaluate(configureAndroid)
    }
}

tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}
