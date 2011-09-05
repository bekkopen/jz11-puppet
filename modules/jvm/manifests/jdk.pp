class jvm::jdk {
  package { "openjdk-6-jdk":
    ensure   => present,
  }
}
Class["jvm::jre"] -> Class["jvm::jdk"]

