import "jvm"
import "nginx"
import "postgresql"
import "users"
import "common"

node default {
	include users::admins
	include common::git
	include common::timezone
	include common::zsh
}

node 'web1.muda.no' inherits default {
	include nginx
	nginx::site { "www":
      domain => "www.muda.no",
      root   => "/var/www/muda",
      upstreams => ["app1.muda.no:9000"],
    }
}

node 'app1.muda.no' inherits default {	
	include users::deployers
	include jvm::jdk
	
	jvm::jetty {"demo": 
		port => 9000, 
		secret => "7a5cfa77a46c2fd9d2224ecb5261df86",
	}
    # TODO: insert postgres here...
}

node 'mgmt.muda.no' inherits default {

	include jvm::jdk
	include jvm::nginx

}