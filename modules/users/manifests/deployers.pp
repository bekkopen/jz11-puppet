class users::deployers {

    user { "deploy":
        ensure     => present,
        uid        => 2000,
        home       => "/home/deploy",
        managehome => true,
        password   => '$6$xSZZx34H$7Wv2cIRg/MP2BGGp64OOmjxL6vxfl2QxNsmsRylxWsyA4maIp20lot3rw76Bl75DXfqltqDQUwNNWmHSTlEuJ/',
    }
    
    ssh_authorized_key { "deploy@snappy":
        ensure  => present,
        key => "AAAAB3NzaC1yc2EAAAABIwAAAQEAmZWL6WJML2kP4deIhCq/YY4DU+SXmXkpLgVvQMLJ+qggo6fXnG+bre/K7LOyC8nowl3qkBhFD/wq0c8LLlAqEeZ9o8lrwNIHck3dOtkri72UCm2CGWdLX4N36eI3wThSdbdiKVVpK9KRYjVqgs6f75raQ4NaDb9fc4j5sffDycYpJYibhu1ZcSL6TrnJQKVHUKysT0h9XnrR+/QaAs7fXG3LC+dMpj4dWQwa5nva5K93yyLlBY3fql5FeEVoVOmDz4dE5hPD+HtM9HIFWBf+Q644qjh9gtX4VEOQnk7y6vkn+gr+egwnJRe7Lse7J2Bb1vNednWFrBFBp0zPium5OQ==",
        user  => deploy,
        type  => "ssh-rsa",
    }

}