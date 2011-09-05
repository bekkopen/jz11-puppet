class jvm::jdk {
  include jvm::jre
  package { "openjdk-6-jdk":
    ensure   => present,
  }
}

