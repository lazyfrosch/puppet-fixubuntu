class fixubuntu {

    if ($::operatingsystem == 'Ubuntu') {
        if ($::lsbdistrelease < '12.10') {
            # Ubuntu is clean
        } else {

            host { 'productsearch.ubuntu.com':
                ensure => present,
                ip     => '127.0.0.1',
            }

            package { 'unity-lens-shopping':
                ensure => absent,
            }

            if ($::lsbdistrelease =~ /13.(04|10)/) {
                file { 'lenses.schema.xml':
                    ensure => file,
                    path   => '/usr/share/glib-2.0/schemas/com.canonical.Unity.Lenses.gschema.xml',
                    source => "puppet:///modules/$module_name/lenses-$::lsbdistrelease.xml",
                }
            }
        }
    }
    else {
        fail("The module fixubuntu is not supported on OS '$::operatingsystem'!")
    }

}
