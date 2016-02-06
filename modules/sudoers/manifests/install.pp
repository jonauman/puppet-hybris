class sudoers::install {
  package { 'sudo': ensure  => installed }
}
