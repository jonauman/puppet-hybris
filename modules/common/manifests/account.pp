class common::account {
	include account
	
	$accounts = hiera('accounts', {})
	create_resources('account', $accounts)
}
