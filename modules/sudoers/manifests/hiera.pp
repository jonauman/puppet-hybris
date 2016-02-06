class sudoers::hiera {

  $sudoersaccount = hiera('sudoersaccount',{})
  create_resources('sudoers', $sudoersaccount)
}
