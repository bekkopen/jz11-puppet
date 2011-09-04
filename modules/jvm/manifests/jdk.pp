class jvm::jdk {
  package { "openjdk-6-jdk":
    ensure   => present,
  }
}
Jvm::Jre -> Jvm::Jdk
