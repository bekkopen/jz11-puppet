class users::admins {

    user { "oc":
        ensure     => present,
        uid        => 1337,
        gid        => users,
        groups     => ["adm", "sudo"],
        home       => "/home/oc",
        managehome => true,
        password   => '$6$xSZZx34H$7Wv2cIRg/MP2BGGp64OOmjxL6vxfl2QxNsmsRylxWsyA4maIp20lot3rw76Bl75DXfqltqDQUwNNWmHSTlEuJ/',
    }
    
    user { "eivind":
        ensure     => present,
        uid        => 1007,
        gid        => users,
        groups     => ["adm", "sudo"],    
        home       => "/home/eivind",
        managehome => true,
        password   => '$6$xSZZx34H$7Wv2cIRg/MP2BGGp64OOmjxL6vxfl2QxNsmsRylxWsyA4maIp20lot3rw76Bl75DXfqltqDQUwNNWmHSTlEuJ/',
    }

    ssh_authorized_key { "oc@snappy":
        ensure  => present,
        key => "AAAAB3NzaC1yc2EAAAABIwAAAQEAmZWL6WJML2kP4deIhCq/YY4DU+SXmXkpLgVvQMLJ+qggo6fXnG+bre/K7LOyC8nowl3qkBhFD/wq0c8LLlAqEeZ9o8lrwNIHck3dOtkri72UCm2CGWdLX4N36eI3wThSdbdiKVVpK9KRYjVqgs6f75raQ4NaDb9fc4j5sffDycYpJYibhu1ZcSL6TrnJQKVHUKysT0h9XnrR+/QaAs7fXG3LC+dMpj4dWQwa5nva5K93yyLlBY3fql5FeEVoVOmDz4dE5hPD+HtM9HIFWBf+Q644qjh9gtX4VEOQnk7y6vkn+gr+egwnJRe7Lse7J2Bb1vNednWFrBFBp0zPium5OQ==",
        user  => oc,
        type  => "ssh-rsa",
    }

    ssh_authorized_key { "eivind@uggedal.com":
        ensure  => present,
        key => "AAAAB3NzaC1yc2EAAAABIwAAAQEAy1ZWC+AumwZB9HKcpVb06Ci6Z/l4mu8VeKJ9boMtK481zQ1bgu5MLYxkUmE4L75ePggz/m7ikUNMcjof0tJOVgy8+fxsdwYeYDb7wnZiBT4TpvjKW4hD9tlmS/nDviI1pVHuQgBvrGBy05cmHKCYYcWtKnHszpw/5E3WAJWOw1DJBFTAFVwOzjbzzXyHJjT/tbpfuBhIsk+gPhpq94tfQ4zUu4DRQTdGXfVtg5C3Fz9abNAP8wcQj03/nZrkNB5w/iE9g+fw2X1HFYEkOr1nGkwk7d/9CD3rijQgXXe6zEjdWUUASbWgQvUpPjnTVTfuGm1OfPhhDsE/L9EfG+RBMQ==",
        user  => eivind,
        type  => "ssh-rsa",
    }
    
}
