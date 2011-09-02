Instructions
------------

Some dependencies is required:

    apt-get install git-core puppet

You'll need to clone this repo and submodules:

    git clone git://github.com/bekkopen/jz11-puppet.git
    cd jz11-puppet
    git submodule update --init --recursive

Then invoke puppet:

    puppet apply --modulepath=modules demo.pp


TODO
----

Vi må nok gjøre en del med eksemplene ihvertfall.

Erfaring fra fagdagen:

* Oppbygningen var bra (fra selvstendig -> klient/server)
* Eksemplene kan være litt raffinerte
* Bruke mer tid på introduksjon
* Kan godt gå litt mer i detalj om de ulike byggestenene
* Spesielt: bruke mer tid på define { }
* Veldig bra: gå gjennom strukturering av et helt modul
  - Vise hvordan gjenbruke
  - Hvordan bruke

* Klient/server var litt uklart
  - Med fordel forklare litt mer om eksempel-arkitekturer...

* Noen av forslagene som kom opp til kjørende eksempler:
  - Bruke apache istedenfor nginx (evt. huske å forklare hva nginx er først!)
  - SSH-nøkkel-provisjonering
  - Installere MySQL / MongoDB
  - Eksempel som bruker augeas
  - Installere Oracle JDK
  - Installere Glassfish
  - Eksempelapp (enkel demo-app med bekk-styling pakket som jar)
  - Jetty: Samme eksempelapp pakket inn i jetty-jar

* Nevne / gi korte eksempler på:
  - ulike environments
  - vagrant+puppet: boot dirt environment
  - etc

* Komme med flere eksempler på "hvorfor" infrastruktur som kode. (jeg tenker tre solide argumenter med tre solide begrunnelser må være maks (og mer enn nok)).
